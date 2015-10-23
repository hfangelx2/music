//
//  MVModel.m
//  MusicSound
//
//  Created by shuwen on 15/6/22.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "MVModel.h"

@implementation MVModel

- (void)dealloc
{
    [_MV_id release];
    [_title release];
    [_desc release];
    [_tag release];
    [_mvList release];
    [_bigPicUrl release];
    [_tagName1 release];
    [_tagColor1 release];
    [_tagName2 release];
    [_tagColor2 release];
    [_url release];
    [super dealloc];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if ([key isEqualToString:@"id"]) {
        self.MV_id = value;
    }
    
}


@end
