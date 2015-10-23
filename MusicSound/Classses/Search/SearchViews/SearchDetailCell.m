//
//  SearchDetailCell.m
//  MusicSound
//
//  Created by shuwen on 15/6/29.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "SearchDetailCell.h"

@implementation SearchDetailCell
{
    CGAdapter adapter;
}

- (void)dealloc
{
    [_song_nameLabel release];
    [_singer_nameLabel release];
    [_searchModel release];
    [_pick_countLabel release];
    [_collectImageView release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubView];
    }
    return self;
}
- (void)createSubView
{
    adapter = [AdapterModel getCGAdapter];
    
    self.song_nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80*adapter.sWidth, 25*adapter.sHeight, kScreenW - 80*adapter.sWidth, 20*adapter.sHeight)];
    [self.contentView addSubview:self.song_nameLabel];
    
    self.singer_nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80*adapter.sWidth, 45*adapter.sHeight, kScreenW - 80*adapter.sWidth, 20*adapter.sHeight)];
    self.singer_nameLabel.textColor = [UIColor lightGrayColor];
    self.singer_nameLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.singer_nameLabel];
    
    self.collectImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_icon_uncollected"]];
    self.collectImageView.frame = CGRectMake(10*adapter.sWidth, 10*adapter.sHeight, 40*adapter.sWidth, 50*adapter.sHeight);
    [self.contentView addSubview:self.collectImageView];
    
    self.pick_countLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*adapter.sWidth, 50*adapter.sHeight, 40*adapter.sWidth, 15*adapter.sHeight)];
    self.pick_countLabel.font = [UIFont systemFontOfSize:10];
    self.pick_countLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.pick_countLabel];
    
    self.longLine = [[UIImageView alloc] initWithFrame:CGRectMake(10*adapter.sWidth, 73*adapter.sHeight, kScreenW - 20*adapter.sWidth, 1*adapter.sHeight)];
    self.longLine.image = [UIImage imageNamed:@"DetailPagePlaybackProgressBackground"];
    [self.contentView addSubview:self.longLine];
    
    [_song_nameLabel release];
    [_singer_nameLabel release];
    [_collectImageView release];
    [_pick_countLabel release];
}

- (void)setSearchModel:(SearchModel *)searchModel
{
    if (_searchModel != searchModel) {
        [_searchModel release];
        _searchModel = [searchModel retain];
    }
    
    self.song_nameLabel.text = _searchModel.song_name;
    self.singer_nameLabel.text = _searchModel.singer_name;
    if (_searchModel.pick_count < 10000) {
        
        self.pick_countLabel.text = [NSString stringWithFormat:@"%ld",_searchModel.pick_count];
        
    }else {
        
        NSString *string = [NSString stringWithFormat:@"%.1f",_searchModel.pick_count/10000.0];
        self.pick_countLabel.text = [NSString stringWithFormat:@"%@"@"万",string];
        
    }
    
}


@end









