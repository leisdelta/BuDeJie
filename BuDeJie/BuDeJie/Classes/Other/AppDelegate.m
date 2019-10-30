//
//  AppDelegate.m
//  BuDeJie
//
//  Created by mushroom on 2019/9/3.
//  Copyright © 2019 xiaomage. All rights reserved.
//

#import "AppDelegate.h"
#import "XMGTabBarController.h"
#import "XMGAdViewController.h"
#import <AFNetworking.h>
#import <SDImageCache.h>
#import "SDDiskCache.h"

@interface AppDelegate ()

@end
/*
 项目架构(结构)搭建:主流结构(UITabBarController + 导航控制器)
 ->项目开发方式1.storyboard 2.纯代码
 */

//每次程序启动的时候进入广告界面
//1.在启动的时候,去加个广告界面
//2.启动完成的时候,加个广告界面(展示启动图片)
/*
 1.程序已启动就进入广告界面,窗口的根控制器设置为广告控制器
 2.直接往窗口上再加上一个广告界面,等几秒过去了,在去广告界面移除(这个方法比较繁琐)
 */
@implementation AppDelegate
//自定义类:1.可以管理自己的业务
//封装:谁的事情谁管理,方便我们以后去维护代码

//程序启动的时候就会调用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

   //1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //2.设置窗口根控制器
    XMGTabBarController *tabBarVc = [[XMGTabBarController alloc]init];
    // XMGAdViewController *adVc = [[XMGAdViewController alloc]init];
   // self.window.rootViewController =adVc;
    self.window.rootViewController =tabBarVc;
     //[UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;

    
    //3.显示窗口,1.成为UIApplication主窗口 2.
    [self.window makeKeyAndVisible];
    
    //4.开始监控网络状况
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    return YES;
    
    //5.每次启动程序,都清除过渡期的图片cleanDisk的方法在这个框架版本中不存在
   // [[SDImageCache sharedImageCache] clearMemory];

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
