//
//  NightOrDaySwitch.h
//  MusicSound
//
//  Created by 大泽 on 15/6/30.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NightOrDaySwitch : UISwitch

SingletonH(NightOrDaySwitch);

@property (nonatomic, assign) BOOL status;

@end
