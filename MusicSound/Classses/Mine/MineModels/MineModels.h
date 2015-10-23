//
//  MineModels.h
//  MusicSound
//
//  Created by 大泽 on 15/6/19.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineModels : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) void(^option)();


+ (instancetype)mineModelsWithTitle:(NSString *)title
                               icon:(NSString *)icon;
- (instancetype)initWithTitle:(NSString *)title
                         icon:(NSString *)icon;

@end
