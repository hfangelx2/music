//
//  HotsFrameModel.m
//  天天动听
//
//  Created by 大泽 on 15/6/17.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "HotsFrameModel.h"
#import "HotsModel.h"
@implementation HotsFrameModel

- (void)dealloc
{
    [_hotsModel release];
    
    [super dealloc];
}


- (void)setHotsModel:(HotsModel *)hotsModel
{
    if (_hotsModel != hotsModel) {
        [_hotsModel release];
        _hotsModel = [hotsModel retain];
    }
    
    CGAdapter adapter = [AdapterModel getCGAdapter];
    
#define adapterW adapter.sWidth
#define adapterH adapter.sHeight
    
    // 1.单元格cell图片
    CGFloat pic_urlX = kMargin * adapterW;
    CGFloat pic_urlY = kMargin * adapterH;
    CGFloat pic_urlW = 64 * 1.7 * adapterW;
    CGFloat pic_urlH = 53 * 1.8 * adapterH;
    
    self.pic_url = CGRectMake(pic_urlX, pic_urlY, pic_urlW, pic_urlH);
    
    // 2.歌曲标题
    CGFloat titleX = CGRectGetMaxX(_pic_url) + kMargin * 3;
    CGFloat titleY = pic_urlY;
    CGFloat titleW = kScreenW - titleX;
    CGFloat titleH = kTextH * adapterH;
    
    self.title = CGRectMake(titleX, titleY, titleW, titleH);
    
    // 3.分割线
    CGFloat lineX = titleX;
    CGFloat lineY = CGRectGetMaxY(_title) + kMargin;
    CGFloat lineW = titleW;
    CGFloat lineH = 1;
    
    self.line = CGRectMake(lineX, lineY, lineW, lineH);
    
    // 4.第一首歌
    CGFloat firstSongX = titleX;
    CGFloat firstSongY = CGRectGetMaxY(_line) + kMargin;
    CGFloat firstSongW = titleW;
    CGFloat firstSongH = kTextH * adapterH;
    
    self.firstSong = CGRectMake(firstSongX, firstSongY, firstSongW, firstSongH);
    
    // 5.第二首歌
    CGFloat secondSongX = titleX;
    CGFloat secondSongY = CGRectGetMaxY(_firstSong) + kMargin;
    CGFloat secondSongW = titleW;
    CGFloat secondSongH = kTextH * adapterH;
    
    self.secondSong = CGRectMake(secondSongX, secondSongY, secondSongW, secondSongH);
    
    // 6.第三首歌
    CGFloat thirdSongX = titleX;
    CGFloat thirdSongY = CGRectGetMaxY(_secondSong) + kMargin;
    CGFloat thirdSongW = titleW;
    CGFloat thirdSongH = kTextH * adapterH;
    
    self.thirdSong = CGRectMake(thirdSongX, thirdSongY, thirdSongW, thirdSongH);
    
    self.cellH = MAX(CGRectGetMaxY(_pic_url), CGRectGetMaxY(_thirdSong)) + kMargin;
}


@end
