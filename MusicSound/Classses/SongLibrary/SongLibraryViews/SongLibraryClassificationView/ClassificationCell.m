//
//  ClassificationCell.m
//  MusicSound
//
//  Created by shuwen on 15/6/26.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "ClassificationCell.h"

@implementation ClassificationCell
{
    CGAdapter adapter;
}

- (void)dealloc
{
    [_classificationModel release];
    [_classificationImageView release];
    [_classificationLabel release];
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
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.classificationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height - 30*adapter.sHeight)];
    [self.contentView addSubview:self.classificationImageView];
    
    self.classificationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 25*adapter.sHeight, self.contentView.frame.size.width, 20*adapter.sHeight)];
    self.classificationLabel.font = [UIFont systemFontOfSize:13*adapter.sHeight];
    [self.contentView addSubview:self.classificationLabel];
    
    [_classificationImageView release];
    [_classificationLabel release];
}

-(void)setClassificationModel:(ClassificationModel *)classificationModel
{
    if (_classificationModel != classificationModel) {
        [_classificationModel release];
        _classificationModel = [classificationModel retain];
    }
    
    self.classificationLabel.text = _classificationModel.songlist_name;
    
    NSString *urlStr = _classificationModel.small_pic_url;
    NSURL *url = [NSURL URLWithString:urlStr];
    [self.classificationImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"grid_default"]];
    
}



@end





