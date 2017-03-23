//
//  Track2ViewController.h
//  Final Assignment
//
//  Created by Xcode User on 2017-03-23.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface Track2ViewController : ViewController<MPMediaPickerControllerDelegate>
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



@end
