//
//  PlayerModels.m
//  MusicSound
//
//  Created by 大泽 on 15/6/19.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "XYMusic.h"
@implementation XYMusic

- (void)dealloc
{
    [_name release];
    [_singerName release];
    [_urlList release];
    
    [super dealloc];
}

- (instancetype)initWithName:(NSString *)name singerName:(NSString *)singerName urlList:(NSString *)urlList posterUrl:(NSString *)posterUrl duration:(NSString *)duration
{
    if (self = [super init]) {
        
        self.name = name;
        self.singerName = singerName;
        self.urlList = urlList;
        self.posterUrl = posterUrl;
        self.duration = duration;
        
    }
    return self;
}

+ (instancetype)musicWithName:(NSString *)name singerName:(NSString *)singerName urlList:(NSString *)urlList posterUrl:(NSString *)posterUrl duration:(NSString *)duration
{
    return [[[self alloc] initWithName:name singerName:singerName urlList:urlList posterUrl:posterUrl duration:duration] autorelease];
}

@end
