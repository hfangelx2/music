//
//  PlayerToolBarController.m
//  MusicSound
//
//  Created by 大泽 on 15/6/28.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "PlayerToolBarController.h"
#import "PlayerViewController.h"
#import "PlayerView.h"
#import "PlayerTools.h"
@interface PlayerToolBarController ()


@property (nonatomic, retain) UIButton *nextBtn;

@property (nonatomic, retain) UIButton *previousBtn;

@property (nonatomic, copy) void(^iconBlock)(NSString *url);

@end

@implementation PlayerToolBarController

SingletonM(PlayerToolBarController);


- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH - 44, kScreenW, 44)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backBtn];
    
//    PlayerView 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upDateContent:) name:@"ToolBarNoti" object:nil];

}

- (UIButton *)backBtn
{
    if (!_backBtn) {
        
        _backBtn = [[UIButton alloc] initWithFrame:self.view.bounds];
        [_backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.backgroundColor = [UIColor whiteColor];
        _backBtn.contentMode = UIViewContentModeScaleAspectFill;
        [_backBtn addSubview:self.icon];
        [self.backBtn addSubview:self.nextBtn];
        [self.backBtn addSubview:self.playerBtn];
        [self.backBtn addSubview:self.previousBtn];
    }
    return [[_backBtn retain] autorelease];
}

- (UIImageView *)icon
{
    if (!_icon) {
        
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        _icon.backgroundColor = [UIColor redColor];
        _icon.image = [UIImage imageNamed:@"grid_default"];
        
    }
    return [[_icon retain] autorelease];
}

#define kSongNameTextFont 16
- (UILabel *)songName
{
    if (!_songName) {
        
        _songName = [[UILabel alloc] init];

        _songName.font = [UIFont systemFontOfSize:kSongNameTextFont];
        [self.backBtn addSubview:_songName];
        
        
        self.songName.size = CGSizeMake(100, 20);
        self.songName.x = CGRectGetMaxX(self.icon.frame) + 20;
        self.songName.y = kMargin;
    }
    return [[_songName retain] autorelease];
}

#define kSingerTextFont 9
- (UILabel *)singName
{
    if (!_singName) {
        
        _singName = [[UILabel alloc] init];

        _singName.font = [UIFont systemFontOfSize:kSingerTextFont];
        [self.backBtn addSubview:_singName];
    }
    return [[_singName retain] autorelease];
}

- (UIButton *)previousBtn
{
    if (!_previousBtn) {
        
        _previousBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenW * 0.5, 0, 44, 44)];
        [_previousBtn setNBg:@"playbar_prebtn_nomal" hBg:@"playbar_prebtn_click"];
        [_previousBtn addTarget:self action:@selector(previous:) forControlEvents:UIControlEventTouchUpInside];
    }
    return [[_previousBtn retain] autorelease];
}

- (UIButton *)playerBtn
{
    if (!_playerBtn) {
        
        _playerBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.previousBtn.frame) + kMargin, 0, 44, 44)];
        
        [_playerBtn setNBg:@"playbar_playbtn_nomal" hBg:@"playbar_playbtn_click"];
        [_playerBtn setBackgroundImage:[UIImage imageNamed:@"playbar_pausebtn_nomal"] forState:UIControlStateSelected];
//        [_playerBtn setBackgroundImage:[UIImage imageNamed:@"playbar_playbtn_nomal"] forState:UIControlStateDisabled];
        
        [_playerBtn addTarget:self action:@selector(playerOrPause:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return [[_playerBtn retain] autorelease];
}



- (UIButton *)nextBtn
{
    if (!_nextBtn) {
        
        _nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.playerBtn.frame) + kMargin, 0, 44, 44)];
        
        [_nextBtn setImage:[UIImage imageNamed:@"playbar_nextbtn_nomal"] forState:UIControlStateNormal];
        [_nextBtn setImage:[UIImage imageNamed:@"playbar_nextbtn_click"] forState:UIControlStateHighlighted];
        [_nextBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    }
    return [[_nextBtn retain] autorelease];
}


