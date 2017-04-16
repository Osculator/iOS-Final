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
    if([md.playerNode1 isPlaying])
        [md.playerNode1 pause];
    else
        [md.playerNode1 play];
    if([md.playerNode2 isPlaying])
        [md.playerNode2 pause];
    else
        [md.playerNode2 play];
}

-(IBAction)stopSongs:(id)sender
{
    [md.playerNode1 stop];
    [md.playerNode2 stop];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    md = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    md.volNum=50;
    md.volNum2=50;
}

-(void)viewWillDisappear:(BOOL)animated {
    if (md.playerNode1.isPlaying)
        [md.playerNode1 stop];
    if (md.playerNode2.isPlaying)
        [md.playerNode2 stop];
}

- (IBAction)unwindToThisViewController:(UIStoryboardSegue *)sender {
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
    md.playerNode1.volume=md.volNum;
    md.playerNode2.volume=md.volNum2;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
