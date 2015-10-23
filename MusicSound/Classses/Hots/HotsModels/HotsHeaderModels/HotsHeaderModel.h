//
//  HotsHeaderModel.h
//  MusicSound
//
//  Created by 大泽 on 15/6/21.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotsHeaderModel : NSObject

@property (nonatomic, copy) NSString *singer_id;

@property (nonatomic, copy) NSString *singer_name;

@property (nonatomic, copy) NSString *pic_url;

- (instancetype)initWithDic:(NSDictionary *)dic;

+ (instancetype)hotsHeaderModelWithDic:(NSDictionary *)dic;

+ (NSMutableArray *)hotsHeaderWithArray:(NSArray *)array;

@end
