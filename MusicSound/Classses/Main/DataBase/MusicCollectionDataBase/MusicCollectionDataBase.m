//
//  MusicCollectionDataBase.m
//  MusicSound
//
//  Created by 大泽 on 15/6/30.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "MusicCollectionDataBase.h"
#import "HotsDetailModel.h"
@implementation MusicCollectionDataBase

SingletonM(MusicCollectionDataBase);

static sqlite3 *db = nil;

// 4.打开数据库
- (void)openDB
{
    if (db != nil) {
        return; // 如果数据库对象存在 则不往下执行
    }
    
    
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString *filePath = [array lastObject];
    NSString *sqlitePath = [filePath stringByAppendingPathComponent:@"dataBase.sqlite"];
    
    NSLog(@"path = %@", sqlitePath);
    
    // 打开数据库函数  UTF8String  转成c语言文字
    // 将数据库对象与数据库文件关联 并打开数据库
    int result = sqlite3_open(sqlitePath.UTF8String, &db);
    if (result == SQLITE_OK) {
        
        NSLog(@"打开数据库成功");
        
    } else {
        
        NSLog(@"打开失败");
        
    }
}

#warning 创建表

// 创建表
- (void)createTable
{
    
    [self openDB];
    
    // 写建表的sql语句
    NSString *sql = @"CREATE TABLE IF NOT EXISTS xy_DetailCollection (number INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, singerName TEXT, url TEXT, duration TEXT)";
    
    // 执行sql语句
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, nil);
    
    if (result == SQLITE_OK) {
        
        NSLog(@"创建表成功");
        
    } else {
        
        NSLog(@"创建表失败");
        
    }
    
}

// 插入
- (void)insertHotsHomeModel:(HotsDetailModel *)hotsHomeModel
{
    // SQL 语句 number 是主键:自动递增
    
    NSDictionary *dic = hotsHomeModel.urlList.lastObject;
    NSString *url = dic[@"url"];
    NSString *duration = dic[@"duration"];
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO xy_DetailCollection (name, singerName, url, duration) VALUES('%@', '%@', '%@', '%@')", hotsHomeModel.name, hotsHomeModel.singerName, url, duration];
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, nil);
    
    if (result == SQLITE_OK) {
        
        NSLog(@"插入成功");
        
    } else {
        
        NSLog(@"插入失败");
        
    }
}



// 查询
- (NSMutableArray *)selectAllHotsHomeModel
{
    [self openDB];
    
    NSString *sql = @"SELECT * FROM xy_DetailCollection";
    
    // 创建数据库跟随指针对象
    sqlite3_stmt *stmt = nil;
    
    // 查询准备操作
    // 参数3 -1代表不限制sql语句长度
    // 主要作用是将数据库对象db, sql语句, 数据库跟随指针关联到一起, 以便数据库进行查询操作
    int result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, nil);
    
    NSMutableArray *array = [NSMutableArray array];
    
    if (result == SQLITE_OK) {
        
        NSLog(@"准备成功");
        //ID, title, pic_url, details, songlist
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            // 取出表中每行中的每个字段的数据
            //            int number = sqlite3_column_int(stmt, 0);
            
            const unsigned char *name = sqlite3_column_text(stmt, 1);
            const unsigned char *singerName = sqlite3_column_text(stmt, 2);
            
            
            NSString *xy_HotsDetailName = [NSString stringWithUTF8String:(const char*)name];
            NSString *xy_HotsDetailSingerName = [NSString stringWithUTF8String:(const char*)singerName];
            
            HotsDetailModel *hotDetailModel = [[HotsDetailModel alloc] init];
            
            hotDetailModel.name = xy_HotsDetailName;
            hotDetailModel.singerName = xy_HotsDetailSingerName;
            
            [array addObject:hotDetailModel];
            
        }
        sqlite3_finalize(stmt);  // 把 stmt 释放掉
        
        return array;
        
    } else {
        NSLog(@"准备失败");
    }
    
    sqlite3_finalize(stmt);  // 把 stmt 释放掉
    
    return nil;
}

// 查询单个的
- (HotsDetailModel *)searchWithName:(NSString *)name
{
    
    [self openDB];
    
    NSString *str = [NSString stringWithFormat:@"select name, singerName, url duration from xy_DetailCollection where name = '%@'", name];
    
    // 定义数据库查询结果
    sqlite3_stmt *stmt;
    
    // 执行SQL语句 并把查询到的结果赋值到stmt中
    int result = sqlite3_prepare(db, [str UTF8String], -1, &stmt, nil); // -1 代表无限长
    
    if (result == SQLITE_OK) {
        
        if (sqlite3_step(stmt) == SQLITE_ROW) {

            
            const unsigned char *name = sqlite3_column_text(stmt, 1);
            const unsigned char *singerName = sqlite3_column_text(stmt, 2);
            
            NSString *xy_HotsDetailName = [NSString stringWithUTF8String:(const char*)name];
            NSString *xy_HotsDetailSingerName = [NSString stringWithUTF8String:(const char*)singerName];
            
            HotsDetailModel *hotsDetailModel = [[HotsDetailModel alloc] init];
            
            hotsDetailModel.name = xy_HotsDetailName;
            hotsDetailModel.singerName = xy_HotsDetailSingerName;
            
            sqlite3_finalize(stmt);  // 把 stmt 释放掉
            
            return hotsDetailModel;
        }
    }
    
    sqlite3_finalize(stmt);  // 把 stmt 释放掉
    
    return nil;
}

// 删除表
- (void)dropTable
{
    
    [self openDB];
    
    NSString *sql = @"DROP TABLE xy_DetailCollection";
    
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, nil);
    
    if (result == SQLITE_OK) {
        
        NSLog(@"删除表成功");
        
    } else {
        
        NSLog(@"删除表失败");
        
    }
    
}

- (void)deleDBFromName:(NSString *)name
{
    [self openDB];
    
    NSString *sql = [NSString stringWithFormat:@"delete from xy_DetailCollection where name = '%@'", name];

    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, nil);
    
    if (result == SQLITE_OK) {
        NSLog(@"删除成功");
    } else {
        NSLog(@"删除失败");
    }
}

- (void)upDateFromDB:(NSString *)name
{
    [self openDB];
//    update info set studentname = '禹舜' where studentid = 1;
//    NSString *sqp = [NSString stringWithFormat:@"select from xy_DetailCollection where name = '%@'", name];
    NSString *upDateSql = [NSString stringWithFormat:@"update xy_DetailCollection set number = 1 where name = '%@'", name];
     sqlite3_exec(db, upDateSql.UTF8String, NULL, NULL, nil);
//    
//    if (result == SQLITE_OK) {
//        NSLog(@"更新成功");
//    } else {
//        NSLog(@"更新失败");
//    }
    
}

@end
