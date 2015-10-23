//
//  NewMusicViewController.m
//  MusicSound
//
//  Created by shuwen on 15/6/25.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "NewMusicViewController.h"
#import "SCNavTabBarController.h"
#import "NewMusicSenderViewController.h"
#import "NewMusicAlbumViewController.h"

@interface NewMusicViewController ()

@property (nonatomic, retain) NewMusicSenderViewController *senderVc;

@property (nonatomic, retain) NewMusicAlbumViewController *albumVc;

@end

@implementation NewMusicViewController

- (void)dealloc
{
    [_senderVc release];
    [_albumVc release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:nil image:@"top_bar_back3" target:self action:@selector(pop)];
    
    self.senderVc = [[NewMusicSenderViewController alloc] init];
    self.albumVc = [[NewMusicAlbumViewController alloc] init];
    
    self.navigationItem.title = @"新歌首发";
    
    self.senderVc.title = @"新歌快递";
    self.albumVc.title = @"最新专辑";
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[self.senderVc, self.albumVc];
    navTabBarController.number = navTabBarController.subViewControllers.count;
    [navTabBarController addParentController:self];
    
    [_senderVc release];
    [_albumVc release];
    [navTabBarController release];
}

-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}




@end








