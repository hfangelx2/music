//
//  Data.m
//  MusicSound
//
//  Created by 王言博 on 15/6/22.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "Data.h"
#import "Action1.h"
@implementation Data

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.action1 = [[Action1 alloc] init];
    }
    return self;
}
- (void)dealloc
{
    [_action release];
    [_action1 release];
    [_reason release];
    [_name release];
    [_desc release];
    [_pic_url release];
    [_listen_count release];
    [_author release];
    [_dataId release];
    
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.dataId = value;
    }
}

- (void)setAction:(NSDictionary *)action
{
    if (_action != action) {
        [_action release];
        _action = [action retain];
    }
    
    [self.action1 setValuesForKeysWithDictionary:action];
    
    
    
}



@end
