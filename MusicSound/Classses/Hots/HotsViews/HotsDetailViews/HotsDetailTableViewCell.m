//
//  HotsDetailTableViewCell.m
//  MusicSound
//
//  Created by 大泽 on 15/6/22.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "HotsDetailTableViewCell.h"
#import "HotsDetailFrameModel.h"
#import "HotsDetailModel.h"
#import "FavButton.h"
#import "FMXYMusicCollectionDataBase.h"
@implementation HotsDetailTableViewCell
#define kTextFont 17

- (void)dealloc
{
    [_name release];
    [_singerName release];
    [_favorites release];
    [_hq release];
    [_line release];
    
    [super dealloc];
}

- (UILabel *)name
{
    if (!_name) {
        
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:kTextFont];
        _name.lineBreakMode = NSLineBreakByTruncatingTail;
        _name.numberOfLines = 1;
        [self.contentView addSubview:_name];
    }
    return [[_name retain] autorelease];
}

- (UILabel *)singerName
{
    if (!_singerName) {
        
        _singerName = [[UILabel alloc] init];
        _singerName.font = [UIFont systemFontOfSize:14];
        _singerName.textColor = [UIColor lightGrayColor];
        _singerName.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_singerName];
    }
    return [[_singerName retain] autorelease];
}

- (FavButton *)favorites
{
    if (!_favorites) {
        
        _favorites = [[FavButton alloc] init];
        _favorites.contentMode = UIViewContentModeCenter;
        [_favorites addTarget:self action:@selector(addFavorite:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_favorites];
    }
    return [[_favorites retain] autorelease];
}

- (UIImageView *)hq
{
    if (!_hq) {
        
        _hq = [[UIImageView alloc] init];
        [self.contentView addSubview:_hq];
    }
    return [[_hq retain] autorelease];
}

- (UILabel *)favoritesCount
{
    if (!_favoritesCount) {
        
        _favoritesCount = [[UILabel alloc] init];
        _favoritesCount.font = [UIFont systemFontOfSize:9];
        _favoritesCount.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_favoritesCount];
    }
    return [[_favoritesCount retain] autorelease];
}

- (UIView *)line
{
    if (!_line) {
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_line];
    }
    return [[_line retain] autorelease];
}

- (void)setHotsDetailFM:(HotsDetailFrameModel *)hotsDetailFM
{
    if (_hotsDetailFM != hotsDetailFM) {
        [_hotsDetailFM release];
        _hotsDetailFM = [hotsDetailFM retain];
    }
    
    // 1.设置cell尺寸
    [self setUpFrame];

    // 2.设置cell内容
    [self setUpContent];
    
    // 3.给button赋值
    self.favorites.hotsDetailModel = hotsDetailFM.hotsDetailModel;
}

- (void)setUpContent
{
    /**
     *  歌名
     */
    self.name.text = self.hotsDetailFM.hotsDetailModel.name;
    
   CGSize currentSize = [self.name.text boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:kTextFont]} context:nil].size;
    self.name.size = currentSize;

    /**
     *  歌手名字
     */
    self.singerName.text = self.hotsDetailFM.hotsDetailModel.singerName;
    
    /**
     *  受欢迎度
     */
    
    UIImage *image = [UIImage imageNamed:@"cell_icon_uncollected"];
    
    [self.favorites setImage:image forState:UIControlStateNormal];
    
#define kScale 1.5
#define adapterH adapter.sHeight
#define adapterW adapter.sWidth
    
    CGAdapter adapter = [AdapterModel getCGAdapter];
    
    self.favorites.size = CGSizeMake(30 * kScale * adapterH, 44 * kScale * adapterW);
    
    self.favorites.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0);
    
    NSString *favorites = [NSString stringWithFormat:@"%@", self.hotsDetailFM.hotsDetailModel.favorites];
    
    NSInteger num = [favorites integerValue];
    
    NSString *count = [NSString stringWithFormat:@"%ld万", num / 10000];
    
    /**
     *  受欢迎度
     */
    
    if (count.floatValue > 0) {
        
        self.favoritesCount.width = self.favorites.width;
        self.favoritesCount.height = 10;
        
        self.favoritesCount.centerX = self.favorites.centerX;
        self.favoritesCount.y = self.favorites.height - 15;
        
        self.favoritesCount.text = count;
    }
    
    
    /**
     *  高清图标
     */
    self.hq.image = [UIImage imageNamed:@"song_cell_hq"];
    
    self.hq.x = CGRectGetMaxX(self.name.frame) + kMargin;
}

- (void)setUpFrame
{
    self.name.frame = self.hotsDetailFM.nameF;
    
    self.singerName.frame = self.hotsDetailFM.singerNameF;
    
    self.favorites.frame = self.hotsDetailFM.favoritesF;
    
    self.hq.frame = self.hotsDetailFM.hqF;
    
    self.line.frame = self.hotsDetailFM.lineF;
}

- (void)addFavorite:(FavButton *)button
{
    NSLog(@"-------%@", button.hotsDetailModel.singerName);
    
    
    HotsDetailModel *model = [[FMXYMusicCollectionDataBase shareFMXYMusicCollectionDataBase] selectWithName:button.hotsDetailModel.name];
    
    if (model) {
        
        [UIAlertView showAlertViewWithTitle:@"已收藏" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
        return;
    }
    NSLog(@"收藏成功");
    
    [UIAlertView showAlertViewWithTitle:@"收藏成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [[FMXYMusicCollectionDataBase shareFMXYMusicCollectionDataBase] insertXYMusicWithHotsDeatilModel:button.hotsDetailModel];
}


@end
