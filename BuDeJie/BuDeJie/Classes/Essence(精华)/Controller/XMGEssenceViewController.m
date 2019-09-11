//
//  XMGEssenceViewController.m
//  BuDeJie
//
//  Created by mushroom on 2019/9/3.
//  Copyright © 2019 xiaomage. All rights reserved.
//
/*
 一、按钮的状态
 1.UIControlStateNormal
 1> 除开UIControlStateHighlighted、UIControlStateDisabled、UIControlStateSelected以外的其他情况，都是normal状态
 2> 这种状态下的按钮【可以】接收点击事件
 
 2.UIControlStateHighlighted
 1> 【当按住按钮不松开】或者【highlighted = YES】时就能达到这种状态
 2> 这种状态下的按钮【可以】接收点击事件
 
 3.UIControlStateDisabled
 1> 【button.enabled = NO】时就能达到这种状态
 2> 这种状态下的按钮【无法】接收点击事件
 
 4.UIControlStateSelected
 1> 【button.selected = YES】时就能达到这种状态
 2> 这种状态下的按钮【可以】接收点击事件
 
 二、让按钮无法点击的2种方法
 1> button.enabled = NO;
 *【会】进入UIControlStateDisabled状态
 
 2> button.userInteractionEnabled = NO;
 *【不会】进入UIControlStateDisabled状态，继续保持当前状态
 
 */
#import "XMGEssenceViewController.h"
#import "XMGTitleButton.h"

#import "XMGAllViewController.h"
#import "XMGVideoViewController.h"
#import "XMGVoiceViewController.h"
#import "XMGPictureViewController.h"
#import "XMGWordViewController.h"

#define XMGRandomColor XMGColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))


//UIBarButtonItem:描述按钮具体的内容
//UINavigationItem:设置导航条上内容(左边,右边,中间)
//tabBarItem:设置tabBar上按钮内容(tabBarItem)
@interface XMGEssenceViewController ()<UIScrollViewDelegate>

/**scrollView*/
@property (nonatomic,weak) UIScrollView *scrollView;
/**titleView属性*/
@property (nonatomic,weak) UIView *titleView;

/**下划线属性*/
@property (nonatomic,weak) UIView *titleUnderline;

/**记录上一次点击的标题按钮*/
@property (nonatomic,weak) UIButton *previousClickedTitleButton;
@end
/*
 UIControlStateNormal       = 0,
 UIControlStateHighlighted  = 1 << 0,                  // used when UIControl isHighlighted is set
 UIControlStateDisabled     = 1 << 1,
 UIControlStateSelected     = 1 << 2,
 */


@implementation XMGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor redColor];
    
    //所有控制器要放置在前面
    [self setuupAllChildVcs];
    
    //设置导航条
    [self setupNavBar];
    
    //设置scrollView
    [self setupScrollView];
    //标题栏
    [self setupTitlesView];
    
    
}
-(void)setuupAllChildVcs
{
    [self addChildViewController:[[XMGAllViewController alloc]init]];
    [self addChildViewController:[[XMGVideoViewController alloc]init]];
    [self addChildViewController:[[XMGVoiceViewController alloc]init]];
    [self addChildViewController:[[XMGPictureViewController alloc]init]];
    [self addChildViewController:[[XMGWordViewController alloc]init]];
}

