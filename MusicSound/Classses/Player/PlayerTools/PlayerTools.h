//
//  PlayerTools.h
//  MusicSound
//
//  Created by 大泽 on 15/6/26.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StreamingKit/STKAudioPlayer.h>
@class XYMusic;
@interface PlayerTools : NSObject

SingletonH(PlayerTools);

@property (nonatomic, retain) STKAudioPlayer *streamer;
@property (nonatomic, retain) XYMusic *music;


/**
 *  准备开始播放
 *
 *  @param music 当前应当播放的音乐
 */
- (void)preparePlayWithMusic:(XYMusic *)music;

/**
 *  开始播放
 */
- (void)start;

/**
 *  暂停播放
 */
- (void)pause;

/**
 *  停止播放
 */
- (void)stop;

/**
 *  暂停恢复播放
 */
- (void)resume;
@end
