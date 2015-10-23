//
//  WebViewViewController.m
//  MusicSound
//
//  Created by 王言博 on 15/6/23.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "WebViewViewController.h"

@interface WebViewViewController ()

@end

@implementation WebViewViewController


- (void)dealloc
{
    [_value release];
    [super dealloc];
}
-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:nil image:@"top_bar_back3" target:self action:@selector(pop)];
    self.view.backgroundColor = [UIColor clearColor];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 44  - 64);
    
    NSLog(@"-----webView.value = %@", self.value);
    
    
//    NSURL *url = [NSURL URLWithString:@"http://fm.baidu.com"];
    NSURL *url = [NSURL URLWithString:self.value];

    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    
    
    [self.view addSubview:webView];
    
    [webView release];
    // Do any additional setup after loading the view.
//    NSURLCache 
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