//设置滚动栏
- (void)setupScrollView
{
    
    
    CGFloat w = UIScreen.mainScreen.bounds.size.width;
    CGFloat h = UIScreen.mainScreen.bounds.size.height;
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, w, 1);
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    // 不允许自动修改UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    //self.extendedLayoutIncludesOpaqueBars = YES;
  
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.frame = CGRectMake(0, 1, w, h-1);
//    if (@available(iOS 11.0, *)) {
//        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    //scrollView.showsHorizontalScrollIndicator = NO;
   // scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    self.scrollView =scrollView;
    
    // 添加子控制器的view
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = scrollView.xmg_width;
    CGFloat scrollViewH = scrollView.xmg_height;
    
    for (NSUInteger i = 0; i < count; i++) {
        
        //UIView *view = [UIView new];
        //view.frame = CGRectMake(0, 0, w, 1);
       // view.backgroundColor = [UIColor redColor];
        [self.view addSubview:view];
        scrollView.frame = CGRectMake(0, 1, w, h-1);
        
        // 取出i位置子控制器的view
        UIView *childVcView = self.childViewControllers[i].view;
        childVcView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
        [scrollView addSubview:childVcView];
    }
    
    scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
    scrollView.delegate = self;
}
#pragma mark -减速为零的时候调用
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    if(!decelerate){
//        //这里复制scrollViewDidEndDecelerating里的代码
//    }
//}

/**
 *  当用户松开scrollView并且滑动结束时调用这个代理方法（scrollView停止滚动的时候）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 求出标题按钮的索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.xmg_width;
    // index == [0, 4]
    
    // 点击对应的标题按钮
    XMGTitleButton *titleButton = self.titleView.subviews[index];
    //    XMGTitleButton *titleButton = [self.titlesView viewWithTag:index];
    [self titleButtonClick:titleButton];
}

//设置标题栏
-(void)setupTitlesView
{
    UIView *titleView = [[UIView alloc] init];
    //设置半透明颜色背景
    titleView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    titleView.frame = CGRectMake(0, 64, self.view.xmg_width, 35);
    [self.view addSubview:titleView];
    self.titleView = titleView;
    //标题栏按钮
    [self setupTitleButtons];
    //标题栏下划线
    [self setupTitleUnderline];
}
//标题栏按钮
-(void)setupTitleButtons{
    
    //按钮文字
    NSArray *titles =@[@"全部",@"视频",@"声音",@"图片",@"段子"];
    
    NSInteger count = titles.count;
    
    CGFloat titleButtonW = self.titleView.xmg_width /count;
    CGFloat titleButtonH = self.titleView.xmg_height;
    
    for(NSInteger i = 0;i < count; i++){
        
        UIButton *titleButton = [[UIButton alloc] init];
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:titleButton];
        titleButton.tag = i;
        
        //frame
        titleButton.frame =CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        //背景色
        titleButton.backgroundColor = XMGRandomColor;
        
        //添加文字
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
    }
}
//监听按钮
-(void)titleButtonClick:(UIButton *)titleButton
{
   // XMGFunc;
    //还原上一次点击的按钮颜色
//    [_previousClickedTitleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//
//    //添加本次的按钮颜色
//    [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//
//    _previousClickedTitleButton = titleButton;
    
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    
    //下划线的调用
    [UIView animateWithDuration:0.25 animations:^{
        //下划线加载
        //算出字体的长度来调整下划线的长度
      // self.titleUnderline.xmg_width = [titleButton.currentTitle sizeWithFont:titleButton.titleLabel.font].width;
        
        self.titleUnderline.xmg_width = [titleButton.currentTitle sizeWithAttributes:@{NSFontAttributeName:titleButton.titleLabel.font}].width;
        self.titleUnderline.xmg_centerX = titleButton.xmg_centerX;
        
        //滚动scrollView设置偏移量
        CGFloat offsetX = self.scrollView.xmg_width *titleButton.tag;
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    }];
}


//标题栏下划线
-(void)setupTitleUnderline
{
    //创建下划线背景图
    XMGTitleButton *firstTitleButton = self.titleView.subviews.firstObject;
    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.xmg_height = 2;
    titleUnderline.xmg_y = self.titleView.xmg_height - titleUnderline.xmg_height;
    //titleUnderline.xmg_width = firstTitleButton.xmg_width;
   // titleUnderline.xmg_width = [firstTitleButton.currentTitle sizeWithFont:firstTitleButton.titleLabel.font].width;
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [self.titleView addSubview:titleUnderline];
    
    //把下划线装载到属性中
    self.titleUnderline = titleUnderline;
    
    //默认点击最前面的按钮
    [firstTitleButton.titleLabel sizeToFit];//label根据文字内容计算尺寸
    [self titleButtonClick:firstTitleButton];
    
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
