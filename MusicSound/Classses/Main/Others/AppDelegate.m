//
//  AppDelegate.m
//  aaas
//
//  Created by 大泽 on 15/6/12.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "NavigationViewController.h"
#import "SongLibraryViewController.h"
#import "PlayerViewController.h"
#import "HotsViewController.h"
#import "RootViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PlayerToolBarController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "PlayerTools.h"
#import "UMSocial.h"
#import "UMSocialSinaHandler.h"
#import "WelcomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOption
{

    [NSThread sleepForTimeInterval:1.0];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    

    [[NSUserDefaults standardUserDefaults] setObject:Day forKey:DayOrNight];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    
//    [self addToolBar];
    [application beginReceivingRemoteControlEvents];
    
    NSString *key = @"CFBundleVersion";
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    //判断是否是第一次运行
    if ([version isEqualToString:currentVersion]) {
        self.window.rootViewController = [[NavigationViewController alloc] initWithRootViewController:[[HotsViewController alloc] init]];
        [self addToolBar];
    } else {
        
        WelcomeViewController *welcomeVc = [[WelcomeViewController alloc] init];
        
        self.window.rootViewController = welcomeVc;
        
        [welcomeVc release];
        [self addToolBar];
        [PlayerToolBarController sharePlayerToolBarController].view.hidden = YES;
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
    }
    
#pragma mark - 友盟分享
    [UMSocialData setAppKey:@"5594f30667e58eb6f70024b2"];
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [application beginBackgroundTaskWithExpirationHandler:nil];
    
}
- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    if (event.type == UIEventTypeRemoteControl) {

        self.remoteBlock(event);
        
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
            
            [self.window.rootViewController presentViewController:playerVc animated:YES completion:^{
                
                // 5.block回调 显示底栏
                vc.hiddenBlock = ^{
                    
                    tool.view.hidden = NO;
                    
                };
            }];
        };
        
    }
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


@end
