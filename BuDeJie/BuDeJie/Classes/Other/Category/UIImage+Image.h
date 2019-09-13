//
//  UIImage+Image.h
//  BuDeJie
//
//  Created by mushroom on 2019/9/3.
//  Copyright © 2019 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Image)
+(UIImage *)imageOriginaWithName:(NSString *)imageName;

- (instancetype)xmg_circleImage;

+ (instancetype)xmg_circleImageNamed:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
