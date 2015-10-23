//
//  OneViewController.h
//  MusicSound
//
//  Created by 王言博 on 15/6/27.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelTableViewCell.h"
#import "HaibaoViewModel.h"
#import "oneHeaderView.h"
#import <MBProgressHUD.h>
#import "RootViewController.h"


@interface OneViewController : RootViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UITableView *myTableView;

@property (nonatomic, retain) oneHeaderView *musicHV;
@property (nonatomic, retain) UIPageControl *pageControl;

@property (nonatomic, copy) NSString *msg_id;
@property (nonatomic, retain) NSMutableArray *array;

@property (nonatomic, retain) NSString *songListUrl;
@property (nonatomic, retain) NSMutableArray *cellArray;

@property (nonatomic, retain) MBProgressHUD *HUD;

@end
