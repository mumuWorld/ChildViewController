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

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *titleView;
@property (nonatomic,strong) UIScrollView *contentView;

/**
 保存标题按钮数组§
 */
@property (nonatomic,strong) NSMutableArray *titleButtons;
@property (nonatomic,strong) UIButton *selectButton;//选中按钮

/**
 判断标题按钮是否加载，如果加载就不要再次加载
 */
@property (nonatomic,assign) BOOL isInitialize;

@end

@implementation ViewController

/**
 保存标题按钮数组§
 */
- (NSMutableArray *)titleButtons
{
    if (_titleButtons == nil) {
        _titleButtons = [[NSMutableArray alloc] init];
    }
    return _titleButtons;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_isInitialize == NO) {
        //设置titleview按钮
        [self setupTitleBtn];
        _isInitialize = YES;
    }
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //导航标题
    self.navigationItem.title = @"网易新闻";
    //添加标题栏
    [self.view addSubview:self.titleView];
    //添加contentview
    [self.view addSubview:self.contentView];
    
    
    
    //iOS7以后，导航控制器中，scrollview 顶部会添加64的额外滚动区域。
    self.automaticallyAdjustsScrollViewInsets = NO;
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
        [self.titleButtons addObject:btn];
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
    
    
   
}

/**
 标题按钮点击事件

 @param btn title
 */
- (void)titleViewBtnClick:(UIButton *)btn
{
    NSLog(@"1111=%li",btn.tag);
    NSInteger i = btn.tag;
    [self selButton:btn];
    //添加对应的子控制器
    [self setupOneViewController:i];
    //contentview滚动到对应的子控制器位置
//    self.contentView.contentOffset = CGPointMake(i*ScreenWidth, 0);
    //带有动画效果- -。
    [self.contentView setContentOffset:CGPointMake(i*ScreenWidth, 0) animated:YES];
}

/**
 设置选中按钮

 @param btn selectButton
 */
- (void)selButton:(UIButton *)btn
{
    //设置临时的button保存上一个选中的button按钮的颜色
    [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _selectButton = btn;
    //使选中的按钮居中
    [self setTitleCenter:btn];
}

/**
 设置标题居中显示

 @param btn 按钮
 */
- (void)setTitleCenter:(UIButton *)btn
{
    CGFloat offsetX = btn.center.x - ScreenWidth*0.5;
    NSLog(@"offsetx=%f",offsetX);
    //如果左边按钮偏移量小0 不移动
    if (offsetX < 0) {
        offsetX = 0;
    }
    //如果右边按钮偏移量大于最大偏移量不移动
    CGFloat maxOffsetX = self.titleView.contentSize.width - ScreenWidth;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    [self.titleView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
/**
 添加子控制器

 @param i 按钮tag
 */
- (void)setupOneViewController:(NSInteger)i
{
    UIViewController *vc = self.childViewControllers[i];
    //判断需要加载的子控制器是否加载完成，加载完成就不要加载了，ios9.0之前需要判断父控制器，ios9.0之后只需要判断
    //vc.viewIfLoaded 即可
    if (vc.view.superview) {
        return;
    }
    CGFloat vcY = CGRectGetMaxY(self.titleView.frame);
    vc.view.frame = CGRectMake(i *ScreenWidth, 0, ScreenWidth, ScreenHeight -vcY);
    [self.contentView addSubview:vc.view];
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
        _titleView.backgroundColor = [UIColor lightGrayColor];
    }
    return _titleView;
}
- (UIScrollView *)contentView
{
    if (_contentView == nil) {
        CGFloat y = CGRectGetMaxY(self.titleView.frame);
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y, ScreenWidth, ScreenHeight - y)];
        _contentView.backgroundColor = [UIColor lightGrayColor];
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.pagingEnabled = YES;
        _contentView.bounces = NO;
        _contentView.delegate = self;
    }
    return _contentView;
}
#pragma mark -----------------scrollview 代理方法
/**
 滚动完成的时候调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //获取当前角标
    NSInteger i = scrollView.contentOffset.x/ScreenWidth;
    
    //获取标题按钮
    UIButton *titleButton = self.titleButtons[i];
    
    //选中标题
    [self selButton:titleButton];
    
    //添加对应的子控制器
    [self setupOneViewController:i];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
