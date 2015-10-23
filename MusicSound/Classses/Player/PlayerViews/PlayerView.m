//
//  PlayerView.m
//  MusicSound
//
//  Created by 大泽 on 15/6/24.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "PlayerView.h"
#import "PlayerTools.h"
#import "XYDropDownMenu.h"
#import "PlayerMenuViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "PlayerToolBarController.h"
#define kPaddingX 120
#define kPaddingY 40

@interface PlayerView ()

@property (nonatomic, copy) void(^posterBlock)(NSString *pic_url);

@property (nonatomic, retain) NSTimer *progressTimer;

@property (nonatomic, retain) UIImageView *backImageView;

@property (nonatomic, retain) UIView *backCover;

@end

@implementation PlayerView

+ (instancetype)playWithFrame:(CGRect)frame
{
    static PlayerView *playerView = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        playerView = [[self alloc] initWithFrame:frame];
        
    });
    
    return playerView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backImageView = [[UIImageView alloc] initWithFrame:self.frame];
        self.backImageView.userInteractionEnabled = YES;
        [self addSubview:self.backImageView];
        self.backImageView.image = [UIImage imageNamed:@"nowplaying_default_bkg"];
        
        [self addPoster];
        [self addProgress];
        [self addPreviousBtn];
        [self addNextBtn];
        [self addPlayOrPauseBtn];
        [self addTimeLabels];
        [self addSingerName];
        [self addSongName];
        [self addBackBtn];
        [self addMenuBtn];

    }
    return self;
}

/**
 *  添加返回按钮
 */
#pragma mark - 添加返回按钮
- (void)addBackBtn
{
    UIButton *bakcBtn = [[UIButton alloc] init];
    [bakcBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bakcBtn setImage:[UIImage imageNamed:@"top_bar_back"] forState:UIControlStateNormal];
    [bakcBtn setImage:[UIImage imageNamed:@"top_bar_back2"] forState:UIControlStateHighlighted];
    
    [self.backImageView addSubview:bakcBtn];
    [bakcBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top).with.mas_offset(30);
        make.left.mas_equalTo(self.mas_left).with.mas_offset(30);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
        
    }];
    [bakcBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [bakcBtn release];
}

/**
 *  右上角菜单按钮
 */
#pragma mark - 右上角按钮菜单
- (void)addMenuBtn
{
    UIButton *menuBtn = [[UIButton alloc] init];
    [menuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.backImageView addSubview:menuBtn];
    [menuBtn release];
    [menuBtn setImage:[UIImage imageNamed:@"play_bar_list"] forState:UIControlStateHighlighted];
    [menuBtn setImage:[UIImage imageNamed:@"play_bar_list2"] forState:UIControlStateNormal];
    
    [menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(self.mas_right).with.mas_offset(-30);
        make.top.mas_equalTo(self.mas_top).with.mas_offset(30);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
        
    }];
    
    [menuBtn addTarget:self action:@selector(dropDownMenu:) forControlEvents:UIControlEventTouchUpInside];
}


/**
 *  歌手图片
 */
#pragma mark - 添加歌手图片
- (void)addPoster
{
    _poster = [[UIImageView alloc] init];
    
    [self.backImageView addSubview:_poster];
    
    [_poster release];
    
    _poster.image = [UIImage imageNamed:@"grid_default"];
    CGAdapter adapter = [AdapterModel getCGAdapter];

#define adapterH adapter.sHeight
#define adapterW adapter.sWidth
 
    [_poster mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).with.offset(130 * adapterH);
        make.left.equalTo(self.mas_left).with.offset(20);
        make.right.equalTo(self.mas_right).with.offset(-20);
        make.height.mas_offset([[UIScreen mainScreen] bounds].size.width - 40);
        
    }];
    
    _poster.layer.cornerRadius = ((kScreenW - 40) * 0.5);
    _poster.layer.masksToBounds = YES;
   
}

/**
 *  歌名
 */
#pragma mark - 添加歌名
- (void)addSongName
{
    CGAdapter adapter = [AdapterModel getCGAdapter];
    
    _songName = [[UILabel alloc] init];
    _songName.font = [UIFont systemFontOfSize:16];
    
    [self.backImageView addSubview:_songName];
    
    _songName.size = CGSizeMake(200, 20);
    
    _songName.centerX = self.centerX;
    _songName.centerY = 40 * adapterH;
    _songName.textAlignment = NSTextAlignmentCenter;
    
    [_songName release];
}

/**
 *  歌手名字
 */
