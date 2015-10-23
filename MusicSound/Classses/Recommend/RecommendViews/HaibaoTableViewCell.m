//
//  HaibaoTableViewCell.m
//  MusicSound
//
//  Created by 王言博 on 15/6/20.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "HaibaoTableViewCell.h"

@implementation HaibaoTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
    }
    return self;
}
- (void)createSubViews
{
    self.scrollV = [[MyScrollView alloc] initWithFrame:CGRectMake(10, 0, 355, 140)];

    self.scrollV.frame = CGRectMake(10, 0, 355, 140);
    // 如果是webView, 执行此方法
    self.scrollV.scrollBlock = ^(NSString *value){
      
        self.haiBaoBlcok(value);
        
    };
    // 不是webView, 执行此方法
    self.scrollV.scrollBlock1 = ^ (NSString *value){
        self.haiBaoBlcok1(value);
    };
    
    self.scrollV.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.scrollV];
    [_scrollV release];
}
- (void)setAllHaibaoArr:(NSMutableArray *)allHaibaoArr
{
    if (_allHaibaoArr != allHaibaoArr) {
        [_allHaibaoArr release];
        _allHaibaoArr = [allHaibaoArr retain];
    }
//    NSLog(@"%@", self.allHaibaoArr);
    [self.scrollV setImages:self.allHaibaoArr];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)dealloc
{
    [_scrollV release];
    [_allHaibaoArr release];
    [_dataArray release];
    [super dealloc];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
