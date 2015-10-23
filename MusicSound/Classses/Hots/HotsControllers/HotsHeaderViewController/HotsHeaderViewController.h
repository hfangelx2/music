//
//  HotsHeaderViewController.h
//  MusicSound
//
//  Created by 大泽 on 15/6/21.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "RootViewController.h"

@interface HotsHeaderViewController : UIViewController

@property (nonatomic, copy) void(^option)(NSIndexPath *indexPath);

@property (nonatomic, retain) UICollectionView *collectionView;

@property (nonatomic, retain) NSMutableArray *collectionViewArray;

@end