#pragma mark - 添加歌手名字
- (void)addSingerName
{
    CGAdapter adapter = [AdapterModel getCGAdapter];
    
    _singerName = [[UILabel alloc] init];
    _singerName.font = [UIFont systemFontOfSize:16];
    _singerName.size = CGSizeMake(200, 20);
    _singerName.centerX = self.centerX;
    _singerName.centerY = 70 * adapterH;
    _singerName.textAlignment = NSTextAlignmentCenter;
    
    [self.backImageView addSubview:_singerName];
    
}

/**
 *  时间label (当前时间, 总时间)
 */
#pragma mark - 添加歌曲时间
- (void)addTimeLabels
{
#define kTimeTextFont 13
    self.currentTime = [[UILabel alloc] init];
    _currentTime.text = @"00:00";
    _currentTime.font = [UIFont systemFontOfSize:kTimeTextFont];
    
    self.totalTime = [[UILabel alloc] init];
    _totalTime.text = @"00:00";
    _totalTime.font = [UIFont systemFontOfSize:kTimeTextFont];

    [self.backImageView addSubview:_currentTime];
    [self.backImageView addSubview:_totalTime];
    
#define kTop 130
    
    [_currentTime mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.mas_top).with.mas_offset((kScreenH - kTop));
        make.left.mas_equalTo(self.mas_left).with.mas_offset(30);
        make.width.mas_offset(50);
        make.height.mas_offset(20);
        
    }];
    
    [_totalTime mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.mas_top).with.mas_offset(kScreenH - kTop);
        make.left.mas_equalTo(self.mas_left).with.mas_offset(kScreenW - 2 * 30);
        make.width.mas_offset(50);
        make.height.mas_offset(20);
        
    }];
    
    [_currentTime release];
    [_totalTime release];
}

#define kSize CGSizeMake(50, 50);
/**
 *  上一曲按键
 */
