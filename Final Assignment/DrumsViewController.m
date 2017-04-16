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
@synthesize dp0, dp1, dp2, dp3, dp4, dp5, dp6, dp7, dp8, dp9, dp10, dp11, dp12, dp13, dp14, dp15;

-(IBAction)padPushed:(id)sender {
    NSInteger tag = [sender tag];
    switch (tag) {
        case 0:
            [dp0 play];
            return;
        case 1:
            [dp1 play];
            return;
        case 2:
            [dp2 play];
            return;
        case 3:
            [dp3 play];
            return;
        case 4:
            [dp4 play];
            return;
        case 5:
            [dp5 play];
            return;
        case 6:
            [dp6 play];
            return;
        case 7:
            [dp7 play];
            return;
        case 8:
            [dp8 play];
            return;
        case 9:
            [dp9 play];
            return;
        case 10:
            [dp10 play];
            return;
        case 11:
            [dp11 play];
            return;
        case 12:
            [dp12 play];
            return;
        case 13:
            [dp13 play];
            return;
        case 14:
            [dp14 play];
            return;
        case 15:
            [dp15 play];
            return;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategoryPlayback error:nil];
    [AVAudioSession.sharedInstance setActive:true error:nil];
    [self loadSamples];
}

-(void)loadSamples {
    NSURL *dp0URL = [[NSURL alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"CleanFatKick" ofType:@"wav"]];
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
    NSURL *dp15URL = [[NSURL alloc] initWithString:[[NSBundle mainBundle] pathForResource:@"Cry" ofType:@"wav"]];
    
    dp0 = [[AVAudioPlayer alloc] initWithContentsOfURL:dp0URL error:nil];
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
    dp15 = [[AVAudioPlayer alloc] initWithContentsOfURL:dp15URL error:nil];
    
    [dp0.delegate self];
    [dp1.delegate self];
    [dp2.delegate self];
    [dp3.delegate self];
    [dp4.delegate self];
    [dp5.delegate self];
    [dp6.delegate self];
    [dp7.delegate self];
    [dp8.delegate self];
    [dp9.delegate self];
    [dp10.delegate self];
    [dp11.delegate self];
    [dp12.delegate self];
    [dp13.delegate self];
    [dp14.delegate self];
    [dp15.delegate self];
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
