//
//  FMHotsHomeDataBase.m
//  MusicSound
//
//  Created by 大泽 on 15/7/1.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "FMHotsHomeDataBase.h"
#import "HotsModel.h"
@interface FMHotsHomeDataBase ()

@property (nonatomic, retain) FMDatabaseQueue *queue;

@end


@implementation FMHotsHomeDataBase

SingletonM(FMHotsHomeDataBase);

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *file = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        file = [file stringByAppendingPathComponent:@"XYmusic.sqlite"];
        
        self.queue = [FMDatabaseQueue databaseQueueWithPath:file];
        
        [self.queue inDatabase:^(FMDatabase *db) {
            
            BOOL flag = [db executeUpdate:@"create table if not exists t_xyMusicHome (number INTEGER PRIMARY KEY AUTOINCREMENT, ID TEXT, title TEXT, pic_url TEXT, details TEXT, data BLOB);"];
            if (flag) {
                NSLog(@"创建成功");
            } else {
                NSLog(@"创建失败");
            }
        }];
    }
    return self;
}


- (void)insertXYMusicWithHomeModel:(HotsModel *)hotsHomeModel
{
    
    NSArray *songList = hotsHomeModel.songlist;
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:songList];
    
    [self.queue inDatabase:^(FMDatabase *db) {
       
        BOOL flag = [db executeUpdate:@"insert into t_xyMusicHome (ID, title, pic_url, details, data) values (?, ?, ?, ?, ?);", hotsHomeModel.ID, hotsHomeModel.title, hotsHomeModel.pic_url, hotsHomeModel.details, data];
        
        if (flag) {
            NSLog(@"插入成功");
        } else {
            NSLog(@"插入失败");
        }
        
    }];
}


- (NSMutableArray *)selectAllXYMusicHotsHomeModel
{
    NSMutableArray *array = [NSMutableArray array];

    [self.queue inDatabase:^(FMDatabase *db) {
       
        FMResultSet *result = [db executeQuery:@"select * from t_xyMusicHome;"];

        while ([result next]) {
            
            
            NSString *ID = [result stringForColumn:@"ID"];
            NSString *title = [result stringForColumn:@"title"];
            NSString *pic_url = [result stringForColumn:@"pic_url"];
            NSString *details = [result stringForColumn:@"details"];
            
            NSData *data = [result dataForColumn:@"data"];
            NSArray *songlist = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            HotsModel *hotsModel = [[HotsModel alloc] init];
            hotsModel.ID = ID;
            hotsModel.title = title;
            hotsModel.pic_url = pic_url;
            hotsModel.details = details;
            hotsModel.songlist = songlist;
            
            [array addObject:hotsModel];
        }
    }];
    return array;

}

- (void)deleteAllXYMusic
{
    [self.queue inDatabase:^(FMDatabase *db) {
       
        [db executeUpdate:@"delete from t_xyMusicHome"];
        
    }];
}

@end
