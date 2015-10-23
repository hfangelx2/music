//
//  Data.h
//  MusicSound
//
//  Created by 王言博 on 15/6/22.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Action1.h"
@interface Data : NSObject
// 最里层data
@property (nonatomic, copy) NSString *_id; // type = 13时候, 传_id参数到指定网址
@property (nonatomic, copy) NSString *reason;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *pic_url;
@property (nonatomic, retain) NSDictionary *action;
@property (nonatomic, copy) NSString *listen_count;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *dataId;

@property (nonatomic, retain) Action1 *action1;

@end
