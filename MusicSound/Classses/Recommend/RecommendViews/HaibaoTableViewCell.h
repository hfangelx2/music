//
//  HaibaoTableViewCell.h
//  MusicSound
//
//  Created by 王言博 on 15/6/20.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyScrollView.h"

@interface HaibaoTableViewCell : UITableViewCell

@property (nonatomic, retain) NSMutableArray *allHaibaoArr;
@property (nonatomic, retain) MyScrollView *scrollV;

@property (nonatomic, retain) NSArray *dataArray;

@property (nonatomic, copy) void(^haiBaoBlcok)(NSString *value);
@property (nonatomic, copy) void(^haiBaoBlcok1)(NSString *value);


@end
