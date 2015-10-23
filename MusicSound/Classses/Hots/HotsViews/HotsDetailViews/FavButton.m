//
//  FavButton.m
//  MusicSound
//
//  Created by 大泽 on 15/6/30.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "FavButton.h"
#import "HotsDetailModel.h"
@implementation FavButton
- (void)dealloc
{
    [_hotsDetailModel release];
    
    [super dealloc];
}

@end
