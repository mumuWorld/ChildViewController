//
//  ViewController.m
//  0531_网易新闻
//
//  Created by mumu on 2017/5/31.
//  Copyright © 2017年 mumu. All rights reserved.
//

#import "ViewController.h"
#import "GlobalParameter.h"
#import "TouTiaoViewController.h"
#import "ReDianViewController.h"
#import "ShiPinViewController.h"
#import "SheHuiViewController.h"
#import "DingYueViewController.h"
#import "KeJiViewController.h"

@interface ViewController ()

@property (nonatomic,strong) UIScrollView *titleView;
@property (nonatomic,strong) UIScrollView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航标题
    self.navigationItem.title = @"网易新闻";
    //添加标题栏
    [self.view addSubview:self.titleView];
    //添加contentview
    [self.view addSubview:self.contentView];
    //添加子控制器
    [self addChildVC];
    //设置titleview
    [self setupTitleBtn];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)setupTitleBtn
{
    NSInteger count = self.childViewControllers.count;
    CGFloat btnW = 100;
    CGFloat btnH = self.titleView.bounds.size.height;
    for (int i=0; i<count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnW*i, 0, btnW, btnH)];
        UIViewController *vc = self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(titleViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:btn];
        //默认选中第一个
        if (i == 0) {
            [self titleViewBtnClick:btn];
        }
    }
    // 设置标题的滚动范围
    self.titleView.contentSize = CGSizeMake(count * btnW, 0);
    self.contentView.contentSize = CGSizeMake(count *ScreenWidth, 0);
    //隐藏水平滚动条
    self.titleView.showsHorizontalScrollIndicator = NO;
    
    //iOS7以后，导航控制器中，scrollview 顶部会添加64的额外滚动区域。
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)titleViewBtnClick:(UIButton *)btn
{
    NSLog(@"1111=%li",btn.tag);
    NSInteger i = btn.tag;
    UIViewController *vc = self.childViewControllers[i];
    CGFloat vcY = CGRectGetMaxY(self.titleView.frame);
    vc.view.frame = CGRectMake(i *ScreenWidth, 0, ScreenWidth, ScreenHeight -vcY);
    [self.contentView addSubview:vc.view];
    self.contentView.contentOffset = CGPointMake(i*ScreenWidth, 0);
}
- (void)addChildVC
{
    TouTiaoViewController *toutiao = [[TouTiaoViewController alloc] init];
    toutiao.title = @"头条";
    [self addChildViewController:toutiao];
    
    ReDianViewController *redian = [[ReDianViewController alloc] init];
    redian.title = @"热点";
    [self addChildViewController:redian];
    
    ShiPinViewController *shipin = [[ShiPinViewController alloc] init];
    shipin.title = @"视频";
    [self addChildViewController:shipin];
    
    SheHuiViewController *shehui = [[SheHuiViewController alloc] init];
    shehui.title = @"社会";
    [self addChildViewController:shehui];
    
    DingYueViewController *dingyue = [[DingYueViewController alloc] init];
    dingyue.title = @"订阅";
    [self addChildViewController:dingyue];
    
    KeJiViewController *keji = [[KeJiViewController alloc] init];
    keji.title = @"科技";
    [self addChildViewController:keji];
}
- (UIScrollView *)titleView
{
    if (_titleView == nil) {
        CGFloat y = self.navigationController.isNavigationBarHidden ? 20:64;
        _titleView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y, ScreenWidth, 44)];
        _titleView.backgroundColor = [UIColor redColor];
    }
    return _titleView;
}
- (UIScrollView *)contentView
{
    if (_contentView == nil) {
        CGFloat y = CGRectGetMaxY(self.titleView.frame);
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y, ScreenWidth, ScreenHeight - y)];
        _contentView.backgroundColor = [UIColor lightGrayColor];
    }
    return _contentView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
