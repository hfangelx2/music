//
//  FMHotsHomeHeaderDataBase.h
//  MusicSound
//
//  Created by 大泽 on 15/7/1.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HotsHeaderModel;
@interface FMHotsHomeHeaderDataBase : NSObject

SingletonH(FMHotsHomeHeaderDataBase)

- (void)insertXYMusicWithHotsHeaderModel:(HotsHeaderModel *)hotsHeaderModel;

- (NSMutableArray *)selectAllXYMusicHotsHomeHeaderModel;

- (void)deleteAllXYMusic;

@end
