//
//  SingerDetailViewController.m
//  MusicSound
//
//  Created by shuwen on 15/6/27.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "SingerDetailViewController.h"
#import "SingerDetailModel.h"
#import "SingerDetailCell.h"
#import "HotsDetailViewController.h"
#import <MBProgressHUD.h>

@interface SingerDetailViewController ()
{
    MBProgressHUD *HUD;
    CGAdapter adapter;
}

@property (nonatomic, retain) UITableView *singerDetailTableView;

@property (nonatomic, retain) NSMutableArray *singerDetailArray;

@end

@implementation SingerDetailViewController

- (void)dealloc
{
    [_singerDetailArray release];
    [_singerDetailTableView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    adapter = [AdapterModel getCGAdapter];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.singerDetailArray = [NSMutableArray array];
    
    [self initSingerDetailTableView];
    
    [self getSingerDetailData];
    
    self.navigationItem.title = self.passTitle;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:nil image:@"top_bar_back3" target:self action:@selector(pop)];
    
    //让菊花旋转起来
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在加载中,请稍等=_=";
    [HUD show:YES];
}

-(void)getSingerDetailData
{
    NSString *url = [NSString stringWithFormat:@"http://v1.ard.tj.itlily.com/ttpod?a=getnewttpod&id=%@&size=1000&page=1&app=ttpod&v=v7.7.0.2015012818&uid=&mid=iPhone5C&f=f320&s=s310&imsi=&hid=&splus=8.0.2&active=1&net=2&openudid=50a40f05044a0e2462e11cbf7d6612844b6c0008&idfa=058C286B-AB2C-41E2-A7FE-B67B3496FBBC&utdid=VQKI/UR603ADANyHaLs5uRrS&alf=201200",self.passId];
    
    [AFNConnect AFNConnectWithUrl:url key:@"data" connectBlock:^(id data) {
        
        for (NSMutableDictionary *dic in data) {
            
            SingerDetailModel *singerDetailModel = [[SingerDetailModel alloc] init];
            
            [singerDetailModel setValuesForKeysWithDictionary:dic];
            
            [self.singerDetailArray addObject:singerDetailModel];
            
            [singerDetailModel release];
            
        }
        [HUD hide:YES];
        [self.singerDetailTableView reloadData];
    }];
}

-(void)initSingerDetailTableView
{
    
    self.singerDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TITLE_HEIGHT, kScreenW, kScreenH - TITLE_HEIGHT - PLAYER_HEIGHT) style:(UITableViewStylePlain)];
    
    [self.view addSubview:self.singerDetailTableView];
    self.singerDetailTableView.backgroundColor = [UIColor whiteColor];
    
    self.singerDetailTableView.separatorStyle = UITableViewCellSelectionStyleNone;//取消分割线
    
    self.singerDetailTableView.delegate = self;
    self.singerDetailTableView.dataSource = self;
    
    [_singerDetailTableView release];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.singerDetailArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cell";
    SingerDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[SingerDetailCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIndentifier];
    }
    SingerDetailModel *singerDetailModel = [self.singerDetailArray objectAtIndex:indexPath.row];
    
    //渐变效果
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.alpha = 0;
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:1];
    cell.alpha = 1;
    [UIView commitAnimations];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    
    cell.singerDetailModel = singerDetailModel;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (kScreenH - TITLE_HEIGHT - PLAYER_HEIGHT) / 5.5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HotsDetailViewController *detail = [[HotsDetailViewController alloc] init];
    
    SingerDetailModel *singerDetailModel = self.singerDetailArray[indexPath.row];
    
    detail.ID = singerDetailModel.singer_id;
    
    detail.type = @"song/singer";
    
    [self.navigationController pushViewController:detail animated:YES];
    
    [detail release];
}



- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end










