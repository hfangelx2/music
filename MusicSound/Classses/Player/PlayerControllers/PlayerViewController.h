//
//  PlayerViewController.h
//  天天动听
//
//  Created by 大泽 on 15/6/16.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "PlayerView.h"

@interface PlayerViewController : RootViewController

+ (PlayerViewController *)shareInterface;

@property (nonatomic, copy) void(^hiddenBlock)();

@property (nonatomic, retain) NSMutableArray *musics;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, retain) PlayerView *player;

- (void)next;
- (void)previous;
@end
