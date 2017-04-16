//
//  AppDelegate.m
//  Final Assignment
//
//  Created by Xcode User on 2017-03-19.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize keyArray, song, song2, volNum, volNum2, songBPM, songBPM2, engine, buffer, timePitchUnit1, timePitchUnit2, playerNode1, playerNode2, mixBPM, mixKey, songFile1, songFile2, song1Key, song2Key;

-(void)attachAndRouteNodes:(NSInteger)trackNumber{
    if (trackNumber == 1) {
        [engine attachNode:playerNode1];
        [engine attachNode:timePitchUnit1];
        [engine connect:playerNode1 to:engine.mainMixerNode format:buffer.format];
        [engine connect:timePitchUnit1 to:engine.mainMixerNode format:buffer.format];
    } if (trackNumber == 2) {
        [engine attachNode:playerNode2];
        [engine attachNode:timePitchUnit2];
        [engine connect:playerNode2 to:timePitchUnit2 format:buffer.format];
        [engine connect:timePitchUnit2 to:engine.mainMixerNode format:buffer.format];
    }
}

-(void)adjustTimePitchUnit:(NSInteger)unitNumber {
    if (unitNumber == 1){
        [timePitchUnit1 setRate:mixBPM-songBPM];
        [timePitchUnit1 setPitch:(mixKey*100) - (song1Key*100)];
    } else {
        [timePitchUnit2 setRate:mixBPM-songBPM2];
        [timePitchUnit2 setPitch:(mixKey*100) - (song2Key*100)];
    }
}

-(void)prepareForPlayback:(NSInteger)trackNumber {
    if (trackNumber == 1) {
        [playerNode1 scheduleFile:songFile1 atTime:nil completionHandler:nil];
    } if (trackNumber == 2) {
        [playerNode2 scheduleFile:songFile2 atTime:nil completionHandler:nil];
    } if (trackNumber == 0) {
        [playerNode1 scheduleFile:songFile1 atTime:nil completionHandler:nil];
        [playerNode2 scheduleFile:songFile2 atTime:nil completionHandler:nil];
    }
    [engine prepare];
    [engine startAndReturnError:nil];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    engine = [[AVAudioEngine alloc] init];
    playerNode1 = [[AVAudioPlayerNode alloc] init];
    playerNode2 = [[AVAudioPlayerNode alloc] init];
    mixBPM = 128;
    mixKey = 0;
    keyArray = [NSArray arrayWithObjects:@"C",@"C#",@"D",@"D#",@"E",@"F",@"F#",@"G",@"G#",@"A",@"A#",@"B",nil];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
