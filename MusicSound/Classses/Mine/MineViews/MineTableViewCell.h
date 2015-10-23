//
//  MineTableViewCell.h
//  MusicSound
//
//  Created by 大泽 on 15/6/21.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MineModels;
@interface MineTableViewCell : UITableViewCell


@property (nonatomic, retain) MineModels *mineModels;

+ (MineTableViewCell *)cellWithTableView:(UITableView *)tableView;

@end
