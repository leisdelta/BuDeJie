//
//  XMGLoginRegisterViewController.m
//  BuDeJie
//
//  Created by mushroom on 2019/9/7.
//  Copyright © 2019 xiaomage. All rights reserved.
//

#import "XMGLoginRegisterViewController.h"
#import "XMGLoginRegisterView.h"
#import "XMGFastLoginView.h"

@interface XMGLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCons;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation XMGLoginRegisterViewController
//关闭
- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//注册
- (IBAction)clickRegister:(UIButton *)sender {
    sender.selected =!sender.selected;
    
    //平移中间的view
    _leadCons.constant = _leadCons.constant == 0? -self.middleView.xmg_width * 0.5:0;
   
    //切换做特效
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

//划分结构(顶部,中间,底部)//2.一个结构一个结构
//越复杂的界面越要封装(复用)


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     屏幕适配必须考虑
     1.一个view从xib加载,需不需要再重新固定尺寸,一定要再重新设置一下
     2.在viewDidload好不好
     
     */
    
    //添加到中间的view
    //创建登录view
    XMGLoginRegisterView *loginView = [XMGLoginRegisterView loginView];
    //适配不同屏幕的尺寸
    //loginView.frame = CGRectMake(0, 0, self.middleView.xmg_width * 0.5, self.middleView.xmg_height * 0.5);
    //t添加中间view
    [self.middleView addSubview:loginView];
    
    //添加注册页面
    XMGLoginRegisterView *registerView = [XMGLoginRegisterView registerView];
    //registerView.isLogin = NO;
   // registerView.frame = CGRectMake(0, 0, self.middleView.xmg_width * 0.5, self.middleView.xmg_height * 0.5);
     registerView.xmg_x = self.middleView.xmg_width*0.5;
     [self.middleView addSubview:registerView];
    //添加底部的view
    XMGFastLoginView *fastView = [XMGFastLoginView fastLoginView];
    [self.bottomView addSubview:fastView];
    
    
}


//viewDidLayoutSubviews:才会根据布局调整控件的尺寸
-(void)viewDidLayoutSubviews
{
    //一定要调用super
    [super viewDidLayoutSubviews];
    
    XMGLoginRegisterView *loginView = self.middleView.subviews[0];
    //适配不同屏幕的尺寸
    loginView.frame = CGRectMake(0, 0, self.middleView.xmg_width * 0.5, self.middleView.xmg_height * 0.5);
    
    XMGLoginRegisterView *registerView = self.middleView.subviews[1];
    //registerView.isLogin = NO;
    registerView.frame = CGRectMake(0, 0, self.middleView.xmg_width * 0.5, self.middleView.xmg_height * 0.5);
    registerView.xmg_x = self.middleView.xmg_width*0.5;
    
    //添加底部的view
    // 设置快速登录
    XMGFastLoginView *fastLoginView = self.bottomView.subviews.firstObject;
    fastLoginView.frame = self.bottomView.bounds;
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
