//
//  HotsModel.h
//  天天动听
//
//  Created by 大泽 on 15/6/17.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HotsSongList;
@interface HotsModel : NSObject

// 1.二级页面传值的ID
@property (nonatomic, copy) NSString *ID;

// 2.歌曲标题
@property (nonatomic, copy) NSString *title;

// 3.单元格cell的图片
@property (nonatomic, copy) NSString *pic_url;

// 4.二级页面上的展示的内容
@property (nonatomic, copy) NSString *details;

// 5.一级页面展示的歌曲内容
@property (nonatomic, retain) NSArray *songlist;

// 6.songList模型
@property (nonatomic, retain) HotsSongList *songList;

- (instancetype)initWithDic:(NSDictionary *)dic;

+ (instancetype)hotsModelWithDic:(NSDictionary *)dic;

+ (NSMutableArray *)hotsWithArray:(NSArray *)array;

@end
