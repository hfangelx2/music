//
//  RootViewController.m
//  REMenuExample
//
//  Created by Roman Efimov on 2/20/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RootViewController.h"
#import "SongLibraryViewController.h"
#import "RecommendViewController.h"
#import "HotsViewController.h"
#import "MineViewController.h"
#import "NavigationViewController.h"
#import "PlayerViewController.h"
#import "PlayerViewController.h"
#import "SearchViewController.h"
#import "PlayerToolBarController.h"
@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(night:) name:@"night" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(day:) name:@"day" object:nil];
    
    // 1.创建导航栏button
    [self createBarButtonItem];
    
    // 2.显示当前页的名字
    [self createLabel];
    
    // 3.增加底栏播放按钮
//    [self createPlayerButton];
    
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    
    [self becomeFirstResponder];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.subtype == UIEventSubtypeMotionShake) { // 判断是否是摇动结束
        [[PlayerViewController shareInterface] next];
        NSLog(@"摇一摇");
    }
    return;
}

- (void)createBarButtonItem
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(toggleMenu)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:nil image:@"searchSmall" target:self action:@selector(search)];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"searchSmall"] style:(UIBarButtonItemStylePlain) target:self action:@selector(search)];
    
}

//模态到搜索页面
- (void)search
{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:searchVC];
    [PlayerToolBarController sharePlayerToolBarController].view.hidden = YES;
    
    [self presentViewController:nav animated:YES completion:^{
        
    }];
    
}



/**
 *  创建当前页的背景图和背景的名字
 */
- (void)createLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    label.text = NSStringFromClass(self.class);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:21];
    label.backgroundColor  = [UIColor clearColor];
    [self.view addSubview:label];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    imageView.image = [UIImage imageNamed:@"Balloon"];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];

}

- (id)getCurRootController{
    RootViewController * rootController = (RootViewController*)self.navigationController.viewControllers[0];
    return rootController;
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    NavigationViewController *navigationController = (NavigationViewController *)self.navigationController;
    [navigationController.menu setNeedsLayout];
}

#pragma mark -
#pragma mark Rotation

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)night:(NSNotification *)noti
{
    self.view.window.alpha = 0.5;
}

- (void)day:(NSNotification *)noti
{
    self.view.window.alpha = 1;
}

@end

