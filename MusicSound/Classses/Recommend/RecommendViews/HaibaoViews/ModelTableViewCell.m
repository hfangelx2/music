//
//  ModelTableViewCell.m
//  MusicSound
//
//  Created by 王言博 on 15/6/25.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "ModelTableViewCell.h"

@implementation ModelTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubview];
    }
    return self;
}
- (void)createSubview
{
    [self.contentView addSubview:self.addButton];
//    [self.contentView addSubview:self.bacgImageV];
//    [_bacgImageV release];
    
    [self.contentView addSubview:self.loveCount];
    [_loveCount release];
    
    [self.contentView addSubview:self.songNameL];
    [_songNameL release];
    
    [self.contentView addSubview:self.actorLabel];
    [_actorLabel release];
    
    [self.contentView addSubview:self.limiLabel];
    [_limiLabel release];
    
    [self.contentView addSubview:self.SQImageView];
    [_SQImageView release];
}
- (UIButton *)addButton
{
    if (_addButton == nil) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame = CGRectMake(20, 0, 40, 40);
        _addButton.backgroundColor = [UIColor clearColor];
//        _addButton.backgroundColor = [UIColor whiteColor];
        [_addButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _addButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_addButton setImage:[UIImage imageNamed:@"face_26"] forState:UIControlStateNormal];

    
    }
    return _addButton;
}
- (UIImageView *)bacgImageV
{
    if (_bacgImageV == nil) {
        _bacgImageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, -10, 50, 50)];
        _bacgImageV.backgroundColor = [UIColor orangeColor];
    }
    return _bacgImageV;
}
- (void)buttonAction:(UIButton *)button
{
    
}
- (UILabel *)loveCount
{
    if (_loveCount == nil) {
        _loveCount = [[UILabel alloc] initWithFrame:CGRectMake(self.addButton.frame.origin.x,self.addButton.frame.origin.y + self.addButton.frame.size.height, self.addButton.frame.size.width, 20)];
        _loveCount.font = [UIFont systemFontOfSize:12.0];
        _loveCount.backgroundColor = [UIColor clearColor];
//        _loveCount.backgroundColor = [UIColor clearColor];
    }
    return _loveCount;
}
- (UILabel *)songNameL
{
    if (_songNameL == nil) {
        _songNameL = [[UILabel alloc] initWithFrame:CGRectMake(self.addButton.frame.origin.x + self.addButton.frame.size.width + 10, self.addButton.frame.origin.y + 25, 200, 20)];
        _songNameL.backgroundColor = [UIColor yellowColor];
        _songNameL.backgroundColor = [UIColor clearColor];
    }
    return _songNameL;
}
- (UILabel *)limiLabel
{
    if (_limiLabel == nil) {
        _limiLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.songNameL.frame.origin.x, 79, self.frame.size.width, 1)];
        _limiLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return _limiLabel;
}
-(UILabel *)actorLabel
{
    if (_actorLabel == nil) {
        _actorLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.songNameL.origin.x + 20, self.songNameL.frame.origin.y + self.songNameL.frame.size.height, 200, 20)];
        _actorLabel.backgroundColor = [UIColor clearColor];
    }
    return _actorLabel;
}
- (void)setBigModel:(songInfoModel *)bigModel
{
    if (_bigModel != bigModel) {
        [_bigModel release];
        _bigModel = [bigModel retain];
    }
    self.loveCount.textAlignment = NSTextAlignmentCenter;
    
    if (self.bigModel.pick_count < 10000) {
        NSString *str1 = [NSString stringWithFormat:@"%ld", self.bigModel.pick_count];
        self.loveCount.text = str1;
    } else
    {
        CGFloat floatStr = self.bigModel.pick_count / 10000.0;
        NSString *str = [NSString stringWithFormat:@"%.1f万", floatStr];
        self.loveCount.text = str;
        
    }
    NSString *songStr = [NSString stringWithFormat:@"%ld. %@",self.cellIndexPath.row + 1, self.bigModel.song_name];
    self.songNameL.text = songStr;
    self.actorLabel.text = self.bigModel.singer_name;

    CGFloat width = [[self class] heigthForCell:self.songNameL.text];
    CGRect frame = self.songNameL.frame;
    frame.size.width = width;
    self.songNameL.frame = frame;
    
    self.SQImageView.x = CGRectGetMaxX(self.songNameL.frame) + 5;
    
//     播放网址
    /*
    for (Url_listModel *ff in self.bigModel.allUrl_list) {
        NSLog(@"%@", ff.type_description);
        NSLog(@"%@", ff.url);
    }
     */
     

}
- (void)setCellSongModel:(DajiaSongModel *)cellSongModel
{
    if (_cellSongModel != cellSongModel) {
        [_cellSongModel release];
        _cellSongModel = [cellSongModel retain];
    }
    self.loveCount.textAlignment = NSTextAlignmentCenter;
    if (self.cellSongModel.favorites < 10000) {
        NSString *str1 = [NSString stringWithFormat:@"%ld", self.cellSongModel.favorites];
        self.loveCount.text = str1;
    } else
    {
        CGFloat floatStr = self.cellSongModel.favorites / 10000.0;
        NSString *str = [NSString stringWithFormat:@"%.1f万", floatStr];
        self.loveCount.text = str;
        
    }
    NSLog(@"%ld", self.cellIndexPath.row);
    NSString *songStr = [NSString stringWithFormat:@"%ld. %@",self.cellIndexPath.row + 1, self.cellSongModel.name];
    self.songNameL.text = songStr;
    self.actorLabel.text = self.cellSongModel.singerName;

    CGFloat width = [[self class] heigthForCell:self.songNameL.text];
    CGRect frame = self.songNameL.frame;
    frame.size.width = width;
    self.songNameL.frame = frame;
    
    self.SQImageView.x = CGRectGetMaxX(self.songNameL.frame) + 5;
    
    for (UrlListModel *uuu in self.cellSongModel.allUrlListArr) {
        NSLog(@"%@%@", uuu.url, uuu.typeDescription);
    }
}
- (UIImageView *)SQImageView
{
    if (_SQImageView == nil) {
        _SQImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.songNameL.frame.origin.x + self.songNameL.frame.size.width + 5, self.songNameL.frame.origin.y + 2, 20, self.songNameL.frame.size.height -4)];
        _SQImageView.backgroundColor = [UIColor greenColor];
        _SQImageView.image = [UIImage imageNamed:@"song_cell_hq"];
    }
    return _SQImageView;
}

+ (CGFloat)heigthForCell:(NSString *)content
{
    //方法体内写 根据内容计算高度的逻辑
    //参数1.设置内容显示大小
    //参数2.设置内容计算类型
    //参数3.设置内容字体大小
    //参数4.苹果备用参数，设置为nil
    CGSize size = CGSizeMake(340, 30);
    
    //将字体属性放入到字典里
    // 计算字体的大小一定要与label的字体大小一致
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:17.0] forKey:NSFontAttributeName];
    //根据文字内容计算出内容大小 NSStringDrawingUsesLineFragmentOrigin 按照文字初始计算大小
    CGRect frame = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return frame.size.width;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
