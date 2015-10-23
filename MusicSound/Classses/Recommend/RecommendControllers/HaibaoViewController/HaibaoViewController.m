//
//  HaibaoViewController.m
//  MusicSound
//
//  Created by 王言博 on 15/6/25.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "HaibaoViewController.h"
#import <MBProgressHUD.h>
#import <UIImageView+WebCache.h>
#import "XYMusic.h"
#import "songInfoModel.h"
#import "PlayerViewController.h"
#import "DestAndCurrentMusic.h"
@interface HaibaoViewController ()
{
    MBProgressHUD *HUD;
}
@end

@implementation HaibaoViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.array = [NSMutableArray array];
        self.cellArr = [NSMutableArray array];

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:nil image:@"top_bar_back3" target:self action:@selector(pop)];
    
    NSLog(@"haibaoVC.type = %@", self.type);
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"推荐";
    // Do any additional setup after loading the view.
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 44 - 64)  style:UITableViewStylePlain];
    self.myTableView.backgroundColor = [UIColor whiteColor];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.rowHeight = 120;
    [self.view addSubview:self.myTableView];
    // 去掉分割线
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if ([self.type isEqual:@13]) {
        self.navigationItem.title = self.data.name;
        NSLog(@"%@", self.data.pic_url);
        UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        backImageView.backgroundColor= [UIColor whiteColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(375 - 240, 60, 80, 80)];
        NSURL *url = [NSURL URLWithString:self.data.pic_url];
        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"content-empty.jpg"]];
        [backImageView addSubview:imageView];
        [backImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"content-empty.jpg"]];
        
        UIVisualEffectView *visualEffct = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        visualEffct.frame = backImageView.frame;
        [imageView addSubview:visualEffct];
        [backImageView addSubview:visualEffct];

        imageView.layer.cornerRadius = 10;
        imageView.layer.masksToBounds = YES;
        [visualEffct addSubview:imageView];
        self.myTableView.tableHeaderView = backImageView;
    
    }else
    {
        self.musicHV = [[HaiBaoHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        self.musicHV.bounces = NO;
        self.musicHV.pagingEnabled = YES;
        self.musicHV.showsHorizontalScrollIndicator = NO;
        //    self.musicHV.contentOffset = CGPointMake(self.view.frame.size.width, 0);
        self.myTableView.tableHeaderView = self.musicHV;
        _musicHV.delegate = self;

        
        self.musicHV.headerBlock = ^(NSString *str) {
            //        NSLog(@"llll----%@", str);
            self.navigationItem.title = str;
        };

    }
       [_myTableView release];
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"网速不好, 那怪我喽";
    [HUD show:YES];


    if ([self.type isEqual:@6] || [self.type isEqual:@13]) {
        [self getSixData];
    } else
    {
        [self getData];
    }
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(140, self.musicHV.frame.size.height - 40, 100, 40)];
    self.pageControl.backgroundColor = [UIColor clearColor];
    [self.myTableView addSubview:self.pageControl];
    [self.pageControl addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
    [_pageControl release];
    
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    
    
}
-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)getData
{
    NSString *string = [NSString stringWithFormat:@"%@%@%@", RecommondURl1, self.value, RecommondURl2];
    [AFNConnect AFNConnectWithUrl:string key:@"data" connectBlock:^(id data) {
//        NSLog(@"-----%@", data);
        NSDictionary *dic = [data objectAtIndex:0];
        HaibaoViewModel *haiBao = [[HaibaoViewModel alloc] init];
        [haiBao setValuesForKeysWithDictionary:dic];
        [self.array addObject:haiBao];
        [haiBao release];

        // 重写set
        self.musicHV.array = self.array;
        HaibaoViewModel *ffff = [self.array objectAtIndex:0];
        
        NSString *string = nil;
        NSString *lastString = @"";
        for (SonglistsModel *ddd in ffff.allHaiViewModel) {
            string = [NSString stringWithFormat:@"%@%@%@", lastString,ddd.song_id, @","];
            lastString = [NSString stringWithFormat:@"%@", string];
        }
//        NSLog(@"%@", string);
        NSString *tmpStr = [string substringToIndex:string.length - 1];
        NSLog(@"song_id参数%@", tmpStr);
        
        NSString *songListStr = [NSString stringWithFormat:@"%@%@%@", SonglistUrl1, tmpStr, SonglistUrl2];
//        NSLog(@"%@", songListStr);
        self.songListUrl =  songListStr;
        [self getSonglistData];
        
    }];
    [self.myTableView reloadData];
}

- (void)getSonglistData
{
    [AFNConnect AFNConnectWithUrl:self.songListUrl key:@"data" connectBlock:^(id data) {
//        NSLog(@"%@", data);
        for (NSDictionary *jjj in data) {
            songInfoModel *bbb = [[songInfoModel alloc] init];
            [bbb setValuesForKeysWithDictionary:jjj];
            [self.cellArr addObject:bbb];
            [bbb release];
        }
        [self.myTableView reloadData];
        [HUD hide:YES];
    }];

}

- (void)getSixData
{
    [AFNConnect AFNConnectWithUrl:[NSString stringWithFormat:@"%@%@%@", SixlistUrl1, self.value, SixlistUrl2] key:@"data" connectBlock:^(id data) {
//        NSLog(@"%@", data);
        for (NSDictionary *jjj in data) {
            songInfoModel *bbb = [[songInfoModel alloc] init];
            [bbb setValuesForKeysWithDictionary:jjj];
            [self.cellArr addObject:bbb];
            //            NSLog(@"%@", self.cellArr);
            [bbb release];
            
        }
        [self.myTableView reloadData];
        [HUD hide:YES];

    }];
}
-(void)pageAction:(UIPageControl *)pageC
{
    [self.musicHV setContentOffset:CGPointMake(375 * pageC.currentPage, 0) animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = _musicHV.contentOffset.x / 375;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellIdentifier = @"myCell";
    ModelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ModelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
//    for (songInfoModel *ff in self.cellArr) {
//        NSLog(@"%@", ff.pick_count);
//    }
    cell.cellIndexPath = indexPath;
    songInfoModel *songModel = [self.cellArr objectAtIndex:indexPath.row];
    cell.bigModel = songModel;

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableArray *musicArray  = [self getMusicsWithArray:self.cellArr];
    PlayerViewController *playVc  = [PlayerViewController shareInterface];
    [DestAndCurrentMusic shareDestAndCurrentMusic].destMusic = musicArray[indexPath.row];

    playVc.musics = musicArray;
    
    playVc.index = indexPath.row;
}
- (NSMutableArray *)getMusicsWithArray:(NSMutableArray *)array
{
    NSMutableArray *arrayM = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(songInfoModel *obj, NSUInteger idx, BOOL *stop) {
        
        NSString *name = obj.song_name;
        NSString *singerName = obj.singer_name;
        NSDictionary *urlList = [obj.url_list lastObject];
        
        NSString *url = urlList[@"url"];
        NSString *duration = urlList[@"duration"];
        
#warning 传值到播放器的核心代码1
        XYMusic *music = [XYMusic musicWithName:name singerName:singerName urlList:url posterUrl:nil duration:duration];
        
        [arrayM addObject:music];
    }];
    return arrayM;
}
- (void)dealloc
{
    [_myTableView release];
    [_type release];
    [_value release];
    [_recomendModel release];
    [_data release];
    [_musicHV release];
    [_pageControl release];
    [_array release];
    [_cellArr release];
    [_songListUrl release];
    [super dealloc];
}

@end
