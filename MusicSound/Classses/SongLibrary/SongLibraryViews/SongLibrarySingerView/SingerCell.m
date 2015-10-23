//
//  SingerCell.m
//  MusicSound
//
//  Created by shuwen on 15/6/25.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "SingerCell.h"


@implementation SingerCell
{
    CGAdapter adapter;
}

- (void)dealloc
{
    [_singerImageView release];
    [_singerLabel release];
    [_singerModel release];
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews
{
    adapter = [AdapterModel getCGAdapter];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.singerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height - 30*adapter.sHeight)];
    [self.contentView addSubview:self.singerImageView];
    
    self.singerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 25*adapter.sHeight, self.contentView.frame.size.width, 20*adapter.sHeight)];
    self.singerLabel.font = [UIFont systemFontOfSize:13*adapter.sHeight];
    [self.contentView addSubview:self.singerLabel];
    
    [_singerImageView release];
    [_singerLabel release];
}

- (void)setSingerModel:(SingerModel *)singerModel
{
    if (_singerModel != singerModel) {
        [_singerModel release];
        _singerModel = [singerModel retain];
    }
    
    self.singerLabel.text = _singerModel.title;
    
    NSString *strUrl = _singerModel.pic_url;
    NSURL *url = [NSURL URLWithString:strUrl];
    [self.singerImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"grid_default"]];
    
}





@end






