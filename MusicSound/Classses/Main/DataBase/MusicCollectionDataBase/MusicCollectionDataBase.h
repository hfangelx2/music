//
//  MusicCollectionDataBase.h
//  MusicSound
//
//  Created by 大泽 on 15/6/30.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HotsDetailModel;
@interface MusicCollectionDataBase : NSObject

SingletonH(MusicCollectionDataBase);
- (void)createTable;

- (void)insertHotsHomeModel:(HotsDetailModel *)hotsHomeModel;

- (void)dropTable;

- (NSMutableArray *)selectAllHotsHomeModel;

- (HotsDetailModel *)searchWithName:(NSString *)name;

- (void)deleDBFromName:(NSString *)name;

- (void)upDateFromDB:(NSString *)name;
@end
