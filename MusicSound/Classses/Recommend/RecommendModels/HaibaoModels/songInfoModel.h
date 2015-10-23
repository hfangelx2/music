//
//  songInfoModel.h
//  MusicSound
//
//  Created by 王言博 on 15/6/26.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Url_listModel.h"

@interface songInfoModel : NSObject
@property (nonatomic, copy) NSString *singer_name; //歌曲演唱者
@property (nonatomic, copy) NSString *song_name; // 歌曲名
@property (nonatomic, assign) NSInteger pick_count; // pick人数

@property (nonatomic, retain) NSArray *url_list;

@property (nonatomic, retain) Url_listModel *myUrl_listModel;
@property (nonatomic, retain) NSMutableArray *allUrl_list;
@end
