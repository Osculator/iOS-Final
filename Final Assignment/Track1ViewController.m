//
//  Track1ViewController.m
//  Final Assignment
//
//  Created by Xcode User on 2017-03-20.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

#import "Track1ViewController.h"
#import "AppDelegate.h"


@interface Track1ViewController ()

@end

@implementation Track1ViewController
@synthesize keyArray, slVolume, sgKeyFlag, sgSyncKey, sgSyncTempo, stKey, stDecimal, stWholeNum, lbVolume, lbTempo, lbKey, lbArtist, lbSongTitle, btArtwork, lbSongLength, audioPlayer, track1Picker, song, btPlayPause, myTimer, myTimer2, slProgress;

- (IBAction) chooseSong: (id) sender
{
    //MPMediaPickerController *track1Picker =
    track1Picker =
    [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeMusic];
    
    track1Picker.delegate                     = self;
    track1Picker.allowsPickingMultipleItems   = NO;
    track1Picker.prompt                       = NSLocalizedString (@"Select any song from the list", @"Prompt to user to choose some songs to play");
    
    [self presentViewController:track1Picker animated:YES completion:nil];
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection
{

    [self dismissViewControllerAnimated:YES completion:nil];
    if(mediaItemCollection)
    {
        //MPMediaItem *song=[[mediaItemCollection items] objectAtIndex:0];
        song=[[mediaItemCollection items] objectAtIndex:0];
        if (! song) {
            return;
        }
        NSString *songArtist = [NSString stringWithFormat:@"%@", song.artist];
        NSString *songTitle = [NSString stringWithFormat:@"%@", song.title];
        int songSeconds = song.playbackDuration;
        int songMinute = song.playbackDuration/60;
        songSeconds = (int)songSeconds%60;
        if([songArtist isEqualToString:@"(null)"])
            [lbArtist setText:@"Artist Unknown"];
        else
            [lbArtist setText:songArtist];
        if([songTitle isEqualToString:@"(null)"])
            [lbSongTitle setText:@"Title Unknown"];
        else
            [lbSongTitle setText:songTitle];
        [lbSongLength setText:[NSString stringWithFormat:@"00:00/%02d:%02d",songMinute, songSeconds]];
        
        CGSize artworkSize = CGSizeMake(30, 30);
        UIImage *artworkImage;
        MPMediaItemArtwork *artwork = [song valueForProperty: MPMediaItemPropertyArtwork];
        artworkImage = [artwork imageWithSize:artworkSize];
        
        if (artworkImage == nil) {
            NSLog(@"artwork not available");
            artworkImage = [UIImage imageNamed:@"AlbumArt1.png"];
        }
        [btArtwork setBackgroundImage:artworkImage forState:UIControlStateNormal];
        
        if(!audioPlayer){
            audioPlayer = [[AVPlayer alloc] initWithURL:[song valueForProperty:MPMediaItemPropertyAssetURL]];
        } else {
            //[audioPlayer replaceCurrentItemWithPlayerItem:[AVPlayerItem playerItemWithURL:itemURL]];
            NSLog(@"exit");
            return;
        }
    }
}

- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)playSong:(id)sender
{
    NSString *title = [(UIButton *)sender currentTitle];
    if([title isEqualToString:@"||"])
    {
        [audioPlayer pause];
        title = @"^";
        [btPlayPause setTitle:title forState:UIControlStateNormal];
    }
    else
    {
        if(audioPlayer!=nil)
        {
            [audioPlayer play];
            myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                             target:self
                                                           selector:@selector(updateTimeLeft)
                                                           userInfo:nil
                                                            repeats:YES];
            myTimer2 = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                   target:self
                                                 selector:@selector(sliderProgressChange:)
                                                 userInfo:nil
                                                  repeats:YES];
            title = @"||";
            [btPlayPause setTitle:title forState:UIControlStateNormal];
        }
    }
    
}

- (void)updateTimeLeft {
    AVPlayerItem *currentItem = audioPlayer.currentItem;
    NSTimeInterval timeLeft = CMTimeGetSeconds(currentItem.currentTime);
    // update your UI with timeLeft
    int songSeconds = song.playbackDuration;
    int songMinute = song.playbackDuration/60;
    songSeconds = (int)songSeconds%60;
    
    int curSongSeconds = timeLeft;
    int curSongMinutes = timeLeft/60;
    curSongSeconds = (int)curSongSeconds%60;

    [lbSongLength setText:[NSString stringWithFormat:@"%02d:%02d/%02d:%02d",curSongMinutes, curSongSeconds, songMinute, songSeconds]];
}

-(IBAction)sliderProgressChange:(id)sender
{
    AVPlayerItem *currentItem = audioPlayer.currentItem;
    NSTimeInterval timeLeft = CMTimeGetSeconds(currentItem.currentTime);
    NSTimeInterval dur = CMTimeGetSeconds(currentItem.duration);
    [slProgress setMaximumValue:dur];
    [slProgress setValue:timeLeft];
}

-(IBAction)sliderVolumeChanged:(id)sender
{
    [self updateLabel];
}

-(IBAction)tempoDecimalChanged:(id)sender{
    float decimal = stDecimal.value;
    
    [lbTempo setText:[NSString stringWithFormat:@"%.1f bpm", decimal]];
    stWholeNum.value = decimal;
}

-(IBAction)tempoWholeChanged:(id)sender{
    float wholeNum = stWholeNum.value;
    
    [lbTempo setText:[NSString stringWithFormat:@"%.1f bpm", wholeNum]];
    stDecimal.value = wholeNum;
}

-(IBAction)keyChanged:(id)sender {
    int key = stKey.value;
    [lbKey setText:[keyArray objectAtIndex:key]];
}

-(void)updateLabel
{
    float vol = slVolume.value;
    NSString *strVol = [NSString stringWithFormat:@"%.0f%%", vol];
    
    [lbVolume setText:strVol];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    keyArray = [NSArray arrayWithObjects:@"A",@"A#",@"B",@"B#",@"C",@"D",@"D#",@"E",@"F",@"F#",@"G",@"G#",nil];
    [self updateLabel];
    [slProgress setThumbImage:[UIImage new] forState:UIControlStateNormal];
    //slProgress.transform = CGAffineTransformMakeScale(0.5, 0.5);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
