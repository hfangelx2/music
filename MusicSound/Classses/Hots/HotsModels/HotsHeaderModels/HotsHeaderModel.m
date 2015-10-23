//
//  HotsHeaderModel.m
//  MusicSound
//
//  Created by 大泽 on 15/6/21.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "HotsHeaderModel.h"
#import "FMHotsHomeHeaderDataBase.h"
@implementation HotsHeaderModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)hotsHeaderModelWithDic:(NSDictionary *)dic
{
    return [[[self alloc] initWithDic:dic] autorelease];
}

+ (NSMutableArray *)hotsHeaderWithArray:(NSArray *)array;
{
    NSMutableArray *arrayA = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
       
        HotsHeaderModel *hotsModel = [HotsHeaderModel hotsHeaderModelWithDic:obj];
        
        [[FMHotsHomeHeaderDataBase shareFMHotsHomeHeaderDataBase] insertXYMusicWithHotsHeaderModel:hotsModel];
        
        [arrayA addObject:hotsModel];
        
    }];
    
    return arrayA;
}

@end
