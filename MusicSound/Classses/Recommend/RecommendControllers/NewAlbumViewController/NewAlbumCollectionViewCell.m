//
//  NewAlbumCollectionViewCell.m
//  MusicSound
//
//  Created by 王言博 on 15/6/30.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "NewAlbumCollectionViewCell.h"

@implementation NewAlbumCollectionViewCell
- (void)dealloc
{
    [_label1 release];
    [_label2 release];
    [_myImageView release];
    [_myAlbumModel release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}
- (void)createSubViews
{
    [self.contentView addSubview:self.myImageView];
    [_myImageView release];
    [self.contentView addSubview:self.label1];
    [_label1 release];
    [self.contentView addSubview:self.label2];
    [_label2 release];

}
- (UIImageView *)myImageView
{
    if (_myImageView == nil) {
        _myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height - 65)];
        _myImageView.backgroundColor = [UIColor purpleColor];
        
    }
    return _myImageView;
}
- (UILabel *)label1
{
    if (_label1 == nil) {
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 56, self.contentView.frame.size.width, 28)];
        _label1.textColor = [UIColor grayColor];
        _label1.backgroundColor = [UIColor redColor];
        _label1.backgroundColor = [UIColor clearColor];
        
    }
    return _label1;
}
- (UILabel *)label2
{
    if (_label2 == nil) {
        _label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 28, self.contentView.frame.size.width, 28)];
        _label2.textColor = [UIColor grayColor];
        _label2.backgroundColor = [UIColor magentaColor];
        _label2.backgroundColor = [UIColor clearColor];
    }
    return _label2;
}
- (void)setMyAlbumModel:(AlbumModel *)myAlbumModel
{
    if (_myAlbumModel != myAlbumModel) {
        [_myAlbumModel release];
        _myAlbumModel = [myAlbumModel retain];
    }
    NSURL *url = [NSURL URLWithString:self.myAlbumModel.pic_url];
    [self.myImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"grid_default"]];
    NSArray *array = [self.myAlbumModel.title componentsSeparatedByString:@" - "];
    self.label2.text = [array objectAtIndex:0];
    self.label1.text = [array objectAtIndex:1];
    
}
@end
