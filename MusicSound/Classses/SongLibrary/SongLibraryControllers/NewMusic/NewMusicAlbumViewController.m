//
//  NewMusicAlbumViewController.m
//  MusicSound
//
//  Created by shuwen on 15/7/1.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "NewMusicAlbumViewController.h"
#import "NewAlbumViewController.h"

@interface NewMusicAlbumViewController ()
{
    CGAdapter adapter;
}

@end

@implementation NewMusicAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    adapter = [AdapterModel getCGAdapter];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage imageNamed:@"10291672.jpg"];
    [self.view addSubview:imageView];
    
    UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(20*adapter.sWidth, 40*adapter.sHeight, 20*adapter.sWidth, 440*adapter.sHeight)];
    firstLabel.textColor = [UIColor whiteColor];
    firstLabel.numberOfLines = 0;
    firstLabel.textAlignment = NSTextAlignmentCenter;
    firstLabel.text = @"全球最新的首发专辑";
    [self.view addSubview:firstLabel];
    
    UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(40*adapter.sWidth, 40*adapter.sHeight, 20*adapter.sWidth, 440*adapter.sHeight)];
    secondLabel.textColor = [UIColor whiteColor];
    secondLabel.numberOfLines = 0;
    secondLabel.textAlignment = NSTextAlignmentCenter;
    secondLabel.text = @"你想要的尽在歆悦音乐播放器";
    [self.view addSubview:secondLabel];
    
    UILabel *thirdLabel = [[UILabel alloc] initWithFrame:CGRectMake(60*adapter.sWidth, 40*adapter.sHeight, 20*adapter.sWidth, 440*adapter.sHeight)];
    thirdLabel.textColor = [UIColor whiteColor];
    thirdLabel.numberOfLines = 0;
    thirdLabel.textAlignment = NSTextAlignmentCenter;
    thirdLabel.text = @"T R U S T M E";
    [self.view addSubview:thirdLabel];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(120*adapter.sWidth, 200*adapter.sHeight, 130*adapter.sWidth, 80*adapter.sHeight);
    [button setBackgroundImage:[UIImage imageNamed:@"3333"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(pushNewAlbum) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    [imageView release];
    [firstLabel release];
    [secondLabel release];
    [thirdLabel release];
}

- (void)pushNewAlbum
{
    NewAlbumViewController *albumVc = [[NewAlbumViewController alloc] init];
    [self.navigationController pushViewController:albumVc animated:YES];
    
}

@end
