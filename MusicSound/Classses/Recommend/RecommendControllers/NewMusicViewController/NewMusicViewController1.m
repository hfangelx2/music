//
//  NewMusicViewController.m
//  MusicSound
//
//  Created by 王言博 on 15/6/26.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "NewMusicViewController1.h"

@interface NewMusicViewController1 ()

@end

@implementation NewMusicViewController1
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}
- (void)viewDidLoad {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:nil image:@"top_bar_back3" target:self action:@selector(pop)];
//    NSLog(@"%@", self.allBigArr);
    self.oneVC  = [[OneViewController alloc] init];
    
    NewMusicModel *one = [self.allBigArr objectAtIndex:0];
    NSString *str1 = [NSString stringWithFormat:@"%@", one.title];
    self.oneVC.title = str1;
    self.oneVC.msg_id = one.msg_id;
    self.oneVC.view.backgroundColor = [UIColor brownColor];
    self.oneVC.HUD = [MBProgressHUD showHUDAddedTo:self.oneVC.view animated:YES];
    self.oneVC.HUD.labelText = @"网速不好, 怪我喽";
    [self.oneVC.HUD show:YES];
    [_oneVC release];
    
    self.twoVC = [[TwoViewController alloc] init];
    self.twoVC.title = @"欧美";
    NewMusicModel *two = [self.allBigArr objectAtIndex:1];
    self.twoVC.msg_id = two.msg_id;
    self.twoVC.view.backgroundColor = [UIColor clearColor];
    [_twoVC release];
    
    self.threeVC = [[ThreeViewController alloc] init];
    self.threeVC.title = @"日韩";
    NewMusicModel *three = [self.allBigArr objectAtIndex:2];
    self.threeVC.msg_id = three.msg_id;
    self.threeVC.view.backgroundColor = [UIColor clearColor];
    [_threeVC release];
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[self.oneVC, self.twoVC, self.threeVC];
    navTabBarController.number = navTabBarController.subViewControllers.count;
//    navTabBarController.showArrowButton = YES;
    [navTabBarController addParentController:self];
}
- (void)dealloc
{
    [_allBigArr release];
    [_oneVC release];
    [_twoVC release];
    [_threeVC release];
    [super dealloc];
}
-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
