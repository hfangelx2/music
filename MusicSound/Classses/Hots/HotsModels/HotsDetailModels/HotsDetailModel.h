//
//  HotsDetailModel.h
//  MusicSound
//
//  Created by 大泽 on 15/6/22.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotsDetailModel : NSObject

// 1.歌名
@property (nonatomic, copy) NSString *name;

// 2.歌手名字
@property (nonatomic, copy) NSString *singerName;

// 3.受欢迎度
@property (nonatomic, copy) NSNumber *favorites;

// 4.urlList
@property (nonatomic, retain) NSArray *urlList;

- (instancetype)initWithDic:(NSDictionary *)dic;

+ (instancetype)hotsDetailModelWithDic:(NSDictionary *)dic;

+ (NSMutableArray *)hotsDetailModelWithArray:(NSArray *)array;

@end
