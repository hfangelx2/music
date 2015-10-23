//
//  PlayerToolBarController.h
//  MusicSound
//
//  Created by 大泽 on 15/6/28.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerToolBarController : UIViewController

SingletonH(PlayerToolBarController);

@property (nonatomic, retain) UIButton *backBtn;

@property (nonatomic, retain) UIImageView *icon;

@property (nonatomic, copy) void(^toolBarBlock)();

@property (nonatomic, retain) UILabel *songName;

@property (nonatomic, retain) UILabel *singName;

@property (nonatomic, retain) UIButton *playerBtn;

- (void)playerOrPause:(UIButton *)btn;
@end
