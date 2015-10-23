//
//  HotsHeaderCollectionViewCell.m
//  MusicSound
//
//  Created by 大泽 on 15/6/21.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "HotsHeaderCollectionViewCell.h"
#import "HotsHeaderModel.h"
@implementation HotsHeaderCollectionViewCell

- (void)awakeFromNib
{
    self.hotsHeaderImageView.layer.cornerRadius = 3;
    self.hotsHeaderImageView.clipsToBounds = YES;
    self.hotsHeaderImageView.layer.borderWidth = 3;
    self.hotsHeaderImageView.layer.borderColor = [UIColor grayColor].CGColor;
}


#define kHotsHeaderHighPic @"http://api.dongting.com/song/singer/%@?detail=true&app=ttpod&v=v7.9.4.2015052918&uid=&mid=iPad%20Mini%20%28WiFi%29&f=f320&s=s330&imsi=&hid=&splus=8.1.1&active=1&net=2&openudid=7c173a4a8cfe0c733d25198b0fdcb3ecfdfb0fba&idfa=E9CD8DEC-BBCF-4839-A3A1-512E844873B3&utdid=VYZUnn%2BuJ1MDAMKwFfCFLTqG&alf=201200&bundle_id=com.ttpod.music"

- (void)setHotsHeaderModel:(HotsHeaderModel *)hotsHeaderModel
{
    if (_hotsHeaderModel != hotsHeaderModel) {
        [_hotsHeaderModel release];
        _hotsHeaderModel = [hotsHeaderModel retain];
    }

    [self.hotsHeaderImageView sd_setImageWithURL:[NSURL URLWithString:self.hotsHeaderModel.pic_url] placeholderImage:[UIImage imageNamed:@"grid_default"]];


    
    self.singer_Name.text = self.hotsHeaderModel.singer_name;
}


- (void)dealloc {
    [_hotsHeaderImageView release];
    [_singer_Name release];
    [super dealloc];
}
@end
