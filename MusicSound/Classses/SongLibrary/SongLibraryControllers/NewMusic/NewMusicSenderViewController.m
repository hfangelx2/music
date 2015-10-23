//
//  NewMusicSenderViewController.m
//  MusicSound
//
//  Created by shuwen on 15/7/1.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "NewMusicSenderViewController.h"
#import "NewMusicViewController1.h"
#import "NewMusicModel.h"

@interface NewMusicSenderViewController ()
{
    CGAdapter adapter;
}

@property (nonatomic, retain) NSMutableArray *allBigArr;

@end

@implementation NewMusicSenderViewController

- (void)dealloc
{
    [_allBigArr dealloc];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    adapter = [AdapterModel getCGAdapter];
    
    self.allBigArr = [NSMutableArray array];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage imageNamed:@"20141206012037_GLJtZ.thumb.700_0.jpg"];
    [self.view addSubview:imageView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20*adapter.sWidth, TITLE_HEIGHT + 50*adapter.sHeight, kScreenW - 40*adapter.sWidth, 20*adapter.sHeight)];
    label1.numberOfLines = 0;
    label1.textColor = [UIColor whiteColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"最新的歌曲推荐";
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(20*adapter.sWidth, label1.frame.origin.y + 20*adapter.sHeight, kScreenW - 40*adapter.sWidth, 20*adapter.sHeight)];
    label2.numberOfLines = 0;
    label2.textColor = [UIColor whiteColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @"最新的华语歌曲 欧美歌曲 日韩歌曲";
    [self.view addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(20*adapter.sWidth, label2.frame.origin.y + 20*adapter.sHeight, kScreenW - 40*adapter.sWidth, 20*adapter.sHeight)];
    label3.numberOfLines = 0;
    label3.textColor = [UIColor whiteColor];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = @"歆悦为您全新打造 COME ON";
    [self.view addSubview:label3];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(kScreenW/2 - 65*adapter.sWidth, 260*adapter.sHeight, 130*adapter.sWidth, 80*adapter.sHeight);
    [button setBackgroundImage:[UIImage imageNamed:@"3333"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(pushNewMusic) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    [self getNewMusicData];
    
    [imageView release];
    [label1 release];
    [label2 release];
    [label3 release];
}

- (void)getNewMusicData
{
    
    [AFNConnect AFNConnectWithUrl:@"http://online.dongting.com/recomm/new_songlists?app=ttpod&v=v7.9.4.2015052918&uid=&mid=iPad4%2C4&f=f320&s=s330&imsi=&hid=&splus=8.3&active=1&net=2&openudid=367f79a32ab2f14c1ee6d0a9e3587bcedc93d35c&idfa=8B711584-C712-4E8F-B6C8-39599E106A4C&utdid=VYJ5JD0tJEwDANcughrXcMK9&alf=201200&bundle_id=com.ttpod.music" key:@"data" connectBlock:^(id data) {
        for (NSDictionary *dic in data) {
            NewMusicModel *newMusicModel = [[NewMusicModel alloc] init];
            [newMusicModel setValuesForKeysWithDictionary:dic];
            [self.allBigArr addObject:newMusicModel];
            
            [newMusicModel release];
        }
        [self viewWillAppear:YES];
    }];
    
    
}

- (void)pushNewMusic
{
    NewMusicViewController1 *newMusicVc = [[NewMusicViewController1 alloc] init];
    if (self.allBigArr.count != 0) {
        newMusicVc.allBigArr = self.allBigArr;
        [self.navigationController pushViewController:newMusicVc animated:YES];
    }
    
    [newMusicVc release];
}


@end






