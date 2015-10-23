//
//  DajiaSongModel.h
//  MusicSound
//
//  Created by 王言博 on 15/6/29.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UrlListModel.h"
#import "MvListModel.h"

@interface DajiaSongModel : NSObject
@property (nonatomic, copy) NSString *songId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *singerName; // 歌手名
@property (nonatomic, copy) NSString *singerId;
@property (nonatomic, retain) NSArray *urlList;
@property (nonatomic, retain) NSArray *mvList;
@property (nonatomic, assign) NSInteger favorites;

@property (nonatomic, retain) UrlListModel *myUrlListModel;
@property (nonatomic, retain) MvListModel *myMvListModel;
@property (nonatomic, retain) NSMutableArray *allUrlListArr;
@property (nonatomic, retain) NSMutableArray *allMvListArr;
@end
