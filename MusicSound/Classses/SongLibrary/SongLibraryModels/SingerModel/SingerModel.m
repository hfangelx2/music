//
//  SingerModel.m
//  MusicSound
//
//  Created by shuwen on 15/6/22.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "SingerModel.h"

@implementation SingerModel

- (void)dealloc
{
    [_singer_id release];
    [_title release];
    [_type release];
    [_style release];
    [_pic_url release];
    [_big_pic_url release];
    [_details release];
    [_time release];
    [_count release];
    [super dealloc];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.singer_id = value;
    }
    
    
}




@end








