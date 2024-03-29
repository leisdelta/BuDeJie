//
//  UIImageView+Download.h
//  BuDeJie
//
//  Created by xiaomage on 16/3/26.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>
#import "SDWebImageManager.h"
//#import "UIImageView+WebCache.h" SDWebImageCompletionBlock
@interface UIImageView (Download)
- (void)xmg_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder completed:(SDExternalCompletionBlock)completedBlock;

- (void)xmg_setHeader:(NSString *)headerUrl;
@end
