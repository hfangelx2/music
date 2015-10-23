//
//  WelcomeViewController.m
//  MusicSound
//
//  Created by shuwen on 15/7/3.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "WelcomeViewController.h"
#import "NavigationViewController.h"
#import "HotsViewController.h"
#import "PlayerToolBarController.h"
#import "PlayerViewController.h"
#import "UMSocial.h"

#define KimageCount 4

@interface WelcomeViewController () <UIScrollViewDelegate>
{
    CGAdapter adapter;
}

@property (nonatomic, retain) UIPageControl *page;

@property (nonatomic, retain) UIButton *shareButton;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    adapter = [AdapterModel getCGAdapter];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    [scrollView release];
    
    CGRect rect = self.view.frame;
    CGFloat x = rect.size.width;
    
    for (int i = 0; i < KimageCount; i++) {
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        UIImage *image = [UIImage imageNamed:name];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRect){x * i, 0, rect.size}];
        imageView.image = image;
        [scrollView addSubview:imageView];
        
        if (i == KimageCount - 1) {
            
            [self setUpShareButtonWith:imageView];
            
        }
        
    }
    
    
    scrollView.contentSize = CGSizeMake(KimageCount * x, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    self.page = [[UIPageControl alloc] init];
    _page.centerX = self.view.centerX;
    _page.centerY = self.view.height - 44;
    _page.numberOfPages = KimageCount;
    [self.view addSubview:_page];
    [_page release];
    _page.currentPageIndicatorTintColor = [UIColor orangeColor];
    _page.pageIndicatorTintColor = [UIColor lightGrayColor];
    
}

- (void)setUpShareButtonWith:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    UIButton *shareButton = [[UIButton alloc] init];
    shareButton.width = 200*adapter.sWidth;
    shareButton.height = 30*adapter.sHeight;
    shareButton.centerX = imageView.width * 0.5;
    shareButton.centerY = imageView.height * 0.4;
    
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareButton setTitle:@"发送给好友" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [imageView addSubview:shareButton];
    [shareButton release];
    [shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.shareButton = shareButton;
    
    UIButton *startButton = [[UIButton alloc] init];
    [startButton setBackgroundImage:[UIImage imageNamed:@"welcomeClick"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"welcomeClick_highlight"] forState:UIControlStateHighlighted];
    [startButton setTitle:@"开启歆悦" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    startButton.width = 130*adapter.sWidth;
    startButton.height = 70*adapter.sHeight;
    startButton.centerX = imageView.width * 0.5;
    startButton.centerY = imageView.height * 0.5;
    [imageView addSubview:startButton];
    [startButton release];
    [startButton addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)startClick
{
    if (self.shareButton.state) {
        [UMSocialSnsService presentSnsController:self appKey:@"5594f30667e58eb6f70024b2" shareText:@"我们一起来使用歆悦播放器吧~" shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren, UMShareToWechatSession,nil] delegate:nil];
    }
    
    [UIView animateWithDuration:1.0f animations:^{
        [PlayerToolBarController sharePlayerToolBarController].view.hidden = NO;
        UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
        window.rootViewController = [[NavigationViewController alloc] initWithRootViewController:[[HotsViewController alloc] init].autorelease];
    } completion:^(BOOL finished) {
        [self addToolBar];
    }];
}

- (void)dealloc
{
    NSLog(@"dealloc");
    [_page release];
    [_shareButton release];
    
    [super dealloc];
}

- (void)shareButtonAction:(UIButton *)button
{
    button.selected = !button.selected;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offSet = scrollView.contentOffset;
    int num = (int)offSet.x / self.view.frame.size.width + 0.5;
    self.page.currentPage = num;
}

- (void)addToolBar
{
    PlayerToolBarController *toolBar = [PlayerToolBarController sharePlayerToolBarController];
    
    [self toolBarAction:toolBar];
    
}

- (void)toolBarAction:(PlayerToolBarController *)toolBar
{
    if (![[[[UIApplication sharedApplication].windows lastObject] subviews] containsObject:toolBar]) {
        
        [[[UIApplication sharedApplication].windows lastObject] addSubview:toolBar.view];
        
        PlayerViewController *playerVc = [PlayerViewController shareInterface];
        
        __block PlayerViewController *vc = playerVc;
        __block PlayerToolBarController *tool = toolBar;
        
        toolBar.toolBarBlock = ^{
            
            // 1.创建播放界面对象
            
            
            // 2.模态进入
            
            toolBar.view.hidden = YES;
            UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
            [window.rootViewController presentViewController:playerVc animated:YES completion:^{
                
                // 5.block回调 显示底栏
                vc.hiddenBlock = ^{
                    
                    tool.view.hidden = NO;
                    
                };
            }];
        };
        
    }
}

@end
