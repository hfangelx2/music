//
//  RecommendViewController.m
//  天天动听
//
//  Created by 大泽 on 15/6/12.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "RecommendViewController.h"
#import <MJRefresh.h>
#import "WebViewViewController.h"
#import "HaibaoViewController.h"
#import <MBProgressHUD.h>
#import "MvTableViewCell.h"
#import "PlayerToolBarController.h"
#import "NewAlbumViewController.h"
#import "PlayerTools.h"

@interface RecommendViewController () <UITableViewDelegate>
{
    @public
    MBProgressHUD *HUD;
}

@end

@implementation RecommendViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        self.allModuleArr = [NSMutableArray array];
        self.allBigArr = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    self.title = @"推荐";
    [super viewDidLoad];
    [self.view addSubview:self.myTableView];
//    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    HUD.labelText = @"网速不好, 怪我喽";
//    [HUD show:YES];
    
    [self addHeader];
//    [self getData];
//    [self getNewMusicData];
    
}
- (void)addHeader
{
    __block RecommendViewController *vc = self;//因为block块里用self会报警告,所以需要将self声明成block变量
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    // 添加下拉刷新头部控件
    self.myTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [vc getData];
        [vc getNewMusicData];
    }];
    
#pragma mark 自动刷新(一进入程序就下拉刷新)
    [self.myTableView.header beginRefreshing];
}

- (UITableView *)myTableView
{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,TITLE_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - TITLE_HEIGHT - PLAYER_HEIGHT) style:UITableViewStyleGrouped];
        _myTableView.backgroundColor = [UIColor whiteColor];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone; // 去掉分割线

        
    }
    return _myTableView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendModel *recommendM = [self.allModuleArr objectAtIndex:indexPath.section];
    NSString *type = [NSString stringWithFormat:@"%@", recommendM.myAction.type];
    NSString *style = [NSString stringWithFormat:@"%@", recommendM.style];

    if ([type isEqualToString:@"0"] && [style isEqualToString:@"8"]) {
        static NSString *cellIdentifier = @"haibaoCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
//            // push 到WebViewController
//            cell.haiBaoBlcok = ^(NSString *value){
//                WebViewViewController *webVc = [[WebViewViewController alloc] init];
//                
//                webVc.value = value;
//                
//                
//                [self.navigationController pushViewController:webVc animated:YES];
//                [webVc release];
//            };
//            
//            cell.haiBaoBlcok1 = ^(NSString *valur){
//                NSLog(@"======%@", valur);
//                HaibaoViewController *haibaoVC = [[HaibaoViewController alloc] init];
//                haibaoVC.value = valur;
//                // push动画
//                CATransition *transition = [CATransition animation];
//                transition.duration = 1.0f;
//                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//                transition.type = @"cube";
//                transition.subtype = kCATransitionFromRight;
//                transition.delegate = self;
//                [self.navigationController.view.layer addAnimation:transition forKey:nil];
//
//                [self.navigationController pushViewController:haibaoVC animated:YES];
//                [haibaoVC release];
//            };
//            
            
        }
//        cell.allHaibaoArr = [NSMutableArray arrayWithArray:recommendM.data];
//        
        
        return cell;
    }
    if ([type isEqualToString:@"0"] && [style isEqualToString:@"2"]) {
        static NSString *cellIdenter = @"newMucic"; // 第二条
        // se
        SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenter];
        if (cell == nil) {
            cell = [[SecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenter];
        }
//        
        cell.allArr = recommendM.dataArray;
        cell.myData = [recommendM.dataArray objectAtIndex:indexPath.row];

        
        return cell;
    }
    
    if ([type isEqualToString:@"200"] && [style isEqualToString:@"9"]) {
        static NSString *cellIdenter = @"omyGod";
        MvTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenter];
        if (cell == nil) {
            cell = [[MvTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenter];
        }
        RecommendModel *myRM = [self.allModuleArr objectAtIndex:indexPath.section];
        cell.mvUrl = myRM.myData.pic_url;
    
        return cell;
    }

    // 热门歌单
    static NSString *cellIdentifier1 = @"cell";
    ThirdTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
    if (cell1 == nil) {
        cell1 = [[ThirdTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];

    }
    cell1.allDataArray = [NSMutableArray arrayWithArray:recommendM.dataArray];
    
    cell1.collectBlock = ^(NSString *str) {
        NSLog(@"%@", str);
        HaibaoViewController *haibaoVC = [[HaibaoViewController alloc] init];
        haibaoVC.value = str;
        [self.navigationController pushViewController:haibaoVC animated:YES];
        
    };
    return cell1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 15;
    }
    return 17;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UILabel *firstHeader = [[UILabel alloc] init];
        return firstHeader;
    }
    UILabel *header = [[UILabel alloc] init];
    header.backgroundColor = [UIColor clearColor];
    RecommendModel *rrr = [self.allModuleArr objectAtIndex:section];
    header.text = [NSString stringWithFormat:@"     %@", rrr.name];
    
    UILabel *smallLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,0, 2, 17)];
    smallLabel.backgroundColor = [UIColor colorWithRed:100.0/256.0 green:200.0/256.0 blue:250.0/256.0 alpha:1.0];
    
