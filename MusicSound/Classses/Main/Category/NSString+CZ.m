//
//  NSString+CZ.m
//  D02-音乐播放
//
//  Created by Vincent_Guo on 14-6-28.
//  Copyright (c) 2014年 vgios. All rights reserved.
//

#import "NSString+CZ.h"

@implementation NSString (CZ)

//+(NSString *)getMinuteSecondWithSecond:(NSTimeInterval)time{
//    
//    int minute = (int)time / 60;
//    int second = (int)time % 60;
//    
//    if (second > 9) { //2:10
//        return [NSString stringWithFormat:@"%d:%d",minute,second];
//    }
//    
//    //2:09
//    return [NSString stringWithFormat:@"%d:0%d",minute,second];
//}

+ (NSString *)getMinuteSecondWithSecond:(NSString *)time
{
    int totalDuration = [time intValue];
    
    int duration = totalDuration / 1000;
    
    int minute = duration / 60;
    int second = duration % 60;
    
    if (second > 9) {
        return [NSString stringWithFormat:@"%02d:%02d", minute, second - 1];
    }
    return [NSString stringWithFormat:@"%02d:%02d", minute, second - 1];
}

@end
