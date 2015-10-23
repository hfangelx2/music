//
//  HotsHomeSongListDataBase.h
//  MusicSound
//
//  Created by 大泽 on 15/6/29.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HotsSongList;
@interface HotsHomeSongListDataBase : NSObject

SingletonH(HotsHomeSongListDataBase);

- (void)dropTable;
- (void)insertHotsHomeSongListModel:(HotsSongList *)hotsHomeSongListModel;
- (NSMutableArray *)selectAllHotsHomeSongListModel;
- (void)createTable;
@end
