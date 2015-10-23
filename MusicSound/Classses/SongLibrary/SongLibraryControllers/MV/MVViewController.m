//
//  MVViewController.m
//  MusicSound
//
//  Created by shuwen on 15/6/25.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "MVViewController.h"
#import "MVModel.h"
#import "MVCell.h"
#import "MVVideoViewController.h"
#import "PlayerViewController.h"
#import "PlayerToolBarController.h"
#import <MBProgressHUD.h>

@interface MVViewController ()
{
    MBProgressHUD *HUD;
    CGAdapter adapter;
}

@property (nonatomic, retain) UITableView *MVtableView;

@property (nonatomic, retain) NSMutableArray *mvArray;

@property (nonatomic, assign) NSInteger nextPage;//记录下一页

@property (nonatomic, assign) BOOL isUpLoading;//标记上拉操作还是下拉操作，yes为上拉

@end

@implementation MVViewController

- (void)dealloc
{
    [_MVtableView release];
    [_mvArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    adapter = [AdapterModel getCGAdapter];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:nil image:@"top_bar_back3" target:self action:@selector(pop)];
    
    self.navigationItem.title = @"MV";
    
    self.MVtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TITLE_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - TITLE_HEIGHT - PLAYER_HEIGHT) style:(UITableViewStylePlain)];
    
    self.MVtableView.backgroundColor = [UIColor whiteColor];
    
    self.MVtableView.dataSource = self;
    self.MVtableView.delegate = self;
    
    self.MVtableView.separatorStyle = UITableViewCellSeparatorStyleNone;//取消分割线
    
    self.mvArray = [NSMutableArray array];
    
    [self.view addSubview:self.MVtableView];
    
    [self addHeader];
    [self addFooter];
    
    [_MVtableView release];
    
}

- (void)addHeader
{
    
    __block MVViewController *mvVc = self;//因为block块里用self会报警告,所以需要将self声明成block变量
    
    // 添加下拉刷新头部控件
    self.MVtableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        // 进入刷新状态就会回调这个Block
        mvVc.nextPage = 1;//记录页码的
        mvVc.isUpLoading = NO;//标记为下拉操作
        [mvVc getMvData:mvVc.nextPage];//重新请求数据
        
    }];
    
#pragma mark 自动刷新(一进入程序就下拉刷新)
    [self.MVtableView.header beginRefreshing];
    
}

#pragma mark --上拉加载更多
- (void)addFooter
{
    __block MVViewController *mvVc = self;
    
    // 添加上拉刷新尾部控件
    self.MVtableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态就会回调这个Block
        
        mvVc.nextPage ++;
        mvVc.isUpLoading = YES;//标记为上拉操作
        [mvVc getMvData:mvVc.nextPage];//请求数据
        
    }];
}

- (void)getMvData:(NSInteger) nextCursor
{
    NSString *str = [NSString stringWithFormat:@"http://api.dongting.com/channel/channel/mvs?page=%ld&size=5",nextCursor];
    NSString *urlStr = [NSString stringWithFormat:@"%@" @"&app=ttpod&v=v7.9.4.2015052918&uid=&mid=iPhone5S&f=f320&s=s310&imsi=&hid=&splus=8.3&active=1&net=2&openudid=d232f6df99e4ad509e71b71c6f6eaee30bb76dba&idfa=1760A76A-80E3-44C9-929D-F8572C7BCDCE&utdid=VZJqKch9m3cDAEfUSH9EJ3JI&alf=201200&bundle_id=com.ttpod.music", str];
    NSLog(@"+++%@",urlStr);
    
    [AFNConnect AFNConnectWithUrl:urlStr key:@"data" connectBlock:^(id data) {
        
        if (self.isUpLoading == NO) {
            //说明是下拉，就要清空数组中的数据
            [self.mvArray removeAllObjects];
        }
        
        for (NSMutableDictionary *mvDic in data) {
            
            MVModel *mvModel =[[MVModel alloc]init];
            
            [mvModel setValuesForKeysWithDictionary:mvDic];
            
            [self.mvArray addObject:mvModel];

            NSMutableDictionary *tagDic1 = mvModel.tag.firstObject;
                
            mvModel.tagName1 = [tagDic1 objectForKey:@"tagName"];
            mvModel.tagColor1 = [tagDic1 objectForKey:@"tagColor"];
            
            NSMutableDictionary *tagDic2 = mvModel.tag.lastObject;
            
            mvModel.tagName2 = [tagDic2 objectForKey:@"tagName"];
            mvModel.tagColor2 = [tagDic2 objectForKey:@"tagColor"];
            
            NSMutableDictionary *urlDic = mvModel.mvList.firstObject;
                
            mvModel.url = [urlDic objectForKey:@"url"];
            
            [mvModel release];
        }
        
        [self.MVtableView.header endRefreshing];
        [self.MVtableView.footer endRefreshing];
        [self.MVtableView reloadData];
    }];
    
}

-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mvArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cell";
    MVCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[MVCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIndentifier].autorelease;
    }
    
    cell.layer.transform = CATransform3DMakeScale(0.7, 0.7, 1);  //动画效果
    [UIView animateWithDuration:0.5 animations:^{
        
        cell.layer.transform = CATransform3DMakeScale(1, 1, 0.5);
        
    }];
    
    cell.selectionStyle = UITextBorderStyleNone;//取消cell点击效果
    if (indexPath.row == 0) {
        cell.titleLabel.textColor = [UIColor cyanColor];
    }
    MVModel *mvModel = [self.mvArray objectAtIndex:indexPath.row];
    cell.mvModel = mvModel;
    
    return cell;
}
    
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 294*adapter.sHeight;
    return height;
}
    
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([NetWork netWork] == YES) {
        
        MVModel *mvModel =   [self.mvArray objectAtIndex:indexPath.item];
        
        MVVideoViewController *video = [[MVVideoViewController alloc] init];
        
        video.mvUrl = mvModel.url;
        
        [PlayerToolBarController sharePlayerToolBarController].view.hidden = YES;
        
        PlayerToolBarController *toolBar = [PlayerToolBarController sharePlayerToolBarController];
        [toolBar playerOrPause:toolBar.playerBtn];
        
        [self.navigationController presentViewController:video animated:YES completion:^{
            
        }];
        
        [video release];
    }else {
        [UIAlertView showAlertViewWithTitle:@"温馨提示" message:@"当前没有网络,无法播放该视频" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
    }
    
}



@end







