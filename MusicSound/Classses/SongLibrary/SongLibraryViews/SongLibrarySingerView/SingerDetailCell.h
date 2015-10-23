//
//  SingerDetailCell.h
//  MusicSound
//
//  Created by shuwen on 15/6/27.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingerDetailModel.h"

@interface SingerDetailCell : UITableViewCell

@property (nonatomic, retain) UIImageView *singerDetailImageView;

@property (nonatomic, retain) UIImageView *smallSingerDetailImageView;

@property (nonatomic, retain) UILabel *singerDetailLabel;

@property (nonatomic, retain) SingerDetailModel *singerDetailModel;

@end
