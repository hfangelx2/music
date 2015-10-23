//
//  MineBaseViewController.m
//  MusicSound
//
//  Created by 大泽 on 15/6/21.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "MineBaseViewController.h"
#import "MineGroup.h"
#import "MineArrowModel.h"
#import "MineModels.h"
#import "MineSwitchModel.h"
#import "MineTableViewCell.h"

@interface MineBaseViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation MineBaseViewController

- (void)dealloc
{
    [_tableView release];
    [_tableViewArray release];
    
    [super dealloc];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 108) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
       
    }
    return [[_tableView retain] autorelease];
}

- (NSMutableArray *)tableViewArray
{
    if (!_tableViewArray) {
        
        _tableViewArray = [[NSMutableArray alloc] init];
        
    }
    return [[_tableViewArray retain] autorelease];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MineGroup *group = self.tableViewArray[section];
    
    return group.items.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineTableViewCell *cell = [MineTableViewCell cellWithTableView:tableView];
    
    MineGroup *group = self.tableViewArray[indexPath.section];
    
    MineModels *mineModels = group.items[indexPath.row];
    
    cell.mineModels = mineModels;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MineGroup *group = self.tableViewArray[indexPath.section];
    
    MineModels *mineModels = group.items[indexPath.row];
    
    if (mineModels.option) {
        mineModels.option();
        return;
    }
    
    if ([mineModels.class isSubclassOfClass:[MineArrowModel class]]) {
        
        MineArrowModel *arr = (MineArrowModel *)mineModels;
        
        if (arr.destVc) {
            
            RootViewController *vc = [[arr.destVc alloc] init];
            
            vc.title = arr.title;
            
            [self.navigationController pushViewController:vc animated:YES];
            
            [vc release];
        }
    }
    
}


@end
