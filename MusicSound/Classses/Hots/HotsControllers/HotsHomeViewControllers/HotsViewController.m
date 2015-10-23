//
//  HotsViewController.m
//  天天动听
//
//  Created by 大泽 on 15/6/12.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "HotsViewController.h"
#import "HotsModel.h"
#import "HotsFrameModel.h"
#import "HotsTableViewCell.h"
#import "HotsDetailViewController.h"
#import "HotsHeaderViewController.h"
#import "HotsHeaderModel.h"
#import "HotsHomeDataBase.h"
#import "HotsHomeSongListDataBase.h"
#import "HotsSongList.h"
#import "FMHotsHomeDataBase.h"
#import "FMHotsHomeHeaderDataBase.h"

#define hotsConnect @"http://v1.ard.tj.itlily.com/ttpod?a=getnewttpod&id=281&app=ttpod&v=v7.9.4.2015052918&uid=&mid=iPhone7%2C2&f=f320&s=s310&imsi=&hid=&splus=8.3&active=1&net=2&openudid=03d04d590225a4fc0d5e5201dfc288d5bd22fe59&idfa=157C61D2-64EC-4453-BCE0-F746F3A64747&utdid=VXlSrtlz43oDAOnVJ3SPXn8M&alf=201200&bundle_id=com.ttpod.music"

#define hotsHeaderConnect @"http://v1.ard.tj.itlily.com/ttpod?a=getnewttpod&id=54&size=1000&page=1&app=ttpod&v=v7.9.4.2015052918&uid=&mid=iPad%20Mini%20%28WiFi%29&f=f320&s=s330&imsi=&hid=&splus=8.1.1&active=0&net=2&openudid=7c173a4a8cfe0c733d25198b0fdcb3ecfdfb0fba&idfa=E9CD8DEC-BBCF-4839-A3A1-512E844873B3&utdid=VYZUnn%2BuJ1MDAMKwFfCFLTqG&alf=201200&bundle_id=com.ttpod.music"

@interface HotsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *tableViewArray;

@property (nonatomic, retain) HotsHeaderViewController *hotsHeaderVc;

@property (nonatomic, assign) BOOL tableViewRFState;

@property (nonatomic, assign) BOOL collectionViewRFState;

@property (nonatomic, copy) void(^endRefreshing)();

/**
 *  判断是否在下拉
 */
@property (nonatomic, assign, getter=isDragDown) BOOL isDragDown;

@end

static NSString *const ID = @"Hots";

@implementation HotsViewController

- (void)dealloc
{
    [_tableView release];
    [_tableViewArray release];
    [_hotsHeaderVc release];
    Block_release(_endRefreshing);
    
    [super dealloc];
}
- (NSMutableArray *)tableViewArray
{
    if (!_tableViewArray) {
        
        _tableViewArray = [[NSMutableArray alloc] init];
        
    }
    return [[_tableViewArray retain] autorelease];
}

#pragma mark - 创建tableview的HeaderView
- (HotsHeaderViewController *)hotsHeaderVc
{
    if (!_hotsHeaderVc) {
        
        _hotsHeaderVc = [[HotsHeaderViewController alloc] init];
        
        __block HotsViewController *hots = self;
        
        __block HotsHeaderViewController *hotsHeaderVc = self.hotsHeaderVc;
        
        // collectionView的点击item的回调方法
        self.hotsHeaderVc.option = ^(NSIndexPath *indexPath){
            
            HotsDetailViewController *hotsDetailVc = [[HotsDetailViewController alloc] init];
            
            HotsHeaderModel *hotsHeaderM = hotsHeaderVc.collectionViewArray[indexPath.item];
            
            hotsDetailVc.ID = hotsHeaderM.singer_id;
            
            hotsDetailVc.type = @"song/singer";
            
            [hots.navigationController pushViewController:hotsDetailVc animated:YES];
            
            [hotsDetailVc release];
            
        };
    }
    return [[_hotsHeaderVc retain] autorelease];
}

