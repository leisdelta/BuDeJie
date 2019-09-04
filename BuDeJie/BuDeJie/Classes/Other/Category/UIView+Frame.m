//
//  UIView+Frame.m
//  BuDeJie
//
//  Created by mushroom on 2019/9/4.
//  Copyright © 2019 xiaomage. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

-(void)setXmg_height:(CGFloat)xmg_height
{
    CGRect rect = self.frame;
    rect.size.height =xmg_height;
    self.frame = rect;
}
-(CGFloat)xmg_height
{
    return self.frame.size.height;
}




-(void)setXmg_width:(CGFloat)xmg_width
{
    CGRect rect = self.frame;
    rect.size.width =xmg_width;
    self.frame = rect;
}
-(CGFloat)xmg_width
{
    return self.frame.size.width;
}




-(void)setXmg_x:(CGFloat)xmg_x
{
    CGRect rect = self.frame;
    rect.origin.x =xmg_x;
    self.frame = rect;
}
-(CGFloat)xmg_x
{
    return self.frame.origin.x;
}

-(void)setXmg_y:(CGFloat)xmg_y
{
    CGRect rect = self.frame;
    rect.origin.y = xmg_y;
    self.frame = rect;
}
-(CGFloat)xmg_y
{
    return self.frame.origin.y;
}



@end
