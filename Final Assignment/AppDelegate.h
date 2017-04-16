//
//  AppDelegate.h
//  Final Assignment
//
//  Created by Xcode User on 2017-03-19.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "songData.h"

#define PLAY_BUTTON = "▶"
#define PAUSE_BUTTON = "⏸"
#define STOP_BUTTON = "⏹"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSArray *keyArray;
    NSMutableArray *someMutableArray;
    MPMediaItem *song;
    MPMediaItem *song2;
    float volNum;
    float volNum2;
    float songBPM;
    float songBPM2;
    
    float mixBPM;
    NSInteger mixKey;
    NSInteger song1Key;
    NSInteger song2Key;
    AVAudioPCMBuffer *buffer;
    AVAudioFile *songFile1;
    AVAudioFile *songFile2;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSArray *keyArray;
@property (strong, nonatomic) MPMediaItem *song;
@property (strong, nonatomic) MPMediaItem *song2;
@property float volNum;
@property float volNum2;
@property float songBPM;
@property float songBPM2;

@property float mixBPM;
@property NSInteger mixKey;
@property NSInteger song1Key;
@property NSInteger song2Key;
@property (strong, nonatomic) AVAudioEngine *engine;
@property (strong, nonatomic) AVAudioPlayerNode *playerNode1;
@property (strong, nonatomic) AVAudioPlayerNode *playerNode2;
@property (strong, nonatomic) AVAudioPCMBuffer *buffer;
@property (strong, nonatomic) AVAudioUnitTimePitch *timePitchUnit1;
@property (strong, nonatomic) AVAudioUnitTimePitch *timePitchUnit2;
@property (strong, nonatomic) AVAudioFile *songFile1;
@property (strong, nonatomic) AVAudioFile *songFile2;

-(void)attachAndRouteNodes:(NSInteger)trackNumber;
-(void)adjustTimePitchUnit:(NSInteger)unitNumber;
-(void)prepareForPlayback:(NSInteger)trackNumber;



@end

