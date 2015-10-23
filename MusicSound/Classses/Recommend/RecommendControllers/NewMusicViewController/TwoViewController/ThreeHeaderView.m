//
//  ThreeHeaderView.m
//  MusicSound
//
//  Created by 王言博 on 15/6/27.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "ThreeHeaderView.h"

@implementation ThreeHeaderView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createSubviews];
        
    }
    return self;
}

-(void)createSubviews
{
    self.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
    
    self.leftIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.leftIV.backgroundColor = [UIColor yellowColor];
    self.leftIV.backgroundColor = [UIColor clearColor];
    [self addSubview:self.leftIV];
    [_leftIV release];
    
    UIImageView *centerIV = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    centerIV.backgroundColor = [UIColor cyanColor];
    centerIV.backgroundColor = [UIColor clearColor];
    centerIV.image = [UIImage imageNamed:@"MusicCircleDefaultImage.jpg"];
    [self addSubview:centerIV];
    [centerIV release];
    
    
    self.rightL = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, self.frame.size.height)];
    self.rightL.backgroundColor = [UIColor lightGrayColor];
   
    [self addSubview:self.rightL];
    [_rightL release];
    
    self.textRight = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width * 2 + 20, 0, self.frame.size.width - 30, self.frame.size.height)];
     self.textRight.text = @"给你最新最热最好听的音乐";
    self.textRight.textColor = [UIColor whiteColor];
    [self addSubview:self.textRight];
    [_textRight release];
}
- (void)setArray:(NSMutableArray *)array
{
    if (_array != array) {
        [_array release];
        _array = [array retain];
    }
    self.myHaiModel = [self.array objectAtIndex:0];
    NSURL *str = [NSURL URLWithString:self.myHaiModel.myPicsModel.pics];
    [self.leftIV sd_setImageWithURL:str placeholderImage:[UIImage imageNamed:@"content-empty"]];
    self.textRight.numberOfLines = 0;
    self.textRight.textColor = [UIColor whiteColor];
    self.textRight.text =  self.myHaiModel.tweet;
}
- (void)dealloc
{
    [_leftIV release];
    [_rightL release];
    [_array release];
    [_myHaiModel release];
    [_textRight release];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
