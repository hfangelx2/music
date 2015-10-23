//
//  NewAlbumViewController.h
//  MusicSound
//
//  Created by 王言博 on 15/6/30.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewAlbumCollectionViewCell.h"
#import "AlbumModel.h"
#import <QuartzCore/QuartzCore.h>
#import "HaibaoViewController.h"
#import "RootViewController.h"

@interface NewAlbumViewController : RootViewController<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) UICollectionView *collectView;

@property(nonatomic,assign)NSInteger nextPage;//记录下一页
@property(nonatomic, retain) NSMutableDictionary *allWeekDic;
@property (nonatomic, retain) NSMutableArray *allWeekArr;
@property(nonatomic, retain) NSMutableArray *allAlbumArr;
@property (nonatomic, retain) NSMutableArray *allkeysArr;
@property (nonatomic, retain) AlbumModel *ii;
@property (nonatomic, retain) AlbumModel *jj;
@end
