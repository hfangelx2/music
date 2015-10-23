//
//  SongLibraryCollectionViewCell.m
//  MusicSound
//
//  Created by shuwen on 15/6/22.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "SongLibraryCollectionViewCell.h"


@implementation SongLibraryCollectionViewCell
{
    CGAdapter adapter;
}

- (void)dealloc
{
    [_songLibraryImageView release];
    [_songLibraryLabel release];
    [_imageStr release];
    [_labelStr release];
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
    
    self.songLibraryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [self.contentView addSubview:self.songLibraryImageView];
    
    //圆角设置
    self.songLibraryImageView.layer.cornerRadius = 10;
    
    self.songLibraryImageView.layer.masksToBounds = YES;
    
    self.songLibraryLabel = [[UILabel alloc] initWithFrame:CGRectMake(5*adapter.sWidth, 10*adapter.sHeight, self.contentView.frame.size.width/2, 40*adapter.sHeight)];
    self.songLibraryLabel.font = [UIFont systemFontOfSize:30*adapter.sHeight];
    self.songLibraryLabel.textColor = [UIColor whiteColor];
    self.songLibraryLabel.shadowColor = [UIColor redColor];
    [self.contentView addSubview:self.songLibraryLabel];
    
    [_songLibraryImageView release];
    [_songLibraryLabel release];
}


- (void)setImageStr:(NSString *)imageStr
{
    if (_imageStr != imageStr) {
        [_imageStr release];
        _imageStr = [imageStr retain];
    }
    
    self.songLibraryImageView.image = [UIImage imageNamed:imageStr];
    
}

- (void)setLabelStr:(NSString *)labelStr
{
    if (_labelStr != labelStr) {
        [_labelStr release];
        _labelStr = [labelStr retain];
    }
    
    self.songLibraryLabel.text = labelStr;
}

@end