#pragma mark - 添加上一曲按键
- (void)addPreviousBtn
{
    UIButton *previousBtn = [[UIButton alloc] init];
 
    [previousBtn setImage:[UIImage imageNamed:@"playbar_prebtn_nomal"] forState:UIControlStateNormal];
    [previousBtn setNormalBg:@"playbar_prebtn_nomal" highlightedBg:@"playbar_prebtn_click"];
    
    previousBtn.size = kSize
    
    previousBtn.centerX = self.centerX - kPaddingX;
    previousBtn.centerY = kScreenH - kPaddingY;
    
    [previousBtn addTarget:self action:@selector(previousPlay:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backImageView addSubview:previousBtn];
    [previousBtn release];
}

/**
 *  下一曲按键
 */
#pragma mark - 添加下一曲按键
- (void)addNextBtn
{
    UIButton *nextBtn = [[UIButton alloc] init];
    [nextBtn setImage:[UIImage imageNamed:@"playbar_nextbtn_nomal"] forState:UIControlStateNormal];
    
    [nextBtn setNormalBg:@"playbar_nextbtn_nomal" highlightedBg:@"playbar_nextbtn_click"];
    nextBtn.size = kSize
    
    nextBtn.centerX = self.centerX + kPaddingX;
    nextBtn.centerY = kScreenH - kPaddingY;
    
    [nextBtn addTarget:self action:@selector(nextPlay:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backImageView addSubview:nextBtn];
    [nextBtn release];
}

/**
 *  播放按键
 */
#pragma mark - 添加播放按键
- (void)addPlayOrPauseBtn
{
    self.playBtn = [[UIButton alloc] init];

    [_playBtn setNormalBg:@"playbar_playbtn_nomal" highlightedBg:@"playbar_playbtn_click"];
    
    _playBtn.size = kSize
    _playBtn.centerX = self.centerX;
    _playBtn.centerY = kScreenH - kPaddingY;
    
    [_playBtn addTarget:self action:@selector(startOrPause:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backImageView addSubview:_playBtn];
    [_playBtn release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startPlay) name:@"StartPlay" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopPlay) name:@"StopPlay" object:nil];
}

/**
 *  进度条
 */
#pragma mark - 添加进度条
- (void)addProgress
{
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(30, kScreenH - 100, kScreenW - 60, 20)];
    
    [self.slider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    [self.slider setThumbImage:[UIImage imageNamed:@"vc_slider_SlideIcon2"] forState:UIControlStateNormal];
    
    [self.backImageView addSubview:_slider];
    [_slider release];
}

#pragma mark - 设置显示的内容
- (void)setPlayingMusic:(XYMusic *)playingMusic
{
    if (self.playingMusic == playingMusic) {
        return;
    }
    
    [_playingMusic release];
    _playingMusic = [playingMusic retain];
    
    /**
     *  歌名
     */
    self.songName.text = playingMusic.name;
    /**
     *  歌手名
     */
    self.singerName.text = playingMusic.singerName;
    
    /**
     *  设置歌手图片
     */
    
    
    [self getPosterWithSongName:self.songName.text];
    self.posterBlock = ^(NSString *pic_url){
        
        [self.poster sd_setImageWithURL:[NSURL URLWithString: pic_url] placeholderImage:[UIImage imageNamed:@"grid_default"]];
        
    };
    
    /**
     *  显示总时长
     */
    self.totalTime.text = playingMusic.duration;
}

#pragma mark - 各种监听的方法

#pragma mark - 开始/暂停播放方法
- (void)startOrPause:(UIButton *)playBtn
{
    if (self.playingMusic) {
        self.playing = !self.playing;
        
        PlayerToolBarController *toolBar = [PlayerToolBarController sharePlayerToolBarController];
        
        if ([self isPlaying]) { // 播放状态 显示为暂停的图标
            NSLog(@"播放状态");
            
            [self startProgressTimer];
            // 开始动画
            [self beginAnimation];
            [self notifyActionWithBtnType:BtnStart];
            
            [playBtn setNormalBg:@"playbar_pausebtn_nomal" highlightedBg:@"playbar_pausebtn_click"];
            toolBar.playerBtn.selected = YES;
            [toolBar.playerBtn setNormalBg:@"playbar_pausebtn_nomal" highlightedBg:@"playbar_pausebtn_click"];
            
        } else if (![self isPlaying]) { // 暂停状态 显示为播放的图标
            NSLog(@"暂停状态");
            
            [self endProgressTimer];
            // 结束动画
            [self endAnimation];
            [self notifyActionWithBtnType:BtnPause];
           
            [playBtn setNormalBg:@"playbar_playbtn_nomal" highlightedBg:@"playbar_playbtn_click"];
            toolBar.playerBtn.selected = NO;
            [toolBar.playerBtn setNormalBg:@"playbar_playbtn_nomal" highlightedBg:@"playbar_playbtn_click"];
        }
        
    }
}

- (void)back:(UIButton *)btn
{
    [self notifyActionWithBtnType:BtnBack];
}

#pragma mark - 上下曲方法
/**
 *  上一曲
 */
- (void)previousPlay:(UIButton *)btn
{
    [self endProgressTimer];
    
    [self notifyActionWithBtnType:BtnPrevious];
    [self endAnimation];
    [self beginAnimation];
}

/**
 *  下一曲
 */
- (void)nextPlay:(UIButton *)btn
{
    [self endProgressTimer];
    
    [self notifyActionWithBtnType:BtnNext];
    [self endAnimation];
    [self beginAnimation];
}



/**
 *  按钮的监听
 */
#pragma mark - 按钮的监听
- (void)notifyActionWithBtnType:(BtnType)BtnType
{
    if ([self.delegate respondsToSelector:@selector(PlayerViewDelegate:BtnType:)]) {
        [self.delegate PlayerViewDelegate:self BtnType:BtnType];
    }
}


/**
 *  设置播放状态为开始 和 播放按钮的图片为暂停
 */
- (void)startPlay
{
    self.playing = YES;
    
    [self.playBtn setNormalBg:@"playbar_pausebtn_nomal" highlightedBg:@"playbar_pausebtn_click"];
}

/**
 *  设置播放状态为暂停 和 播放按钮的图片为开始
 */
- (void)stopPlay
{
    self.playing = NO;
    
    [self.playBtn setNormalBg:@"playbar_playbtn_nomal" highlightedBg:@"playbar_playbtn_click"];
}

#pragma mark - 开始定时器
- (void)startProgressTimer
{
    if ([PlayerTools sharePlayerTools].streamer) {
//        if (self.playing) {
        
        if (self.progressTimer) {
            return;
        }
            self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(upDataContents) userInfo:nil repeats:YES];
//        }
    }
}

