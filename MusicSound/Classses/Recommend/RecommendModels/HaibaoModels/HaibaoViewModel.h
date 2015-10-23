//
//  HaibaoViewModel.h
//  MusicSound
//
//  Created by 王言博 on 15/6/25.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SonglistsModel.h"
#import "PicsModel.h"

@interface HaibaoViewModel : NSObject
@property (nonatomic, copy) NSString *songlistname;
@property (nonatomic, copy) NSString *songlistid; // 网址参数
@property (nonatomic, copy) NSString *repost_count; // 分享人数
@property (nonatomic, copy) NSString *type; // type = 3
@property (nonatomic, copy) NSString *tweet; // 3.简介
@property (nonatomic, retain) NSArray *songlist; // 所有song_id
@property (nonatomic, retain) NSArray *pics; // 1.图片

@property (nonatomic, retain) NSMutableArray *allHaiViewModel;

@property (nonatomic, retain) SonglistsModel *mySonglistsModel;
@property (nonatomic, retain) PicsModel *myPicsModel;


//@property (nonatomic, copy) NSString *favorite_count;
@end
