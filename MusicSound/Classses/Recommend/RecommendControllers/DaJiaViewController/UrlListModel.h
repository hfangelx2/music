//
//  UrlListModel.h
//  MusicSound
//
//  Created by 王言博 on 15/6/29.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UrlListModel : NSObject
@property (nonatomic, copy) NSString *bitRate; // 32 为压缩品质 128 为标准品质  192为高品质 320 为超高品质
@property (nonatomic, copy) NSString *duration; // 存储的毫秒
@property (nonatomic, copy) NSString *typeDescription; // 品质类型
@property (nonatomic, copy) NSString *suffix; // MP3/MP4格式
@property (nonatomic, copy) NSString *url; // 连接
@property (nonatomic, copy) NSString *size; // 内存大小 存储单位B

@end
