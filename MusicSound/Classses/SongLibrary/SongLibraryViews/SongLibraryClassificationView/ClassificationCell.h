//
//  ClassificationCell.h
//  MusicSound
//
//  Created by shuwen on 15/6/26.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassificationModel.h"

@interface ClassificationCell : UICollectionViewCell

@property (nonatomic, retain) ClassificationModel *classificationModel;

//每个item上的图片
@property (nonatomic, retain) UIImageView *classificationImageView;

//每个item上的文字选项
@property (nonatomic, retain) UILabel *classificationLabel;



@end
