//
//  MineModels.m
//  MusicSound
//
//  Created by 大泽 on 15/6/19.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "MineModels.h"

@implementation MineModels

- (void)dealloc
{
    [_title release];
    [_icon release];
    
    [super dealloc];
}

- (instancetype)initWithTitle:(NSString *)title icon:(NSString *)icon
{
    if (self = [super init]) {
        
        self.title = title;
        self.icon = icon;
        
    }
    return self;
}

+ (instancetype)mineModelsWithTitle:(NSString *)title icon:(NSString *)icon
{
    return [[[self alloc] initWithTitle:title icon:icon] autorelease];
}

@end
