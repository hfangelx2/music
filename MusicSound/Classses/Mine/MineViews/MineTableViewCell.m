//
//  MineTableViewCell.m
//  MusicSound
//
//  Created by 大泽 on 15/6/21.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "MineTableViewCell.h"
#import "MineModels.h"
#import "MineSwitchModel.h"
#import "MineArrowModel.h"
#import "NightOrDaySwitch.h"


@interface MineTableViewCell ()

@property (nonatomic, retain) UISwitch *switchView;

@property (nonatomic, retain) UIImageView *arrowView;
@end

@implementation MineTableViewCell

- (void)dealloc
{
    [_mineModels release];
    [_switchView release];
    [_arrowView release];
    
    [super dealloc];
}

- (UISwitch *)switchView
{
    if (!_switchView) {
        _switchView = [[UISwitch alloc] init];
        
        NSString *status = [[NSUserDefaults standardUserDefaults] objectForKey:DayOrNight];
        
        if ([status isEqualToString:Night]) {
            _switchView.on = YES;
        }
        
        [_switchView addTarget:self action:@selector(nightOrDay:) forControlEvents:UIControlEventValueChanged];
        
    }
    return [[_switchView retain] autorelease];
}

- (UIImageView *)arrowView
{
    if (!_arrowView) {
        
        _arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        _arrowView.image = [UIImage imageNamed:@"CellArrow"];
        _arrowView.contentMode = UIViewContentModeCenter;
        
    }
    return [[_arrowView retain] autorelease];
}



+ (MineTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *const ID = @"mine";

    
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}


- (void)setMineModels:(MineModels *)mineModels
{
    if (_mineModels != mineModels) {
        [_mineModels release];
        _mineModels = [mineModels retain];
    }
    
    [self setUpItem];
    
    [self setUpAccerossory];
}

- (void)setUpItem
{
    if (self.mineModels.icon) {
        self.imageView.image = [UIImage imageNamed:self.mineModels.icon];
    }
    
    self.textLabel.text = self.mineModels.title;
}

- (void)setUpAccerossory
{
    
    if ([self.mineModels isKindOfClass:[MineArrowModel class]]) {
        self.accessoryView = self.arrowView;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else if ([self.mineModels isKindOfClass:[MineSwitchModel class]]) {
        
        self.accessoryView = self.switchView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    } else {
        
        self.accessoryView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}
- (void)nightOrDay:(UISwitch *)switchView
{
    if (switchView.on) {
 
        [[NSNotificationCenter defaultCenter] postNotificationName:@"night" object:nil];
        [[NSUserDefaults standardUserDefaults] setObject:Night forKey:DayOrNight];
        return;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"day" object:nil];
    [[NSUserDefaults standardUserDefaults] setObject:Day forKey:DayOrNight];
}

@end
