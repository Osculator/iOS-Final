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
@synthesize keyArray2, slVolume2, sgKeyFlag2, sgSyncKey2, sgSyncTempo2, stKey2, stDecimal2, stWholeNum2, lbVolume2, lbTempo2, lbKey2, lbArtist2, lbSongTitle2, btArtwork2;

- (IBAction) chooseSong: (id) sender
{
    MPMediaPickerController *track1Picker =
    [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeMusic];
    
    track1Picker.delegate                     = self;
    track1Picker.allowsPickingMultipleItems   = NO;
    track1Picker.prompt                       = NSLocalizedString (@"Select any song from the list", @"Prompt to user to choose some songs to play");
    
    [self presentViewController:track1Picker animated:YES completion:nil];
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    if(mediaItemCollection)
    {
        MPMediaItem *song=[[mediaItemCollection items] objectAtIndex:0];
        if (! song) {
            return;
        }
        NSString *songArtist = [NSString stringWithFormat:@"%@", song.artist];
        NSString *songTitle = [NSString stringWithFormat:@"%@", song.title];
        [lbArtist2 setText:songArtist];
        [lbSongTitle2 setText:songTitle];
        
        CGSize artworkSize = CGSizeMake(30, 30);
        UIImage *artworkImage;
        MPMediaItemArtwork *artwork = [song valueForProperty: MPMediaItemPropertyArtwork];
        artworkImage = [artwork imageWithSize:artworkSize];
        
        if (artworkImage == nil) {
            NSLog(@"artwork not available");
            artworkImage = [UIImage imageNamed:@"AlbumArt1.png"];
        }
        NSLog(@"Albumn art should appear");
        [btArtwork2 setBackgroundImage:artworkImage forState:UIControlStateNormal];
        
    }
    
    
}

- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(IBAction)sliderVolumeChanged2:(id)sender
{
    [self updateLabel2];
}

-(IBAction)tempoDecimalChanged2:(id)sender{
    float decimal = stDecimal2.value;
    
    [lbTempo2 setText:[NSString stringWithFormat:@"%.1f bpm", decimal]];
    stWholeNum2.value = decimal;
}

-(IBAction)tempoWholeChanged2:(id)sender{
    float wholeNum = stWholeNum2.value;
    
    [lbTempo2 setText:[NSString stringWithFormat:@"%.1f bpm", wholeNum]];
    stDecimal2.value = wholeNum;
}

-(IBAction)keyChanged2:(id)sender {
    int key = stKey2.value;
    [lbKey2 setText:[keyArray2 objectAtIndex:key]];
}

-(void)updateLabel2
{
    float vol = slVolume2.value;
    NSString *strVol = [NSString stringWithFormat:@"%.0f%%", vol];
    
    [lbVolume2 setText:strVol];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    keyArray2 = [NSArray arrayWithObjects:@"A",@"A#",@"B",@"B#",@"C",@"D",@"D#",@"E",@"F",@"F#",@"G",@"G#",nil];
    [self updateLabel2];

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
