//
//  Url_listModel.h
//  MusicSound
//
//  Created by 王言博 on 15/6/26.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Url_listModel : NSObject
@property (nonatomic, copy) NSString *duration; // 播放时长
@property (nonatomic, copy) NSString *type_description; // 品质
@property (nonatomic, copy) NSString *type; // 1 2 4 按照品质优劣
@property (nonatomic, copy) NSString *size; // 歌曲大小
@property (nonatomic, copy) NSString *url; // 播放网址

@end
