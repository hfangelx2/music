//
//  RecommendModel.m
//  MusicSound
//
//  Created by 大泽 on 15/6/19.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "RecommendModel.h"

@implementation RecommendModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.myAction = [[Action alloc] init];
        self.dataArray = [NSMutableArray array];
    }
    return self;
}
- (void)setAction:(NSDictionary *)action
{
    [self.myAction setValuesForKeysWithDictionary:action];
    [_myAction release];
}
- (void)setData:(NSArray *)data{
    if (_data != data) {
        [_data release];
        _data = [data retain];
    }
    // 想当于forin 遍历_data数组里面的元素字典类型的obj
    [_data enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        
        self.myData = [[Data alloc] init];
        
        [self.myData setValuesForKeysWithDictionary:obj];
        
        [self.dataArray addObject:self.myData];
        
        [_myData release];
    }];
}
- (void)dealloc
{
    [_dataArray release];
    [_data release];
    [_action release];
    [_style release];
    [_name release];
    [_desc release];
    [_promotionzones release];
    [_myData release];
    [_myAction release];
    [super dealloc];
}
@end
