//
//  Track2ViewController.m
//  Final Assignment
//
//  Created by Xcode User on 2017-03-23.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

#import "Track2ViewController.h"
#import "AppDelegate.h"

@interface Track2ViewController ()

@end

@implementation Track2ViewController
@synthesize keyArray2, slVolume2, sgKeyFlag2, sgSyncKey2, sgSyncTempo2, stKey2, stDecimal2, stWholeNum2, lbVolume2, lbTempo2, lbKey2, lbArtist2, lbSongTitle2, btArtwork2, lbSongLength2, audioPlayer2, track2Picker, song2, btPlayPause2, myTimer, myTimer2, slProgress2;

- (IBAction) chooseSong: (id) sender
{
    //MPMediaPickerController *track1Picker =
    track2Picker =
    [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeMusic];
    
    track2Picker.delegate                     = self;
    track2Picker.allowsPickingMultipleItems   = NO;
    track2Picker.prompt                       = NSLocalizedString (@"Select any song from the list", @"Prompt to user to choose some songs to play");
    
    [self presentViewController:track2Picker animated:YES completion:nil];
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    if(mediaItemCollection)
    {
        //MPMediaItem *song=[[mediaItemCollection items] objectAtIndex:0];
        song2=[[mediaItemCollection items] objectAtIndex:0];
        if (! song2) {
            return;
        }
        NSString *songArtist = [NSString stringWithFormat:@"%@", song2.artist];
        NSString *songTitle = [NSString stringWithFormat:@"%@", song2.title];
        int songSeconds = song2.playbackDuration;
        int songMinute = song2.playbackDuration/60;
        songSeconds = (int)songSeconds%60;
        if([songArtist isEqualToString:@"(null)"])
            [lbArtist2 setText:@"Artist Unknown"];
        else
            [lbArtist2 setText:songArtist];
        if([songTitle isEqualToString:@"(null)"])
            [lbSongTitle2 setText:@"Title Unknown"];
        else
            [lbSongTitle2 setText:songTitle];
        [lbSongLength2 setText:[NSString stringWithFormat:@"00:00/%02d:%02d",songMinute, songSeconds]];
        
        CGSize artworkSize = CGSizeMake(30, 30);
        UIImage *artworkImage;
        MPMediaItemArtwork *artwork = [song2 valueForProperty: MPMediaItemPropertyArtwork];
        artworkImage = [artwork imageWithSize:artworkSize];
        
        if (artworkImage == nil) {
            NSLog(@"artwork not available");
            artworkImage = [UIImage imageNamed:@"AlbumArt1.png"];
        }
        [btArtwork2 setBackgroundImage:artworkImage forState:UIControlStateNormal];
        
        if(!audioPlayer2){
            audioPlayer2 = [[AVPlayer alloc] initWithURL:[song2 valueForProperty:MPMediaItemPropertyAssetURL]];
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
        [audioPlayer2 pause];
        title = @"^";
        [btPlayPause2 setTitle:title forState:UIControlStateNormal];
    }
    else
    {
        if(audioPlayer2!=nil)
        {
            [audioPlayer2 play];
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
            [btPlayPause2 setTitle:title forState:UIControlStateNormal];
        }
    }
    
}

- (void)updateTimeLeft {
    AVPlayerItem *currentItem = audioPlayer2.currentItem;
    NSTimeInterval timeLeft = CMTimeGetSeconds(currentItem.currentTime);
    // update your UI with timeLeft
    int songSeconds = song2.playbackDuration;
    int songMinute = song2.playbackDuration/60;
    songSeconds = (int)songSeconds%60;
    
    int curSongSeconds = timeLeft;
    int curSongMinutes = timeLeft/60;
    curSongSeconds = (int)curSongSeconds%60;
    
    [lbSongLength2 setText:[NSString stringWithFormat:@"%02d:%02d/%02d:%02d",curSongMinutes, curSongSeconds, songMinute, songSeconds]];
}

-(IBAction)sliderProgressChange:(id)sender
{
    AVPlayerItem *currentItem = audioPlayer2.currentItem;
    NSTimeInterval timeLeft = CMTimeGetSeconds(currentItem.currentTime);
    NSTimeInterval dur = CMTimeGetSeconds(currentItem.duration);
    [slProgress2 setMaximumValue:dur];
    [slProgress2 setValue:timeLeft];
}

-(IBAction)sliderVolumeChanged:(id)sender
{
    [self updateLabel];
}

-(IBAction)tempoDecimalChanged:(id)sender{
    float decimal = stDecimal2.value;
    
    [lbTempo2 setText:[NSString stringWithFormat:@"%.1f bpm", decimal]];
    stWholeNum2.value = decimal;
}

-(IBAction)tempoWholeChanged:(id)sender{
    float wholeNum = stWholeNum2.value;
    
    [lbTempo2 setText:[NSString stringWithFormat:@"%.1f bpm", wholeNum]];
    stDecimal2.value = wholeNum;
}

-(IBAction)keyChanged:(id)sender {
    int key = stKey2.value;
    [lbKey2 setText:[keyArray2 objectAtIndex:key]];
}

-(void)updateLabel
{
    float vol = slVolume2.value;
    NSString *strVol = [NSString stringWithFormat:@"%.0f%%", vol];
    
    [lbVolume2 setText:strVol];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    keyArray2 = [NSArray arrayWithObjects:@"A",@"A#",@"B",@"B#",@"C",@"D",@"D#",@"E",@"F",@"F#",@"G",@"G#",nil];
    [self updateLabel];
    [slProgress2 setThumbImage:[UIImage new] forState:UIControlStateNormal];
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
