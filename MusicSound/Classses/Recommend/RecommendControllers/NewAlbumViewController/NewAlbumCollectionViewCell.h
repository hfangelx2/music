//
//  NewAlbumCollectionViewCell.h
//  MusicSound
//
//  Created by 王言博 on 15/6/30.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumModel.h"

@interface NewAlbumCollectionViewCell : UICollectionViewCell
@property (nonatomic, retain) UIImageView *myImageView;
@property (nonatomic, retain) UILabel *label1;
@property (nonatomic, retain) UILabel *label2;

@property (nonatomic, retain) AlbumModel *myAlbumModel;
@end
