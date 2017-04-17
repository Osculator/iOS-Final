//
//  Track2ViewController.h
//  Final Assignment
//
//  Created by Xcode User on 2017-03-23.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

#import "AppDelegate.h"

@interface Track2ViewController : UIViewController<MPMediaPickerControllerDelegate>
{
    IBOutlet UISlider *slVolume2;
    IBOutlet UISegmentedControl *sgKeyFlag2;
    IBOutlet UISegmentedControl *sgSyncTempo2;
    IBOutlet UISegmentedControl *sgSyncKey2;
    IBOutlet UIStepper *stDecimal2;
    IBOutlet UIStepper *stWholeNum2;
    IBOutlet UIStepper *stKey2;
    IBOutlet UILabel *lbVolume2;
    IBOutlet UILabel *lbTempo2;
    IBOutlet UILabel *lbKey2;
    IBOutlet UILabel *lbSongTitle2;
    IBOutlet UILabel *lbArtist2;
    IBOutlet UIButton *btArtwork2;
    IBOutlet UILabel *lbSongLength2;
    //AVPlayer *audioPlayer2;
    MPMediaPickerController *track2Picker;
    //MPMediaItem *song2;
    IBOutlet UIButton *btPlayPause2;
    NSTimer *myTimer;
    NSTimer *myTimer2;
    IBOutlet UISlider *slProgress2;
    AppDelegate *md;
}

@property (strong, nonatomic) NSArray *keyArray2;
@property (strong, nonatomic) IBOutlet UISlider *slVolume2;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sgKeyFlag2;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sgSyncTempo2;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sgSyncKey2;
@property (strong, nonatomic) IBOutlet UIStepper *stDecimal2;
@property (strong, nonatomic) IBOutlet UIStepper *stWholeNum2;
@property (strong, nonatomic) IBOutlet UIStepper *stKey2;
@property (strong, nonatomic) IBOutlet UILabel *lbVolume2;
@property (strong, nonatomic) IBOutlet UILabel *lbTempo2;
@property (strong, nonatomic) IBOutlet UILabel *lbKey2;
@property (strong, nonatomic) IBOutlet UILabel *lbSongTitle2;
@property (strong, nonatomic) IBOutlet UILabel *lbArtist2;
@property (strong, nonatomic) IBOutlet UIButton *btArtwork2;
@property (strong, nonatomic) IBOutlet UILabel *lbSongLength2;
//@property (strong, nonatomic) IBOutlet AVPlayer *audioPlayer2;
@property (strong, nonatomic) MPMediaPickerController *track2Picker;
//@property (strong, nonatomic) MPMediaItem *song2;
@property (strong, nonatomic) IBOutlet UIButton *btPlayPause2;
@property (strong, nonatomic) NSTimer *myTimer;
@property (strong, nonatomic) NSTimer *myTimer2;
@property (strong, nonatomic) IBOutlet UISlider *slProgress2;
@property (strong, nonatomic) AppDelegate *md;



@end
