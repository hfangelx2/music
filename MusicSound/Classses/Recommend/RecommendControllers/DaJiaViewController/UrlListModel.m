//
//  UrlListModel.m
//  MusicSound
//
//  Created by 王言博 on 15/6/29.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "UrlListModel.h"

@implementation UrlListModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    
}
- (void)dealloc
{
    [_bitRate release];
    [_duration release];
    [_typeDescription release];
    [_suffix release];
    [_url release];
    [_size release];
    [super dealloc];
}
@end
