//
//  FMHotsHomeHeaderDataBase.m
//  MusicSound
//
//  Created by 大泽 on 15/7/1.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "FMHotsHomeHeaderDataBase.h"
#import "HotsHeaderModel.h"
@interface FMHotsHomeHeaderDataBase ()

@property (nonatomic, retain) FMDatabaseQueue *queue;

@end

@implementation FMHotsHomeHeaderDataBase

SingletonM(FMHotsHomeHeaderDataBase);

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *file = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        file = [file stringByAppendingPathComponent:@"XYmusic.sqlite"];
        
        self.queue = [FMDatabaseQueue databaseQueueWithPath:file];
        
        [self.queue inDatabase:^(FMDatabase *db) {
            
            BOOL flag = [db executeUpdate:@"create table if not exists t_xyMusicHeader (number INTEGER PRIMARY KEY AUTOINCREMENT, singer_id TEXT, singer_name TEXT, pic_url TEXT);"];
            if (flag) {
                NSLog(@"创建成功");
            } else {
                NSLog(@"创建失败");
            }
        }];
    }
    return self;
}


- (void)insertXYMusicWithHotsHeaderModel:(HotsHeaderModel *)hotsHeaderModel
{
    [self.queue inDatabase:^(FMDatabase *db) {
        
        BOOL flag = [db executeUpdate:@"insert into t_xyMusicHeader (singer_id, singer_name, pic_url) values (?, ?, ?);", hotsHeaderModel.singer_id, hotsHeaderModel.singer_name, hotsHeaderModel.pic_url];
        
        if (flag) {
            NSLog(@"插入成功");
        } else {
            NSLog(@"插入失败");
        }
        
    }];
}


- (NSMutableArray *)selectAllXYMusicHotsHomeHeaderModel
{
    NSMutableArray *array = [NSMutableArray array];
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *result = [db executeQuery:@"select * from t_xyMusicHeader;"];
        
        while ([result next]) {
            
            
            NSString *singer_id = [result stringForColumn:@"singer_id"];
            NSString *singer_name = [result stringForColumn:@"singer_name"];
            NSString *pic_url = [result stringForColumn:@"pic_url"];
           
            
            HotsHeaderModel *hotHeaderModel = [[HotsHeaderModel alloc] init];
            
            hotHeaderModel.singer_id = singer_id;
            hotHeaderModel.singer_name = singer_name;
            hotHeaderModel.pic_url = pic_url;
            
            [array addObject:hotHeaderModel];
        }
    }];
    return array;
}

- (void)deleteAllXYMusic
{
    [self.queue inDatabase:^(FMDatabase *db) {
        
        [db executeUpdate:@"delete from t_xyMusicHeader"];
        
    }];
}


@end
