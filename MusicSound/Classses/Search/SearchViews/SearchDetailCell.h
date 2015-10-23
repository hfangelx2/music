//
//  SearchDetailCell.h
//  MusicSound
//
//  Created by shuwen on 15/6/29.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"

@interface SearchDetailCell : UITableViewCell

@property (nonatomic, retain) UILabel *song_nameLabel;

@property (nonatomic, retain) UILabel *singer_nameLabel;

@property (nonatomic, retain) SearchModel *searchModel;

@property (nonatomic, retain) UILabel *pick_countLabel;

@property (nonatomic, retain) UIImageView *collectImageView;

@property (nonatomic, retain) UIImageView *longLine;


@end





