//
//  ThirdTableViewCell.h
//  MusicSound
//
//  Created by 王言博 on 15/6/22.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionViewCell.h"
#import "Data.h"
#import "HaibaoViewController.h"
#import <MBProgressHUD.h>

@interface ThirdTableViewCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) NSMutableArray *allDataArray;
@property (nonatomic, retain) Data *myData;

@property (nonatomic, copy) NSString *value;

@property (nonatomic, copy) void(^collectBlock)(NSString *value);
@property (nonatomic, retain) MBProgressHUD *HUD;
@end
