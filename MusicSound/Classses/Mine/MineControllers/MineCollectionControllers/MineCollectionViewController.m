//
//  MineCollectionViewController.m
//  MusicSound
//
//  Created by 大泽 on 15/6/30.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "MineCollectionViewController.h"
#import "HotsDetailModel.h"
#import "UMSocial.h"
#import "DestAndCurrentMusic.h"
#import "PlayerViewController.h"
#import "FMXYMusicCollectionDataBase.h"
@interface MineCollectionViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *tableViewArray;

@property (nonatomic, retain) UITableView *tableView;
@end

@implementation MineCollectionViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
            }
    return self;
}


static NSString *const ID = @"collection";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"返回" image:nil target:self action:@selector(pop)];
    
    
    self.tableViewArray = [NSMutableArray array];
    
    NSMutableArray *array = [[FMXYMusicCollectionDataBase shareFMXYMusicCollectionDataBase] selectAllXYMusicHotsDetailModel];
    
    [self.tableViewArray addObjectsFromArray:array];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 108) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    
    [self.view addSubview:self.tableView];
    [self.tableView release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%@", self.tableViewArray);
    return self.tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    HotsDetailModel *hotsM = self.tableViewArray[indexPath.row];
    
    cell.textLabel.text = hotsM.name;
    cell.detailTextLabel.text = hotsM.singerName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"didSelectRowAtIndexPath");
    
    PlayerViewController *playVc = [PlayerViewController shareInterface];

    NSMutableArray *musicArray = [self getMusicsWithArray:self.tableViewArray];
    
    [DestAndCurrentMusic shareDestAndCurrentMusic].destMusic = musicArray[indexPath.row];
    
    
#warning 传值到播放器的核心代码2
    playVc.musics = musicArray;
#warning 传值到播放器的核心代码3
    // 再传数组
    playVc.index = indexPath.item;
}


- (NSMutableArray *)getMusicsWithArray:(NSMutableArray *)array
{
    NSMutableArray *arrayM = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(HotsDetailModel *obj, NSUInteger idx, BOOL *stop) {
        
        NSString *name = obj.name;
        NSString *singerName = obj.singerName;
        NSDictionary *urlList = [obj.urlList lastObject];
        
        NSString *url = urlList[@"url"];
        NSString *duration = urlList[@"duration"];
        
        NSString *time = [NSString getMinuteSecondWithSecond:duration];
        
#warning 传值到播放器的核心代码1
        XYMusic *music = [XYMusic musicWithName:name singerName:singerName urlList:url posterUrl:nil duration:time];
        
        [arrayM addObject:music];
    }];
    return arrayM;
}

- (void)dealloc
{
    [_tableViewArray release];
    
    [super dealloc];
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    UITableViewRowAction *remove = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
               
        HotsDetailModel *hotsM = self.tableViewArray[indexPath.row];

        [[FMXYMusicCollectionDataBase shareFMXYMusicCollectionDataBase] deleteFromDBWithName:hotsM.name];
        
        NSInteger num = indexPath.row;
        [self.tableViewArray removeObjectAtIndex:num];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
      
    }];
    
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"分享给好友" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        HotsDetailModel *hotsDetailM = self.tableViewArray[indexPath.row];
        
        NSString *name = hotsDetailM.name;
        NSString *singerName = hotsDetailM.singerName;
        NSArray *urlList = hotsDetailM.urlList;
        NSDictionary *dic = [urlList lastObject];
        NSString *url = dic[@"url"];
        NSString *text = [NSString stringWithFormat:@"我正在使用歆悦播放器在听 %@的<%@> 我很喜欢这首歌,一起来听吧~ %@", singerName, name, url];
        
        [UMSocialSnsService presentSnsController:self appKey:@"5594f30667e58eb6f70024b2" shareText:text shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren, UMShareToWechatSession,nil] delegate:nil];
       
    }];
    
    topRowAction.backgroundColor = [UIColor greenColor];
    
    return @[remove, topRowAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