#pragma mark - 结束定时器
- (void)endProgressTimer
{
    [self.progressTimer invalidate];
    self.progressTimer = nil;
    [self.progressTimer release];
}
#pragma mark - 更新显示的内容
- (void)upDataContents
{
    NSInteger minte = (NSInteger)[PlayerTools sharePlayerTools].streamer.progress / 60;
    NSInteger second = (NSInteger)[PlayerTools sharePlayerTools].streamer.progress % 60;
    
    NSString *currentTime = [NSString stringWithFormat:@"%02ld:%02ld", minte, second];
    
    // 当前的时间
    self.currentTime.text = currentTime;
    
    self.slider.maximumValue = [PlayerTools sharePlayerTools].streamer.duration;
    self.slider.value = [PlayerTools sharePlayerTools].streamer.progress;
    
    NSLog(@"%d", [PlayerTools sharePlayerTools].streamer.stopReason);
    
    
    if ([self.currentTime.text isEqualToString: self.totalTime.text]) {
        [self notifyActionWithBtnType:BtnNext];
    }
    
    NSLog(@"duration = %f", [PlayerTools sharePlayerTools].streamer.duration);
    
    NSLog(@"progress = %f", [PlayerTools sharePlayerTools].streamer.progress);
    
    if ([self.currentTime.text isEqualToString:self.totalTime.text]) {
        
        [self endProgressTimer];
        [self notifyActionWithBtnType:BtnNext];
    }
    
    if ([PlayerTools sharePlayerTools].streamer.duration != 0 && self.disPlayStatue && self.poster.image) {
        self.disPlayStatue = NO;
        [self disPlayOnBack];
    }
    
}

#pragma mark - 更新进度条
- (void)valueChange:(UISlider *)slider
{
    [self endProgressTimer];
    
    if ([PlayerTools sharePlayerTools].streamer.state == STKAudioPlayerStateStopped) {
        [self notifyActionWithBtnType:BtnNext];
    }
    
    [[PlayerTools sharePlayerTools].streamer seekToTime:slider.value];
    [self startProgressTimer];
}

#pragma mark - 后台显示的东西
- (void)disPlayOnBack
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    PlayerTools *tool = [PlayerTools sharePlayerTools];
    
    // 歌曲名
    dic[MPMediaItemPropertyTitle] = tool.music.name;
    
    // 歌手名
    dic[MPMediaItemPropertyArtist] = tool.music.singerName;
    
    // 时长
    dic[MPMediaItemPropertyPlaybackDuration] = @(tool.streamer.duration);
    
    // 背景图
    MPMediaItemArtwork *artWork = [[MPMediaItemArtwork alloc] initWithImage:self.poster.image];
    
    dic[MPMediaItemPropertyArtwork] = artWork;
    
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = dic;
    
}

#pragma mark - 第一种动画旋转效果
int angle;

-(void) startAnimation
{
    [UIView beginAnimations:@"aar" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    self.poster.transform = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    [UIView commitAnimations];
    angle += 10;
}



#pragma mark - 第二种动画效果

- (void)beginAnimation
{
    if ([self isPlaying]) {
        CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        [basicAnimation setFromValue:@0];
        // 设置动画结束值
        [basicAnimation setToValue:[NSNumber numberWithFloat: M_PI * 2]];
        // 基本类型转成对象类型用NSNumber  int float char double
        // 设置动画时长
        [basicAnimation setDuration: 60];
        [basicAnimation setAutoreverses:YES]; // 是否旋转到原来状态
        [basicAnimation setCumulative:YES]; // 累加 追加 不会出现结束后卡顿的现象 在上一次结束的地方继续开始
        // 无限旋转
        [basicAnimation setRepeatCount:FLT_MAX];
        [self.poster.layer addAnimation:basicAnimation forKey:@"basicA"];
    }
}

- (void)endAnimation
{
    [self.poster.layer removeAllAnimations];
}


- (void)dropDownMenu:(UIButton *)menuBtn
{
    
    self.menuBtnOption(menuBtn);
    
}

#pragma mark - 从乐流获取图片
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
    
    __block PlayerView *view = self;
        [manager GET:superAddress parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [netWorkManager stopMonitoring];
            
            NSDictionary *dic = responseObject[@"info"];
            NSArray *array = dic[@"data"];
            
            if (0 == array.count) {
                UIImage *image = [UIImage imageNamed:@"grid_default"];
                view.poster.image = image;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"back" object:nil];
                
                return;
            }
            
            NSDictionary *dic1 = array[0];
            NSString *pic_url = dic1[@"pic_url"];
            
            view.posterBlock(pic_url);
            
//            [view disPlayOnBackWithImage:self.poster.image];
            
//            NSURL *url = [NSURL URLWithString:pic_url];dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//               
//                NSData *data = [NSData dataWithContentsOfURL:url];
//                
//                UIImage *image = [UIImage imageWithData:data];
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    
//                    [view disPlayOnBackWithImage:image];
//                    
//                });
//                
//                
//            });
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
            NSLog(@"失败==== %@",error);
            
        }];
    
}

@end
