//
//  HaibaoViewController.h
//  MusicSound
//
//  Created by 王言博 on 15/6/25.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelTableViewCell.h" 
#import "HaibaoViewModel.h"  // 大的model
#import "SonglistsModel.h"
#import "HaiBaoHeaderView.h"
#import "songInfoModel.h"
#import "RecommendModel.h"
#import "Data.h"
#import "RootViewController.h"




@interface HaibaoViewController : RootViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, retain) RecommendModel *recomendModel;
@property (nonatomic, retain) Data *data;

@property (nonatomic, retain) HaiBaoHeaderView *musicHV;
@property (nonatomic, retain) UIPageControl *pageControl;

@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic, retain) NSMutableArray *cellArr;

@property (nonatomic, copy) NSString *songListUrl;
@end
