//
//  SingerDetailCell.m
//  MusicSound
//
//  Created by shuwen on 15/6/27.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "SingerDetailCell.h"

@implementation SingerDetailCell
{
    CGAdapter adapter;
}

-(void)dealloc
{
    [_singerDetailImageView release];
    [_singerDetailLabel release];
    [_singerDetailModel release];
    [_smallSingerDetailImageView release];
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
    
    self.singerDetailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*adapter.sWidth, 10*adapter.sHeight, 80*adapter.sWidth, 80*adapter.sHeight)];
    //给imageView加上阴影效果
    self.singerDetailImageView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.singerDetailImageView.layer.shadowOffset = CGSizeMake(5, 5);
    self.singerDetailImageView.layer.shadowOpacity = 0.7;
    
    [self.contentView addSubview:self.singerDetailImageView];
    [_singerDetailImageView release];
    
    self.singerDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.singerDetailImageView.frame.size.width + 30*adapter.sWidth, 40*adapter.sHeight, 200*adapter.sWidth, 20*adapter.sHeight)];
    [self.contentView addSubview:self.singerDetailLabel];
    [_singerDetailLabel release];
    
}

-(void)setSingerDetailModel:(SingerDetailModel *)singerDetailModel
{
    if (_singerDetailModel != singerDetailModel) {
        [_singerDetailModel release];
        _singerDetailModel = [singerDetailModel retain];
    }
    
    self.singerDetailLabel.text = singerDetailModel.singer_name;
    
    NSURL *url = [NSURL URLWithString:_singerDetailModel.pic_url];
    [self.singerDetailImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"grid_default"]];
    
}


@end
