//
//  DestAndCurrentMusic.h
//  MusicSound
//
//  Created by 大泽 on 15/6/29.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYMusic.h"
@interface DestAndCurrentMusic : NSObject

SingletonH(DestAndCurrentMusic);

@property (nonatomic, retain) XYMusic *currentMusic;

@property (nonatomic, retain) XYMusic *destMusic;

@end
