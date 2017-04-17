//
//  Track1ViewController.m
//  Final Assignment
//
//  Created by Xcode User on 2017-03-20.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

//AUTHOR: Patrick Simmons
//This class allows you to pick and change songs for track1. You can change the volume and set the temp of the song as well.

#import "Track1ViewController.h"


@interface Track1ViewController ()

@end

@implementation Track1ViewController
@synthesize keyArray, slVolume, sgKeyFlag, sgSyncKey, sgSyncTempo, stKey, stDecimal, stWholeNum, lbVolume, lbTempo, lbKey, lbArtist, lbSongTitle, btArtwork, lbSongLength, track1Picker, btPlayPause, myTimer, myTimer2, slProgress, md;

//This method is when a user clicks on this button and allows the user to begin to choose a song
- (IBAction) chooseSong: (id) sender
{
    track1Picker =
    [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeMusic];
    
    track1Picker.delegate                     = self;
    track1Picker.allowsPickingMultipleItems   = NO;
    track1Picker.prompt                       = NSLocalizedString (@"Select any song from the list", @"Prompt to user to choose some songs to play");
    
    [self presentViewController:track1Picker animated:YES completion:nil];
    if(md.audioPlayer)
        [md.audioPlayer pause];
    
}

//This method allows a user to select a song from their music library, and will display all the information that was stored about the song.
- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection
{
    NSString *title=btPlayPause.titleLabel.text;
    if([title isEqualToString:@""]){
        title = @"▶";
        [btPlayPause setTitle:title forState:UIControlStateNormal];
    }
    
    md.audioPlayer=nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    if(mediaItemCollection)
    {
        md.song=[[mediaItemCollection items] objectAtIndex:0];
        if (! md.song) {
            return;
        }
        NSString *songArtist = [NSString stringWithFormat:@"%@", md.song.artist];
        NSString *songTitle = [NSString stringWithFormat:@"%@", md.song.title];
        int songSeconds = md.song.playbackDuration;
        int songMinute = md.song.playbackDuration/60;
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
        MPMediaItemArtwork *artwork = [md.song valueForProperty: MPMediaItemPropertyArtwork];
        artworkImage = [artwork imageWithSize:artworkSize];
        
        if (artworkImage == nil) {
            NSLog(@"artwork not available");
            artworkImage = [UIImage imageNamed:@"AlbumArt1.png"];
        }
        [btArtwork setBackgroundImage:artworkImage forState:UIControlStateNormal];
        
        NSURL *url = [md.song valueForProperty:MPMediaItemPropertyAssetURL];
        
        if(!md.audioPlayer){
            md.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        } else {
            NSLog(@"exit");
            return;
        }
    }
}

//This method is for when we have finished picking a song to close the view that was opened.
- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker
{
    NSString *title=btPlayPause.titleLabel.text;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if([title isEqualToString:@"⏸"]){
        title = @"▶";
        [btPlayPause setTitle:title forState:UIControlStateNormal];
    }
}

//This method is for when the user clicks to play/pause the song
//it also starts and pauses a timer to keep track of how far you are into the song
-(IBAction)playSong:(id)sender
{
    NSString *title = [(UIButton *)sender currentTitle];
    if([title isEqualToString:@"⏸"])
    {
        [md.audioPlayer pause];
        title = @"▶";
        [btPlayPause setTitle:title forState:UIControlStateNormal];
    }
    else
    {
        if(md.audioPlayer!=nil)
        {
            [md.audioPlayer play];
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
            [btPlayPause setTitle:title forState:UIControlStateNormal];
        }
    }
    
}

//This method is to keep track of how much time the timer has gone through and to update the label every second
- (void)updateTimeLeft {
    NSTimeInterval timeLeft = md.audioPlayer.currentTime;
    int songSeconds = md.song.playbackDuration;
    int songMinute = md.song.playbackDuration/60;
    songSeconds = (int)songSeconds%60;
    
    int curSongSeconds = timeLeft;
    int curSongMinutes = timeLeft/60;
    curSongSeconds = (int)curSongSeconds%60;

    [lbSongLength setText:[NSString stringWithFormat:@"%02d:%02d/%02d:%02d",curSongMinutes, curSongSeconds, songMinute, songSeconds]];
    
    if(timeLeft == md.song.playbackDuration)
    {
        [btPlayPause setTitle:@"▶" forState:UIControlStateNormal];
        [md.audioPlayer pause];
        md.audioPlayer.currentTime=0;
        
        curSongSeconds = 0;
        curSongMinutes = 0;
        
        [lbSongLength setText:[NSString stringWithFormat:@"%02d:%02d/%02d:%02d",curSongMinutes, curSongSeconds, songMinute, songSeconds]];
        
    }
}

