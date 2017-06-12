//
//  MMViewController.m
//  0531_网易新闻
//
//  Created by mumu on 2017/6/12.
//  Copyright © 2017年 mumu. All rights reserved.
//

#import "MMViewController.h"
#import "TouTiaoViewController.h"
#import "ReDianViewController.h"
#import "ShiPinViewController.h"
#import "SheHuiViewController.h"
#import "DingYueViewController.h"
#import "KeJiViewController.h"

@interface MMViewController ()

@end

@implementation MMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子控制器
    [self addChildVC];
    // Do any additional setup after loading the view.
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
