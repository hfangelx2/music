//
//  PlayerViewController.m
//  天天动听
//
//  Created by 大泽 on 15/6/16.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "PlayerViewController.h"
#import "PlayerTools.h"
#import "XYDropDownMenu.h"
#import "PlayerMenuViewController.h"
#import "DestAndCurrentMusic.h"
#import "PlayerToolBarController.h"
@interface PlayerViewController () <PlayerViewDelegate>


@end

@implementation PlayerViewController


- (PlayerView *)player
{
    if (!_player) {
        
        self.player = [PlayerView playWithFrame:self.view.bounds];
        
        self.player.delegate = self;
        
        self.player.menuBtnOption = ^(UIButton *menuBtn){
          
            [self dropDownMenu:menuBtn];
            
        };
    }
    return [[_player retain] autorelease];
}

- (void)dropDownMenu:(UIButton *)menuBtn
{
    XYDropDownMenu *menu = [XYDropDownMenu showFrom:menuBtn];
    
    PlayerMenuViewController *vc = [[PlayerMenuViewController alloc] init];
    vc.tableViewArray = self.musics;
    vc.index = self.index;
    
    vc.view.height = 250;
    menu.contentVc = vc;
    
}

+ (PlayerViewController *)shareInterface
{
    static PlayerViewController *playVc = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        playVc = [[PlayerViewController alloc] init];
        
        [playVc.view addSubview:playVc.player];
    });
    
    return playVc;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self.player beginAnimation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    __block PlayerViewController *vc = self;
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    appDelegate.remoteBlock = ^(UIEvent *event){

        PlayerToolBarController *tool = [PlayerToolBarController sharePlayerToolBarController];
        
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:
                
                [[PlayerTools sharePlayerTools] resume];
                [tool playerOrPause:tool.playerBtn];
//                [self.player startOrPause:self.player.playBtn];
                break;
                
            case UIEventSubtypeRemoteControlPause:
                
                [[PlayerTools sharePlayerTools] pause];
                [tool playerOrPause:tool.playerBtn];
//                [self.player startOrPause:self.player.playBtn];
                
                break;
                
            case UIEventSubtypeRemoteControlNextTrack:
                
                [vc next];
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack:
                
                [vc previous];
                break;
                
            default:
                break;
        }
        
    };
    
}
#pragma mark - 播放的索引值
- (void)setIndex:(NSInteger)index
{
    DestAndCurrentMusic *destAndCurrentM = [DestAndCurrentMusic shareDestAndCurrentMusic];
    
    if ([destAndCurrentM.currentMusic.urlList isEqualToString:destAndCurrentM.destMusic.urlList]) {
        return;
    }
    
    _index = index;
    
    [[PlayerTools sharePlayerTools] stop];
    
    [self playMusic];
    self.player.slider.value = 0;

    self.player.disPlayStatue = YES;
    [self.player startProgressTimer];

}

#pragma mark - 判断是不是同一个数组
- (void)setMusics:(NSMutableArray *)musics
{
    if (_musics != musics) {
        [_musics release];
        _musics = [musics retain];
        [self.player endProgressTimer];
    }
}

#pragma mark - PlayerViewDelegate
- (void)PlayerViewDelegate:(PlayerView *)playerview BtnType:(BtnType)BtnType
{
    switch (BtnType) {
        case BtnStart:
            
            if (self.musics) {
                
                [[PlayerTools sharePlayerTools] resume];
            }
            
            break;
            
        case BtnPause:
            
            if (self.musics) {
                
                [[PlayerTools sharePlayerTools] pause];
            }
            
            break;
            
        case BtnNext:
            
            if (self.musics) {
                
                [self next];
           
                self.player.currentTime.text = @"00:00";
            }
            
            break;
            
        case BtnPrevious:
            
            if (self.musics) {
                
                [self previous];

                self.player.currentTime.text = @"00:00";
            }
            
            break;
            
        case BtnBack:
            
            [self backAction];
            
        default:
            break;
    }
}

/**
 *  下一曲
 */
- (void)next
{
    if (_index + 1 == self.musics.count) {
        [DestAndCurrentMusic shareDestAndCurrentMusic].destMusic = self.musics[0];
        
    } else {
        [DestAndCurrentMusic shareDestAndCurrentMusic].destMusic = self.musics[_index + 1];
    }
    
    self.index ++;
}

/**
 *  上一曲
 */
- (void)previous
{
    if (_index - 1 < 0) {
        [DestAndCurrentMusic shareDestAndCurrentMusic].destMusic = self.musics[self.musics.count - 1];
       
    } else {
        [DestAndCurrentMusic shareDestAndCurrentMusic].destMusic = self.musics[_index - 1];
    }
    self.index --;
}

/**
 *  播放音乐
 */
- (void)playMusic
{
    if (_index < 0) {
        _index = self.musics.count - 1;
    }
    
    if (_index == self.musics.count) {
        _index = 0;
    }
    
    // 重新初始化一个音乐
    [[PlayerTools sharePlayerTools] preparePlayWithMusic:self.musics[self.index]];
    
    self.player.playingMusic = self.musics[self.index];
    
    // 开始播放状态 设置播放按钮的图标
    [[NSNotificationCenter defaultCenter] postNotificationName:@"StartPlay" object:nil];
    
    [[PlayerTools sharePlayerTools] start];
}


- (void)backAction
{
    self.hiddenBlock();
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
