//
//  SearchDetailViewController.h
//  MusicSound
//
//  Created by shuwen on 15/6/29.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "RootViewController.h"

@interface SearchDetailViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy) NSString *searchText;

@end
