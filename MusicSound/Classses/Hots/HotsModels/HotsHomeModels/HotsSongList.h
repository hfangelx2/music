//
//  HotsSongList.h
//  MusicSound
//
//  Created by 大泽 on 15/6/20.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotsSongList : NSObject

// 1.歌手的名字
@property (nonatomic, copy) NSString *singerName;

// 2.歌曲的名字
@property (nonatomic, copy) NSString *songName;

- (instancetype)initWithDic:(NSDictionary *)dic;

+ (instancetype)hotsSongListWith:(NSDictionary *)dic;

@end
