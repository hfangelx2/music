//
//  HotsDetailModel.m
//  MusicSound
//
//  Created by 大泽 on 15/6/22.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "HotsDetailModel.h"
#import "HotsDetailFrameModel.h"

@implementation HotsDetailModel

- (void)dealloc
{
    [_name release];
    [_singerName release];
    [_favorites release];
    [_urlList release];
    
    [super dealloc];
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)hotsDetailModelWithDic:(NSDictionary *)dic
{
    return [[[self alloc] initWithDic:dic] autorelease];
}

+ (NSMutableArray *)hotsDetailModelWithArray:(NSArray *)array
{
    NSMutableArray *arrayA = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        
        HotsDetailFrameModel *hotsDetailFM = [[HotsDetailFrameModel alloc] init];
        
        HotsDetailModel *hotsDetailM = [HotsDetailModel hotsDetailModelWithDic:obj];
        
        hotsDetailFM.hotsDetailModel = hotsDetailM;
        
        [arrayA addObject:hotsDetailFM];
        
        [hotsDetailFM release];
        
    }];
    
    return arrayA;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
