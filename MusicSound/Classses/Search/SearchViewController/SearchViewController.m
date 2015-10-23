//
//  SearchViewController.m
//  MusicSound
//
//  Created by shuwen on 15/6/29.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchDetailViewController.h"
#import "PlayerToolBarController.h"
#import "TOP100NameModel.h"

@interface SearchViewController ()
{
    CGAdapter adapter;
}

@property (nonatomic, retain) UITextField *searchField;

@property (nonatomic, retain) UISearchBar *searchBar;

@property (nonatomic, retain) NSMutableArray *topArray;

@end

@implementation SearchViewController

- (void)dealloc
{
    [_searchField release];
    [_searchBar release];
    [_topArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    adapter = [AdapterModel getCGAdapter];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:nil image:@"top_bar_back3" target:self action:@selector(disMiss)];
    self.navigationItem.title = @"搜索";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:nil image:nil target:nil action:nil];
    
    [self getData];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, TITLE_HEIGHT, kScreenW, 40*adapter.sHeight)];
    [self.view addSubview:self.searchBar];
    self.searchBar.delegate = self;
    
    self.topArray = [NSMutableArray array];
    
    [self.searchBar release];
    
}

- (void)getData
{
    NSString *url = [NSString stringWithFormat:@"http://v1.ard.tj.itlily.com/ttpod?a=getnewttpod&id=54&size=1000&page=1&app=ttpod&v=v7.7.0.2015012818&uid=&mid=iPhone5S&f=f320&s=s310&imsi=&hid=&splus=8.3&active=1&net=2&openudid=34694f31c85de7a7a450477cfb3109e3312c82b9&idfa=1760A76A-80E3-44C9-929D-F8572C7BCDCE&utdid=VCzS+CneWGcDABb/RxmsfFu8&alf=201200"];
    
    [AFNConnect AFNConnectWithUrl:url key:@"data" connectBlock:^(id data) {
        
        for (NSMutableDictionary *dic in data) {
            
            TOP100NameModel *topModel = [[TOP100NameModel alloc] init];
            
            [topModel setValuesForKeysWithDictionary:dic];
            
            [self.topArray addObject:topModel.singer_name];
            
            [topModel release];
        }
        
        [self viewWillAppear:YES];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, TITLE_HEIGHT + 40, kScreenW, kScreenH - TITLE_HEIGHT - 40)]autorelease];
    imageView.image = [UIImage imageNamed:@"CloudBG"];
    [self.view addSubview:imageView];
    
        NSMutableArray *array = [NSMutableArray arrayWithObjects:@"薛之谦",@"周杰伦",@"陈奕迅",@"TFBoys",@"邓紫棋",@"筷子兄弟",@"庄心妍",@"张杰",@"凤凰传奇",@"刘德华",@"汪峰",@"Beyond",@"林俊杰",@"张信哲",@"蔡依林",@"本兮",@"小贱",@"王力宏",@"五月天",@"萧亚轩",@"张靓颖",@"萧敬腾",@"杨宗纬",@"郝云", nil];
    
    CloudView *cloud = [[CloudView alloc] initWithFrame:CGRectMake(0, TITLE_HEIGHT + 40, kScreenW, kScreenH - TITLE_HEIGHT - 40) andNodeCount:array];
    
    cloud.delegate = self;
    
    [self.view addSubview:cloud];
    
}

-(void)didSelectedNodeButton:(CloudButton *)button
{
    SearchDetailViewController *searchDetailVC = [[SearchDetailViewController alloc] init];
    
    searchDetailVC.searchText = button.titleLabel.text;
    
    [PlayerToolBarController sharePlayerToolBarController].view.hidden = YES;
    [self.navigationController pushViewController:searchDetailVC animated:YES];
    
    [searchDetailVC release];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    SearchDetailViewController *searchDetailVC = [[SearchDetailViewController alloc] init];
    
    searchDetailVC.searchText = self.searchBar.text;
    
    [PlayerToolBarController sharePlayerToolBarController].view.hidden = YES;
    [self.navigationController pushViewController:searchDetailVC animated:YES];
    
    [searchDetailVC release];
}



- (void)disMiss
{
    [PlayerToolBarController sharePlayerToolBarController].view.hidden = NO;
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
