
//
//  NewAlbumViewController.m
//  MusicSound
//
//  Created by 王言博 on 15/6/30.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "NewAlbumViewController.h"

@interface NewAlbumViewController ()

@end

@implementation NewAlbumViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.allkeysArr = [NSMutableArray array];
        self.allAlbumArr = [NSMutableArray array];
        self.allWeekArr = [NSMutableArray array];
        self.allWeekDic = [NSMutableDictionary dictionary];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:nil image:@"top_bar_back3" target:self action:@selector(pop)];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.collectView];
    [_collectView release];
    [self getData];
    [self addFooter];

}
- (void)getData
{
        self.nextPage = 1;
//       [self GetPersonList:self.nextPage];
}

-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addFooter
{
    __block NewAlbumViewController *vc = self;
    
    self.collectView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        vc.nextPage ++;
        [vc GetPersonList:vc.nextPage];

    }];

    
    [self.collectView.footer beginRefreshing];

}
-(void)GetPersonList:(NSInteger)nextCursor
{
    
    [AFNConnect AFNConnectWithUrl:[NSString stringWithFormat:@"%@%ld%@", NewAlbumUrl1, nextCursor, NewAlbumUrl2] key:@"data" connectBlock:^(id data) {
        for (NSDictionary *dic in data) {
            AlbumModel *aaaaa = [[AlbumModel alloc] init];
            [aaaaa setValuesForKeysWithDictionary:dic];
            [self.allAlbumArr addObject:aaaaa];
            [aaaaa release];
        }
        [self.allkeysArr removeAllObjects];
        AlbumModel *ccc = [self.allAlbumArr lastObject];
        AlbumModel *ddd = [self.allAlbumArr firstObject];
        NSInteger last = [ccc.week integerValue];
        NSInteger fir  = [ddd.week integerValue];
       
        for (NSInteger i = fir; i>last; i--) {
             NSMutableArray *array = [NSMutableArray array];
            NSString *str1 = [NSString stringWithFormat:@"%ld", i];
            [self.allkeysArr addObject:str1];
        for (AlbumModel *bbb in self.allAlbumArr) {
            NSString *str2 = [NSString stringWithFormat:@"%@",bbb.week];
            
            if ([str1 isEqualToString:str2]) {
                [array addObject:bbb];
            }
            [self.allWeekDic setObject:array forKey:str1];
        }
            
            
        }

        [self.collectView.footer endRefreshing];
        [self.collectView reloadData];
    }];
    
}

- (UICollectionView *)collectView
{
    if (_collectView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(170 , 170 + 65);
        flowLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 80);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        flowLayout.minimumInteritemSpacing = 1.0; // 列间距
        flowLayout.minimumLineSpacing = 20; // 行间距
        
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, 375, self.view.frame.size.height - 44) collectionViewLayout:flowLayout];
        _collectView.backgroundColor = [UIColor yellowColor];
        _collectView.backgroundColor = [UIColor clearColor];
        [_collectView registerClass:[NewAlbumCollectionViewCell class] forCellWithReuseIdentifier:@"resuse"];
        [_collectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerReuse"];
        _collectView.delegate = self;
        _collectView.dataSource = self;
    }
    return _collectView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewAlbumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"resuse" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    cell.backgroundColor = [UIColor clearColor];
    
    NSString *key = [self.allkeysArr objectAtIndex:indexPath.section];
    NSMutableArray *array = [self.allWeekDic objectForKey:key];
    AlbumModel *dd = [array objectAtIndex:indexPath.row];
    
    cell.myAlbumModel = dd;
    return cell;
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.allkeysArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *key = [self.allkeysArr objectAtIndex:section];
    NSMutableArray *array = [self.allWeekDic objectForKey:key];
    return array.count;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerReuse" forIndexPath:indexPath];
    
        headerView.backgroundColor = [UIColor cyanColor];
    headerView.backgroundColor = [UIColor clearColor];
    UIImageView *weekImageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 50, 50)];
    weekImageV.image = [UIImage imageNamed:@"WeekRecommendBackground.png"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 20, 30, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.text = @"17";
    label.textAlignment = NSTextAlignmentCenter;
    NSString *key = [self.allkeysArr objectAtIndex:indexPath.section];
    label.text = key;
        [headerView addSubview:weekImageV];
    
    [headerView addSubview:label];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(300, 30, 60, 30)];
    label2.text = @"2015";
    label2.font = [UIFont systemFontOfSize:20];
    label2.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label2];
        return headerView;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [self.allkeysArr objectAtIndex:indexPath.section];
    NSMutableArray *array = [self.allWeekDic objectForKey:key];
    AlbumModel *aaaa = [array objectAtIndex:indexPath.row];
    HaibaoViewController *bbbb = [[HaibaoViewController alloc] init];
    bbbb.value = aaaa.msg_id;
    [self.navigationController pushViewController:bbbb animated:YES];
    
}
- (void)dealloc
{
    [_allWeekDic release];
    [_allWeekArr release];
    [_allAlbumArr release];
    [_allkeysArr release];
    [_ii release];
    [_jj release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
