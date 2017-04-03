//
//  ViewController.h
//  Final Assignment
//
//  Created by Xcode User on 2017-03-19.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>
/*#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVPlayer.h>
#import <AVFoundation/AVFoundation.h>*/
#import "AppDelegate.h"

@interface ViewController : UIViewController
{
    AppDelegate *md;
    IBOutlet UILabel *lbSongTitle;
    IBOutlet UILabel *lbArtist;
    IBOutlet UIButton *btArtwork;
    IBOutlet UILabel *lbSongTitle2;
    IBOutlet UILabel *lbArtist2;
    IBOutlet UIButton *btArtwork2;
}
//@property (strong, nonatomic) IBOutlet AVPlayer *audioPlayer;
//@property (strong, nonatomic) IBOutlet AVPlayer *audioPlayer2;
@property (strong, nonatomic) AppDelegate *md;
@property (strong, nonatomic) IBOutlet UILabel *lbSongTitle;
@property (strong, nonatomic) IBOutlet UILabel *lbArtist;
@property (strong, nonatomic) IBOutlet UIButton *btArtwork;
@property (strong, nonatomic) IBOutlet UILabel *lbSongTitle2;
@property (strong, nonatomic) IBOutlet UILabel *lbArtist2;
@property (strong, nonatomic) IBOutlet UIButton *btArtwork2;


@end

