//
//  TOP100NameModel.m
//  MusicSound
//
//  Created by shuwen on 15/6/29.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "TOP100NameModel.h"

@implementation TOP100NameModel

- (void)dealloc
{
    [_singer_name release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
