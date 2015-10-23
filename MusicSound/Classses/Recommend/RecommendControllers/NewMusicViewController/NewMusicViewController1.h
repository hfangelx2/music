//
//  NewMusicViewController.h
//  MusicSound
//
//  Created by 王言博 on 15/6/26.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCNavTabBarController.h"
#import "NewMusicModel.h"
#import "HaibaoViewController.h"


#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "RootViewController.h"


@interface NewMusicViewController1 : RootViewController
@property (nonatomic, retain) NSMutableArray *allBigArr;
@property (nonatomic, retain) OneViewController *oneVC;
@property (nonatomic, retain) TwoViewController *twoVC;
@property (nonatomic, retain) ThreeViewController *threeVC;
@property (nonatomic, copy) void (^titleBlock)(NSString *str);

@end
