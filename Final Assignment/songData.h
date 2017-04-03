//
//  songData.h
//  Final Assignment
//
//  Created by Xcode User on 2017-03-30.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface songData : NSObject{
    NSString *songArtist;
    NSString *songTitle;
    //int songSeconds;
    //int songMinute;
    //int *songDuration;
    MPMediaItemArtwork *artwork;
}
@property(nonatomic, strong) NSString *songArtist;
@property(nonatomic, strong) NSString *songTitle;
//@property(nonatomic, strong) int *songDuration;
@property(nonatomic, strong) MPMediaItemArtwork *artwork;

-(id)initWithTitle:(NSString *)t Artist:(NSString *)a Artwork:(MPMediaItemArtwork *)aw;

@end
