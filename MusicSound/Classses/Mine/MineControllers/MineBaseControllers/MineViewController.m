//
//  MineViewController.m
//  天天动听
//
//  Created by 大泽 on 15/6/12.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "MineViewController.h"

#import "MineGroup.h"
#import "MineArrowModel.h"
#import "MineModels.h"
#import "MineSwitchModel.h"
#import "MineTableViewCell.h"
#import "MineCollectionViewController.h"
#import "UMSocial.h"
@interface MineViewController ()
@property (nonatomic, retain) UIWebView *webView;
@end

@implementation MineViewController

- (UIWebView *)webView
{
    if (!_webView) {
        
        _webView = [[UIWebView alloc] init];
        
    }
    return [[_webView retain] autorelease];
}
- (void)viewDidLoad
{
    self.title = @"我的";
    [super viewDidLoad];
    
    
    UIImage *image = [UIImage imageNamed:@"191813uehtectnn5h110hh.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 200)];
    imageView.image = image;
    self.tableView.tableHeaderView = imageView;
    [imageView release];
    
    [self addGroup0];
    
    [self addGroup1];
    
    [self addGroup5];
    
    [self addGroup2];
}

- (void)addGroup0
{
    
    MineModels *musicCollection = [MineArrowModel mineModelsWithTitle:@"我的收藏" icon:nil destVc:[MineCollectionViewController class]];
    
    MineModels *clearDisk = [MineArrowModel mineModelsWithTitle:@"清除缓存" icon:nil];
    clearDisk.option = ^{
        
        [[SDImageCache sharedImageCache] clearDisk];
        
        
        [UIAlertView showAlertViewWithTitle:@"清除缓存成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    };
    MineGroup *group0 = [[MineGroup alloc] init];
    
    group0.items = @[musicCollection, clearDisk];
    
    [self.tableViewArray addObject:group0];
    [group0 release];
}

- (void)addGroup1
{
    MineModels *night = [MineSwitchModel mineModelsWithTitle:@"夜间模式" icon:nil];
    MineModels *shake = [MineModels mineModelsWithTitle:@"摇一摇换歌" icon:nil];
    
    MineGroup *group1 = [[MineGroup alloc] init];
    group1.items = @[night, shake];
    
    [self.tableViewArray addObject:group1];
    [group1 release];
}


- (void)addGroup5
{
    MineModels *share = [MineArrowModel mineModelsWithTitle:@"分享给好友" icon:nil];
    share.option = ^{
        
        [UMSocialSnsService presentSnsController:self appKey:@"5594f30667e58eb6f70024b2" shareText:@"我们一起来使用歆悦播放器吧~" shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren, UMShareToWechatSession,nil] delegate:nil];
        
        
    };
    MineGroup *group = [[MineGroup alloc] init];
    group.items = @[share];
    [self.tableViewArray addObject:group];
    [group release];
}

- (void)addGroup2
{
    MineModels *disclaimer = [MineArrowModel mineModelsWithTitle:@"免责声明" icon:nil destVc:nil];
    disclaimer.option = ^{
        
        [UIAlertView showAlertViewWithTitle:@"免责声明" message:@"1 本APP客户端用户凡以任何方式直接,间接使用本APP资料者,均被视为自愿接受本网站相关声明和用户服务协议.\n 2 APP转载的内容不代表APP手机之意见及观点,也不意味着本网赞同其观点或证实其内容的真实性.\n 3 本APP内容均由第三方提供,本APP内容仅用于欣赏和分享等非营利性用途,APP所转载的文字,图片等资料,如果侵犯了第三方的知识产权或其他权利,请通知我方开发团队做相应的修改处理." delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
    };
    
    MineModels *aboutUs= [MineArrowModel mineModelsWithTitle:@"联系我们" icon:nil destVc:nil];
    aboutUs.option = ^{
      
        [UIAlertView showAlertViewWithTitle:@"联系我们" message:@"Email:i_dzcpt@163.com \n 开发者:刘洪泽 舒文 王言博" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
    };
    
    
    MineGroup *group2 = [[MineGroup alloc] init];
    group2.items = @[disclaimer, aboutUs];
    
    [self.tableViewArray addObject:group2];
    [group2 release];
}



@end
