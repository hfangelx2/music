//
//  songInfoModel.m
//  MusicSound
//
//  Created by 王言博 on 15/6/26.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "songInfoModel.h"

@implementation songInfoModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.allUrl_list = [NSMutableArray array];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (void)setUrl_list:(NSArray *)url_list
{
    if (_url_list != url_list) {
        [_url_list release];
        _url_list  = [url_list retain];
    }
    [_url_list enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        
        self.myUrl_listModel = [[Url_listModel alloc] init];
        [self.myUrl_listModel setValuesForKeysWithDictionary:obj];
        [self.allUrl_list addObject:self.myUrl_listModel];
        
    }];
    
}
- (void)dealloc
{
    [_singer_name release];
    [_song_name release];
    [_url_list release];
    [_myUrl_listModel release];
    [_allUrl_list release];
    [super dealloc];
}
@end
