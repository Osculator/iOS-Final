//
//  DrumsViewController.h
//  Final Assignment
//
//  Created by Xcode User on 2017-04-15.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface DrumsViewController : UIViewController <AVAudioPlayerDelegate> {
    AVAudioPlayer *dp0, *dp1, *dp2, *dp3, *dp4, *dp5, *dp6, *dp7, *dp8, *dp9, *dp10, *dp11, *dp12, *dp13, *dp14, *dp15;
    NSArray *soundsArray;
}
@property (nonatomic, retain) AVAudioPlayer *dp0, *dp1, *dp2, *dp3, *dp4, *dp5, *dp6, *dp7, *dp8, *dp9, *dp10, *dp11, *dp12, *dp13, *dp14, *dp15;
@property (nonatomic, strong) NSArray *soundsArray;

-(IBAction)padPushed:(id)sender;
-(void)loadSamples;

@end
