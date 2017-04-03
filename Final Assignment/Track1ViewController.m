//
//  Track1ViewController.m
//  Final Assignment
//
//  Created by Xcode User on 2017-03-20.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

#import "Track1ViewController.h"


@interface Track1ViewController ()

@end

@implementation Track1ViewController
@synthesize keyArray, slVolume, sgKeyFlag, sgSyncKey, sgSyncTempo, stKey, stDecimal, stWholeNum, lbVolume, lbTempo, lbKey, lbArtist, lbSongTitle, btArtwork, lbSongLength, track1Picker, btPlayPause, myTimer, myTimer2, slProgress, md;//audioPlayer,song;

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

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection
{
    //Data *person = [[Data alloc] initWitName:tbName.text Email:tbEmail.text Food:tbFood.text];
    NSString *title=btPlayPause.titleLabel.text;
    if([title isEqualToString:@"||"]){
        title = @"^";
        [btPlayPause setTitle:title forState:UIControlStateNormal];
    }
    
    md.audioPlayer=nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    if(mediaItemCollection)
    {
        //MPMediaItem *song=[[mediaItemCollection items] objectAtIndex:0];
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
        
        if([title isEqualToString:@"||"])
            [md.audioPlayer pause];
        
        if(!md.audioPlayer){
            md.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        } else {
            //[audioPlayer replaceCurrentItemWithPlayerItem:[AVPlayerItem playerItemWithURL:itemURL]];
            NSLog(@"exit");
            return;
        }
        //NSString *bpm;
        //[lbTempo setText:[NSString stringWithFormat:@"%.02f bpm",md.audioPlayer.rate]];
    }
}

- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker
{
    NSString *title=btPlayPause.titleLabel.text;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if([title isEqualToString:@"||"]){
        title = @"^";
        [btPlayPause setTitle:title forState:UIControlStateNormal];
    }
}

-(IBAction)playSong:(id)sender
{
    NSString *title = [(UIButton *)sender currentTitle];
    if([title isEqualToString:@"||"])
    {
        [md.audioPlayer pause];
        title = @"^";
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
            title = @"||";
            [btPlayPause setTitle:title forState:UIControlStateNormal];
        }
    }
    
}

- (void)updateTimeLeft {
    //AVPlayerItem *currentItem = md.audioPlayer.currentItem;
    NSTimeInterval timeLeft = md.audioPlayer.currentTime;
    // update your UI with timeLeft
    int songSeconds = md.song.playbackDuration;
    int songMinute = md.song.playbackDuration/60;
    songSeconds = (int)songSeconds%60;
    
    int curSongSeconds = timeLeft;
    int curSongMinutes = timeLeft/60;
    curSongSeconds = (int)curSongSeconds%60;

    [lbSongLength setText:[NSString stringWithFormat:@"%02d:%02d/%02d:%02d",curSongMinutes, curSongSeconds, songMinute, songSeconds]];
    
    if(timeLeft == md.song.playbackDuration)
    {
        [btPlayPause setTitle:@"^" forState:UIControlStateNormal];
        [md.audioPlayer pause];
        //[md.audioPlayer seekToTime:kCMTimeZero];
        md.audioPlayer.currentTime=0;
        
        curSongSeconds = 0;
        curSongMinutes = 0;
        
        [lbSongLength setText:[NSString stringWithFormat:@"%02d:%02d/%02d:%02d",curSongMinutes, curSongSeconds, songMinute, songSeconds]];
        
    }
}

-(IBAction)sliderProgressChange:(id)sender
{
    //AVAudioPlayerItem *currentItem = md.audioPlayer.currentItem;
    NSTimeInterval timeLeft = md.audioPlayer.currentTime;
    NSTimeInterval dur = md.audioPlayer.duration;
    [slProgress setMaximumValue:dur];
    [slProgress setValue:timeLeft];
}

-(IBAction)sliderVolumeChanged:(id)sender
{
    [self updateLabel];
    md.volNum = slVolume.value;
    md.volNum=md.volNum/100;
    //NSLog(@"%.2f", volNum);
    md.audioPlayer.volume=md.volNum;
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
    md = (AppDelegate *) [[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated {
    if(md.audioPlayer){
        [md.audioPlayer pause];
        //[md.audioPlayer seekToTime:kCMTimeZero];
        md.audioPlayer.currentTime=0;
    }
}

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
    //slVolume.value=slVolume.value;
    //NSLog(@"%.2f",md.volNum);
    //NSLog(@"%.2f",slVolume.value);
    //slVolume.value=md.volNum;
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
