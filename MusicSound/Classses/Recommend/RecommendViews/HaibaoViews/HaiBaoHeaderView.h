//
//  HaiBaoHeaderView.h
//  MusicSound
//
//  Created by 王言博 on 15/6/25.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HaibaoViewModel.h"
#import <UIImageView+WebCache.h>

@interface HaiBaoHeaderView : UIScrollView
@property (nonatomic, retain) NSMutableArray *array; // 存储一个haibaoViewModel
@property (nonatomic, retain) HaibaoViewModel *myHaiModel;

@property (nonatomic, retain) UIImageView *leftIV;

@property (nonatomic, retain) UILabel *rightL;
@property (nonatomic, retain) UILabel *textRight;
@property (nonatomic, copy) void (^headerBlock)(NSString *songlistName);

@end
