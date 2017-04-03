//
//  Track2ViewController.m
//  Final Assignment
//
//  Created by Xcode User on 2017-03-23.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

#import "Track2ViewController.h"

@interface Track2ViewController ()

@end

@implementation Track2ViewController
@synthesize keyArray2, slVolume2, sgKeyFlag2, sgSyncKey2, sgSyncTempo2, stKey2, stDecimal2, stWholeNum2, lbVolume2, lbTempo2, lbKey2, lbArtist2, lbSongTitle2, btArtwork2, lbSongLength2, track2Picker, btPlayPause2, myTimer, myTimer2, slProgress2, md;//audioPlayer2, song2;

- (IBAction) chooseSong: (id) sender
{
    track2Picker =
    [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeMusic];
    
    track2Picker.delegate                     = self;
    track2Picker.allowsPickingMultipleItems   = NO;
    track2Picker.prompt                       = NSLocalizedString (@"Select any song from the list", @"Prompt to user to choose some songs to play");
    
    [self presentViewController:track2Picker animated:YES completion:nil];
    if(md.audioPlayer2)
        [md.audioPlayer2 pause];
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection
{
    NSString *title=btPlayPause2.titleLabel.text;
    if([title isEqualToString:@"||"]){
        title = @"^";
        [btPlayPause2 setTitle:title forState:UIControlStateNormal];
    }
    
    md.audioPlayer2=nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    if(mediaItemCollection)
    {
        //MPMediaItem *song=[[mediaItemCollection items] objectAtIndex:0];
        md.song2=[[mediaItemCollection items] objectAtIndex:0];
        if (! md.song2) {
            return;
        }
        NSString *songArtist = [NSString stringWithFormat:@"%@", md.song2.artist];
        NSString *songTitle = [NSString stringWithFormat:@"%@", md.song2.title];
        int songSeconds = md.song2.playbackDuration;
        int songMinute = md.song2.playbackDuration/60;
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
        MPMediaItemArtwork *artwork = [md.song2 valueForProperty: MPMediaItemPropertyArtwork];
        artworkImage = [artwork imageWithSize:artworkSize];
        
        if (artworkImage == nil) {
            NSLog(@"artwork not available");
            artworkImage = [UIImage imageNamed:@"AlbumArt1.png"];
        }
        [btArtwork2 setBackgroundImage:artworkImage forState:UIControlStateNormal];
        
        NSURL *url = [md.song2 valueForProperty:MPMediaItemPropertyAssetURL];
        
        if([title isEqualToString:@"||"])
            [md.audioPlayer2 pause];
        
        if(!md.audioPlayer2){
            md.audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        } else {
            //[audioPlayer replaceCurrentItemWithPlayerItem:[AVPlayerItem playerItemWithURL:itemURL]];
            NSLog(@"exit");
            return;
        }
    }
}

- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker
{
    NSString *title=btPlayPause2.titleLabel.text;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if([title isEqualToString:@"||"]){
        title = @"^";
        [btPlayPause2 setTitle:title forState:UIControlStateNormal];
    }
}

-(IBAction)playSong:(id)sender
{
    NSString *title = [(UIButton *)sender currentTitle];
    if([title isEqualToString:@"||"])
    {
        [md.audioPlayer2 pause];
        title = @"^";
        [btPlayPause2 setTitle:title forState:UIControlStateNormal];
    }
    else
    {
        if(md.audioPlayer2!=nil)
        {
            [md.audioPlayer2 play];
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
    //AVPlayerItem *currentItem = md.audioPlayer2.currentItem;
    NSTimeInterval timeLeft = md.audioPlayer2.currentTime;
    // update your UI with timeLeft
    int songSeconds = md.song2.playbackDuration;
    int songMinute = md.song2.playbackDuration/60;
    songSeconds = (int)songSeconds%60;
    
    int curSongSeconds = timeLeft;
    int curSongMinutes = timeLeft/60;
    curSongSeconds = (int)curSongSeconds%60;
    
    [lbSongLength2 setText:[NSString stringWithFormat:@"%02d:%02d/%02d:%02d",curSongMinutes, curSongSeconds, songMinute, songSeconds]];
    
    if(timeLeft == md.song2.playbackDuration)
    {
        [btPlayPause2 setTitle:@"^" forState:UIControlStateNormal];
        [md.audioPlayer2 pause];
        //[md.audioPlayer2 seekToTime:kCMTimeZero];
        md.audioPlayer2.currentTime=0;
        
        curSongSeconds = 0;
        curSongMinutes = 0;
        
        [lbSongLength2 setText:[NSString stringWithFormat:@"%02d:%02d/%02d:%02d",curSongMinutes, curSongSeconds, songMinute, songSeconds]];
        
    }
}

-(IBAction)sliderProgressChange:(id)sender
{
    //AVPlayerItem *currentItem = md.audioPlayer2.currentItem;
    NSTimeInterval timeLeft = md.audioPlayer2.currentTime;
    NSTimeInterval dur = md.audioPlayer2.duration;
    [slProgress2 setMaximumValue:dur];
    [slProgress2 setValue:timeLeft];
}

-(IBAction)sliderVolumeChanged:(id)sender
{
    [self updateLabel];
    md.volNum2 = slVolume2.value;
    md.volNum2=md.volNum2/100;
    //NSLog(@"%.2f", volNum);
    md.audioPlayer2.volume=md.volNum2;
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
    md = (AppDelegate *) [[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated {
    if(md.audioPlayer2){
        [md.audioPlayer2 pause];
        //[md.audioPlayer2 seekToTime:kCMTimeZero];
        md.audioPlayer2.currentTime=0;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"%@", md.song2.artist);
    NSString *songArtist = [NSString stringWithFormat:@"%@", md.song2.artist];
    NSString *songTitle = [NSString stringWithFormat:@"%@", md.song2.title];
    if([songArtist isEqualToString:@"(null)"])
        [lbArtist2 setText:@"Artist Unknown"];
    else
        [lbArtist2 setText:songArtist];
    
    if([songTitle isEqualToString:@"(null)"])
        [lbSongTitle2 setText:@"Title Unknown"];
    else
        [lbSongTitle2 setText:songTitle];
    
    CGSize artworkSize = CGSizeMake(30, 30);
    UIImage *artworkImage;
    MPMediaItemArtwork *artwork = [md.song2 valueForProperty: MPMediaItemPropertyArtwork];
    artworkImage = [artwork imageWithSize:artworkSize];
    
    if (artworkImage == nil) {
        NSLog(@"artwork not available");
        artworkImage = [UIImage imageNamed:@"AlbumArt2.png"];
    }
    [btArtwork2 setBackgroundImage:artworkImage forState:UIControlStateNormal];
    
    int songSeconds = md.song2.playbackDuration;
    int songMinute = md.song2.playbackDuration/60;
    songSeconds = (int)songSeconds%60;
    [lbSongLength2 setText:[NSString stringWithFormat:@"00:00/%02d:%02d",songMinute, songSeconds]];
    if(md.volNum2<=1)
        md.volNum2=md.volNum2*100;
    slVolume2.value=md.volNum2;
    [self updateLabel];
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
