//
//  SingerDetailViewController.h
//  MusicSound
//
//  Created by shuwen on 15/6/27.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface SingerDetailViewController : RootViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, copy)NSString *passTitle;
@property(nonatomic, copy)NSString *passId;



@end