//    smallLabel.backgroundColor = [UIColor redColor];
    [header addSubview:smallLabel];
    
    return header;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //  最新音乐 row = 0
    if (indexPath.section==1 && indexPath.row == 0) {
       
        NewMusicViewController1 *newMusicVC = [[NewMusicViewController1 alloc] init];
        
        if (self.allBigArr.count != 0) {
            
            newMusicVC.allBigArr = self.allBigArr;
            [self.navigationController pushViewController:newMusicVC animated:YES];
        }
        

    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        NewAlbumViewController *newMusicMv = [[NewAlbumViewController alloc] init];
        [self.navigationController pushViewController:newMusicMv animated:YES];
    }
    
    // 亚洲新歌榜 44444
//    RecommendModel *yaZhouModel = [self.allModuleArr objectAtIndex:indexPath.section];
//    NSString *string= [NSString stringWithFormat:@"%@", yaZhouModel.myData.action1.type];
//    if (indexPath.section == 4) {
//
//        if ([string isEqualToString:@"1"]) {
//            WebViewViewController *yaZhouNew = [[WebViewViewController alloc] init];
//            
//            yaZhouNew.value = yaZhouModel.myData.action1.value;
//            
//            [[PlayerTools sharePlayerTools] stop];
//            
//            [self.navigationController pushViewController:yaZhouNew animated:YES];
//        }
//
//    }
    
    // 个性化推荐
    RecommendModel *sixRecomendModel = [[RecommendModel alloc] init];
    sixRecomendModel  = [self.allModuleArr objectAtIndex:indexPath.section];
//    NSLog(@"%@ %@", sixRecomendModel.data, sixRecomendModel.name); // 打印section = 6 的大data
    if (indexPath.section == 6 || indexPath.section == 7) {
        Data *rowData = [sixRecomendModel.dataArray objectAtIndex:indexPath.row];
        NSLog(@"%@----%@", rowData.action1.type, rowData.action1.value);
        if ([rowData.action1.type isEqual:@13]) {
            NSLog(@"%@", rowData._id);
            HaibaoViewController *haibaoVC = [[HaibaoViewController alloc] init];
            haibaoVC.type = rowData.action1.type;
            haibaoVC.value= rowData._id;
            haibaoVC.recomendModel = sixRecomendModel;
            haibaoVC.data = rowData;
            [self.navigationController pushViewController:haibaoVC animated:YES];
        }
        if ([rowData.action1.type isEqual:@5]) {

            HaibaoViewController *haibaoVC = [[HaibaoViewController alloc] init];
            haibaoVC.value= rowData.action1.value;
            [self.navigationController pushViewController:haibaoVC animated:YES];
        }
        
        if ([rowData.action1.type isEqual:@6]) {
            DajiaViewController *daJiaVC = [[DajiaViewController alloc] init];
            [self.navigationController pushViewController:daJiaVC animated:YES];
        }

    }
    
    //
    RecommendModel *fiveRM = [self.allModuleArr objectAtIndex:indexPath.section];
    if (indexPath.section == 5) {
        if ([fiveRM.myData.action1.type isEqual:@18]) {
            NSLog(@"视频");
            __block BOOL xinYue = NO;
            __block RecommendViewController *vc = self;
            
            self.DajiaMVUrl = fiveRM.myData.action1.value;
            [self getDajiaData];
            MVVideoViewController *mvVC = [[MVVideoViewController alloc] init];
            self.DajiaKanBlock = ^(DajiaSongModel *model){
                MvListModel *tt = [model.allMvListArr firstObject];
//                NSLog(@"-----:::::%@", tt.url);
                if (![tt.url isEqualToString:@""]) {
                    xinYue = YES;
                    mvVC.mvUrl = tt.url;
                }
               
                [PlayerToolBarController sharePlayerToolBarController].view.hidden = YES;
                
                PlayerToolBarController *toolBar = [PlayerToolBarController sharePlayerToolBarController];
                [toolBar playerOrPause:toolBar.playerBtn];
                
                if (vc.presentedViewController == nil)
                {
                    [vc presentViewController:mvVC animated:YES completion:nil];
                }

   
            };
            

        }
    }
