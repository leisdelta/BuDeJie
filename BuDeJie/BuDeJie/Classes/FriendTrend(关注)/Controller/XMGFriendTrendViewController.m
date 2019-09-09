//
//  XMGFriendTrendViewController.m
//  BuDeJie
//
//  Created by mushroom on 2019/9/3.
//  Copyright © 2019 xiaomage. All rights reserved.
//

#import "XMGFriendTrendViewController.h"
#import "XMGLoginRegisterViewController.h"

@interface XMGFriendTrendViewController ()

@end

@implementation XMGFriendTrendViewController
//点击登录注册就会调用
- (IBAction)clickLoginRegister:(id)sender {
    //进入得到登录注册界面
    XMGLoginRegisterViewController *loginVc = [[XMGLoginRegisterViewController alloc] init];
    
    [self presentViewController:loginVc animated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
}


-(void)setupNavBar
{
    //左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsRecomment)];
    
    //右边按钮
    //self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:@selector(game)];
    
    //titleView
   // self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.title =@"我的关注";
    
}
//推荐关注
-(void)friendsRecomment
{
    
}

@end
