//
//  RecommendModel.h
//  MusicSound
//
//  Created by 大泽 on 15/6/19.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Action.h"
#import "Data.h"

@interface RecommendModel : NSObject

// songlists 中所存储的数据如下
@property (nonatomic, retain) NSArray *data; // data里面存储的是字典
@property (nonatomic, retain) NSDictionary *action;
@property (nonatomic, copy) NSString *style;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc; // 模块名称(海报)
@property (nonatomic, retain) NSArray *promotionzones;// 存储登陆


@property (nonatomic, retain) NSMutableArray *dataArray;

// model 套 model
@property (nonatomic, retain) Action *myAction;
@property (nonatomic, retain) Data *myData;
@end
