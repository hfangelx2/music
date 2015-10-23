//
//  SongLibraryCollectionViewCell.h
//  MusicSound
//
//  Created by shuwen on 15/6/22.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

@interface SongLibraryCollectionViewCell : UICollectionViewCell

//每个item上的图片
@property (nonatomic, retain) UIImageView *songLibraryImageView;

//每个item上的文字选项
@property (nonatomic, retain) UILabel *songLibraryLabel;

//图片
@property (nonatomic, copy) NSString *imageStr;

//文字
@property (nonatomic, copy) NSString *labelStr;


@end





