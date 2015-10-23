//
//  MvListModel.m
//  MusicSound
//
//  Created by 王言博 on 15/6/29.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "MvListModel.h"

@implementation MvListModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (void)dealloc
{
    [_videoId release];
    [_duration release];
    [_size release];
    [_picUrl release];
    [_suffix release];
    [_url release];
    [_typeDescription release];
    [super dealloc];
}
@end
