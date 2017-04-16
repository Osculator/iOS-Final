//
//  AppDelegate.h
//  Final Assignment
//
//  Created by Xcode User on 2017-03-19.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "songData.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSArray *keyArray;
    NSMutableArray *someMutableArray;
    AVAudioPlayer *audioPlayer;
    AVAudioPlayer *audioPlayer2;
    MPMediaItem *song;
    MPMediaItem *song2;
    float volNum;
    float volNum2;
    int songBPM;
    float songBPM2;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSArray *keyArray;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer2;
@property (strong, nonatomic) MPMediaItem *song;
@property (strong, nonatomic) MPMediaItem *song2;
@property float volNum;
@property float volNum2;
@property int songBPM;
@property float songBPM2;


@end

