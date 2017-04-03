//
//  songData.m
//  Final Assignment
//
//  Created by Xcode User on 2017-03-30.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

#import "songData.h"

@implementation songData
@synthesize artwork,songTitle,songArtist;

-(id)initWithTitle:(NSString *)t Artist:(NSString *)a Artwork:(MPMediaItemArtwork *)aw
{
    if(self = [super init])
    {
        [self setSongTitle:t];
        [self setSongArtist:a];
        [self setArtwork:aw];
    }
    return self;
}

@end
