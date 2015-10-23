//
//  SingerCell.h
//  MusicSound
//
//  Created by shuwen on 15/6/25.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingerModel.h"

@interface SingerCell : UICollectionViewCell


//每个item上的图片
@property (nonatomic, retain) UIImageView *singerImageView;

//每个item上的文字选项
@property (nonatomic, retain) UILabel *singerLabel;


@property (nonatomic, retain) SingerModel *singerModel;





@end









