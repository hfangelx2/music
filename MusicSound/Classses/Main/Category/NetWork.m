//
//  NetWorkStatus.m
//  MusicSound
//
//  Created by 大泽 on 15/6/30.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "NetWork.h"

@implementation NetWork


+ (BOOL)netWork
{
    Reachability *ability = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    
    NetworkStatus status = [ability currentReachabilityStatus];
    
    switch (status) {
        case NotReachable:
            return NO;
            break;
            
        case ReachableViaWiFi:
            return YES;
            break;
            
        case ReachableViaWWAN:
            
            return YES;
            break;
            
        default:
            break;
    }
}

@end
