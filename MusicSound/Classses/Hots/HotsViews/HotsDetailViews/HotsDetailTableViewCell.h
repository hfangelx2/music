//
//  HotsDetailTableViewCell.h
//  MusicSound
//
//  Created by 大泽 on 15/6/22.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotsDetailFrameModel;
@class FavButton;
@interface HotsDetailTableViewCell : UITableViewCell

// 1.歌名
@property (nonatomic, retain) UILabel *name;

// 2.歌手名字
@property (nonatomic, retain) UILabel *singerName;

// 3.受欢迎度
@property (nonatomic, retain) FavButton *favorites;

// 4.高清图片
@property (nonatomic, retain) UIImageView *hq;

// 5.分割线
@property (nonatomic, retain) UIView *line;

@property (nonatomic, retain) UILabel *favoritesCount;


@property (nonatomic, retain) HotsDetailFrameModel *hotsDetailFM;

@end
