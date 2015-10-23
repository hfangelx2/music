//
//  SongLibraryViewController.m
//  MusicSound
//
//  Created by shuwen on 15/6/22.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "SongLibraryViewController.h"
#import "SongLibraryGroup.h"
#import "NewMusicViewController.h"
#import "SingerViewController.h"
#import "MVViewController.h"
#import "ClassificationViewController.h"

@interface SongLibraryViewController ()
{
    CGAdapter adapter;
}

@property (nonatomic, retain) UICollectionView *myCollectionView;

@property (nonatomic, retain) NSMutableArray *collectionViewArray;

@end

@implementation SongLibraryViewController

- (void)dealloc
{
    [_myCollectionView release];
    [_collectionViewArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    adapter = [AdapterModel getCGAdapter];
    
    self.navigationItem.title = @"乐库";
    
    [self initCollectionView];
    
    self.collectionViewArray = [NSMutableArray array];
    
    SongLibraryGroup *group0 = [SongLibraryGroup songLibraryGroupWithUrl:Music_newMusic destVc:[NewMusicViewController class] labelStr:nil imageStr:@"SongLibraryNewMusic"];
    
    SongLibraryGroup *group1 = [SongLibraryGroup songLibraryGroupWithUrl:Music_singer destVc:[SingerViewController class] labelStr:nil imageStr:@"SongLibrarySinger"];
    
    SongLibraryGroup *group2 = [SongLibraryGroup songLibraryGroupWithUrl:nil destVc:[MVViewController class] labelStr:nil imageStr:@"SongLibraryMV"];
    
    SongLibraryGroup *group3 = [SongLibraryGroup songLibraryGroupWithUrl:Music_classification destVc:[ClassificationViewController class] labelStr:nil imageStr:@"SongLibraryClassification"];
    
    [self.collectionViewArray addObject:group0];
    [self.collectionViewArray addObject:group1];
    [self.collectionViewArray addObject:group2];
    [self.collectionViewArray addObject:group3];
}

-(void)initCollectionView
{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, TITLE_HEIGHT, self.view.frame.size.width, (self.view.frame.size.height - TITLE_HEIGHT - PLAYER_HEIGHT)) collectionViewLayout:flowLayout];
    _myCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myCollectionView];
    
    flowLayout.itemSize = CGSizeMake(kScreenW - 20*adapter.sWidth, 160*adapter.sHeight);
    
    flowLayout.sectionInset = UIEdgeInsetsMake(MARGIN_WIDTH*2, MARGIN_WIDTH*2, MARGIN_WIDTH*2, MARGIN_WIDTH*2);    //设置边缘间距
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;   //设置竖向滚动
    
    //注册cell
    [_myCollectionView registerClass:[SongLibraryCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
    
    //列间距
    flowLayout.minimumInteritemSpacing = 10;
    //行间距
    flowLayout.minimumLineSpacing = 10;
    
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    
    [flowLayout release];
    [_myCollectionView release];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionViewArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SongLibraryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];

    SongLibraryGroup *group = self.collectionViewArray[indexPath.row];
    
    cell.labelStr = group.labelStr;
    cell.imageStr = group.imageStr;
    
    cell.layer.transform = CATransform3DMakeScale(0.7, 0.7, 1);  //动画效果
    [UIView animateWithDuration:0.5 animations:^{
        
        cell.layer.transform = CATransform3DMakeScale(1, 1, 0.5);
        
    }];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    
    SongLibraryGroup *group = self.collectionViewArray[indexPath.row];
    
    RootViewController *vc = [[group.destVc alloc] init];
        
    [self.navigationController pushViewController:vc animated:YES];
    
    [vc release];
}




@end









