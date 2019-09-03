//
//  UIImage+Image.m
//  BuDeJie
//
//  Created by mushroom on 2019/9/3.
//  Copyright © 2019 xiaomage. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

+(UIImage *)imageOriginaWithName:(NSString *)imageName
{
    UIImage *image =[UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

@end
