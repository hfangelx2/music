//
//  RecommendViewController.h
//  天天动听
//
//  Created by 大泽 on 15/6/12.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "RootViewController.h"
#import "RecommendModel.h"
#import "HaibaoTableViewCell.h"
#import "SecondTableViewCell.h"
#import "ThirdTableViewCell.h"
#import "Data.h"
#import "NewMusicViewController1.h"
#import "DajiaViewController.h"  // 大家在听VC
#import "MVVideoViewController.h"

#import "NewMusicModel.h"
#import "DajiaSongModel.h"

@interface RecommendViewController : RootViewController<UITableViewDataSource>
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *allModuleArr;


@property (nonatomic, retain) NSMutableArray *allBigArr;// 最新音乐
@property (nonatomic, retain) NSString *DajiaMVUrl;
@property (nonatomic, retain) DajiaSongModel *onlyMVModel;
@property (nonatomic, copy) void(^DajiaKanBlock)(DajiaSongModel *model);
@end
