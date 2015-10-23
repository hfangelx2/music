//
//  ThirdTableViewCell.m
//  MusicSound
//
//  Created by 王言博 on 15/6/22.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "ThirdTableViewCell.h"
#import "AdapterModel.h"


@implementation ThirdTableViewCell
{
    CGAdapter adapter;
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
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(110 * adapter.sWidth, 170 * adapter.sHeight);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(10 * adapter.sWidth, 10 * adapter.sHeight, 10 * adapter.sWidth, 10 * adapter.sHeight);
    flowLayout.minimumInteritemSpacing = 1.0;
    flowLayout.minimumLineSpacing = 20 * adapter.sHeight;
    
//    NSLog(@"%f", self.frame.size.width);
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 170 * adapter.sHeight) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:collectionView];
    [collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"resuse"];
    collectionView.scrollEnabled = NO; // 不让它滚
    collectionView.delegate = self;
    collectionView.dataSource = self;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 直接从系统的重用池里取cell
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"resuse" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.myData = [self.allDataArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld, %ld", indexPath.section, indexPath.item);
    Data *bb = [self.allDataArray objectAtIndex:indexPath.item];
    
    NSLog(@"%@", bb.action1.value);
    self.collectBlock(bb.action1.value);
    
}


// 设置item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.allDataArray.count;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
