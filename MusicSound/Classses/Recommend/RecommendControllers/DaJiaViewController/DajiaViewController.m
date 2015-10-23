
//
//  DajiaViewController.m
//  MusicSound
//
//  Created by 王言博 on 15/6/29.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//


#import "DajiaViewController.h"

@interface DajiaViewController ()

@end

@implementation DajiaViewController

- (void)dealloc
{
    [_myTableView release];
    [_allSongArray release];
    [super dealloc];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.allSongArray = [NSMutableArray array];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:nil image:@"top_bar_back3" target:self action:@selector(pop)];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.myTableView];
    [_myTableView release];
    self.isUpLoading = NO;

    
    [self addHeader];
    [self addFooter];

    
}
-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addHeader
{
      __block DajiaViewController *vc = self;//因为block块里用self会报警告,所以需要将self声明成block变量
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    // 添加下拉刷新头部控件
    self.myTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        vc.nextPage = 1; // 记录页码
        vc.isUpLoading = NO; //  标记为下拉操作
        [vc GetPersonList:vc.nextPage];
    }];
    
#pragma mark 自动刷新(一进入程序就下拉刷新)
    [self.myTableView.header beginRefreshing];
}
- (void)addFooter
{
    __block DajiaViewController *vc = self;
    self.myTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        vc.nextPage ++;
        vc.isUpLoading = YES; // 标记为上拉操作
        [vc GetPersonList:vc.nextPage];
    }];
}
-(void)GetPersonList:(NSInteger)nextCursor
{
    NSString *url = [NSString stringWithFormat:@"%@%ld%@", DajiaUrl1,nextCursor,DajiaUrl2];
    NSLog(@"page = %ld", self.nextPage);
    [AFNConnect AFNConnectWithUrl:url key:@"data" connectBlock:^(id data) {
//        NSLog(@"%@", data);
        
        if (self.isUpLoading == NO) {
            //说明是下拉，就要清空数组中的数据
            [self.allSongArray removeAllObjects];
        }
        for (NSDictionary *dic in data) {
            DajiaSongModel *dddd = [[DajiaSongModel alloc] init];
            [dddd setValuesForKeysWithDictionary:dic];
            [self.allSongArray addObject:dddd];
            [dddd release];
        }
        [self.myTableView.header endRefreshing];
        [self.myTableView.footer endRefreshing];
        [self.myTableView reloadData];

        
//        NSLog(@"%@", self.allSongArray);
    }];

}
- (UITableView *)myTableView
{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 44 - 64)  style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor whiteColor];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.rowHeight = 80;
        // 去掉分割线
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return _myTableView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *DajiaCellIdentifier = @"DajiaCell";
    ModelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DajiaCellIdentifier];
    if (cell == nil) {
        cell = [[ModelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DajiaCellIdentifier];
        
    }
    cell.cellIndexPath = indexPath;
    DajiaSongModel *aa = [self.allSongArray objectAtIndex:indexPath.row];
    cell.cellSongModel = aa;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"-----%ld", indexPath.row);
    
    NSMutableArray *musicArray  = [self getMusicsWithArray:self.allSongArray];
    PlayerViewController *playVc  = [PlayerViewController shareInterface];
    
    playVc.musics = musicArray;
    
    playVc.index = indexPath.row;

}
- (NSMutableArray *)getMusicsWithArray:(NSMutableArray *)array
{
    NSMutableArray *arrayM = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(DajiaSongModel *obj, NSUInteger idx, BOOL *stop) {
        
        NSString *name = obj.name;
        NSString *singerName = obj.singerName;
        NSDictionary *urlList = [obj.urlList firstObject];
        
        NSString *url = urlList[@"url"];
        NSString *dura = urlList[@"duration"];
        NSInteger temp = [dura integerValue]/1000;
        NSString *duration = [NSString stringWithFormat:@"%ld",temp];
        
#warning 传值到播放器的核心代码1
        XYMusic *music = [XYMusic musicWithName:name singerName:singerName urlList:url posterUrl:nil duration:duration];
        
        [arrayM addObject:music];
    }];
    return arrayM;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"%ld", self.allSongArray.count);
    return self.allSongArray.count;

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
