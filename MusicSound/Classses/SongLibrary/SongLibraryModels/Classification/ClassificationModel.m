//
//  ClassificationModel.m
//  MusicSound
//
//  Created by shuwen on 15/6/22.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "ClassificationModel.h"

@implementation ClassificationModel

- (void)dealloc
{
    [_songlist_id release];
    [_songlist_name release];
    [_details release];
    [_quantity release];
    [_parentname release];
    [_large_pic_url release];
    [_small_pic_url release];
    [super dealloc];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}



@end
