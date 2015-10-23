//
//  FMHotsHomeDataBase.h
//  MusicSound
//
//  Created by 大泽 on 15/7/1.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HotsModel;

@interface FMHotsHomeDataBase : NSObject

SingletonH(FMHotsHomeDataBase);

- (void)insertXYMusicWithHomeModel:(HotsModel *)hotsHomeModel;

- (NSMutableArray *)selectAllXYMusicHotsHomeModel;

- (void)deleteAllXYMusic;
@end
