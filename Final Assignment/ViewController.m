//
//  ViewController.m
//  Final Assignment
//
//  Created by Xcode User on 2017-03-19.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

//AUTHOR: Patrick Simmons
//This class controls the main menu of the application. From this page you can go to all of the other pages by clicking onto the appropriate buttons. When you have songs selected you can play/pause both of the songs together.

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController
@synthesize md, lbArtist, lbArtist2, lbSongTitle, lbSongTitle2, btArtwork, btArtwork2;

//This method allows you to play/pause the tracks that you selected together
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

//This method allows you to stop the song and it restarts it
-(IBAction)stopSongs:(id)sender
{
    [md.audioPlayer pause];
    md.audioPlayer.currentTime=0;
    [md.audioPlayer2 pause];
    md.audioPlayer2.currentTime=0;
}

//When the app loads for the first time we set the volume to 50 for each track.
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    md = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    md.volNum=50;
    md.volNum2=50;
}

//This method happens when some one changes from this view and it will stop and restart each track.
//It will also remeber the volume the tracks were set at.
-(void)viewWillDisappear:(BOOL)animated {
    if(md.audioPlayer){
        [md.audioPlayer pause];
        md.audioPlayer.currentTime=0;
    }
    if(md.audioPlayer2){
        [md.audioPlayer2 pause];
        md.audioPlayer.currentTime=0;
    }
    md.audioPlayer.volume=md.volNum;
    md.audioPlayer2.volume=md.volNum2;
}

//When we come back to this view from one of the other views it will remember what songs
//should be played together and what tracks they are. They will show the album art for each song, artist,
//and song title. It also sets the volume for each song as well.
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
