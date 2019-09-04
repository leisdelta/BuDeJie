//
//  XMGEssenceViewController.m
//  BuDeJie
//
//  Created by mushroom on 2019/9/3.
//  Copyright © 2019 xiaomage. All rights reserved.
//

#import "XMGEssenceViewController.h"
//UIBarButtonItem:描述按钮具体的内容
//UINavigationItem:设置导航条上内容(左边,右边,中间)
//tabBarItem:设置tabBar上按钮内容(tabBarItem)
@interface XMGEssenceViewController ()

@end

@implementation XMGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
   
    //设置导航条
    [self setupNavBar];
}

//设置导航条
-(void)setupNavBar
{
    //左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    
    //右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:@selector(game)];
    
    //titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setImage:[UIImage imageNamed:@"nav_item_game_icon"] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"nav_item_game_click_icon"] forState:UIControlStateHighlighted];
//    //避免点击范围过大,旧版本这样设计可能还不能满足
//    [btn sizeToFit];
//
//    //点击按钮触发事件
//    [btn addTarget:self action:@selector(game) forControlEvents:UIControlEventTouchUpInside];
//
//    //把button包装成一个uiview然后缩小范围
//    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
//    [containView addSubview:btn];
//    UIBarButtonItem *leftItem  = [[UIBarButtonItem alloc]initWithCustomView:containView];
    
    //self.navigationItem.leftBarButtonItem =leftItem;
    
}

#pragma mark --左边按钮点击事件
-(void)game
{
    XMGFunc;
}

@end
