//
//  MyCollectionViewCell.m
//  MusicSound
//
//  Created by 王言博 on 15/6/23.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell
{
    CGAdapter adaapter;
}

- (void)dealloc
{
    [_myData release];
    [_imageView release];
    [_myLabel1 release];
    [_myLabel2 release];
    [_myLabel3 release];
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
    adaapter = [AdapterModel getCGAdapter];
    [self.contentView addSubview:self.imageView];
    [_imageView release];
    
    [self.contentView addSubview:self.myLabel1];
    [_myLabel1 release];
    
    [self.contentView addSubview:self.myLabel2];
    [_myLabel2 release];
    
    [self.contentView addSubview:self.myLabel3];
    [_myLabel3 release];
}
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        NSLog(@"%f", self.contentView.frame.size.width);
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.width)];
        _imageView.backgroundColor = [UIColor orangeColor];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.layer.cornerRadius = 8;
        
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}
- (UILabel *)myLabel1
{
    if (_myLabel1 == nil) {
        _myLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.origin.x , 0, self.contentView.frame.size.width, 17)];
        _myLabel1.backgroundColor = [UIColor redColor];
        _myLabel1.textAlignment = NSTextAlignmentRight;
        _myLabel1.layer.cornerRadius = 8;
        
        _myLabel1.layer.masksToBounds = YES;
    }
    return _myLabel1;
}
- (UILabel *)myLabel2
{
    if (_myLabel2 == nil) {
        _myLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.size.height - 50, self.contentView.frame.size.width, 50)];
        _myLabel2.backgroundColor = [UIColor clearColor];
        _myLabel2.textColor = [UIColor grayColor];

    }
    return _myLabel2;
}

- (UILabel *)myLabel3
{
    if (_myLabel3 == nil) {
        _myLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(3, self.imageView.frame.size.height - 17, self.contentView.frame.size.width - 6, 17)];
        _myLabel3.backgroundColor = [UIColor yellowColor];
        _myLabel3.backgroundColor = [UIColor clearColor];
    }
    return _myLabel3;
}
- (void)setMyData:(Data *)myData
{
    if (_myData != myData) {
        [_myData release];
        _myData = [myData retain];
    }
    NSURL *url = [NSURL URLWithString:self.myData.pic_url];
    [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"grid_default"]];
    NSString *str = [NSString stringWithFormat:@"收听人数: %@", self.myData.listen_count];
    self.myLabel1.text = str;
    self.myLabel1.font = [UIFont systemFontOfSize:12.0];
    self.myLabel2.text = self.myData.name;
    self.myLabel2.font = [UIFont systemFontOfSize:15.0];
    self.myLabel1.textColor = [UIColor whiteColor];
    self.myLabel3.textColor = [UIColor whiteColor];
    CGSize size = [self.myLabel2.text boundingRectWithSize:CGSizeMake(self.contentView.frame.size.width, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
    CGRect rect = self.myLabel2.frame;
    
    rect.size = size;
    
    self.myLabel2.frame = rect;
    
    
    self.myLabel2.numberOfLines = 2;
    self.myLabel3.text = self.myData.author;
    
    self.myLabel1.backgroundColor = [UIColor lightGrayColor];
    self.myLabel1.alpha = 0.6;
    
    
}
@end
