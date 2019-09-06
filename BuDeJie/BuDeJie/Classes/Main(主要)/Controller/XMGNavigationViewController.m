//
//  XMGNavigationViewController.m
//  BuDeJie
//
//  Created by mushroom on 2019/9/4.
//  Copyright © 2019 xiaomage. All rights reserved.
//

#import "XMGNavigationViewController.h"

@interface XMGNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation XMGNavigationViewController

+(void)load
{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    
    //只要是通过模型设置,都是通过富文本设置
    //设置导航条标题 =>UINavigationBar
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:attrs];
    //设置导航条的背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    
    [self.view addGestureRecognizer:pan];
    
    pan.delegate = self;
    //禁止之前的手势
    self.interactivePopGestureRecognizer.enabled = NO;

    //控制手势什么时候去触发
    //self.interactivePopGestureRecognizer.delegate = self;
    
}

#pragma mark --UIGestureRecognizerDelegate
//决定是否触发手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count > 1;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //NSLog(@"%s",__func__);
    XMGFunc;

    if(self.childViewControllers.count >0){//非根控制器
        //设置导航条左边按钮
        //恢复滑动返回功能->分析:把系统的返回按钮覆盖 ->1.手势失效(1.手势被清空 2.可能手势代理做了一些事情,导致手势失效)
        self.navigationItem.leftBarButtonItem =  [UIBarButtonItem backItemWithimage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(back) title:@"返回"];
        
    }
   
    //真正的跳转
    [super pushViewController:viewController animated:animated];
    
}

-(void)back
{
    [self popViewControllerAnimated:YES];
}
@end
