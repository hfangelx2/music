//
//  PlayerMenuViewController.m
//  MusicSound
//
//  Created by 大泽 on 15/6/28.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "PlayerMenuViewController.h"
#import "XYMusic.h"
#import "PlayerViewController.h"
#import "XYDropDownMenu.h"
#import "DestAndCurrentMusic.h"
@interface PlayerMenuViewController ()

@end
static NSString *const ID = @"Menu";
@implementation PlayerMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.alpha = 0.6;
    
 
}

- (NSMutableArray *)tableViewArray
{
    if (!_tableViewArray) {
        
        _tableViewArray = [[NSMutableArray alloc] init];
        
    }
    return [[_tableViewArray retain] autorelease];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    XYMusic *music = self.tableViewArray[indexPath.row];
    
    cell.textLabel.text = music.name;
    cell.detailTextLabel.text = music.singerName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PlayerViewController *playVc = [PlayerViewController shareInterface];
    
    [DestAndCurrentMusic shareDestAndCurrentMusic].destMusic = self.tableViewArray[indexPath.row];
    
    playVc.musics = self.tableViewArray;
    
    playVc.index = indexPath.row;
}


@end
