//
//  MineGroup.m
//  MusicSound
//
//  Created by 大泽 on 15/6/21.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "MineGroup.h"

@implementation MineGroup

- (void)dealloc
{
    [_footer release];
    [_header release];
    [_items release];
    
    [super dealloc];
}

@end
