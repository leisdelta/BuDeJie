//
//  XMGNewViewController.m
//  BuDeJie
//
//  Created by mushroom on 2019/9/3.
//  Copyright © 2019 xiaomage. All rights reserved.
//

#import "XMGNewViewController.h"

@interface XMGNewViewController ()

@end

@implementation XMGNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    [self setupNavBar];
}

//设置导航条
-(void)setupNavBar
{
    //左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(tagClick)];
    
    //右边按钮
    //self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:@selector(game)];
    
    //titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];

    
}

#pragma mark --左边按钮点击事件
-(void)tagClick
{
    XMGFunc;
    //进入推荐标签界面
    self.navigationController pushViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>
    
}

@end
