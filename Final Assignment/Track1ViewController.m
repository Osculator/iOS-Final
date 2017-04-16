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
@synthesize slVolume, sgKeyFlag, sgSyncKey, sgSyncTempo, stKey, stDecimal, stWholeNum, lbVolume, lbTempo, lbKey, lbArtist, lbSongTitle, btArtwork, lbSongLength, track1Picker, btPlayPause, myTimer, myTimer2, slProgress, md;//audioPlayer,song;

- (IBAction) chooseSong: (id) sender
{
    track1Picker =
    [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeMusic];
    
    track1Picker.delegate                     = self;
    track1Picker.allowsPickingMultipleItems   = NO;
    track1Picker.prompt                       = NSLocalizedString (@"Select any song from the list", @"Prompt to user to choose some songs to play");
    
    [self presentViewController:track1Picker animated:YES completion:nil];
    if(md.playerNode1)
        [md.playerNode1 pause];
    
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection
{
    NSString *title=btPlayPause.titleLabel.text;
    if([title isEqualToString:@"⏸"]){
        title = @"▶";
        [btPlayPause setTitle:title forState:UIControlStateNormal];
    }
    
    
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
        
        NSURL *url = [md.song valueForProperty:MPMediaItemPropertyAssetURL];
        AVAudioFile *file = [[AVAudioFile alloc] initForReading:url error:nil];
        md.buffer = [[AVAudioPCMBuffer alloc] initWithPCMFormat:file.processingFormat frameCapacity:(UInt32)file.length];
        [file readIntoBuffer:md.buffer error:nil];
        [md adjustTimePitchUnit:1];
        [md attachAndRouteNodes:1];
        [md prepareForPlayback:1];

        if (artworkImage == nil) {
            NSLog(@"artwork not available");
            artworkImage = [UIImage imageNamed:@"AlbumArt1.png"];
        }
        [btArtwork setBackgroundImage:artworkImage forState:UIControlStateNormal];
        
        if([title isEqualToString:@"⏸"])
            [md.playerNode1 pause];

    }
}

- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker
{
    NSString *title=btPlayPause.titleLabel.text;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if([title isEqualToString:@"⏸"]){
        title = @"▶";
        [btPlayPause setTitle:title forState:UIControlStateNormal];
    }
}

-(IBAction)playSong:(id)sender
{
    NSString *title = [(UIButton *)sender currentTitle];
    if([title isEqualToString:@"⏸"])
    {
        [md.playerNode1 pause];
        title = @"▶";
        [btPlayPause setTitle:title forState:UIControlStateNormal];
    }
    else
    {
        [md adjustTimePitchUnit:1];
        md.playerNode1.volume = slVolume.value;
            [md.playerNode1 play];
            title = @"⏸";
            [btPlayPause setTitle:title forState:UIControlStateNormal];
    }
    
}

- (void)updateTimeLeft {
    //AVPlayerItem *currentItem = md.playerNode1.currentItem;
    NSTimeInterval timeLeft = 500;
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
        [btPlayPause setTitle:@"▶" forState:UIControlStateNormal];
        [md.playerNode1 pause];
        
        curSongSeconds = 0;
        curSongMinutes = 0;
        
        [lbSongLength setText:[NSString stringWithFormat:@"%02d:%02d/%02d:%02d",curSongMinutes, curSongSeconds, songMinute, songSeconds]];
        
    }
}

-(IBAction)sliderProgressChange:(id)sender
{
    //AVAudioPlayerItem *currentItem = md.playerNode1.currentItem;
    NSTimeInterval timeLeft = 0;
    NSTimeInterval dur = md.song.playbackDuration;
    [slProgress setMaximumValue:dur];
    [slProgress setValue:timeLeft];
}

-(IBAction)sliderVolumeChanged:(id)sender
{
    [self updateLabel];
    md.volNum = slVolume.value;
    md.volNum=md.volNum/100;
    //NSLog(@"%.2f", volNum);
    md.playerNode1.volume=md.volNum;
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
    [md.timePitchUnit1 setPitch:(key*100)];
    [lbKey setText:[md.keyArray objectAtIndex:key]];
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
    [self updateLabel];
    [slProgress setThumbImage:[UIImage new] forState:UIControlStateNormal];
    md = (AppDelegate *) [[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated {
    if(md.playerNode1){
        [md.playerNode1 stop];
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
