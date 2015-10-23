//
//  ClassificationViewController.m
//  MusicSound
//
//  Created by shuwen on 15/6/26.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "ClassificationViewController.h"
#import "ClassificationCell.h"
#import "ClassificationModel.h"
#import "HotsDetailViewController.h"
#import <MBProgressHUD.h>

@interface ClassificationViewController ()
{
    MBProgressHUD *HUD;
}

@property (nonatomic, retain) UICollectionView *classificationCollection;

@property (nonatomic, retain) NSMutableArray *classificationArray;

@end

@implementation ClassificationViewController

- (void)dealloc
{
    [_classificationCollection release];
    [_classificationArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"分类";
    
    [self initClassificationCollection];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:nil image:@"top_bar_back3" target:self action:@selector(pop)];
    
    self.classificationArray = [NSMutableArray array];
    
    [self getClassificationData];
    
    //让菊花旋转起来
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载中,请稍等=_=";
    [HUD show:YES];
}

-(void)getClassificationData
{
    [AFNConnect AFNConnectWithUrl:Music_classification key:@"data" connectBlock:^(id data) {
        for (NSMutableDictionary *dic in data) {
            
            ClassificationModel *classificationModel = [[ClassificationModel alloc] init];
            
            [classificationModel setValuesForKeysWithDictionary:dic];
            
            [self.classificationArray addObject:classificationModel];
            
            [classificationModel release];
        }
        [HUD hide:YES];
        [self.classificationCollection reloadData];
    }];
}

- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initClassificationCollection
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.classificationCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, TITLE_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - TITLE_HEIGHT - PLAYER_HEIGHT) collectionViewLayout:flowLayout];
    self.classificationCollection.backgroundColor = [UIColor whiteColor];
    self.classificationCollection.alpha = 0.9;
    
    self.classificationCollection.delegate = self;
    self.classificationCollection.dataSource = self;
    
    //设置item大小
    flowLayout.itemSize = CGSizeMake((self.view.frame.size.width / 3 - 2*MARGIN_WIDTH), (self.view.frame.size.height - TITLE_HEIGHT - PLAYER_HEIGHT) / 4);
    
    flowLayout.sectionInset = UIEdgeInsetsMake(MARGIN_WIDTH, MARGIN_WIDTH, MARGIN_WIDTH, MARGIN_WIDTH);    //设置边缘间距
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;   //设置竖向滚动
    
    //列间距
    flowLayout.minimumInteritemSpacing = 5;
    //行间距
    flowLayout.minimumLineSpacing = 5;
    
    [self.view addSubview:self.classificationCollection];
    
    //注册cell
    [self.classificationCollection registerClass:[ClassificationCell class] forCellWithReuseIdentifier:@"reuse"];
    
    [flowLayout release];
    [_classificationCollection release];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.classificationArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassificationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    
    ClassificationModel *classificationModel = [self.classificationArray objectAtIndex:indexPath.row];
    
    cell.layer.transform = CATransform3DMakeScale(0.7, 0.7, 1);  //动画效果
    [UIView animateWithDuration:0.5 animations:^{
        
        cell.layer.transform = CATransform3DMakeScale(1, 1, 0.5);
        
    }];
    
    cell.classificationModel = classificationModel;
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    HotsDetailViewController *detail = [[HotsDetailViewController alloc] init];
    
    ClassificationModel *classificationModel = self.classificationArray[indexPath.row];
    
    detail.ID = classificationModel.songlist_id;
    
    detail.type = @"channel/channel";
    
    [self.navigationController pushViewController:detail animated:YES];
    
    [detail release];
}


@end






