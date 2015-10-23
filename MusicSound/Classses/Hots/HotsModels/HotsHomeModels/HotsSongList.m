//
//  HotsSongList.m
//  MusicSound
//
//  Created by 大泽 on 15/6/20.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "HotsSongList.h"

@implementation HotsSongList

- (void)dealloc
{
    [_songName release];
    [_singerName release];
    
    [super dealloc];
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    return self;
}

+ (instancetype)hotsSongListWith:(NSDictionary *)dic
{
    return [[[self alloc] initWithDic:dic] autorelease];
}

@end