//This method is to show what the progress is of the song through a slider
-(IBAction)sliderProgressChange:(id)sender
{
    NSTimeInterval timeLeft = md.audioPlayer.currentTime;
    NSTimeInterval dur = md.audioPlayer.duration;
    [slProgress setMaximumValue:dur];
    [slProgress setValue:timeLeft];
}

//This method allows for the tempo of the song to be set by .1
-(IBAction)tempoDecimalChanged:(id)sender{
    float decimal = stDecimal.value;
    [lbTempo setText:[NSString stringWithFormat:@"%.1f bpm", decimal]];
    stWholeNum.value = decimal;
    md.songBPM = decimal;
}

//This method allows for the tempo of the song to be set by 1
-(IBAction)tempoWholeChanged:(id)sender{
    float wholeNum = stWholeNum.value;
    [lbTempo setText:[NSString stringWithFormat:@"%.1f bpm", wholeNum]];
    stDecimal.value = wholeNum;
    md.songBPM = wholeNum;
}

//This method allows the user to change the volume of the song
-(IBAction)sliderVolumeChanged:(id)sender
{
    [self updateLabel];
    md.volNum = slVolume.value;
    md.volNum = md.volNum/100;
    md.audioPlayer.volume=md.volNum;
}

//This method just updates the label of what the key could be changed to
-(IBAction)keyChanged:(id)sender {
    int key = stKey.value;
    [lbKey setText:[keyArray objectAtIndex:key]];
}

//This method updates the label of what the voulme will be at
-(void)updateLabel
{
    float vol = slVolume.value;
    NSString *strVol = [NSString stringWithFormat:@"%.0f%%", vol];
    
    [lbVolume setText:strVol];
}

//This method laods in the app delegate
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateLabel];
    [slProgress setThumbImage:[UIImage new] forState:UIControlStateNormal];
    md = (AppDelegate *) [[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//when we leave this view the song will be paused and resarted
-(void)viewWillDisappear:(BOOL)animated {
    if(md.audioPlayer){
        [md.audioPlayer pause];
        md.audioPlayer.currentTime=0;
    }
}

//when we come back to this view all of the info that was changed before we left the page will be remembered
-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"%@", md.song.artist);
    NSString *songArtist = [NSString stringWithFormat:@"%@", md.song.artist];
    NSString *songTitle = [NSString stringWithFormat:@"%@", md.song.title];
    if([songArtist isEqualToString:@"(null)"])
        [lbArtist setText:@"Artist Unknown"];
    else
        [lbArtist setText:songArtist];
    
    if([songTitle isEqualToString:@"(null)"])
        [lbSongTitle setText:@"Title Unknown"];
    else
        [lbSongTitle setText:songTitle];
    
    CGSize artworkSize = CGSizeMake(30, 30);
    UIImage *artworkImage;
    MPMediaItemArtwork *artwork = [md.song valueForProperty: MPMediaItemPropertyArtwork];
    artworkImage = [artwork imageWithSize:artworkSize];
    
    if (artworkImage == nil) {
        NSLog(@"artwork not available");
        artworkImage = [UIImage imageNamed:@"AlbumArt1.png"];
    }
    [btArtwork setBackgroundImage:artworkImage forState:UIControlStateNormal];
    
    int songSeconds = md.song.playbackDuration;
    int songMinute = md.song.playbackDuration/60;
    songSeconds = (int)songSeconds%60;
    [lbSongLength setText:[NSString stringWithFormat:@"00:00/%02d:%02d",songMinute, songSeconds]];
    if(md.volNum<=1)
        md.volNum=md.volNum*100;
    slVolume.value=md.volNum;
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
