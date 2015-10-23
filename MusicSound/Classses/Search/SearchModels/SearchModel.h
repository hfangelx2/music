//
//  SearchModel.h
//  MusicSound
//
//  Created by shuwen on 15/6/29.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject

@property (nonatomic, copy) NSString *song_name;
@property (nonatomic, copy) NSString *singer_name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, retain) NSMutableArray *url_list;
@property (nonatomic, retain) NSMutableArray *audition_list;
@property (nonatomic, assign) NSInteger pick_count;

@end
