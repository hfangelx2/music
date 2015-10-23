//
//  NavigationViewController.m
//  REMenuExample
//
//  Created by Roman Efimov on 4/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//
//  Sample icons from http://icons8.com/download-free-icons-for-ios-tab-bar
//

#import "NavigationViewController.h"
#import "SongLibraryViewController.h"
#import "RecommendViewController.h"
#import "HotsViewController.h"
#import "MineViewController.h"
#import "PlayerViewController.h"

@interface NavigationViewController () <REMenuDelegate>

@property (strong, readwrite, nonatomic) REMenu *menu;

@end

@implementation NavigationViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    

    if (REUIKitIsFlatMode()) {
        [self.navigationBar performSelector:@selector(setBarTintColor:) withObject:[UIColor whiteColor]];
        self.navigationBar.tintColor = kColor(94, 148, 220);
    } else {
        self.navigationBar.tintColor = [UIColor colorWithRed:0 green:179/255.0 blue:134/255.0 alpha:1];
    }
    
    __typeof (self) __block weakSelf = self;
//    __block NavigationViewController *weakSelf = self;
    
    REMenuItem *songLibraryItem = [[REMenuItem alloc] initWithTitle:@"乐库"
                                                    subtitle:@"Return to SongLibiary"
                                                       image:[UIImage imageNamed:@"Icon_Home"]
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
//                                                          NSLog(@"Item: %@", item);
                                                          SongLibraryViewController *controller = [[SongLibraryViewController alloc] init];
                                                          [weakSelf setViewControllers:@[controller] animated:NO];
                                                      }];
    
    REMenuItem *recommendItem = [[REMenuItem alloc] initWithTitle:@"推荐"
                                                       subtitle:@"Return to Recommend"
                                                          image:[UIImage imageNamed:@"Icon_Explore"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             RecommendViewController *controller = [[RecommendViewController alloc] init];
                                                             [weakSelf setViewControllers:@[controller] animated:NO];
                                                         }];
    
    REMenuItem *hotsItem = [[REMenuItem alloc] initWithTitle:@"排行"
                                                        subtitle:@"Return to HOT"
                                                           image:[UIImage imageNamed:@"Icon_Activity"]
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
//                                                              NSLog(@"Item: %@", item);
                                                              HotsViewController *controller = [[HotsViewController alloc] init];
                                                              [weakSelf setViewControllers:@[controller] animated:NO];
                                                          }];
    
//    activityItem.badge = @"12";
    
    REMenuItem *mineItem = [[REMenuItem alloc] initWithTitle:@"我的"
                                                    subtitle:@"Return to Mine"
                                                          image:[UIImage imageNamed:@"Icon_Profile"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
//                                                             NSLog(@"Item: %@", item);
                                                             MineViewController *controller = [[MineViewController alloc] init];
                                                             [weakSelf setViewControllers:@[controller] animated:NO];
                                                         }];
    
    // You can also assign a custom view for any particular item
    // Uncomment the code below and add `customViewItem` to `initWithItems` array, for example:
    
    
//    UIView *customView = [[UIView alloc] init];
//    customView.backgroundColor = [UIColor blueColor];
//    customView.alpha = 0.4;
//    REMenuItem *customViewItem = [[REMenuItem alloc] initWithCustomView:customView action:^(REMenuItem *item) {
//        NSLog(@"Tap on customView");
//    }];
//    
//    self.menu = [[REMenu alloc] initWithItems:@[homeItem, exploreItem, activityItem, profileItem, customViewItem]];
    
    songLibraryItem.tag = 0;
    recommendItem.tag = 1;
    hotsItem.tag = 2;
    mineItem.tag = 3;
    
    self.menu = [[REMenu alloc] initWithItems:@[hotsItem, songLibraryItem, recommendItem, mineItem]];
    
    // Background view
    //
    //self.menu.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    //self.menu.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //self.menu.backgroundView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.600];

    //self.menu.imageAlignment = REMenuImageAlignmentRight;
    //self.menu.closeOnSelection = NO;
    //self.menu.appearsBehindNavigationBar = NO; // Affects only iOS 7
    if (!REUIKitIsFlatMode()) {
        self.menu.cornerRadius = 4;
        self.menu.shadowRadius = 4;
        self.menu.shadowColor = [UIColor blackColor];
        self.menu.shadowOffset = CGSizeMake(0, 1);
        self.menu.shadowOpacity = 1;
    }
    
    // Blurred background in iOS 7
    //
    //self.menu.liveBlur = YES;
    //self.menu.liveBlurBackgroundStyle = REMenuLiveBackgroundStyleDark;

    self.menu.separatorOffset = CGSizeMake(15.0, 0.0);
    self.menu.imageOffset = CGSizeMake(5, -1);
    self.menu.waitUntilAnimationIsComplete = NO;
    self.menu.badgeLabelConfigurationBlock = ^(UILabel *badgeLabel, REMenuItem *item) {
        badgeLabel.backgroundColor = [UIColor colorWithRed:0 green:179/255.0 blue:134/255.0 alpha:1];
        badgeLabel.layer.borderColor = [UIColor colorWithRed:0.000 green:0.648 blue:0.507 alpha:1.000].CGColor;
    };
    self.menu.delegate = self;
    
    
    [self.menu setClosePreparationBlock:^{
//        NSLog(@"Menu will close");
    }];
    
    [self.menu setCloseCompletionHandler:^{
//        NSLog(@"Menu did close");
    }];

    
}



- (void)toggleMenu
{
    if (self.menu.isOpen)
        return [self.menu close];
    
    [self.menu showFromNavigationController:self];
}



#pragma mark - REMenu Delegate Methods

-(void)willOpenMenu:(REMenu *)menu
{
//    NSLog(@"Delegate method: %@", NSStringFromSelector(_cmd));
}

-(void)didOpenMenu:(REMenu *)menu
{
//    NSLog(@"Delegate method: %@", NSStringFromSelector(_cmd));
}

-(void)willCloseMenu:(REMenu *)menu
{
//    NSLog(@"Delegate method: %@", NSStringFromSelector(_cmd));
}

-(void)didCloseMenu:(REMenu *)menu
{
//    NSLog(@"Delegate method: %@", NSStringFromSelector(_cmd));
}

@end
