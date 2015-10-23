//
//  MVVideoViewController.m
//  MusicSound
//
//  Created by shuwen on 15/6/26.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "MVVideoViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "PlayerToolBarController.h"
#import <MBProgressHUD.h>
@interface MVVideoViewController ()
{
    MBProgressHUD *HUD;
}

@property (nonatomic ,retain) MPMoviePlayerController *player;

@end

@implementation MVVideoViewController

- (void)dealloc
{
    [_player release];
    [_mvUrl release];
    [super dealloc];
    
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createVideo];
    
}

- (void)pop
{
    [self.player  stop];
    
    [PlayerToolBarController sharePlayerToolBarController].view.hidden = NO;

    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)createVideo
{
    //视频播放对象
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.mvUrl]];
    self.player.controlStyle = MPMovieControlStyleFullscreen;
    [self.player.view setFrame:self.view.bounds];
//    self.player.initialPlaybackTime = -1;
    [self.view addSubview:self.player.view];
    
    //注册一个播放结束的通知, 当播放结束时, 监听到并且做一些处理
    //播放器自带有播放通知的功能, 在此仅仅只需要注册观察者监听通知的即可
    //监听Done事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myMovieFinishedCallback:) name:MPMoviePlayerDidExitFullscreenNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myMovieFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;    //适应屏幕大小，保持宽高比

    // 横屏
    //设置应用程序的状态栏到指定的方向
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    //view旋转
    [self.view setTransform:CGAffineTransformMakeRotation(M_PI/2)];
    //    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    
    [self.player play];
    
    if (![self.player isPreparedToPlay]) {
        [self.player pause];
    }
    
    [_player release];
    
}

// 横屏
- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

- (void)myMovieFinishedCallback:(NSNotification *)notify
{
    [PlayerToolBarController sharePlayerToolBarController].view.hidden = NO;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}




@end