//    if (indexPath.section == 8) {
//        WebViewViewController *yaZhouNew = [[WebViewViewController alloc] init];
//        yaZhouNew.value = yaZhouModel.myData.action1.value;
//        [self.navigationController pushViewController:yaZhouNew animated:YES];
//    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return 7;
    return self.allModuleArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0) {
        return 1;
    }
//    NSLog(@"%ld", self.allModuleArr.count);
    RecommendModel *uuuu = [self.allModuleArr objectAtIndex:section];
    
    NSString *type = [NSString stringWithFormat:@"%@", uuuu.myAction.type];
    NSString *style = [NSString stringWithFormat:@"%@", uuuu.style];

    if ([type isEqualToString:@"0"] && [style isEqualToString:@"5"]) {
        return 1;
    }
    return uuuu.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 1;
    }
    if (indexPath.section == 2) {
        return 180;
    }
    if (indexPath.section == 3) {
        return 180;
    }
    if (indexPath.section == 5) {
        return 200;
    }
    
    if (indexPath.section == 7 && indexPath.row == 2) {
        return 200;
    }
    return 110;
}
- (void)getData
{
    [AFNConnect AFNConnectWithUrl:@"http://online.dongting.com/recomm/recomm_modules?app=ttpod&v=v7.9.4.2015052918&uid=&mid=iPad4%2C4&f=f320&s=s330&imsi=&hid=&splus=8.3&active=1&net=2&openudid=367f79a32ab2f14c1ee6d0a9e3587bcedc93d35c&idfa=8B711584-C712-4E8F-B6C8-39599E106A4C&utdid=VYJ5JD0tJEwDANcughrXcMK9&alf=201200&bundle_id=com.ttpod.music&version=1" key:@"data" connectBlock:^(id data) {
        [self.allModuleArr removeAllObjects];
        //        NSLog(@"%@", data);
        NSArray *arr = [data objectForKey:@"songlists"];
        
        for (NSDictionary *dic in arr) {
            RecommendModel *recommendM = [[RecommendModel alloc] init];
            [recommendM setValuesForKeysWithDictionary:dic];
            [self.allModuleArr addObject:recommendM];
            [recommendM release];
        }
        [self.myTableView.header endRefreshing];
        [self.myTableView reloadData];
        [HUD hide:YES];
    }];
}
- (void)getNewMusicData
{
    [AFNConnect AFNConnectWithUrl:@"http://online.dongting.com/recomm/new_songlists?app=ttpod&v=v7.9.4.2015052918&uid=&mid=iPad4%2C4&f=f320&s=s330&imsi=&hid=&splus=8.3&active=1&net=2&openudid=367f79a32ab2f14c1ee6d0a9e3587bcedc93d35c&idfa=8B711584-C712-4E8F-B6C8-39599E106A4C&utdid=VYJ5JD0tJEwDANcughrXcMK9&alf=201200&bundle_id=com.ttpod.music" key:@"data" connectBlock:^(id data) {
        for (NSDictionary *dic in data) {
            NewMusicModel *jjj = [[NewMusicModel alloc] init];
            [jjj setValuesForKeysWithDictionary:dic];
            [self.allBigArr addObject:jjj];
            [jjj release];
        }
        [self.myTableView reloadData];

    }];
    
    
}
- (void)getDajiaData
{

    [AFNConnect AFNConnectWithUrl:[NSString stringWithFormat:@"%@%@%@",DajiaKanUrl1, self.DajiaMVUrl,DajiaKanUrl2] key:@"data" connectBlock:^(id data) {
//        NSLog(@"%@", data);
        self.onlyMVModel = [[DajiaSongModel alloc] init];
        [self.onlyMVModel setValuesForKeysWithDictionary:data];
        self.DajiaKanBlock(self.onlyMVModel);
        [_onlyMVModel release];
        [self.myTableView reloadData];
    }];
}
- (void)dealloc
{
    [_myTableView release];
    [_allBigArr release];
    [_allModuleArr release];
    [_DajiaMVUrl release];
    [_onlyMVModel release];
    [super dealloc];
}
@end
