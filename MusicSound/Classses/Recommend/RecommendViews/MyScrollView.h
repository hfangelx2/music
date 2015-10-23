//
//  MyScrollView.h
//  MusicSound
//
//  Created by 王言博 on 15/6/21.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>
#import "RecommendModel.h"  //
#import "Data.h"



@interface MyScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, retain) UIScrollView *scroll;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic,retain) NSTimer *myTimer;

@property (nonatomic, retain) UIPageControl *pageControl;

- (void)setImages:(NSMutableArray *)names;
@property (nonatomic, retain) NSMutableArray *allHaibaoArr;

@property (nonatomic, retain) RecommendModel *aaaa;

@property (nonatomic, copy) void(^scrollBlock)(NSString *value);
@property (nonatomic, copy) void(^scrollBlock1)(NSString *value);
//+ (instancetype)shareHandleScrollV;
@end
