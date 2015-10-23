//
//  Url_listModel.m
//  MusicSound
//
//  Created by 王言博 on 15/6/26.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "Url_listModel.h"

@implementation Url_listModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (void)dealloc
{
    [_duration release];
    [_type release];
    [_type_description release];
    [_size release];
    [_url release];
    [super dealloc];
}
@end
