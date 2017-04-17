//
//  DrumsViewController.m
//  Final Assignment
//
//  Created by Xcode User on 2017-04-15.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

#import "DrumsViewController.h"
@interface DrumsViewController ()

@end

@implementation DrumsViewController
@synthesize dp0, dp1, dp2, dp3, dp4, dp5, dp6, dp7, dp8, dp9, dp10, dp11, dp12, dp13, dp14, dp15, soundsArray, md;

-(IBAction)padPushed:(id)sender {
    NSInteger tag = [sender tag];
    switch (tag) {
        case 0:
            dp0.currentTime=0;
            [dp0 play];
            [dp0 prepareToPlay];
            return;
        case 1:
            dp1.currentTime=0;
            [dp1 play];
            [dp1 prepareToPlay];
            return;
        case 2:
            dp2.currentTime=0;
            [dp2 play];
            [dp2 prepareToPlay];
            return;
        case 3:
            dp3.currentTime=0;
            [dp3 play];
            [dp3 prepareToPlay];
            return;
        case 4:
            dp4.currentTime=0;
            [dp4 play];
            [dp4 prepareToPlay];
            return;
        case 5:
            dp5.currentTime=0;
            [dp5 play];
            [dp5 prepareToPlay];
            return;
        case 6:
            dp6.currentTime=0;
            [dp6 play];
            [dp6 prepareToPlay];
            return;
        case 7:
            dp7.currentTime=0;
            [dp7 play];
            [dp7 prepareToPlay];
            return;
        case 8:
            dp8.currentTime=0;
            [dp8 play];
            [dp8 prepareToPlay];
            return;
        case 9:
            dp9.currentTime=0;
            [dp9 play];
            [dp9 prepareToPlay];
            return;
        case 10:
            dp10.currentTime=0;
            [dp10 play];
            [dp10 prepareToPlay];
            return;
        case 11:
            dp11.currentTime=0;
            [dp11 play];
            [dp11 prepareToPlay];
            return;
        case 12:
            dp12.currentTime=0;
            [dp12 play];
            [dp12 prepareToPlay];
            return;
        case 13:
            dp13.currentTime=0;
            [dp13 play];
            [dp13 prepareToPlay];
            return;
        case 14:
            dp14.currentTime=0;
            [dp14 play];
            [dp14 prepareToPlay];
            return;
        case 15:
            dp15.currentTime=0;
            [dp15 play];
            [dp15 prepareToPlay];
            return;
    }
}

-(IBAction)playPauseSong:(id)sender{
    if([md.audioPlayer isPlaying])
        [md.audioPlayer pause];
    else
        [md.audioPlayer play];
    
    if([md.audioPlayer2 isPlaying])
        [md.audioPlayer2 pause];
    else
        [md.audioPlayer2 play];
}

-(IBAction)stopSongs:(id)sender
{
    [md.audioPlayer pause];
    md.audioPlayer.currentTime=0;
    [md.audioPlayer2 pause];
    md.audioPlayer2.currentTime=0;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    md = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self loadSamples];
}



-(void)loadSamples {
    
    NSString *dp0String = [[NSBundle mainBundle] pathForResource:@"CleanFatKick" ofType:@"wav"];
    NSString *dp1String = [[NSBundle mainBundle] pathForResource:@"Bicc" ofType:@"wav"];
    NSString *dp2String = [[NSBundle mainBundle] pathForResource:@"BWBSnare" ofType:@"wav"];
    NSString *dp3String = [[NSBundle mainBundle] pathForResource:@"LowSnare" ofType:@"wav"];
    NSString *dp4String = [[NSBundle mainBundle] pathForResource:@"ICY808" ofType:@"wav"];
    NSString *dp5String = [[NSBundle mainBundle] pathForResource:@"Rim" ofType:@"wav"];
    NSString *dp6String = [[NSBundle mainBundle] pathForResource:@"8bitClap" ofType:@"wav"];
    NSString *dp7String = [[NSBundle mainBundle] pathForResource:@"FrozeSnap" ofType:@"wav"];
    NSString *dp8String = [[NSBundle mainBundle] pathForResource:@"ICYHiHat" ofType:@"wav"];
    NSString *dp9String = [[NSBundle mainBundle] pathForResource:@"ICYOpenHat" ofType:@"wav"];
    NSString *dp10String = [[NSBundle mainBundle] pathForResource:@"Shaker" ofType:@"wav"];
    NSString *dp11String = [[NSBundle mainBundle] pathForResource:@"ICYPerc" ofType:@"wav"];
    NSString *dp12String = [[NSBundle mainBundle] pathForResource:@"ICECREAM" ofType:@"wav"];
    NSString *dp13String = [[NSBundle mainBundle] pathForResource:@"feels" ofType:@"wav"];
    NSString *dp14String = [[NSBundle mainBundle] pathForResource:@"ICYVox" ofType:@"wav"];
    NSString *dp15String = [[NSBundle mainBundle] pathForResource:@"Cry" ofType:@"wav"];
    
    dp0=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp0String] error:NULL];
    dp1=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp1String] error:NULL];
    dp2=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp2String] error:NULL];
    dp3=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp3String] error:NULL];
    dp4=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp4String] error:NULL];
    dp5=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp5String] error:NULL];
    dp6=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp6String] error:NULL];
    dp7=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp7String] error:NULL];
    dp8=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp8String] error:NULL];
    dp9=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp9String] error:NULL];
    dp10=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp10String] error:NULL];
    dp11=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp11String] error:NULL];
    dp12=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp12String] error:NULL];
    dp13=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp13String] error:NULL];
    dp14=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp14String] error:NULL];
    dp15=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp15String] error:NULL];
    
    dp0.delegate = self;
    dp1.delegate = self;
    dp2.delegate = self;
    dp3.delegate = self;
    dp4.delegate = self;
    dp5.delegate = self;
    dp6.delegate = self;
    dp7.delegate = self;
    dp8.delegate = self;
    dp9.delegate = self;
    dp10.delegate = self;
    dp11.delegate = self;
    dp12.delegate = self;
    dp13.delegate = self;
    dp14.delegate = self;
    dp15.delegate = self;
    
    dp0.volume = dp1.volume = dp2.volume = dp3.volume = dp4.volume = dp5.volume = dp6.volume = dp7.volume = dp8.volume = dp9.volume = dp10.volume = dp11.volume = dp12.volume = dp13.volume = dp14.volume = dp15.volume = 1;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
