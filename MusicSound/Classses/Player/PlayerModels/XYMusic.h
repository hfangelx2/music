//
//  PlayerModels.h
//  MusicSound
//
//  Created by 大泽 on 15/6/19.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYMusic : NSObject

/**
 *  歌曲名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  歌手名
 */
@property (nonatomic, copy) NSString *singerName;

/**
 *  歌曲链接
 */
@property (nonatomic, copy) NSString *urlList;

/**
 *  歌手图片链接
 */
@property (nonatomic, copy) NSString *posterUrl;

/**
 *  歌曲时长
 */
@property (nonatomic, copy) NSString *duration;




- (instancetype)initWithName:(NSString *)name
                  singerName:(NSString *)singerName
                     urlList:(NSString *)urlList
                      posterUrl:(NSString *)posterUrl
                    duration:(NSString *)duration;

/**
 *  便利构造器
 *
 *  @param name       歌曲名字
 *  @param singerName 歌手名字
 *  @param urlList    歌曲链接
 */

+ (instancetype)musicWithName:(NSString *)name
                   singerName:(NSString *)singerName
                      urlList:(NSString *)urlList
                    posterUrl:(NSString *)posterUrl
                     duration:(NSString *)duration;

@end
