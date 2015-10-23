//
//  HotsHomeDataBase.h
//  MusicSound
//
//  Created by 大泽 on 15/6/29.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HotsModel;
@interface HotsHomeDataBase : NSObject

SingletonH(HotsHomeDataBase);

- (NSMutableArray *)selectAllHotsHomeModel;

- (void)insertHotsHomeModel:(HotsModel *)hotsHomeModel;

- (void)createTable;

- (void)dropTable;
@end
