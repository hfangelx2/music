//
//  HotsHeaderViewController.m
//  MusicSound
//
//  Created by 大泽 on 15/6/21.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "HotsHeaderViewController.h"
#import "HotsHeaderCollectionViewCell.h"
#import "HotsHeaderFlowLayout.h"
#import "HotsHeaderModel.h"
#import "HotsDetailViewController.h"
@interface HotsHeaderViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

static NSString *const ID = @"Hots";

@implementation HotsHeaderViewController


- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 150)];
}

- (void)dealloc
{
    [_collectionView release];
    [_collectionViewArray release];
    
    [super dealloc];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[HotsHeaderFlowLayout alloc] init]];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"HotsHeaderCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
        
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return [[_collectionView retain] autorelease];
}


- (void)setCollectionViewArray:(NSMutableArray *)collectionViewArray
{
    if (_collectionViewArray != collectionViewArray) {
        [_collectionViewArray release];
        _collectionViewArray = [collectionViewArray retain];
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionViewArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HotsHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    HotsHeaderModel *hotsHeaderModel = self.collectionViewArray[indexPath.item];
    
    cell.hotsHeaderModel = hotsHeaderModel;
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    self.option(indexPath);
}

@end
