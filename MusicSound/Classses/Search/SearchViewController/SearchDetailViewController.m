//
//  SearchDetailViewController.m
//  MusicSound
//
//  Created by shuwen on 15/6/29.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "SearchDetailViewController.h"
#import "SearchModel.h"
#import "SearchDetailCell.h"
#import "PlayerViewController.h"
#import "DestAndCurrentMusic.h"
#import "PlayerToolBarController.h"
#import <MBProgressHUD.h>

@interface SearchDetailViewController ()
{
    MBProgressHUD *HUD;
    CGAdapter adapter;
}

@property (nonatomic, retain) UITableView *searchTableView;

@property (nonatomic, retain) NSMutableArray *searchArray;

@property (nonatomic, assign) NSInteger nextPage;//记录下一页

@end

@implementation SearchDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    adapter = [AdapterModel getCGAdapter];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:nil image:@"top_bar_back3" target:self action:@selector(pop)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:nil image:nil target:nil action:nil];
    
    self.navigationItem.title = self.searchText;
    
    [self createTableView];
    
    self.searchArray = [NSMutableArray array];
    
    [self getData:self.nextPage];
    [self addFooter];
    
    //让菊花旋转起来
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载中,请稍等=_=";
    [HUD show:YES];
}

#pragma mark --上拉加载更多
- (void)addFooter
{
    //    __unsafe_unretained typeof(self) vc = self;
    __block SearchDetailViewController *searchDetailVc = self;
    
    // 添加上拉刷新尾部控件
    self.searchTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态就会回调这个Block
        
        searchDetailVc.nextPage ++;
        [searchDetailVc getData:searchDetailVc.nextPage];//请求数据
        
    }];
}

- (void)getData:(NSInteger) nextCursor
{
    //利用UTF8进行转码
    NSString *urlStr = [[NSString stringWithFormat:@"http://so.ard.iyyin.com/s/song_with_out?q=%@&page=%ld&size=30&app=ttpod&v=v7.7.0.2015012818&uid=&mid=iPhone4&f=f320&s=s310&imsi=&hid=&splus=7.1.1&active=1&net=2&openudid=ad6f50f586818c4f36ff4358053c1b53fee58cdf&idfa=E2EAC64B-1F1C-4AC5-A0E1-8BE37A03FB96&utdid=VTCyBQSkYzwDAALO9zZTFfPC&alf=201200",self.searchText, self.nextPage] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSMutableArray *array = [dic objectForKey:@"data"];
        
        for (NSMutableDictionary *dataDic in array) {
            SearchModel *searchModel = [[SearchModel alloc] init];
            [searchModel setValuesForKeysWithDictionary:dataDic];
            NSMutableArray *urlArr = dataDic[@"url_list"];
            NSMutableDictionary *urlDic = [urlArr lastObject];
            [searchModel setValuesForKeysWithDictionary:urlDic];
            [self.searchArray addObject:searchModel];
            
            [searchModel release];
        }
        [HUD hide:YES];
        [self.searchTableView.footer endRefreshing];
        [self.searchTableView reloadData];
    }];

}

- (void)createTableView
{
    self.searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TITLE_HEIGHT, kScreenW, kScreenH - TITLE_HEIGHT) style:(UITableViewStylePlain)];
    
    self.searchTableView.backgroundColor = [UIColor whiteColor];
    
    self.searchTableView.separatorStyle = UITableViewCellSelectionStyleNone;//取消分割线
    
    [self.view addSubview:self.searchTableView];
    
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    
    [_searchTableView release];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cell";
    SearchDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[SearchDetailCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIndentifier];
    }
    SearchModel *searchModel = [self.searchArray objectAtIndex:indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    
    cell.searchModel = searchModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger height = 75*adapter.sHeight;
    return height;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PlayerViewController *playVC = [PlayerViewController shareInterface];
    
    // 先传数组
    // 获取对应页的所有音乐数据 歌名 歌手名 链接
    NSMutableArray *musicArray = [self getMusicsWithArray:self.searchArray];
    
    [DestAndCurrentMusic shareDestAndCurrentMusic].destMusic = musicArray[indexPath.row];
    
#warning 传值到播放器的核心代码2
    playVC.musics = musicArray;
#warning 传值到播放器的核心代码3
    // 再传数组
    playVC.index = indexPath.item;
    
}

/**
 *  返回一个数组,装的全是音乐的数据源
 *
 *  @param array         tableview的数据源
 *  @return 装的全是音乐的数据源
 */
- (NSMutableArray *)getMusicsWithArray:(NSMutableArray *)array
{
    NSMutableArray *arrayM = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(SearchModel *search, NSUInteger idx, BOOL *stop) {
        
        NSString *name = search.song_name;
        NSString *singerName = search.singer_name;
        NSDictionary *urlList = [search.url_list lastObject];
        
        NSString *url = urlList[@"url"];
        NSString *duration = urlList[@"duration"];
        
//        NSString *time = [NSString getMinuteSecondWithSecond:duration]; //将时间格式转换
        
#warning 传值到播放器的核心代码1
        XYMusic *music = [XYMusic musicWithName:name singerName:singerName urlList:url posterUrl:nil duration:duration];
        
        [arrayM addObject:music];
    }];
    return arrayM;
}


- (void)pop
{
    [PlayerToolBarController sharePlayerToolBarController].view.hidden = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end











