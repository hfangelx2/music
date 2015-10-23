//
//  AppDelegate.h
//  aaas
//
//  Created by 大泽 on 15/6/12.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PlayerToolBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, copy) void(^remoteBlock)(UIEvent *event);

//- (void)toolBarAction:(PlayerToolBarController *)toolBar;

@end

