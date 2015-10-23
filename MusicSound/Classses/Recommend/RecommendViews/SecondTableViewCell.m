//
//  SecondTableViewCell.m
//  MusicSound
//
//  Created by 王言博 on 15/6/22.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "SecondTableViewCell.h"
#import "AdapterModel.h"

@implementation SecondTableViewCell
{
    CGAdapter adapter;
}

- (void)dealloc
{
    [_allArr release];
    [_myData release];
    [_liMiLabel release];
    [_label1 release];
    [_label2 release];
    [_imageView1 release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
    }
    return self;
}
- (void)createSubViews
{
    adapter = [AdapterModel getCGAdapter];
    [self.contentView addSubview:self.imageView1];
    [_imageView1 release];
    [self.contentView addSubview:self.label1];
    [_label1 release];
    [self.contentView addSubview:self.liMiLabel];
    [_liMiLabel release];
    [self.contentView addSubview:self.label2];
    [_label2 release];
    
    
}
- (UIImageView *)imageView1{
    if (_imageView1 == nil) {
        _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10 * adapter.sWidth, 10 * adapter.sHeight, 88 * adapter.sWidth, 88 * adapter.sHeight)];
        _imageView1.backgroundColor = [UIColor yellowColor];
        _imageView1.image = [UIImage imageNamed:@"grid_default"];
        _imageView1.layer.cornerRadius = 8;
        
        _imageView1.layer.masksToBounds = YES;
    }
    return _imageView1;
}
- (UILabel *)label1
{
    if (_label1 == nil) {
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake((self.imageView1.frame.size.width + 30) * adapter.sWidth, 20 * adapter.sHeight, 251 * adapter.sWidth, 30 * adapter.sHeight)];
        _label1.textColor = [UIColor grayColor];
        _label1.backgroundColor = [UIColor yellowColor];
        _label1.backgroundColor = [UIColor clearColor];
    }
    
    return _label1;
}
- (UILabel *)label2
{
    if (_label2 == nil) {
        _label2 = [[UILabel alloc] initWithFrame:CGRectMake((self.imageView1.frame.size.width + 30) * adapter.sWidth, (self.label1.frame.size.height + self.label1.frame.origin.y + 5) * adapter.sHeight, 251 * adapter.sWidth, 30 * adapter.sHeight)];
        _label2.textColor = [UIColor grayColor];
        _label2.backgroundColor = [UIColor orangeColor];
        _label2.backgroundColor = [UIColor clearColor];
        _label2.font = [UIFont systemFontOfSize:14.0];
    }
    return _label2;
}
- (UIImageView *)liMiLabel
{
    if (_liMiLabel == nil) {
        _liMiLabel = [[UIImageView alloc] initWithFrame:CGRectMake(100 * adapter.sWidth, 109 * adapter.sHeight, 260 * adapter.sWidth, 1)];
        _liMiLabel.image = [UIImage imageNamed:@"DetailPagePlaybackProgressBackground"];
    }
    return _liMiLabel;
}
- (void)setMyData:(Data *)myData
{
    if (_myData != myData) {
        [_myData release];
        _myData = [myData retain];
    }
    NSURL *url = [NSURL URLWithString:self.myData.pic_url];
    [self.imageView1 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"grid_default"]];
    self.label1.text = self.myData.name;

    if (self.myData.reason == nil) {
        self.label2.text = self.myData.desc;
    } else
    {
        self.label2.text = self.myData.reason;
    }
    
        //    NSLog(@"%@", self.allArr);
        
        _liMiLabel.hidden = NO;
        
        if ([self.myData isEqual:[self.allArr lastObject]]) {
            _liMiLabel.hidden = YES;
        }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
