//
//  XYDropDownMenu.m
//  MusicSound
//
//  Created by 大泽 on 15/6/28.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "XYDropDownMenu.h"
#import "PlayerMenuViewController.h"
@interface XYDropDownMenu ()

/**
 *  下拉菜单的imgview
 */
@property (nonatomic, retain) UIImageView *containerView;

@end

@implementation XYDropDownMenu

- (void)dealloc
{
    [_containerView release];
    
    [super dealloc];
}

- (UIImageView *)containerView
{
    if (!_containerView) {
        
        _containerView = [[UIImageView alloc] init];
        _containerView.image = [UIImage imageNamed:@"popover_background_right"];
        _containerView.userInteractionEnabled = YES;
        _containerView.alpha = 0.8;
        [self addSubview:_containerView];
    }
    return [[_containerView retain] autorelease];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)showFrom:(UIView *)from
{
    XYDropDownMenu *menu = [[XYDropDownMenu alloc] init];
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:menu];
    
    menu.frame = window.bounds;
    
    [menu release];
    
    // 显示灰色图片
    [menu showMenuFrom:from];
    
    return menu;
}

- (void)showMenuFrom:(UIView *)from
{
    self.containerView.width = 160;
    self.containerView.height = 300;
    
    CGRect newFrame = [self.containerView convertRect:self.containerView.bounds toView:[[UIApplication sharedApplication].windows lastObject]];
    
    newFrame.origin.x = CGRectGetMaxX(from.frame) - self.containerView.width;
    newFrame.origin.y = CGRectGetMaxY(from.frame);

    self.containerView.frame = newFrame;
}

- (void)setContentVc:(PlayerMenuViewController *)contentVc
{
    if (_contentVc != contentVc) {
        [_contentVc release];
        _contentVc = [contentVc retain];
    }
    
    
    if (contentVc.tableViewArray.count != 0) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:contentVc.index inSection:0];
        
        [contentVc.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [contentVc.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:contentVc.index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
    
    contentVc.view.x = 10;
    contentVc.view.y = 15;
    contentVc.view.width = self.containerView.width - 20;
    self.containerView.height = CGRectGetMaxY(contentVc.view.frame) + 10;
    [self.containerView addSubview: contentVc.view];
    
}

- (void)dismiss
{
    [self removeFromSuperview];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

@end
