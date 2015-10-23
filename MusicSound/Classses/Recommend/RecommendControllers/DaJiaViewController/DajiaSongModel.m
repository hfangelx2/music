//
//  DajiaSongModel.m
//  MusicSound
//
//  Created by 王言博 on 15/6/29.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "DajiaSongModel.h"

@implementation DajiaSongModel
- (void)dealloc
{
    [_songId release];
    [_name release];
    [_singerName release];
    [_singerId release];
    [_urlList release];
    [_mvList release];
    [_myMvListModel release];
    [_myUrlListModel release];
    [_allMvListArr release];
    [_allUrlListArr release];
    [super dealloc];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.allUrlListArr = [NSMutableArray array];
        self.allMvListArr = [NSMutableArray array];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (void)setUrlList:(NSArray *)urlList
{
    if (_urlList != urlList) {
        [_urlList release];
        _urlList = [urlList retain];
    }
    [_urlList enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        
        self.myUrlListModel = [[UrlListModel alloc] init];
        [self.myUrlListModel setValuesForKeysWithDictionary:obj];
        [self.allUrlListArr addObject:self.myUrlListModel];
    }];
}
- (void)setMvList:(NSArray *)mvList
{
    if (_mvList != mvList) {
        [_mvList release];
        _mvList = [mvList retain];
    }
    NSDictionary *dic = [_mvList firstObject];
    self.myMvListModel = [[MvListModel alloc] init];
    [self.myMvListModel setValuesForKeysWithDictionary:dic];
    
    [self.allMvListArr addObject:self.myMvListModel];
}
@end
