//
//  FMXYMusicCollectionDataBase.h
//  MusicSound
//
//  Created by 大泽 on 15/7/3.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HotsDetailModel;
@interface FMXYMusicCollectionDataBase : NSObject

SingletonH(FMXYMusicCollectionDataBase);

- (void)insertXYMusicWithHotsDeatilModel:(HotsDetailModel *)hotsDetailModel;
- (NSMutableArray *)selectAllXYMusicHotsDetailModel;
- (void)deleteAllXYMusic;
- (HotsDetailModel *)selectWithName:(NSString *)name;
- (void)deleteFromDBWithName:(NSString *)name;
@end
