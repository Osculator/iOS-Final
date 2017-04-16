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
@synthesize dp0, dp1, dp2, dp3, dp4, dp5, dp6, dp7, dp8, dp9, dp10, dp11, dp12, dp13, dp14, dp15, soundsArray;

-(IBAction)padPushed:(id)sender {
    /*NSString *path = [[NSBundle mainBundle] pathForResource:@"8bitClap" ofType:@"wav"];
     AVAudioPlayer* theAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
     theAudio.delegate = self;
     [theAudio play];*/
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
            /*if(dp4.isPlaying){
                NSLog(@"Playing");
                //[dp4 pause];
                dp4.currentTime=0;
                //[dp4 play];
                //[dp4 prepareToPlay];
                //[dp4 stop];
                //[dp4 play];
                //[dp4 prepareToPlay];
                
            }*/
            //[dp4 stop];
            dp4.currentTime=0;
            [dp4 play];
            //[dp4 prepareToPlay];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategoryPlayback error:nil];
    [AVAudioSession.sharedInstance setActive:true error:nil];
    [self loadSamples];
    //soundsArray = [NSArray arrayWithObjects:dp0, dp1, dp2, dp3, dp4, dp5, dp6, dp7, dp8, dp9, dp10, dp11, dp12, dp13, dp14, dp15, nil];
    //self.imageData = [NSArray arrayWithObjects:@"avatar1.png", @"avatar2.png", @"avatar3.png", nil];
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
    
    
    /*NSURL *dp0URL = [[NSURL alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"CleanFatKick" ofType:@"wav"]];
    NSURL *dp1URL = [[NSURL alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"Bicc" ofType:@"wav"]];
    NSURL *dp2URL = [[NSURL alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"BWBSnare" ofType:@"wav"]];
    NSURL *dp3URL = [[NSURL alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"LowSnare" ofType:@"wav"]];
    NSURL *dp4URL = [[NSURL alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"ICY808" ofType:@"wav"]];
    NSURL *dp5URL = [[NSURL alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"Rim" ofType:@"wav"]];
    NSURL *dp6URL = [[NSURL alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"8bitClap" ofType:@"wav"]];
    NSURL *dp7URL = [[NSURL alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"FrozeSnap" ofType:@"wav"]];
    NSURL *dp8URL = [[NSURL alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"ICYHiHat" ofType:@"wav"]];
    NSURL *dp9URL = [[NSURL alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"ICYOpenHat" ofType:@"wav"]];
    NSURL *dp10URL = [[NSURL alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"Shaker" ofType:@"wav"]];
    NSURL *dp11URL = [[NSURL alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"ICYPerc" ofType:@"wav"]];
    NSURL *dp12URL = [[NSURL alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"ICECREAM" ofType:@"wav"]];
    NSURL *dp13URL = [[NSURL alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"feels" ofType:@"wav"]];
    NSURL *dp14URL = [[NSURL alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"ICYVox" ofType:@"wav"]];
    NSURL *dp15URL = [[NSURL alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"Cry" ofType:@"wav"]];*/
    
    
    dp0=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp0String] error:NULL];
    dp1=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp1String] error:NULL];
    dp2=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp2String] error:NULL];
    dp3=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp3String] error:NULL];
    dp4=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp4String] error:NULL];
    dp5=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp5String] error:NULL];
    dp6=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp6String] error:NULL];
    dp7=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp7String] error:NULL];\
    dp8=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp8String] error:NULL];
    dp9=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp9String] error:NULL];
    dp10=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp10String] error:NULL];
    dp11=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp11String] error:NULL];
    dp12=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp12String] error:NULL];
    dp13=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp13String] error:NULL];
    dp14=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp14String] error:NULL];
    dp15=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:dp15String] error:NULL];
    
    /*dp0 = [[AVAudioPlayer alloc] initWithContentsOfURL:dp0URL error:nil];
    dp1 = [[AVAudioPlayer alloc] initWithContentsOfURL:dp1URL error:nil];
    dp2 = [[AVAudioPlayer alloc] initWithContentsOfURL:dp2URL error:nil];
    dp3 = [[AVAudioPlayer alloc] initWithContentsOfURL:dp3URL error:nil];
    dp4 = [[AVAudioPlayer alloc] initWithContentsOfURL:dp4URL error:nil];
    dp5 = [[AVAudioPlayer alloc] initWithContentsOfURL:dp5URL error:nil];
    dp6 = [[AVAudioPlayer alloc] initWithContentsOfURL:dp6URL error:nil];
    dp7 = [[AVAudioPlayer alloc] initWithContentsOfURL:dp7URL error:nil];
    dp8 = [[AVAudioPlayer alloc] initWithContentsOfURL:dp8URL error:nil];
    dp9 = [[AVAudioPlayer alloc] initWithContentsOfURL:dp9URL error:nil];
    dp10 = [[AVAudioPlayer alloc] initWithContentsOfURL:dp10URL error:nil];
    dp11 = [[AVAudioPlayer alloc] initWithContentsOfURL:dp11URL error:nil];
    dp12 = [[AVAudioPlayer alloc] initWithContentsOfURL:dp12URL error:nil];
    dp13 = [[AVAudioPlayer alloc] initWithContentsOfURL:dp13URL error:nil];
    dp14 = [[AVAudioPlayer alloc] initWithContentsOfURL:dp14URL error:nil];
    dp15 = [[AVAudioPlayer alloc] initWithContentsOfURL:dp15URL error:nil];*/
    
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
    
    //dp4.volume=8.0;
}

-(void)dealloc {
    [dp0 release];
    [dp1 release];
    [dp2 release];
    [dp3 release];
    [dp4 release];
    [dp5 release];
    [dp6 release];
    [dp7 release];
    [dp8 release];
    [dp9 release];
    [dp10 release];
    [dp11 release];
    [dp12 release];
    [dp13 release];
    [dp14 release];
    [dp15 release];
    [super dealloc];
}

/*-(MPMediaItem *)getMediaItemForURL:(NSURL *)url

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
