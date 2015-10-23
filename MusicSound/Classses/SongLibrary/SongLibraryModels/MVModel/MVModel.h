//
//  MVModel.h
//  MusicSound
//
//  Created by shuwen on 15/6/22.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MVModel : NSObject

@property (nonatomic, copy) NSString *MV_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, retain) NSArray *tag;
@property (nonatomic, retain) NSArray *mvList;
@property (nonatomic, copy) NSString *bigPicUrl;
@property (nonatomic, copy) NSString *tagName1;
@property (nonatomic, copy) NSString *tagColor1;
@property (nonatomic, copy) NSString *tagName2;
@property (nonatomic, copy) NSString *tagColor2;

@property (nonatomic, copy) NSString *url;

@end
