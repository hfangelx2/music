//
//  HotsDetailFrameModel.h
//  MusicSound
//
//  Created by 大泽 on 15/6/22.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class HotsDetailModel;
@interface HotsDetailFrameModel : NSObject

/**
 *  歌名
 */
@property (nonatomic, assign) CGRect nameF;


/**
 *  歌手名字
 */
@property (nonatomic, assign) CGRect singerNameF;

/**
 *  受欢迎度
 */
@property (nonatomic, assign) CGRect favoritesF;

/**
 *  高清图片
 */
@property (nonatomic, assign) CGRect hqF;

/**
 *  分割线
 */
@property (nonatomic, assign) CGRect lineF;

/**
 *  行高
 */
@property (nonatomic, assign) CGFloat cellH;

@property (nonatomic, retain) HotsDetailModel *hotsDetailModel;

@end
