//
//  AFNConnect.m
//  豆瓣1.0
//
//  Created by 大泽 on 15/6/4.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "AFNConnect.h"
#import <AFNetworking.h>
@implementation AFNConnect

+ (void)AFNConnectWithUrl:(NSString *)urlStr key:(NSString *)key connectBlock:(void (^)(id))myBlock
{
    AFNetworkReachabilityManager *netWorkManager = [AFNetworkReachabilityManager sharedManager];
   
    
    //[NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];  代表支持所有的接口类型
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [netWorkManager stopMonitoring];
        
        if ([responseObject[key] isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dic = responseObject[key];
            myBlock(dic);
            
        } else {
            
            NSArray *array = responseObject[key];
            
            myBlock(array);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"失败==== %@",error);
        
        [UIAlertView showAlertViewWithTitle:@"网络连接超时,请重试" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
    }];
    

}




@end
