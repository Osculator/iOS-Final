//
//  ViewController.m
//  Final Assignment
//
//  Created by Xcode User on 2017-03-19.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController
@synthesize md, lbArtist, lbArtist2, lbSongTitle, lbSongTitle2, btArtwork, btArtwork2;

-(IBAction)playPauseSong:(id)sender{
    if([md.audioPlayer isPlaying])
        [md.audioPlayer pause];
    else
        [md.audioPlayer play];
    if([md.audioPlayer2 isPlaying])
        [md.audioPlayer2 pause];
    else
        [md.audioPlayer2 play];
}

-(IBAction)stopSongs:(id)sender
{
    [md.audioPlayer pause];
    md.audioPlayer.currentTime=0;
    [md.audioPlayer2 pause];
    md.audioPlayer2.currentTime=0;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    md = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    md.volNum=50;
    md.volNum2=50;
}

-(void)viewWillDisappear:(BOOL)animated {
    if(md.audioPlayer){
        [md.audioPlayer pause];
        //[md.audioPlayer seekToTime:kCMTimeZero];
        md.audioPlayer.currentTime=0;
    }
    if(md.audioPlayer2){
        [md.audioPlayer2 pause];
        //[md.audioPlayer2 seekToTime:kCMTimeZero];
        md.audioPlayer.currentTime=0;
    }
    md.audioPlayer.volume=md.volNum;
    md.audioPlayer2.volume=md.volNum2;
}

- (IBAction)unwindToThisViewController:(UIStoryboardSegue *)sender {
    NSLog(@"%@", md.song.artist);
    NSString *songArtist = [NSString stringWithFormat:@"%@", md.song.artist];
    NSString *songTitle = [NSString stringWithFormat:@"%@", md.song.title];
    if([songArtist isEqualToString:@"(null)"])
        [lbArtist setText:@"Artist Unknown"];
    else
        [lbArtist setText:songArtist];
    if([songTitle isEqualToString:@"(null)"])
        [lbSongTitle setText:@"Title Unknown"];
    else
        [lbSongTitle setText:songTitle];
    
    CGSize artworkSize = CGSizeMake(30, 30);
    UIImage *artworkImage;
    MPMediaItemArtwork *artwork = [md.song valueForProperty: MPMediaItemPropertyArtwork];
    artworkImage = [artwork imageWithSize:artworkSize];
    
    if (artworkImage == nil) {
        NSLog(@"artwork not available");
        artworkImage = [UIImage imageNamed:@"AlbumArt1.png"];
    }
    [btArtwork setBackgroundImage:artworkImage forState:UIControlStateNormal];
    
    
    NSString *songArtist2 = [NSString stringWithFormat:@"%@", md.song2.artist];
    NSString *songTitle2 = [NSString stringWithFormat:@"%@", md.song2.title];
    if([songArtist2 isEqualToString:@"(null)"])
        [lbArtist2 setText:@"Artist Unknown"];
    else
        [lbArtist2 setText:songArtist2];
    if([songTitle2 isEqualToString:@"(null)"])
        [lbSongTitle2 setText:@"Title Unknown"];
    else
        [lbSongTitle2 setText:songTitle2];
    
    CGSize artworkSize2 = CGSizeMake(30, 30);
    UIImage *artworkImage2;
    MPMediaItemArtwork *artwork2 = [md.song2 valueForProperty: MPMediaItemPropertyArtwork];
    artworkImage2 = [artwork2 imageWithSize:artworkSize2];
    
    if (artworkImage2 == nil) {
        NSLog(@"artwork not available");
        artworkImage2 = [UIImage imageNamed:@"AlbumArt2.png"];
    }
    [btArtwork2 setBackgroundImage:artworkImage2 forState:UIControlStateNormal];
    md.audioPlayer.volume=md.volNum;
    md.audioPlayer2.volume=md.volNum2;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
