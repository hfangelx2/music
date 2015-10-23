//
//  MVCell.m
//  MusicSound
//
//  Created by shuwen on 15/6/26.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "MVCell.h"

@implementation MVCell
{
    CGAdapter adapter;
}

- (void)dealloc
{
    [_mvModel release];
    [_mvImageView release];
    [_titleLabel release];
    [_titlePartLabel release];
    [_descLabel release];
    [_tagNameLabel1 release];
    [_tagNameLabel2 release];
    [_playImageView release];
    [_shortLine release];
    [_longLine release];
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self mvCell];
    }
    return self;
}

-(void)mvCell
{
    adapter = [AdapterModel getCGAdapter];
    
    self.mvImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*adapter.sWidth, 70*adapter.sHeight, kScreenW - 20*adapter.sWidth, 210*adapter.sHeight)];
    [self.contentView addSubview:self.mvImageView];
    
    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(65*adapter.sWidth, 5*adapter.sHeight, kScreenW - 100*adapter.sWidth, 40*adapter.sHeight)];
    self.descLabel.font = [UIFont systemFontOfSize:15*adapter.sHeight];
    self.descLabel.textColor = [UIColor lightGrayColor];
    self.descLabel.numberOfLines = 0;
    [self.contentView addSubview:self.descLabel];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(17*adapter.sWidth, 5*adapter.sHeight, 60*adapter.sWidth, 40*adapter.sHeight)];
    self.titleLabel.textColor = [UIColor lightGrayColor];
    self.titleLabel.font = [UIFont systemFontOfSize:30*adapter.sHeight];
    [self.contentView addSubview:self.titleLabel];
    
    self.titlePartLabel = [[UILabel alloc] initWithFrame:CGRectMake(25*adapter.sWidth, 45*adapter.sHeight, 40*adapter.sWidth, 20*adapter.sHeight)];
    self.titlePartLabel.textColor = [UIColor lightGrayColor];
    self.titlePartLabel.font = [UIFont systemFontOfSize:15*adapter.sHeight];
    [self.contentView addSubview:self.titlePartLabel];
    
    self.tagNameLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(65*adapter.sWidth, 45*adapter.sHeight, 34*adapter.sWidth, 20*adapter.sHeight)];
    //圆角设置
    self.tagNameLabel1.layer.cornerRadius = 8;
    self.tagNameLabel1.layer.masksToBounds = YES;
    self.tagNameLabel1.textColor = [UIColor whiteColor];
    self.tagNameLabel1.font = [UIFont systemFontOfSize:13*adapter.sHeight];
    self.tagNameLabel1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.tagNameLabel1];
    
    self.tagNameLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(105*adapter.sWidth, 45*adapter.sHeight, 34*adapter.sWidth, 20*adapter.sHeight)];
    //圆角设置
    self.tagNameLabel2.layer.cornerRadius = 8;
    self.tagNameLabel2.layer.masksToBounds = YES;
    self.tagNameLabel2.textColor = [UIColor whiteColor];
    self.tagNameLabel2.font = [UIFont systemFontOfSize:13*adapter.sHeight];
    self.tagNameLabel2.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.tagNameLabel2];
    
    self.playImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.mvImageView.centerX - (60*adapter.sWidth)/2, self.mvImageView.centerY - (60*adapter.sHeight)/2, 60*adapter.sWidth, 60*adapter.sHeight)];
    self.playImageView.alpha = 0.8;
    self.playImageView.image = [UIImage imageNamed:@"playbar_playbtn_click"];
    [self.contentView addSubview:self.playImageView];
    
    self.shortLine = [[UIImageView alloc] initWithFrame:CGRectMake(13*adapter.sWidth, 42*adapter.sHeight, 40*adapter.sWidth, 1*adapter.sHeight)];
    self.shortLine.image = [UIImage imageNamed:@"DetailPagePlaybackProgressBackground"];
    [self.contentView addSubview:self.shortLine];
    
    self.longLine = [[UIImageView alloc] initWithFrame:CGRectMake(10*adapter.sWidth, 292*adapter.sHeight, kScreenW - 20*adapter.sWidth, 1*adapter.sHeight)];
    self.longLine.image = [UIImage imageNamed:@"DetailPagePlaybackProgressBackground"];
    [self.contentView addSubview:self.longLine];
    
    [_mvImageView release];
    [_descLabel release];
    [_titleLabel release];
    [_titlePartLabel release];
    [_tagNameLabel1 release];
    [_tagNameLabel2 release];
    [_playImageView release];
    [_shortLine release];
    [_longLine release];
}

- (void)setMvModel:(MVModel *)mvModel
{
    if (_mvModel != mvModel) {
        [_mvModel release];
        _mvModel = [mvModel retain];
    }
    
    self.descLabel.text = _mvModel.desc;
    
    self.tagNameLabel1.text = _mvModel.tagName1;
    
    self.tagNameLabel1.backgroundColor = [UIColor colorWithRed:[[_mvModel.tagColor1 substringWithRange:NSMakeRange(4,3)] intValue]/255.0 green:[[_mvModel.tagColor1 substringWithRange:NSMakeRange(8,3)] intValue]/255.0 blue:[[_mvModel.tagColor1 substringWithRange:NSMakeRange(12,3)] intValue]/255.0 alpha:1.0];
    
    self.tagNameLabel2.text = _mvModel.tagName2;
    
    self.tagNameLabel2.backgroundColor = [UIColor colorWithRed:[[_mvModel.tagColor2 substringWithRange:NSMakeRange(4,3)] intValue]/255.0 green:[[_mvModel.tagColor2 substringWithRange:NSMakeRange(8,3)] intValue]/255.0 blue:[[_mvModel.tagColor2 substringWithRange:NSMakeRange(12,3)] intValue]/255.0 alpha:1.0];
    
    if ([_mvModel.title containsString:@"/"]) {
        
    NSArray *array = [_mvModel.title componentsSeparatedByString:@"/"];//天天动听接口有时有错误,发现过一次
    
    if ([array[0]floatValue] < 10) {
        NSString *string = [@"0"stringByAppendingString:array[0]];
        self.titleLabel.text = string;
    }else {
        self.titleLabel.text = array[0];
    }
    if ([array[1]floatValue] < 10) {
        NSString *string = [@"0"stringByAppendingString:array[1]];
        self.titlePartLabel.text = string;
    }else {
        self.titlePartLabel.text = array[1];
    }
    }else {
        self.titleLabel.text = _mvModel.title;
    }
    
    NSString *urlStr = _mvModel.bigPicUrl;
    NSURL *url = [NSURL URLWithString:urlStr];
    [self.mvImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"grid_default"]];
    
    
}





@end
