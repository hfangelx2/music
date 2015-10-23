//
//  PlayerTools.m
//  MusicSound
//
//  Created by 大泽 on 15/6/26.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "PlayerTools.h"
#import "XYMusic.h"
#import "DestAndCurrentMusic.h"
@interface PlayerTools ()

@property (nonatomic, retain) NSURL *url;
@end

@implementation PlayerTools

SingletonM(PlayerTools);

- (void)preparePlayWithMusic:(XYMusic *)music
{
    NSString *urlStr = music.urlList;
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    self.streamer = [[STKAudioPlayer alloc] init];
        
    self.url = url;
    
    self.music = music;
    
    [DestAndCurrentMusic shareDestAndCurrentMusic].currentMusic = music;

}

- (void)start
{
    if (self.streamer) {
        
        if (ReachableViaWiFi | ReachableViaWWAN) {
            
            [self.streamer playURL:self.url];
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            //        dic[@"icon"] = self.music.posterUrl;
            dic[@"songName"] = self.music.name;
            dic[@"singName"] = self.music.singerName;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ToolBarNoti" object:nil userInfo:dic];
            
        }  
    }
}
/**
 *  暂停状态恢复播放
 */
- (void)resume
{
    [self.streamer resume];
    
}


- (void)pause
{
    [self.streamer pause];
}

- (void)stop
{
    if (self.streamer) {
        
        [self.streamer stop];
        
        [self.streamer release];
    }
}


@end
