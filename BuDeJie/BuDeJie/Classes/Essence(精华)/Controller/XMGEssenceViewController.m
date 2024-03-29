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
/*
 1.weak
 1>oc对象
 2.assign
 1>基本数据类型
 2>oc对象
 
 3.strong
 1>oc对象
 
 4.copy
 1>NSString *
 2>black
 
 5weak与assign的区别
 1>成员变量
 1)weak生成的成员变量是_weak修饰,
 2)assign生成的成员变量是_unsafe_unretained修饰
 2>_weak和_unsafe_unretained
 1)都不是抢指针(不是强引用),不能保住对象的命
 2)_weak:锁指向的对象销毁后,会自动变成nil指针(空指针)
 3)_unsafe_unretained:所指向的对象销毁后,仍旧指向已经销毁的这个对象(报错)
 
 */

#import "XMGEssenceViewController.h"
#import "XMGTitleButton.h"

#import "XMGAllViewController.h"
#import "XMGVideoViewController.h"
#import "XMGVoiceViewController.h"
#import "XMGPictureViewController.h"
#import "XMGWordViewController.h"

@interface XMGEssenceViewController () <UIScrollViewDelegate>
/** 用来存放所有子控制器view的scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 标题栏 */
@property (nonatomic, weak) UIView *titlesView;
/** 标题下划线 */
@property (nonatomic, weak) UIView *titleUnderline;
/** 上一次点击的标题按钮 */
@property (nonatomic, weak) XMGTitleButton *previousClickedTitleButton;
@end

@implementation XMGEssenceViewController
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化子控制器
    [self setupAllChildVcs];
    
    // 设置导航条
    [self setupNavBar];
    
    // scrollView
    [self setupScrollView];
    
    // 标题栏
    [self setupTitlesView];
    
    // 添加第0个子控制器的view
    [self addChildVcViewIntoScrollView:0];
}

/**
 *  初始化子控制器
 */
- (void)setupAllChildVcs
{
    [self addChildViewController:[[XMGAllViewController alloc] init]];
    [self addChildViewController:[[XMGVideoViewController alloc] init]];
    [self addChildViewController:[[XMGVoiceViewController alloc] init]];
    [self addChildViewController:[[XMGPictureViewController alloc] init]];
    [self addChildViewController:[[XMGWordViewController alloc] init]];
}

/**
 *  设置导航条
 */
- (void)setupNavBar
{
    // 左边按钮
    // 把UIButton包装成UIBarButtonItem.就导致按钮点击区域扩大
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
    
    // titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

/**
 *  scrollView
 */
- (void)setupScrollView
{
    // 不允许自动修改UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.scrollsToTop = NO; // 点击状态栏的时候，这个scrollView不会滚动到最顶部
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 添加子控制器的view
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = scrollView.xmg_width;
    scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
}

/**
 *  标题栏
 */
- (void)setupTitlesView
{
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    //titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    //titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    titlesView.frame = CGRectMake(0, 64, self.view.xmg_width, 35);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 标题栏按钮
    [self setupTitleButtons];
    
    // 标题下划线
    [self setupTitleUnderline];
}

/**
 *  标题栏按钮
 */
- (void)setupTitleButtons
{
    // 文字
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    
    // 标题按钮的尺寸
    CGFloat titleButtonW = self.titlesView.xmg_width / count;
    CGFloat titleButtonH = self.titlesView.xmg_height;
    
    // 创建5个标题按钮
    for (NSUInteger i = 0; i < count; i++) {
        XMGTitleButton *titleButton = [[XMGTitleButton alloc] init];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:titleButton];
        // frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        // 文字
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
    }
}

/**
 *  标题下划线
 */
- (void)setupTitleUnderline
{
    // 标题按钮
    XMGTitleButton *firstTitleButton = self.titlesView.subviews.firstObject;
    
    // 下划线
    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.xmg_height = 2;
    titleUnderline.xmg_y = self.titlesView.xmg_height - titleUnderline.xmg_height;
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderline];
    self.titleUnderline = titleUnderline;
    
    // 切换按钮状态
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
    
    [firstTitleButton.titleLabel sizeToFit]; // 让label根据文字内容计算尺寸
    self.titleUnderline.xmg_width = firstTitleButton.titleLabel.xmg_width + 10;
    self.titleUnderline.xmg_centerX = firstTitleButton.xmg_centerX;
}

#pragma mark - 监听
/**
 *  点击标题按钮
 */
- (IBAction)titleButtonClick:(XMGTitleButton *)titleButton
{
    // 重复点击了标题按钮
    if (self.previousClickedTitleButton == titleButton) {
        [[NSNotificationCenter defaultCenter] postNotificationName:XMGTitleButtonDidRepeatClickNotification object:nil];
    }
    
    //处理标题按钮点击
    [self dealTitleButtonClick:titleButton];
    
   
}
//处理标题按钮点击
-(void)dealTitleButtonClick:(XMGTitleButton *)titleButton{
    // 切换按钮状态
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    
    NSUInteger index = titleButton.tag;
    [UIView animateWithDuration:0.25 animations:^{
        // 处理下划线
        self.titleUnderline.xmg_width = titleButton.titleLabel.xmg_width + 10;
        self.titleUnderline.xmg_centerX = titleButton.xmg_centerX;
        
        // 滚动scrollView
        CGFloat offsetX = self.scrollView.xmg_width * index;
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        // 添加子控制器的view
        [self addChildVcViewIntoScrollView:index];
    }];
    
    // 设置index位置对应的tableView.scrollsToTop = YES， 其他都设置为NO
    for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *childVc = self.childViewControllers[i];
        // 如果view还没有被创建，就不用去处理
        if (!childVc.isViewLoaded) continue;
        
        UIScrollView *scrollView = (UIScrollView *)childVc.view;
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        
        //        if (i == index) { // 是标题按钮对应的子控制器
        //            scrollView.scrollsToTop = YES;
        //        } else {
        //            scrollView.scrollsToTop = NO;
        //        }
        scrollView.scrollsToTop = (i == index);
    }
}



- (void)game
{
    XMGFunc
}

#pragma mark - <UIScrollViewDelegate>
/**
 *  当用户松开scrollView并且滑动结束时调用这个代理方法（scrollView停止滚动的时候）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 求出标题按钮的索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.xmg_width;
    
    // 点击对应的标题按钮
    XMGTitleButton *titleButton = self.titlesView.subviews[index];
    [self dealTitleButtonClick:titleButton];
}

#pragma mark - 其他
/**
 *  添加第index个子控制器的view到scrollView中
 */
- (void)addChildVcViewIntoScrollView:(NSUInteger)index
{
    UIViewController *childVc = self.childViewControllers[index];
    
    // 如果view已经被加载过，就直接返回
    if (childVc.isViewLoaded) return;
    
    // 取出index位置对应的子控制器view
    UIView *childVcView = childVc.view;
    
    // 设置子控制器view的frame
    CGFloat scrollViewW = self.scrollView.xmg_width;
    childVcView.frame = CGRectMake(index * scrollViewW, 0, scrollViewW, self.scrollView.xmg_height);
    // 添加子控制器的view到scrollView中
    [self.scrollView addSubview:childVcView];
}
@end
