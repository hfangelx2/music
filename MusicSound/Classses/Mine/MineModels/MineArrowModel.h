//
//  MineArrowModel.h
//  MusicSound
//
//  Created by 大泽 on 15/6/21.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "MineModels.h"

@interface MineArrowModel : MineModels

@property (nonatomic, assign) Class destVc;

+ (instancetype)mineModelsWithTitle:(NSString *)title icon:(NSString *)icon destVc:(Class)destVc;

@end
