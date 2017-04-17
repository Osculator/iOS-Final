//
//  MixViewController.m
//  Final Assignment
//
//  Created by Xcode User on 2017-04-16.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

#import "MixViewController.h"

@interface MixViewController ()

@end

@implementation MixViewController
@synthesize stWhole, stDecimal, md, slMix, bpmLabel, bpmOption;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    md = (AppDelegate *) [[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)tempoDecimalChanged:(id)sender{
    float decimal = stDecimal.value;
    [bpmLabel setText:[NSString stringWithFormat:@"%.1f bpm", decimal]];
    stWhole.value = decimal;
    md.mixBPM = decimal;
}

-(IBAction)tempoWholeChanged:(id)sender{
    float wholeNum = stWhole.value;
    [bpmLabel setText:[NSString stringWithFormat:@"%.1f bpm", wholeNum]];
    stDecimal.value = wholeNum;
    md.mixBPM = wholeNum;
}

-(IBAction)bpmOptionChanged:(UISegmentedControl*)sender {
    [self stopSongs:nil];
    NSInteger segmentIndex = [sender selectedSegmentIndex];
    [md.audioPlayer setEnableRate:YES];
    [md.audioPlayer2 setEnableRate:YES];
    
    if (segmentIndex == 0) {
        [md.audioPlayer setRate:1];
        [md.audioPlayer2 setRate:(md.songBPM / md.songBPM2)];
    } if (segmentIndex == 1) {
        [md.audioPlayer setRate:(md.songBPM2 / md.songBPM)];
        [md.audioPlayer2 setRate:1];
    } if (segmentIndex == 2){
        [md.audioPlayer setRate:(md.mixBPM / md.songBPM)];
        [md.audioPlayer2 setRate:(md.mixBPM / md.songBPM2)];
    }
}

-(IBAction)playPauseSongs:(id)sender {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