- (void)upDateContent:(NSNotification *)noti
{
    NSDictionary *dic = noti.userInfo;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:dic[@"icon"]] placeholderImage:[UIImage imageNamed:@"grid_default"]];
    self.songName.text = dic[@"songName"];
    self.singName.text = dic[@"singName"];
    
    self.playerBtn.selected = YES;
    
//    [self.playerBtn setNBg:@"playbar_pausebtn_nomal" hBg:@"playbar_pausebtn_click"];
    
    [self getPosterWithSongName:self.songName.text];
    
    self.iconBlock = ^(NSString *url){
      
        [self.icon sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"grid_default"]];
        
    };
    
    
    CGSize singNameCurrentSize = [self.singName.text boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:kSingerTextFont]} context:nil].size;
    self.singName.size = singNameCurrentSize;
    
    self.singName.x = self.songName.x;
    self.singName.y = CGRectGetMaxY(self.songName.frame) + kMargin;
    
//    self.playerBtn.selected = YES;
}


- (void)getPosterWithSongName:(NSString *)name
{
    NSString *urlString= [NSString stringWithFormat:@"%@",name];
    
    NSString * encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)urlString, NULL, NULL,  kCFStringEncodingUTF8 );
    
    NSString * add1 = @"http://api.raventech.cn/api/music/search?album_name=&appkey=54679361&appversion=ios1.3.0&cate_type=0&client_time=2015-05-21%2015%3A28%3A39&content=";
    NSString *add2 =  @"&deviceid=86D47CC5-7337-4186-98C3-6EB77C5C8CD3&deviceusername=%25E5%25A4%25AA%25E9%2598%25B3&key=";
    NSString *str3 =  @"&network_type=1&page=1&searchtype=0&singer_name=&song_name=&type=0&zone=Asia%252FShanghai%2520%2528GMT%252B8%2529";
    NSString *superAddress = [NSString stringWithFormat:@"%@%@%@%@%@", add1,encodedString,add2,encodedString,str3];
    
    
    AFNetworkReachabilityManager *netWorkManager = [AFNetworkReachabilityManager sharedManager];
    
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    
    [manager GET:superAddress parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [netWorkManager stopMonitoring];
        
        NSDictionary *dic = responseObject[@"info"];
        NSArray *array = dic[@"data"];
        
        if (array.count == 0) {
            self.icon.image = [UIImage imageNamed:@"grid_default"];
            return;
        }
        
        NSDictionary *dic1 = array[0];
        NSString *pic_url = dic1[@"pic_url"];
        
        self.iconBlock(pic_url);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        NSLog(@"失败==== %@",error);
        
    }];
    
}



- (void)next:(UIButton *)nextBtn
{
    if ([PlayerTools sharePlayerTools].streamer) {
        
        [[PlayerViewController shareInterface] next];
    }
}

- (void)previous:(UIButton *)previousBtn
{
    if ([PlayerTools sharePlayerTools].streamer) {
        [[PlayerViewController shareInterface] previous];
    }
}

- (void)playerOrPause:(UIButton *)btn
{
    
    if ([PlayerTools sharePlayerTools].streamer) {
        
        btn.selected = !btn.selected;
        
        PlayerView *playerView = [PlayerView playWithFrame:CGRectZero];
        
        if (!btn.selected) { // 存在 显示播放按钮
            [btn setNBg:@"playbar_playbtn_nomal" hBg:@"playbar_playbtn_nomal"];
            [[PlayerTools sharePlayerTools] pause];
            [playerView endProgressTimer];
            [playerView.playBtn setNormalBg:@"playbar_playbtn_nomal" highlightedBg:@"playbar_playbtn_click"];
            playerView.playing = !playerView.playing;
            return;
        }
        
        // 不存在 显示暂停按钮
        [btn setNBg:@"playbar_pausebtn_nomal" hBg:@"playbar_pausebtn_click"];
        [[PlayerTools sharePlayerTools] resume];
        [playerView startProgressTimer];
        [playerView.playBtn setNormalBg:@"playbar_pausebtn_nomal" highlightedBg:@"playbar_pausebtn_click"];
        playerView.playing = !playerView.playing;
    }
}

- (void)backBtnAction:(UIButton *)button
{
    self.toolBarBlock();
}

@end
