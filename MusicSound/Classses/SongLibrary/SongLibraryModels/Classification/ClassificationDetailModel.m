//
//  ClassificationDetailModel.m
//  MusicSound
//
//  Created by shuwen on 15/6/27.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "ClassificationDetailModel.h"

@implementation ClassificationDetailModel

- (void)dealloc
{
    [_singer_id release];
    [_singer_name release];
    [_pic_url release];
    [super dealloc];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
