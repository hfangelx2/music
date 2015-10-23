//
//  UIBarButtonItem+Extension.m
//  MusicSound
//
//  Created by 大泽 on 15/6/20.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title image:(NSString *)image target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];

    [button setTitleColor:kColor(94, 148, 220) forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    
    if (image) {
        
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        button.contentMode = UIViewContentModeCenter;
    }
        
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}


@end
