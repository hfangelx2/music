//
//  twoHeaderView.h
//  MusicSound
//
//  Created by 王言博 on 15/6/27.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HaibaoViewModel.h"

@interface twoHeaderView : UIScrollView
@property (nonatomic, retain) UIImageView *leftIV;

@property (nonatomic, retain) UILabel *rightL;

@property (nonatomic, retain) NSMutableArray *array;

@property (nonatomic, retain) HaibaoViewModel *myHaiModel;

@property (nonatomic, retain) UILabel *textRight;
@end
