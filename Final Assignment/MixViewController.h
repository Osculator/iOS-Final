//
//  MixViewController.h
//  Final Assignment
//
//  Created by Xcode User on 2017-04-16.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MixViewController : UIViewController {
    AppDelegate *md;
    IBOutlet UIStepper *stWhole, *stDecimal;
    IBOutlet UISlider *slMix;
    IBOutlet UILabel *bpmLabel;
    IBOutlet UISegmentedControl *bpmOption;
}

@property (strong, nonatomic) AppDelegate *md;
@property (strong, nonatomic) IBOutlet UIStepper *stWhole, *stDecimal;
@property (strong, nonatomic) IBOutlet UILabel *bpmLabel;
@property (strong, nonatomic) IBOutlet UISlider *slMix;
@property (strong, nonatomic) IBOutlet IBOutlet UISegmentedControl *bpmOption;
    
@end
