//
//  HotsDetailFrameModel.m
//  MusicSound
//
//  Created by 大泽 on 15/6/22.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "HotsDetailFrameModel.h"
#import "HotsDetailModel.h"

@implementation HotsDetailFrameModel

- (void)setHotsDetailModel:(HotsDetailModel *)hotsDetailModel
{
    if (_hotsDetailModel != hotsDetailModel) {
        [_hotsDetailModel release];
        _hotsDetailModel = [hotsDetailModel retain];
    }
    
    [self setUpAllFrame];
}


- (void)setUpAllFrame
{
    CGAdapter adapter = [AdapterModel getCGAdapter];
#define adapterH adapter.sHeight
#define adapterW adapter.sWidth
    /**
     *  受欢迎度
     */
    
    CGFloat favoritesX = kMargin * adapterW;
    CGFloat favoritesY = kMargin * adapterH;
    CGFloat favoritesW = 60 * adapterW;
    CGFloat favoritesH = 60 * adapterH;
    
    self.favoritesF = CGRectMake(favoritesX, favoritesY, favoritesW, favoritesH);
    
    /**
     *  歌名
     */
    CGFloat nameX = CGRectGetMaxX(_favoritesF);
    CGFloat nameY = (favoritesY + k2Margin);
    CGFloat nameW = (kScreenW - k2Margin) * adapterW;
    CGFloat nameH = 30 * adapterH;
    
    self.nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    /**
     *  歌手名字
     */
    CGFloat singerNameX = nameX;
    CGFloat singerNameY = CGRectGetMaxY(_nameF);
    CGFloat singerNameW = nameW;
    CGFloat singerNameH = (kTextH - 5) * adapterH;
    
    self.singerNameF = CGRectMake(singerNameX, singerNameY, singerNameW, singerNameH);
     
    /**
     *  高清图片
     */
    CGFloat hqX = CGRectGetMidX(_nameF) + kMargin;
    CGFloat hqY = nameY + kMargin;
    CGFloat hqW = 22;
    CGFloat hqH = 13 * adapterH;
    
    self.hqF = CGRectMake(hqX, hqY, hqW, hqH);
    
    /**
     *  分割线
     */
    CGFloat lineX = nameX;
    CGFloat lineY = MAX(CGRectGetMaxY(_favoritesF), CGRectGetMaxY(_singerNameF)) + kMargin;
    CGFloat lineW = kScreenW - lineX;
    CGFloat lineH = 1;
    
    self.lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    /**
     *  行高
     */
    
    self.cellH = CGRectGetMaxY(_lineF);
}



@end
