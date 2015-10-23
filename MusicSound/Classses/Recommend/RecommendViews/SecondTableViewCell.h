//
//  SecondTableViewCell.h
//  MusicSound
//
//  Created by 王言博 on 15/6/22.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"
#import <UIImageView+WebCache.h>


@interface SecondTableViewCell : UITableViewCell
@property (nonatomic, retain) UIImageView *imageView1;
@property (nonatomic, retain) UILabel *label1;
@property (nonatomic, retain) UILabel *label2;

@property (nonatomic, retain) UIImageView *liMiLabel;
@property (nonatomic, retain) NSMutableArray *allArr;
@property (nonatomic, retain) Data *myData;
@end
