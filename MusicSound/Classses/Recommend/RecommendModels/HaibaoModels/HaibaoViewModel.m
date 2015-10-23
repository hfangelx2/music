//
//  HaibaoViewModel.m
//  MusicSound
//
//  Created by 王言博 on 15/6/25.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "HaibaoViewModel.h"

@implementation HaibaoViewModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mySonglistsModel = [[SonglistsModel alloc] init];
        self.myPicsModel = [[PicsModel alloc] init];
        self.allHaiViewModel = [NSMutableArray array];
    }
    return self;
}
- (void)setSonglist:(NSArray *)songlist
{
    if (_songlist != songlist) {
        [_songlist release];
        _songlist = [songlist retain];
    }
    [_songlist enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        self.mySonglistsModel = [[SonglistsModel alloc] init];
        [self.mySonglistsModel setValuesForKeysWithDictionary:obj];
        
        [self.allHaiViewModel addObject:self.mySonglistsModel];
        [_mySonglistsModel release];
    }];
}
- (void)setPics:(NSArray *)pics
{
    if (_pics != pics) {
        [_pics release];
        _pics = [pics retain];
    }
    NSString *str = [self.pics objectAtIndex:0];
    self.myPicsModel = [[PicsModel alloc] init];
    self.myPicsModel.pics = str;
    [_myPicsModel release];
}
- (void)dealloc
{
    [_songlist release];
    [_songlistid release];
    [_songlistname release];
    [super dealloc];
}
@end
