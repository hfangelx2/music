//
//  MyCollectionViewCell.h
//  MusicSound
//
//  Created by 王言博 on 15/6/23.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>
#import "Data.h"

@interface MyCollectionViewCell : UICollectionViewCell
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *myLabel1; // 听的人数
@property (nonatomic, retain) UILabel *myLabel2; // 副标题
@property (nonatomic, retain) UILabel *myLabel3; // 提下标题

@property (nonatomic, retain) Data *myData;
@end
