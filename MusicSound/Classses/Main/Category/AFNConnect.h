//
//  AFNConnect.h
//  豆瓣1.0
//
//  Created by 大泽 on 15/6/4.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFNConnect : NSObject


+ (void)AFNConnectWithUrl:(NSString *)urlStr key:(NSString *)key connectBlock:(void(^)(id data))myBlock;

                                                                               
@end
