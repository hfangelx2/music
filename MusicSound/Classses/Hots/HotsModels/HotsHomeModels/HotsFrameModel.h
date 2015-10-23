//
//  HotsFrameModel.h
//  天天动听
//
//  Created by 大泽 on 15/6/17.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class HotsModel;
@interface HotsFrameModel : NSObject

@property (nonatomic, retain) HotsModel *hotsModel;

// 1.歌曲标题
@property (nonatomic, assign) CGRect title;

// 2.单元格cell图片
@property (nonatomic, assign) CGRect pic_url;

// 3.分割线
@property (nonatomic, assign) CGRect line;

// 4.第一首歌
@property (nonatomic, assign) CGRect firstSong;

// 5.第二首歌
@property (nonatomic, assign) CGRect secondSong;

// 6.第三首歌
@property (nonatomic, assign) CGRect thirdSong;

// cell行高
@property (nonatomic, assign) CGFloat cellH;

@end
