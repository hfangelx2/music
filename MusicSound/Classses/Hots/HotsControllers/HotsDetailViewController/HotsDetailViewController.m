//
//  HotsDetailViewController.m
//  MusicSound
//
//  Created by 大泽 on 15/6/20.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "HotsDetailViewController.h"
#import "HotsDetailModel.h"
#import "HotsDetailFrameModel.h"
#import "HotsDetailTableViewCell.h"
#import "PlayerViewController.h"
#import "XYMusic.h"
#import "DestAndCurrentMusic.h"
@interface HotsDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *tableViewArray;

@property (nonatomic, retain) UIImageView *imageView;

@property (nonatomic, assign, getter=isDragDownLoading) BOOL dragDownLoading;

@property (nonatomic, assign, getter=isDragUpLoading) BOOL dragUpLoading;

@property (nonatomic, assign) int page;
@end

@implementation HotsDetailViewController

static NSString *const ID = @"DetailHots";

- (void)dealloc
{
    [_tableView release];
    [_tableViewArray release];
    
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:nil image:@"top_bar_back3" target:self action:@selector(pop)];
    self.page = 1;
    [self.view addSubview:self.tableView];
}


#define kHotsDetailConnect @"http://api.dongting.com/%@/%@/songs?page=%d"

#define kHotsDetailConnect1 @"&app=ttpod&v=v7.9.4.2015052918&uid=&mid=iPhone7%2C2&f=f320&s=s310&imsi=&hid=&splus=8.3&active=1&net=2&openudid=03d04d590225a4fc0d5e5201dfc288d5bd22fe59&idfa=157C61D2-64EC-4453-BCE0-F746F3A64747&utdid=VXlSrtlz43oDAOnVJ3SPXn8M&alf=201200&bundle_id=com.ttpod.music"


#warning 详情
/*

//@"http://api.dongting.com/song/singer/1022065/songs?page=1&size=50&app=ttpod&v=v7.9.4.2015052918&uid=&mid=iPhone7%2C2&f=f320&s=s310&imsi=&hid=&splus=8.3&active=1&net=2&openudid=03d04d590225a4fc0d5e5201dfc288d5bd22fe59&idfa=157C61D2-64EC-4453-BCE0-F746F3A64747&utdid=VXlSrtlz43oDAOnVJ3SPXn8M&alf=201200&bundle_id=com.ttpod.music"

//@"http://api.dongting.com/song/singer/1022065/songs?page=2&size=50&app=ttpod&v=v7.9.4.2015052918&uid=&mid=iPhone7%2C2&f=f320&s=s310&imsi=&hid=&splus=8.3&active=1&net=2&openudid=03d04d590225a4fc0d5e5201dfc288d5bd22fe59&idfa=157C61D2-64EC-4453-BCE0-F746F3A64747&utdid=VXlSrtlz43oDAOnVJ3SPXn8M&alf=201200&bundle_id=com.ttpod.music"
*/
- (NSMutableArray *)tableViewArray
{
    
    if (!_tableViewArray) {
        
        self.tableViewArray = [NSMutableArray array];
        [self addDetailConnect];
        
    }
    return [[_tableViewArray retain] autorelease];
}

- (UIImageView *)imageView
{
#define adapterH adapter.sHeight
#define adapterW adapter.sWidth
    CGAdapter adapter = [AdapterModel getCGAdapter];
    
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW * adapterW, 160 * adapterH)];
        _imageView.image = [UIImage imageNamed:@"MusicCircleDefaultImage.jpg"];
    }
    return [[_imageView retain] autorelease];
}

- (void)addDetailConnect
{
    __block HotsDetailViewController *hotsDetailVc = self;
    
    NSString *url1 = [NSString stringWithFormat:kHotsDetailConnect,self.type, self.ID, self.page];
    
    NSString *url = [url1 stringByAppendingString:kHotsDetailConnect1];
    
    [AFNConnect AFNConnectWithUrl:url key:@"data" connectBlock:^(id data) {
        
        NSMutableArray *array =  [HotsDetailModel hotsDetailModelWithArray:data];
        
        [hotsDetailVc.tableViewArray addObjectsFromArray:array];
        
        if ([hotsDetailVc isDragDownLoading]) {
            [hotsDetailVc.tableView.header endRefreshing];
            hotsDetailVc.dragDownLoading = NO;
        }
        
        if ([hotsDetailVc isDragUpLoading]) {
            [hotsDetailVc.tableView.footer endRefreshing];
            hotsDetailVc.dragUpLoading = NO;
        }
        
        [_tableView reloadData];
    }];
}


- (UITableView *)tableView
{
    if (!_tableView) {
        
        __block HotsDetailViewController *hotsDetailVc = self;

        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 108) style:UITableViewStylePlain];
        _tableView.alpha = 0.9;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HotsDetailTableViewCell class] forCellReuseIdentifier:ID];
        _tableView.tableHeaderView = self.imageView;

        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            hotsDetailVc.dragDownLoading = YES;
            hotsDetailVc.page = 1;
            [hotsDetailVc addDetailConnect];
            
        }];
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            hotsDetailVc.dragUpLoading = YES;
            hotsDetailVc.page ++;
            
            [hotsDetailVc addDetailConnect];
        }];
        _tableView.footer = footer;

    }
    return [[_tableView retain] autorelease];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    HotsDetailFrameModel *hotsDetailF = self.tableViewArray[indexPath.row];
    
    cell.hotsDetailFM = hotsDetailF;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotsDetailFrameModel *hotsDetailFM = self.tableViewArray[indexPath.row];
    
    return hotsDetailFM.cellH;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PlayerViewController *playVc = [PlayerViewController shareInterface];
    
    // 先传数组
    // 获取对应页的所有音乐数据 歌名 歌手名 链接
    NSMutableArray *musicArray = [self getMusicsWithArray:self.tableViewArray];
    
    [DestAndCurrentMusic shareDestAndCurrentMusic].destMusic = musicArray[indexPath.row];

    
#warning 传值到播放器的核心代码2
    playVc.musics = musicArray;
#warning 传值到播放器的核心代码3
    // 再传数组
    playVc.index = indexPath.item;
    
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
    
    [array enumerateObjectsUsingBlock:^(HotsDetailFrameModel *obj, NSUInteger idx, BOOL *stop) {
        
        NSString *name = obj.hotsDetailModel.name;
        NSString *singerName = obj.hotsDetailModel.singerName;
        NSDictionary *urlList = [obj.hotsDetailModel.urlList lastObject];
        
        NSString *url = urlList[@"url"];
        NSString *duration = urlList[@"duration"];
        
        NSString *time = [NSString getMinuteSecondWithSecond:duration];
        
#warning 传值到播放器的核心代码1
        XYMusic *music = [XYMusic musicWithName:name singerName:singerName urlList:url posterUrl:nil duration:time];
        
        [arrayM addObject:music];
    }];
    return arrayM;
}




- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
