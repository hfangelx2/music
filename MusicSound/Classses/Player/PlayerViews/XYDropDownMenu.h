//
//  XYDropDownMenu.h
//  MusicSound
//
//  Created by 大泽 on 15/6/28.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYDropDownMenu : UIView

@property (nonatomic, retain) UIViewController *contentVc;

+ (instancetype)showFrom:(UIView *)from;

- (void)dismiss;

@end
