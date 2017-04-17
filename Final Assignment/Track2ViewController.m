//
//  Track2ViewController.m
//  Final Assignment
//
//  Created by Xcode User on 2017-03-23.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

//AUTHOR: Patrick Simmons
//This class allows you to pick and change songs for track1. You can change the volume and set the temp of the song as well.

#import "Track2ViewController.h"

@interface Track2ViewController ()

@end

@implementation Track2ViewController
@synthesize keyArray2, slVolume2, sgKeyFlag2, sgSyncKey2, sgSyncTempo2, stKey2, stDecimal2, stWholeNum2, lbVolume2, lbTempo2, lbKey2, lbArtist2, lbSongTitle2, btArtwork2, lbSongLength2, track2Picker, btPlayPause2, myTimer, myTimer2, slProgress2, md;

//This method is when a user clicks on this button and allows the user to begin to choose a song
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

//This method allows a user to select a song from their music library, and will display all the information that was stored about the song.
- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection
{
    NSString *title=btPlayPause2.titleLabel.text;
    if([title isEqualToString:@"⏸"]){
        title = @"▶";
        [btPlayPause2 setTitle:title forState:UIControlStateNormal];
    }
    
    md.audioPlayer2=nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    if(mediaItemCollection)
    {
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
        
        if([title isEqualToString:@"⏸"])
            [md.audioPlayer2 pause];
        
        if(!md.audioPlayer2){
            md.audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        } else {
            NSLog(@"exit");
            return;
        }
    }
}

//This method is for when we have finished picking a song to close the view that was opened.
- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker
{
    NSString *title=btPlayPause2.titleLabel.text;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if([title isEqualToString:@"⏸"]){
        title = @"▶";
        [btPlayPause2 setTitle:title forState:UIControlStateNormal];
    }
}

//This method is for when the user clicks to play/pause the song
//it also starts and pauses a timer to keep track of how far you are into the song
-(IBAction)playSong:(id)sender
{
    NSString *title = [(UIButton *)sender currentTitle];
    if([title isEqualToString:@"⏸"])
    {
        [md.audioPlayer2 pause];
        title = @"▶";
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
            title = @"⏸";
            [btPlayPause2 setTitle:title forState:UIControlStateNormal];
        }
    }
    
}

//This method is to keep track of how much time the timer has gone through and to update the label every second
- (void)updateTimeLeft {
    NSTimeInterval timeLeft = md.audioPlayer2.currentTime;
    int songSeconds = md.song2.playbackDuration;
    int songMinute = md.song2.playbackDuration/60;
    songSeconds = (int)songSeconds%60;
    
    int curSongSeconds = timeLeft;
    int curSongMinutes = timeLeft/60;
    curSongSeconds = (int)curSongSeconds%60;
    
    [lbSongLength2 setText:[NSString stringWithFormat:@"%02d:%02d/%02d:%02d",curSongMinutes, curSongSeconds, songMinute, songSeconds]];
    
    if(timeLeft == md.song2.playbackDuration)
    {
        [btPlayPause2 setTitle:@"▶" forState:UIControlStateNormal];
        [md.audioPlayer2 pause];
        md.audioPlayer2.currentTime=0;
        
        curSongSeconds = 0;
        curSongMinutes = 0;
        
        [lbSongLength2 setText:[NSString stringWithFormat:@"%02d:%02d/%02d:%02d",curSongMinutes, curSongSeconds, songMinute, songSeconds]];
        
    }
}

//This method is to show what the progress is of the song through a slider
-(IBAction)sliderProgressChange:(id)sender
{
    NSTimeInterval timeLeft = md.audioPlayer2.currentTime;
    NSTimeInterval dur = md.audioPlayer2.duration;
    [slProgress2 setMaximumValue:dur];
    [slProgress2 setValue:timeLeft];
}

//This method allows the user to change the volume of the song
-(IBAction)sliderVolumeChanged:(id)sender
{
    [self updateLabel];
    md.volNum2 = slVolume2.value;
    md.volNum2=md.volNum2/100;
    md.audioPlayer2.volume=md.volNum2;
}

//This method allows for the tempo of the song to be set by .1
-(IBAction)tempoDecimalChanged:(id)sender{
    float decimal = stDecimal2.value;
    md.songBPM2 = decimal;
    [lbTempo2 setText:[NSString stringWithFormat:@"%.1f bpm", decimal]];
    stWholeNum2.value = decimal;
}

//This method allows for the tempo of the song to be set by 1
-(IBAction)tempoWholeChanged:(id)sender{
    float wholeNum = stWholeNum2.value;
    md.songBPM2 = wholeNum;
    [lbTempo2 setText:[NSString stringWithFormat:@"%.1f bpm", wholeNum]];
    stDecimal2.value = wholeNum;
}

//This method just updates the label of what the key could be changed to
-(IBAction)keyChanged:(id)sender {
    int key = stKey2.value;
    [lbKey2 setText:[keyArray2 objectAtIndex:key]];
}

//This method updates the label of what the voulme will be at
-(void)updateLabel
{
    float vol = slVolume2.value;
    NSString *strVol = [NSString stringWithFormat:@"%.0f%%", vol];
    
    [lbVolume2 setText:strVol];
}

//This method laods in the app delegate
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateLabel];
    [slProgress2 setThumbImage:[UIImage new] forState:UIControlStateNormal];
    md = (AppDelegate *) [[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//when we leave this view the song will be paused and resarted
-(void)viewWillDisappear:(BOOL)animated {
    if(md.audioPlayer2){
        [md.audioPlayer2 pause];
        md.audioPlayer2.currentTime=0;
    }
}

//when we come back to this view all of the info that was changed before we left the page will be remembered
-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"%@", md.song2.artist);
    NSString *songArtist = [NSString stringWithFormat:@"%@", md.song2.artist];
    NSString *songTitle = [NSString stringWithFormat:@"%@", md.song2.title];
    if(md.songBPM2) {
        [lbTempo2 setText:[NSString stringWithFormat:@"%.1f bpm", md.songBPM2]];
    }
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
