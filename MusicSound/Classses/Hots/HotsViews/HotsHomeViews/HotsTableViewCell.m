//
//  HotsTableViewCell.m
//  MusicSound
//
//  Created by 大泽 on 15/6/20.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "HotsTableViewCell.h"
#import "HotsFrameModel.h"
#import "HotsModel.h"
#import "HotsSongList.h"
#import "HotsHomeSongListDataBase.h"
#import <UIImageView+WebCache.h>
@interface HotsTableViewCell ()

@property (nonatomic, retain) NSArray *array;

// 1.单元格cell的图片
@property (nonatomic, retain) UIImageView *pic_url;

// 2.歌曲标题
@property (nonatomic, retain) UILabel *title;

// 3.分割线
@property (nonatomic, retain) UIView *line;

// 4.第一首歌
@property (nonatomic, retain) UILabel *firstSong;

// 5.第二首歌
@property (nonatomic, retain) UILabel *secoundSong;

// 6.第三首歌
@property (nonatomic, retain) UILabel *thirdSong;


@end

@implementation HotsTableViewCell



- (void)dealloc
{
    [_hotsFModel release];
    [_array release];
    [_pic_url release];
    [_title release];
    [_line release];
    [_firstSong release];
    [_secoundSong release];
    [_thirdSong release];
    
    [super dealloc];
}



// 1.单元格cell的图片
- (UIImageView *)pic_url
{
    if (!_pic_url) {
        
        _pic_url = [[UIImageView alloc] init];
        [self.contentView addSubview:_pic_url];
        
    }
    return [[_pic_url retain] autorelease];
}
// 2.歌曲标题
- (UILabel *)title
{
    if (!_title) {
        
        _title = [[UILabel alloc] init];
        [self.contentView addSubview:_title];
        
    }
    return [[_title retain] autorelease];
}

// 3.分割线
- (UIView *)line
{
    if (!_line) {
        
        _line = [[UIView alloc] init];
        [self.contentView addSubview:_line];
        _line.backgroundColor = [UIColor lightGrayColor];
        
    }
    return [[_line retain] autorelease];
}

#define kTextFont 14
// 4.第一首歌
- (UILabel *)firstSong
{
    if (!_firstSong) {
        
        _firstSong = [[UILabel alloc] init];
        [self.contentView addSubview:_firstSong];
        _firstSong.font = [UIFont systemFontOfSize:kTextFont];
        _firstSong.textColor = [UIColor lightGrayColor];
        
    }
    return [[_firstSong retain] autorelease];
}

// 5.第二首歌
- (UILabel *)secoundSong
{
    if (!_secoundSong) {
        
        _secoundSong = [[UILabel alloc] init];
        [self.contentView addSubview:_secoundSong];
        _secoundSong.font = [UIFont systemFontOfSize:kTextFont];
        _secoundSong.textColor = [UIColor lightGrayColor];
        
    }
    return [[_secoundSong retain] autorelease];
}

// 6.第三首歌
- (UILabel *)thirdSong
{
    if (!_thirdSong) {
        
        _thirdSong = [[UILabel alloc] init];
        [self.contentView addSubview:_thirdSong];
        _thirdSong.font = [UIFont systemFontOfSize:kTextFont];
        _thirdSong.textColor = [UIColor lightGrayColor];
        
    }
    return [[_thirdSong retain] autorelease];
}

- (void)setHotsFModel:(HotsFrameModel *)hotsFModel
{
    
    if (_hotsFModel != hotsFModel) {
        [_hotsFModel release];
        _hotsFModel = [hotsFModel retain];
    }

    // 2.设置cell尺寸
    [self setCellRect:hotsFModel];
    
    // 1.设置cell内容
    [self setCellContent:hotsFModel];
}


- (void)setCellContent:(HotsFrameModel *)hotsFModel
{
    // 1.单元格cell
    NSURL *url = [NSURL URLWithString:hotsFModel.hotsModel.pic_url];
    [self.pic_url sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"grid_default"]];
    
    // 2.歌曲标题
    self.title.text = hotsFModel.hotsModel.title;
    self.title.font = [UIFont systemFontOfSize:15];
    self.title.textColor = [UIColor darkGrayColor];
    
    self.array = @[self.firstSong, self.secoundSong, self.thirdSong];
    // 4.首页展示的歌
    NSArray *songList = hotsFModel.hotsModel.songlist;
    [songList enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
       
        UILabel *song = self.array[idx];
        
        NSString *numText = [NSString stringWithFormat:@"%ld. ", idx + 1];
        
        song.text = [NSString stringWithFormat:@"%@%@", numText, obj[@"songName"]];
        
        if (idx == 2) {
            *stop = YES;
        }
    }];
    
}

- (void)setCellRect:(HotsFrameModel *)hotsFModel
{
    self.title.frame = hotsFModel.title;
    self.pic_url.frame = hotsFModel.pic_url;
    self.line.frame = hotsFModel.line;
    self.firstSong.frame = hotsFModel.firstSong;
    self.secoundSong.frame = hotsFModel.secondSong;
    self.thirdSong.frame = hotsFModel.thirdSong;
}



@end
