//
//  MyScrollView.m
//  MusicSound
//
//  Created by 王言博 on 15/6/21.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "MyScrollView.h"

@interface MyScrollView () <UIScrollViewDelegate>

@end

@implementation MyScrollView

- (void)dealloc
{
    [_scroll release];
    [_myTimer release];
    [_pageControl release];
    [_allHaibaoArr release];
    [_aaaa release];
    [super dealloc];
}

//+ (instancetype)shareHandleScrollV
//{
//    static MyScrollView *scrollV = nil;
//    static dispatch_once_t onctToken;
//    dispatch_once(&onctToken, ^{
//        scrollV = [[MyScrollView alloc] init];
//    });
//    return scrollV;
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.page = 1;
        self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        //边框回弹取消
        self.scroll.bounces = NO;
        self.scroll.delegate = self;
        self.scroll.showsHorizontalScrollIndicator = NO;
        self.scroll.showsVerticalScrollIndicator = NO;
        [self addSubview:_scroll];
        [_scroll release];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(30, 105, 260, 30)];
        [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:self.pageControl];
//        self.pageControl.backgroundColor = [UIColor orangeColor];
        
        self.allHaibaoArr = [NSMutableArray array];
        [_pageControl release];

    }
    return self;
}

- (void)setImages:(NSMutableArray *)names{
    
    self.allHaibaoArr = names;
    
//    NSLog(@"%@", self.allHaibaoArr);
    NSString *first = [names firstObject];
    NSString *last = [names lastObject];
    [names insertObject:last atIndex:0];
    [names addObject:first];
    
    
    self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width *names.count, 0);
    self.pageControl.numberOfPages = names.count - 2;
    [self createTimer];//创建定时器
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSDictionary *dic in names) {
        
        NSString *web = [dic objectForKey:@"pic_url"];
//        NSLog(@"============%@", web);
        [arr addObject:web];
    }
    
    int i = 0;
//    NSLog(@"%@", names);  // names 数组存储所有的海报信息
    
    for (NSString *name in arr) {
        
        UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(self.scroll.frame.size.width * i, 0, self.scroll.frame.size.width, self.scroll.frame.size.height)];
        //圆角设置
        
        im.layer.cornerRadius = 8;
        
        im.layer.masksToBounds = YES;
        im.backgroundColor = [UIColor clearColor];
        im.tag = 10000 + i;
        NSURL *url = [NSURL URLWithString:name];
        [im sd_setImageWithURL:url];
        
        [self.scroll addSubview:im];
        _scroll.pagingEnabled= YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [im addGestureRecognizer: tap];
        im.userInteractionEnabled = YES;
        
        i++;
    }
    [self.scroll setContentOffset:CGPointMake(self.frame.size.width, 0)];
}
#pragma mark --创建定时器
-(void)createTimer
{
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAciton:) userInfo:nil repeats:YES];
}

#pragma mark --定时器调用的方法
- (void)timerAciton:(NSTimer *)timer{
    
    //当正常滚动的时候
    self.page ++;
    //将要到达偏移量的宽度
    CGFloat offWith = _scroll.frame.size.width *self.page;
//    NSLog(@"with = %f",offWith);
    
    //    [UIView animateWithDuration:0.5 animations:^{ //用动画也能实现,动画的偏移
    [self.scroll setContentOffset:CGPointMake(offWith, 0) animated:YES];
//    NSLog(@"正常滚动");
    //    }];
    
    
    //当不是正常滚动,滚动到边缘就取消动画
    NSInteger number = self.scroll.contentSize.width / self.scroll.frame.size.width;
    //number是当前图片个数
    if (offWith == self.scroll.frame.size.width * (number - 1)) {
        self.page = 1;
        [self.scroll setContentOffset:CGPointMake(0, 0)];
//        NSLog(@"快速跳转");
    }
    
}

#pragma mark-- 停止定时器
-(void)stopTimer
{
    if (self.myTimer) {
        
        if (self.myTimer.isValid) {//如果是开启状态
            
            [self.myTimer invalidate];
            self.myTimer = nil;
        }
        
    }
    
}

#pragma mark--手指将要拖拽的时候停止计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
    NSLog(@"timer = %@",self.myTimer);
}
#pragma mark--将要结束拖拽,也就是手指离开的时候
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self createTimer];
    
}

#pragma mark --加速结束的时候
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    CGSize  size = scrollView.contentSize;
    CGFloat with = scrollView.frame.size.width;
    self.page = scrollView.contentOffset.x / with;
    
    //往左划,如果是滑到最后一张图
    if (scrollView.contentOffset.x == (size.width - with)) {
        
        self.page = 1;
        [scrollView setContentOffset:CGPointMake(with, 0)];
        
    }
    //往右滑,如果滑到第一张图
    if (scrollView.contentOffset.x == 0){
        
        self.page = scrollView.contentSize.width / scrollView.frame.size.width - 2 ;
        [scrollView setContentOffset:CGPointMake(size.width - with * 2, 0)];
    }
    
    
}


#pragma mark tapAction;
- (void)tapAction:(UITapGestureRecognizer *)tap{
//    NSLog(@"%@", self.allHaibaoArr);
//    NSLog(@"page = %ld",self.page);
    // 获取点击的视图
    UIImageView *image = (UIImageView *)tap.view;
    NSLog(@"image = %ld",image.tag);
//    NSLog(@"sssssss-----%ld", self.allHaibaoArr.count);
    NSDictionary *dic = self.allHaibaoArr[image.tag - 10000];
    
    NSDictionary *dic1 = dic[@"action"];
    
    NSString *value = dic1[@"value"];
    
//    NSLog(@"-----%@", value);
    NSNumber *type = dic1[@"type"];

    
    if ([@1 isEqual:type]) {
        
        self.scrollBlock(value);
        NSLog(@"此页是webView");
    } else if ([@5 isEqual:type]) {
//        NSLog(@"此页不是webView");
        self.scrollBlock1(value);
    }
    
    
    return;
    
}

// 使页面上点的变化与视图的变化一致
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"ffffffff");
    self.pageControl.currentPage = self.scroll.contentOffset.x / 375;
}


- (void)changePage:(UIPageControl *)page
{
    [self.scroll setContentOffset:CGPointMake((page.currentPage + 1) * 355, 0) animated:YES];
}

@end
