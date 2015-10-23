//
//  SongLibraryGroup.m
//  MusicSound
//
//  Created by shuwen on 15/6/25.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "SongLibraryGroup.h"

@implementation SongLibraryGroup

- (void)dealloc
{
    [_url release];
    [_labelStr release];
    [_imageStr release];
    [super dealloc];
}

- (instancetype)initWithUrl:(NSString *)url destVc:(Class)destVc labelStr:(NSString *)labelStr imageStr:(NSString *)imageStr
{
    if (self = [super init]) {
        
        self.url = url;
        self.destVc = destVc;
        self.labelStr = labelStr;
        self.imageStr = imageStr;
        
    }
    return self;
}

+ (instancetype)songLibraryGroupWithUrl:(NSString *)url destVc:(Class)destVc labelStr:(NSString *)labelStr imageStr:(NSString *)imageStr
{
    return [[[self alloc] initWithUrl:url destVc:destVc labelStr:labelStr imageStr:imageStr] autorelease];
    
}


@end
