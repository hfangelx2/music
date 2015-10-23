//
//  OneViewController.m
//  MusicSound
//
//  Created by 王言博 on 15/6/27.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "OneViewController.h"
#import "PlayerViewController.h"
#import "DestAndCurrentMusic.h"

@implementation OneViewController
{
    CGAdapter adapter;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.array = [NSMutableArray array];
        self.cellArray = [NSMutableArray array];

    };
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    adapter = [AdapterModel getCGAdapter];
    

    NSLog(@"%@", self.msg_id);
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 64 - 44) style:UITableViewStylePlain];
    self.myTableView.backgroundColor = [UIColor whiteColor];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
//    self.myTableView.rowHeight = 120;
        self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myTableView];
    [_myTableView release];

    self.musicHV = [[oneHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200*adapter.sHeight)];
    self.musicHV.bounces = NO;
    self.musicHV.pagingEnabled = YES;
    self.musicHV.showsHorizontalScrollIndicator = NO;

    self.myTableView.tableHeaderView = self.musicHV;
    _musicHV.delegate = self;
    // Do any additional setup after loading the view.
    [_musicHV release];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(140 *adapter.sWidth, (self.musicHV.frame.size.height - 40) *adapter.sHeight, 100 * adapter.sWidth, 40 * adapter.sHeight)];
    
    self.pageControl.backgroundColor = [UIColor clearColor];
    [self.myTableView addSubview:self.pageControl];
    [self.pageControl addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
    [_pageControl release];
    
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    [self getData];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"oneCell";
    ModelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ModelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.cellIndexPath = indexPath;
    songInfoModel *songModel = [self.cellArray objectAtIndex:indexPath.row];
    cell.bigModel = songModel;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableArray *musicArray  = [self getMusicsWithArray:self.cellArray];
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellArray.count;
}
- (void)getData
{
    
    NSString *string = [NSString stringWithFormat:@"%@%@%@", RecommondURl1, self.msg_id, RecommondURl2];
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
//                NSLog(@"%@", songListStr);
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
            [self.cellArray addObject:bbb];
            [bbb release];
//            NSLog(@"%@", self.cellArray);
            [self.HUD hide:YES];
            [self.myTableView reloadData];
            
        }
    }];
    
    


}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    songInfoModel *ssss = [self.cellArray objectAtIndex:indexPath.row];
    if ([ssss isEqual:[self.cellArray lastObject]]) {
        return 150;
    }
    return 80;
}
-(void)pageAction:(UIPageControl *)pageC
{
    [self.musicHV setContentOffset:CGPointMake(kScreenW * pageC.currentPage, 0) animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = _musicHV.contentOffset.x / kScreenW;
}
- (void)dealloc
{
    [_array release];
    [_myTableView release];
    [_musicHV release];
    [_pageControl release];
    [_msg_id release];
    [_array release];
    [_songListUrl release];
    [_cellArray release];
    [_HUD release];
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
