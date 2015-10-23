//
//  MVCell.h
//  MusicSound
//
//  Created by shuwen on 15/6/26.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVModel.h"

@interface MVCell : UITableViewCell

@property (nonatomic, retain) MVModel *mvModel;

@property (nonatomic, retain) UIImageView *mvImageView;

@property (nonatomic, retain) UILabel *titleLabel;

@property (nonatomic, retain) UILabel *titlePartLabel;

@property (nonatomic, retain) UILabel *descLabel;

@property (nonatomic, retain) UILabel *tagNameLabel1;

@property (nonatomic, retain) UILabel *tagNameLabel2;

@property (nonatomic, retain) UIImageView *playImageView;

@property (nonatomic, retain) UIImageView *shortLine;

@property (nonatomic, retain) UIImageView *longLine;

@end