- (void)viewDidLoad
{
    self.title = @"排行";
    [super viewDidLoad];
    
    // 1.先从本地读取数据 装入数组中
    [self getHotsHomeFromLoc];
    [self getHotsHomeHeaderFromLoc];
    
    self.navigationController.automaticallyAdjustsScrollViewInsets = YES;
    
    [self.view addSubview:self.tableView];
}
#pragma mark - 排行的主页从本地读
- (void)getHotsHomeFromLoc
{
    NSMutableArray *array = [[FMHotsHomeDataBase shareFMHotsHomeDataBase] selectAllXYMusicHotsHomeModel];
    
    
    [array enumerateObjectsUsingBlock:^(HotsModel *hotsModel, NSUInteger idx, BOOL *stop) {
        
        HotsFrameModel *hotsFM = [[HotsFrameModel alloc] init];
        
        hotsFM.hotsModel = hotsModel;
        
        [self.tableViewArray addObject:hotsFM];
    }];
}

#pragma mark - 排行的headerView从本地读
- (void)getHotsHomeHeaderFromLoc
{
    NSMutableArray *array = [[FMHotsHomeHeaderDataBase shareFMHotsHomeHeaderDataBase] selectAllXYMusicHotsHomeHeaderModel];
        
    self.hotsHeaderVc.collectionViewArray = array;
}

#pragma mark - 排行的页面都从网络请求
- (void)getHotsHomeFromNet
{
    [[FMHotsHomeDataBase shareFMHotsHomeDataBase] deleteAllXYMusic];
    [[FMHotsHomeHeaderDataBase shareFMHotsHomeHeaderDataBase] deleteAllXYMusic];
    
//    [self.tableViewArray removeAllObjects];
//    [self.hotsHeaderVc.collectionViewArray removeAllObjects];
    
    [self addHotsHomeConnect];
    [self addHotsHeaderConnect];
}

#pragma mark - 排行主页网络请求
- (void)addHotsHomeConnect
{
    __block HotsViewController *hots = self;
    
    [AFNConnect AFNConnectWithUrl: hotsConnect key:@"data" connectBlock:^(id data) {
        
        hots.tableViewArray = [HotsModel hotsWithArray:data];
        
        [_tableView reloadData];
        
        hots.tableViewRFState = YES;
        
        [hots shouldEndRefreshing];
        
    }];
    
}

#pragma mark - 排行headerView的网络请求
- (void)addHotsHeaderConnect
{
    __block HotsViewController *hots = self;
    
    __block HotsHeaderViewController *hotsHeaderVc = self.hotsHeaderVc;
    
    // 从本地读取
    
    [AFNConnect AFNConnectWithUrl:hotsHeaderConnect key:@"data" connectBlock:^(id data) {
        
        hotsHeaderVc.collectionViewArray = [HotsHeaderModel hotsHeaderWithArray:data];
        
        [hotsHeaderVc.collectionView reloadData];
        
#pragma mark - 判断collectionView是否是下拉状态
        
        hots.collectionViewRFState = YES;
        
        [hots shouldEndRefreshing];
        
    }];

}

#pragma mark - 回调属性的结束刷新
- (void)shouldEndRefreshing
{
    if (self.tableViewRFState && self.collectionViewRFState) {
        self.endRefreshing();
        self.isDragDown = NO;
    }
}
- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 108) style:UITableViewStylePlain];
        _tableView.alpha = 0.9;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HotsTableViewCell class] forCellReuseIdentifier:ID];
        
        _tableView.tableHeaderView = self.hotsHeaderVc.view;
        
        __block HotsViewController *hots = self;
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
            
#warning 统一从网络请求
            
            if ([self isDragDown] == NO) {
                
                [hots getHotsHomeFromNet];
                
                self.isDragDown = YES;
                // 2. 回调的结束刷新方法
                hots.endRefreshing = ^{
                    
                    // MJRefresh 结束刷新
                    [hots.tableView.header endRefreshing];
                    
                    hots.tableViewRFState = NO;
                    hots.collectionViewRFState = NO;
                    
                };
            }
            
        }];
        
        if (self.tableViewArray.count == 0) {
            [self.tableView.header beginRefreshing];
        }
    }
    return [[_tableView retain] autorelease];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    HotsFrameModel *hotsFM = self.tableViewArray[indexPath.row];
    
    cell.hotsFModel = hotsFM;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotsFrameModel *hotsFM = self.tableViewArray[indexPath.row];
    
    return hotsFM.cellH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HotsDetailViewController *detail = [[HotsDetailViewController alloc] init];
    
    HotsFrameModel *hotsFM = self.tableViewArray[indexPath.row];
    
    detail.ID = hotsFM.hotsModel.ID;
    
    detail.type = @"channel/ranklist";

    [self.navigationController pushViewController:detail animated:YES];
}

@end
