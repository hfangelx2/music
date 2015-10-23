//
//  MineArrowModel.m
//  MusicSound
//
//  Created by 大泽 on 15/6/21.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "MineArrowModel.h"

@implementation MineArrowModel

+ (instancetype)mineModelsWithTitle:(NSString *)title icon:(NSString *)icon destVc:(Class)destVc
{
    MineArrowModel *mineArr = [super mineModelsWithTitle:title icon:icon];
    mineArr.destVc = destVc;
    
    return mineArr;
}

@end
