//
//  XMGTabBar.m
//  BuDeJie
//
//  Created by mushroom on 2019/9/4.
//  Copyright © 2019 xiaomage. All rights reserved.
//

#import "XMGTabBar.h"
#import "UIView+Frame.h"
@interface XMGTabBar()

/**tabBarItem的中间按钮懒加载一次*/
@property (nonatomic,weak) UIButton *plusButton;

@end
///Users/lei/Desktop/GitHub/BuDeJie/BuDeJie/BuDeJie/Classes/Other/BuDeJie.pch

@implementation XMGTabBar

-(UIButton *)plusButton
{
    if(!_plusButton){
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //设置尺寸才能显示
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        //根据按钮内容自适应
        [plusButton sizeToFit];
        
        
        _plusButton = plusButton;
        //因为是弱引用,避免销毁
        [self addSubview:plusButton];
    }
    return _plusButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.items.count +1;
    //CGFloat btnW =self.frame.size.width /count;
    CGFloat btnW =self.xmg_width /count;
    //CGFloat btnH = self.frame.size.height;
    CGFloat btnH = self.xmg_height;
    CGFloat btnX = 0;
    
    //布局tabBarButton
    //NSLog(@"%@",self.subviews);
    NSInteger i = 0;
    for(UIView *tabBarButton in self.subviews){
        if([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
          //  NSLog(@"%@",tabBarButton);
            if(i == 2){
                i+=1;
            }
            btnX = i * btnW;
            
            tabBarButton.frame = CGRectMake(btnX, 0, btnW, btnH);
            
            i++;
        }
    }
    
    //设置加号按钮center
    self.plusButton.center = CGPointMake(self.frame.size.width *0.5, self.frame.size.height * 0.5);
    
}

@end
