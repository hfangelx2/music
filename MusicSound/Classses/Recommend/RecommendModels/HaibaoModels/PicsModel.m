//
//  PicsModel.m
//  MusicSound
//
//  Created by 王言博 on 15/6/25.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "PicsModel.h"

@implementation PicsModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (void)dealloc
{
    [_pics release];
    [super dealloc];
}
@end
