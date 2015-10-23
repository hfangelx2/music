//
//  UIBarButtonItem+Extension.h
//  MusicSound
//
//  Created by 大泽 on 15/6/20.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title image:(NSString *)image target:(id)target action:(SEL)action;

@end
