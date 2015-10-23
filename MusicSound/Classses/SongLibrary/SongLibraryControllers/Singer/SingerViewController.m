//
//  SingerViewController.m
//  MusicSound
//
//  Created by shuwen on 15/6/25.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "SingerViewController.h"
#import "SingerCell.h"
#import "SingerModel.h"
#import "SingerDetailViewController.h"
#import <MBProgressHUD.h>

@interface SingerViewController ()
{
    MBProgressHUD *HUD;
    CGAdapter adapter;
}

@property (nonatomic, retain) NSMutableArray *singerArray;

@property (nonatomic, retain) UICollectionView *singerCollectionView;

@property (nonatomic, retain) NSMutableArray *singerModelArray;

@end

@implementation SingerViewController

- (void)dealloc
{
    [_singerArray release];
    [_singerCollectionView release];
    [_singerModelArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    adapter = [AdapterModel getCGAdapter];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"歌手";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:nil image:@"top_bar_back3" target:self action:@selector(pop)];
    
    self.singerArray = [NSMutableArray array];
    
    [self initCollectionView];
    
    [self getSingerData];
    
    //让菊花旋转起来
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载中,请稍等=_=";
    [HUD show:YES];
}

- (void)getSingerData
{
    [AFNConnect AFNConnectWithUrl:Music_singer key:@"data" connectBlock:^(id data) {
        
        for (NSMutableDictionary *dic in data) {
            
            SingerModel *singerModel = [[SingerModel alloc] init];
            
            [singerModel setValuesForKeysWithDictionary:dic];
            
            [self.singerArray addObject:singerModel];
            
            [singerModel release];
        }
        [HUD hide:YES];
        [self.singerCollectionView reloadData];
    }];
}

- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.singerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, TITLE_HEIGHT, kScreenW, kScreenH - TITLE_HEIGHT - PLAYER_HEIGHT) collectionViewLayout:flowLayout];
    self.singerCollectionView.backgroundColor = [UIColor whiteColor];
    
    self.singerCollectionView.delegate = self;
    self.singerCollectionView.dataSource = self;
    
    //设置item大小
    flowLayout.itemSize = CGSizeMake((kScreenW / 3 - 2*MARGIN_WIDTH), (kScreenH - TITLE_HEIGHT - PLAYER_HEIGHT) / 4);
    
    flowLayout.sectionInset = UIEdgeInsetsMake(MARGIN_WIDTH, MARGIN_WIDTH, MARGIN_WIDTH, MARGIN_WIDTH);    //设置边缘间距
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;   //设置竖向滚动
    
    //列间距
    flowLayout.minimumInteritemSpacing = 5;
    //行间距
    flowLayout.minimumLineSpacing = 5;
    
    [self.view addSubview:self.singerCollectionView];
    
    //注册cell
    [self.singerCollectionView registerClass:[SingerCell class] forCellWithReuseIdentifier:@"reuse"];
    
    [flowLayout release];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.singerArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SingerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    
    SingerModel *singerModel = [self.singerArray objectAtIndex:indexPath.row];
    
    cell.singerModel = singerModel;
    
    cell.layer.transform = CATransform3DMakeScale(0.7, 0.7, 1);  //动画效果
    [UIView animateWithDuration:0.5 animations:^{
        
        cell.layer.transform = CATransform3DMakeScale(1, 1, 0.5);
        
    }];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SingerDetailViewController *singerDetailVC = [[SingerDetailViewController alloc] init];
    
    singerDetailVC.passTitle = [self.singerArray[indexPath.row] title];
    singerDetailVC.passId = [self.singerArray[indexPath.row] singer_id];
    
    [self.navigationController pushViewController:singerDetailVC animated:YES];
    
    [singerDetailVC release];
}


@end





