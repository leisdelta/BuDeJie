//
//  XMGTabBarController.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTabBarController.h"
#import "XMGEssenceViewController.h"
#import "XMGFriendTrendViewController.h"
#import "XMGMeViewController.h"
#import "XMGNewViewController.h"
#import "XMGPublishViewController.h"
#import "UIImage+Image.h"
#import "XMGTabBar.h"


@interface XMGTabBarController ()

@end

@implementation XMGTabBarController

// 只会调用一次
+ (void)load
{
    // 获取哪个类中UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    // 设置按钮选中标题的颜色:富文本:描述一个文字颜色,字体,阴影,空心,图文混排
    // 创建一个描述文本属性的字典
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    // 设置字体尺寸:只有设置正常状态下,才会有效果
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
}
//注意:可能会调用多次
//+(void)initialize
//{
//    if(self ==[XMGTabBarController class])
//    {
//
//    }
//}

/*
 1.选中的图片被渲染
 2.选中的标题颜色:黑色 标题字体变大
 3.发布按钮显示不出来
 */

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    // 2.1 添加子控制器(5个子控制器) -> 自定义控制器 -> 划分项目文件结构
    [self setupAllChildViewController];
    
    // 2.2 设置tabBar上按钮内容 -> 由对应的子控制器的tabBarItem属性
    [self setupAllTitleButton];
    
    //2.3自定义tabBar
    [self setupTabBar];
    
   // XMGLog(@"打印");
    
    //1.问题:选中图片被渲染:解决:1.直接操作图片 2.通过代码
    //2.选中文字颜色也不需要渲染 分析:1.按钮由谁决定 tabBarItem
    
    //3.发布按钮显示不出来,位置也不对,分析:1.有没有文字,图片的位置都固定 2.加号的图片比其他图片大因此就会超出tabBar 3.不想要超出,让加号的图片垂直居中 => 修改加号按钮位置 =>tabBar上按钮位置由系统决定,我们自己不能决定 => 系统的tabBarButton没有提供高亮图片状态,因此做不了实例程序效果 => 加号,应该是普通按钮,高亮
    //4.最终方法:调整系统TabBar上按钮位置,平均分成5等分,再把加号按钮显示在中间就好了
    
    
    
}

/*
 自定义TabBar
 */
-(void)setupTabBar
{
    XMGTabBar *tabBar = [[XMGTabBar alloc] init];
    
    [self setValue:tabBar forKey:@"tabBar"];
}

/*
 1.改插件-> 如何去查找插件->插件开发知识->插件代码肯定有个地方指定安装在什么地方
 */

#warning TODO:  NOONNOONONOONO
#pragma mark - 添加所有子控制器
- (void)setupAllChildViewController
{
    // 精华
    XMGEssenceViewController *essenceVc = [[XMGEssenceViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:essenceVc];
    // initWithRootViewController:push
    
    // tabBarVc:会把第0个子控制器的view添加去
    [self addChildViewController:nav];
    
    // 新帖
    XMGNewViewController *newVc = [[XMGNewViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:newVc];
    // tabBarVc:会把第0个子控制器的view添加去
    [self addChildViewController:nav1];
    
    // 发布
//    XMGPublishViewController *publishVc = [[XMGPublishViewController alloc] init];
//    // tabBarVc:会把第0个子控制器的view添加去
//    [self addChildViewController:publishVc];
    
    // 关注
    XMGFriendTrendViewController *ftVc = [[XMGFriendTrendViewController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:ftVc];
    // initWithRootViewController:push
    
    // tabBarVc:会把第0个子控制器的view添加去
    [self addChildViewController:nav3];
    
    // 我
    XMGMeViewController *meVc = [[XMGMeViewController alloc] init];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:meVc];
    // initWithRootViewController:push
    
    // tabBarVc:会把第0个子控制器的view添加去
    [self addChildViewController:nav4];

}

// 设置tabBar上所有按钮内容
- (void)setupAllTitleButton
{
    // 0:nav
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"精华";
    nav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    //快速生成一个没有渲染图片
    nav.tabBarItem.selectedImage = [UIImage imageOriginaWithName:@"tabBar_essence_click_icon"];

   // nav.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    
    // 1:新帖
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"新帖";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
   // nav1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginaWithName:@"tabBar_new_click_icon"];
    
    // 2:发布
//    XMGPublishViewController *publishVc = self.childViewControllers[2];
//    publishVc.tabBarItem.image = [UIImage imageNamed:@"tabBar_publish_icon"];
//    //publishVc.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_publish_click_icon"];
//    publishVc.tabBarItem.selectedImage = [UIImage imageOriginaWithName:@"tabBar_publish_click_icon"];
    
    // 3.关注
    UINavigationController *nav3 = self.childViewControllers[2];
    nav3.tabBarItem.title = @"关注";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    //nav3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageOriginaWithName:@"tabBar_friendTrends_icon"];
    
    // 4.我
    UINavigationController *nav4 = self.childViewControllers[3];
    nav4.tabBarItem.title = @"我";
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    //nav4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    nav4.tabBarItem.selectedImage = [UIImage imageOriginaWithName:@"tabBar_me_click_icon"];
    

    

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
