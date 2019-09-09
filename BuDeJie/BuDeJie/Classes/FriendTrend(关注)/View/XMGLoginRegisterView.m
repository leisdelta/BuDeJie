//
//  XMGLoginRegisterView.m
//  BuDeJie
//
//  Created by mushroom on 2019/9/7.
//  Copyright © 2019 xiaomage. All rights reserved.
//

#import "XMGLoginRegisterView.h"
@interface XMGLoginRegisterView()
@property (weak, nonatomic) IBOutlet UIButton *loginRegisterButton;

@end

@implementation XMGLoginRegisterView

//-(void)setIsLogin:(BOOL)isLogin
//{
//    if(_isLogin == NO){
//        //修改登录按钮的字体,修改占位符
//        
//        //隐藏忘记密码按钮
//    }
//}

+(instancetype)loginView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+(instancetype)registerView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    UIImage *image = _loginRegisterButton.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    
    //让按钮背景图片不要被拉伸
    [_loginRegisterButton setBackgroundImage:image forState:UIControlStateNormal];
}

@end
