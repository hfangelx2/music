//
//  SearchModel.m
//  MusicSound
//
//  Created by shuwen on 15/6/29.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

- (void)dealloc
{
    [_song_name release];
    [_singer_name release];
    [_url release];
    [_url_list release];
    [_audition_list release];
    [super dealloc];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
