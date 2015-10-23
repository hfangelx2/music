//
//  ThreeViewController.h
//  MusicSound
//
//  Created by 王言博 on 15/6/27.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelTableViewCell.h"
#import "ThreeHeaderView.h"
#import <MBProgressHUD.h>
#import "RootViewController.h"

@interface ThreeViewController : RootViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UITableView *myTableView;

@property (nonatomic, retain) ThreeHeaderView *musicHV;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, copy) NSString *msg_id;

@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic, copy) NSString *songListUrl;
@property (nonatomic, retain) NSMutableArray *cellArray;

@property (nonatomic, retain) MBProgressHUD *HUD;

@end
