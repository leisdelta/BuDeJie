//
//  UIView+Frame.h
//  BuDeJie
//
//  Created by mushroom on 2019/9/4.
//  Copyright © 2019 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/*
 写分类:避免跟其他开发者产生冲突
 */
@interface UIView (Frame)

@property CGFloat xmg_width;
@property CGFloat xmg_height;
@property CGFloat xmg_x;
@property CGFloat xmg_y;
@property CGFloat xmg_centerX;
@property CGFloat xmg_centerY;
@end

NS_ASSUME_NONNULL_END
