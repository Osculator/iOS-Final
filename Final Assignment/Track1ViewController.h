//
//  Track1ViewController.h
//  Final Assignment
//
//  Created by Xcode User on 2017-03-20.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface Track1ViewController : UIViewController <MPMediaPickerControllerDelegate>{
    IBOutlet UISlider *slVolume;
    IBOutlet UISegmentedControl *sgKeyFlag;
    IBOutlet UISegmentedControl *sgSyncTempo;
    IBOutlet UISegmentedControl *sgSyncKey;
    IBOutlet UIStepper *stDecimal;
    IBOutlet UIStepper *stWholeNum;
    IBOutlet UIStepper *stKey;
    IBOutlet UILabel *lbVolume;
    IBOutlet UILabel *lbTempo;
    IBOutlet UILabel *lbKey;
    IBOutlet UILabel *lbSongTitle;
    IBOutlet UILabel *lbArtist;
    IBOutlet UIButton *btArtwork;
    IBOutlet UILabel *lbSongLength;
    AVPlayer *audioPlayer;
    MPMediaPickerController *track1Picker;
    MPMediaItem *song;
    IBOutlet UIButton *btPlayPause;
    NSTimer *myTimer;
    NSTimer *myTimer2;
    IBOutlet UISlider *slProgress;
    
}

@property (strong, nonatomic) NSArray *keyArray;
@property (strong, nonatomic) IBOutlet UISlider *slVolume;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sgKeyFlag;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sgSyncTempo;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sgSyncKey;
@property (strong, nonatomic) IBOutlet UIStepper *stDecimal;
@property (strong, nonatomic) IBOutlet UIStepper *stWholeNum;
@property (strong, nonatomic) IBOutlet UIStepper *stKey;
@property (strong, nonatomic) IBOutlet UILabel *lbVolume;
@property (strong, nonatomic) IBOutlet UILabel *lbTempo;
@property (strong, nonatomic) IBOutlet UILabel *lbKey;
@property (strong, nonatomic) IBOutlet UILabel *lbSongTitle;
@property (strong, nonatomic) IBOutlet UILabel *lbArtist;
@property (strong, nonatomic) IBOutlet UIButton *btArtwork;
@property (strong, nonatomic) IBOutlet UILabel *lbSongLength;
@property (strong, nonatomic) IBOutlet AVPlayer *audioPlayer;
@property (strong, nonatomic) MPMediaPickerController *track1Picker;
@property (strong, nonatomic) MPMediaItem *song;
@property (strong, nonatomic) IBOutlet UIButton *btPlayPause;
@property (strong, nonatomic) NSTimer *myTimer;
@property (strong, nonatomic) NSTimer *myTimer2;
@property (strong, nonatomic) IBOutlet UISlider *slProgress;

@end
