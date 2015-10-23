//
//  HotsModel.m
//  天天动听
//
//  Created by 大泽 on 15/6/17.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "HotsModel.h"
#import "HotsFrameModel.h"
#import "HotsSongList.h"
#import "HotsHomeDataBase.h"
#import "HotsHomeSongListDataBase.h"
#import "FMHotsHomeDataBase.h"
@implementation HotsModel

- (void)dealloc
{
    [_ID release];
    [_title release];
    [_pic_url release];
    [_details release];
    [_songlist release];
    [_songList release];
    
    [super dealloc];
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.songlist = [NSMutableArray array];
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    return self;
}

+ (instancetype)hotsModelWithDic:(NSDictionary *)dic
{
    return [[[self alloc] initWithDic:dic] autorelease];
}

/**
 *  重写id的值
 */
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

/**
 *  给songList使用KVC赋值
 */
- (void)setSonglist:(NSArray *)songlist
{
    if (_songlist != songlist) {
        [_songlist release];
        _songlist = [songlist retain];
    }
    
    [songlist enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
       
        self.songList = [HotsSongList hotsSongListWith:obj];
         
    }];
}

+ (NSMutableArray *)hotsWithArray:(NSArray *)array
{
    NSMutableArray *arrayA = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        
        HotsModel *hotsModel = [self hotsModelWithDic:obj];
        
        [[FMHotsHomeDataBase shareFMHotsHomeDataBase] insertXYMusicWithHomeModel:hotsModel];
        
        HotsFrameModel *hotsFM = [[HotsFrameModel alloc] init];
        
        hotsFM.hotsModel = hotsModel;
        
        [arrayA addObject:hotsFM];
                
        [hotsFM release];
        
    }];
    
    return arrayA;
}

@end
