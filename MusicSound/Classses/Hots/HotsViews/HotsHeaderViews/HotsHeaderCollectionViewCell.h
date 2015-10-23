//
//  HotsHeaderCollectionViewCell.h
//  MusicSound
//
//  Created by 大泽 on 15/6/21.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotsHeaderModel;
@interface HotsHeaderCollectionViewCell : UICollectionViewCell

@property (retain, nonatomic) IBOutlet UIImageView *hotsHeaderImageView;

@property (nonatomic, retain) HotsHeaderModel *hotsHeaderModel;

@property (retain, nonatomic) IBOutlet UILabel *singer_Name;

@end
