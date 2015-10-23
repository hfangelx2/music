//
//  SongLibraryGroup.h
//  MusicSound
//
//  Created by shuwen on 15/6/25.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongLibraryGroup : NSObject

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) Class destVc;

@property (nonatomic, copy) NSString *labelStr;

@property (nonatomic, copy) NSString *imageStr;

+ (instancetype)songLibraryGroupWithUrl:(NSString *)url
                                 destVc:(Class)destVc
                               labelStr:(NSString *)labelStr
                               imageStr:(NSString *)imageStr;

@end
