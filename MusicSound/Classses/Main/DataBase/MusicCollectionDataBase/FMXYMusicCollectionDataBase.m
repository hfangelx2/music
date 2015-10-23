//
//  FMXYMusicCollectionDataBase.m
//  MusicSound
//
//  Created by 大泽 on 15/7/3.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "FMXYMusicCollectionDataBase.h"
#import "HotsDetailModel.h"
@interface FMXYMusicCollectionDataBase ()

@property (nonatomic, retain) FMDatabaseQueue *queue;

@end

@implementation FMXYMusicCollectionDataBase

SingletonM(FMXYMusicCollectionDataBase);

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *file = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        NSLog(@"%@", file);
        file = [file stringByAppendingPathComponent:@"XYmusic.sqlite"];
        
        self.queue = [FMDatabaseQueue databaseQueueWithPath:file];
        
        [self.queue inDatabase:^(FMDatabase *db) {
            
            BOOL flag = [db executeUpdate:@"create table if not exists t_xyMusicCollection (number INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, singerName TEXT, urlList BLOB);"];
            if (flag) {
                NSLog(@"创建成功");
            } else {
                NSLog(@"创建失败");
            }
        }];
    }
    return self;
}


- (void)insertXYMusicWithHotsDeatilModel:(HotsDetailModel *)hotsDetailModel
{
    [self.queue inDatabase:^(FMDatabase *db) {
        
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:hotsDetailModel.urlList];
        
        BOOL flag = [db executeUpdate:@"insert into t_xyMusicCollection (name, singerName, urlList) values (?, ?, ?);", hotsDetailModel.name, hotsDetailModel.singerName, data];
        
        if (flag) {
            NSLog(@"插入成功");
        } else {
            NSLog(@"插入失败");
        }
        
    }];
}


- (NSMutableArray *)selectAllXYMusicHotsDetailModel
{
    NSMutableArray *array = [NSMutableArray array];
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *result = [db executeQuery:@"select * from t_xyMusicCollection;"];
        
        while ([result next]) {
            
            
            NSString *name = [result stringForColumn:@"name"];
            NSString *singerName = [result stringForColumn:@"singerName"];
            NSData *data = [result dataForColumn:@"urlList"];
            
           
            NSArray *urlList = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            HotsDetailModel *hotsDeatilM = [[HotsDetailModel alloc] init];
            
            hotsDeatilM.name = name;
            hotsDeatilM.singerName = singerName;
            hotsDeatilM.urlList = urlList;
            
            [array addObject:hotsDeatilM];
        }
    }];
    return array;
}

- (void)deleteAllXYMusic
{
    [self.queue inDatabase:^(FMDatabase *db) {
        
        [db executeUpdate:@"delete from t_xyMusicCollection;"];
        
    }];
}

- (HotsDetailModel *)selectWithName:(NSString *)name
{
    HotsDetailModel *hotsDatailModel = [[HotsDetailModel alloc] init];

    [self.queue inDatabase:^(FMDatabase *db) {
       
        FMResultSet *result = [db executeQuery:@"select * from t_xyMusicCollection where name = ?;", name];
        
        while ([result next]) {
            
            NSString *name = [result stringForColumn:@"name"];
            NSString *singerName = [result stringForColumn:@"singerName"];
            NSData *data = [result dataForColumn:@"urlList"];
            
            NSArray *urlList = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            hotsDatailModel.name = name;
            hotsDatailModel.singerName = singerName;
            hotsDatailModel.urlList = urlList;
            
        }
        
    }];
    
    if (hotsDatailModel.name == nil) {
        return nil;
    }
    
    return hotsDatailModel;
}

- (void)deleteFromDBWithName:(NSString *)name
{
    [self.queue inDatabase:^(FMDatabase *db) {
       
        [db executeUpdate:@"delete from t_xyMusicCollection where name = ?", name];
        
    }];
}

@end
