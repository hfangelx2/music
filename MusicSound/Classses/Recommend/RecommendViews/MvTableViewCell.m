
//
//  MvTableViewCell.m
//  MusicSound
//
//  Created by 王言博 on 15/6/29.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "MvTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation MvTableViewCell
{
    CGAdapter adapter;
}
- (void)dealloc
{
    [_mvImageV release];
    [_beginImageV release];
    [_mvUrl release];
    [super dealloc];
}
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
    adapter = [AdapterModel getCGAdapter];
    [self.contentView addSubview:self.mvImageV];
    [_mvImageV release];
    
    [self.contentView addSubview:self.beginImageV];
    [_beginImageV release];

}
- (UIImageView *)mvImageV
{
    if (_mvImageV == nil) {
        _mvImageV = [[UIImageView alloc] initWithFrame:CGRectMake(10 * adapter.sWidth, 10 * adapter.sHeight, 355 * adapter.sWidth,180* adapter.sHeight)];
        _mvImageV.backgroundColor = [UIColor yellowColor];
        _mvImageV.backgroundColor = [UIColor clearColor];
    }
    _mvImageV.userInteractionEnabled = YES;
    return _mvImageV;
}
- (UIImageView *)beginImageV
{
    if (_beginImageV == nil) {
        _beginImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"playbar_playbtn_click"]];
        _beginImageV.frame = CGRectMake(((kScreenW - 80) / 2) * adapter.sWidth, ((200- 80) / 2) * adapter.sHeight, 80* adapter.sWidth, 80 * adapter.sHeight);
        _beginImageV.backgroundColor = [UIColor clearColor];
        _beginImageV.alpha = 0.7;
        _beginImageV.userInteractionEnabled = YES;
    }
    return _beginImageV;
}
- (void)setMvUrl:(NSString *)mvUrl
{
    if (_mvUrl != mvUrl) {
        [_mvUrl release];
        _mvUrl =  [mvUrl retain];
    }
    NSURL *url = [NSURL URLWithString:self.mvUrl];
    [self.mvImageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"content-empty"]];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
