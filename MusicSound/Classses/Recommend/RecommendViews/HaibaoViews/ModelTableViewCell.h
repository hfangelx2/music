//
//  ModelTableViewCell.h
//  MusicSound
//
//  Created by 王言博 on 15/6/25.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HaibaoViewModel.h"
#import "songInfoModel.h"
#import "DajiaSongModel.h"

@interface ModelTableViewCell : UITableViewCell
@property (nonatomic, retain) UIButton *addButton; //收藏❤️按钮
@property (nonatomic, retain) UIImageView *bacgImageV;
@property (nonatomic, retain) UILabel *loveCount; // 喜欢人数
@property (nonatomic, retain) UIImageView *SQImageView;
@property (nonatomic, retain) UIImageView *MVImageView;
@property (nonatomic, retain) UILabel *actorLabel; // 歌曲作者
@property (nonatomic, retain) UILabel *songNameL; // 歌曲名
@property (nonatomic, retain) UILabel *limiLabel;

@property (nonatomic, retain) songInfoModel *bigModel;
@property (nonatomic, retain) NSIndexPath *cellIndexPath;

@property (nonatomic, retain) DajiaSongModel *cellSongModel;
@end
