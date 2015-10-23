//
//  HotsHomeDataBase.m
//  MusicSound
//
//  Created by 大泽 on 15/6/29.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "HotsHomeDataBase.h"
#import "HotsModel.h"
#import "HotsSongList.h"
@implementation HotsHomeDataBase

SingletonM(HotsHomeDataBase);


static sqlite3 *db = nil;

// 4.打开数据库
- (void)openDB
{
    if (db != nil) {
        return; // 如果数据库对象存在 则不往下执行
    }
    
    
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
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
    NSString *sql = @"CREATE TABLE IF NOT EXISTS hotsHome (number INTEGER PRIMARY KEY AUTOINCREMENT, ID TEXT, title TEXT, pic_url TEXT, details TEXT, data BLOB)";
    
    // 执行sql语句
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, nil);
    
    if (result == SQLITE_OK) {
        
        NSLog(@"创建表成功");
        
    } else {
        
        NSLog(@"创建表失败");
        
    }
    
}

// 插入
- (void)insertHotsHomeModel:(HotsModel *)hotsHomeModel
{
    // SQL 语句 number 是主键:自动递增
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:hotsHomeModel.songlist options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO hotsHome (ID, title, pic_url, details, data) VALUES('%@', '%@', '%@', '%@', '%@')", hotsHomeModel.ID, hotsHomeModel.title, hotsHomeModel.pic_url, hotsHomeModel.details, data];
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
    
    NSString *sql = @"SELECT * FROM hotsHome";
    
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
            
            
            const unsigned char *ID = sqlite3_column_text(stmt, 1);
            const unsigned char *title = sqlite3_column_text(stmt, 2);
            const unsigned char *pic_url = sqlite3_column_text(stmt, 3);
            const unsigned char *details = sqlite3_column_text(stmt, 4);
            const void *data = sqlite3_column_blob(stmt, 5);
            
            
            NSString *hotsHomeID = [NSString stringWithUTF8String:(const char*)ID];
            NSString *hotsHomeTitle  = [NSString stringWithUTF8String:(const char*)title];
            NSString *hotsHomePic_url = [NSString stringWithUTF8String:(const char*)pic_url];
            NSString *hotsHomeDetails  = [NSString stringWithUTF8String:(const char*)details];
            NSArray *hotsHomeSongList = [NSJSONSerialization JSONObjectWithData:data options:NSUTF8StringEncoding error:nil];
            
            
            HotsModel *hotsHomeModel = [[HotsModel alloc] init];
            hotsHomeModel.ID = hotsHomeID;
            hotsHomeModel.title = hotsHomeTitle;
            hotsHomeModel.pic_url = hotsHomePic_url;
            hotsHomeModel.details = hotsHomeDetails;
            hotsHomeModel.songlist = hotsHomeSongList;
            
            
            [array addObject:hotsHomeModel];
            
        }
        sqlite3_finalize(stmt);  // 把 stmt 释放掉
        
        return array;
        
    } else {
        NSLog(@"准备失败");
    }
    
    sqlite3_finalize(stmt);  // 把 stmt 释放掉
    
    return nil;
}



// 删除表
- (void)dropTable
{
    
    [self openDB];
    
    NSString *sql = @"DROP TABLE hotsHome";
    
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, nil);
    
    if (result == SQLITE_OK) {
        
        NSLog(@"删除表成功");
        
    } else {
        
        NSLog(@"删除表失败");
        
    }
    
}



@end
