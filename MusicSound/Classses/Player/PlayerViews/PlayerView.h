//
//  PlayerView.h
//  MusicSound
//
//  Created by 大泽 on 15/6/24.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYMusic.h"
@class PlayerView;

typedef enum {
    BtnStart,
    BtnPause,
    BtnNext,
    BtnPrevious,
    BtnBack,
    BtnMenu
}BtnType;

@protocol PlayerViewDelegate <NSObject>

- (void)PlayerViewDelegate:(PlayerView *)playerview BtnType:(BtnType)BtnType;

@end

@interface PlayerView : UIView

+ (instancetype)playWithFrame:(CGRect)frame;

@property (nonatomic, assign) BOOL disPlayStatue;

@property (nonatomic, assign) id<PlayerViewDelegate> delegate;

@property (nonatomic, assign, getter=isPlaying) BOOL playing;

@property (nonatomic, retain) XYMusic *playingMusic; // 当前播放的音乐

@property (nonatomic, retain) UIButton *playBtn;

@property (nonatomic, copy) void(^menuBtnOption)(UIButton *menuBtn);

/**
 *  歌手图片
 */
@property (nonatomic, retain) UIImageView *poster;

/**
 *  歌曲名字
 */
@property (nonatomic, retain) UILabel *songName;

/**
 *  歌手名字
 */
@property (nonatomic, retain) UILabel *singerName;

/**
 *  歌曲总时间
 */
@property (nonatomic, retain) UILabel *totalTime;

/**
 *  当前时间
 */
@property (nonatomic, retain) UILabel *currentTime;

//@property (nonatomic, retain) UIButton *progressBtn;

@property (nonatomic, retain) UISlider *slider;
- (void)startProgressTimer;
- (void)endProgressTimer;
- (void)beginAnimation;
- (void)startOrPause:(UIButton *)playBtn;

@end
