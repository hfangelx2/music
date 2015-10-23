//
//  DajiaViewController.h
//  MusicSound
//
//  Created by 王言博 on 15/6/29.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "RootViewController.h"
#import "ModelTableViewCell.h"
#import <MJRefresh.h>
#import "DajiaSongModel.h"
#import "PlayerViewController.h"
#import "RootViewController.h"

@interface DajiaViewController : RootViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *allSongArray;
@property(nonatomic,assign)NSInteger nextPage;//记录下一页
@property(nonatomic,assign)BOOL isUpLoading;//标记上拉操作还是下拉操作，yes为上拉


@end
