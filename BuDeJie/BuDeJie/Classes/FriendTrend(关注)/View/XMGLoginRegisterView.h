//
//  XMGLoginRegisterView.h
//  BuDeJie
//
//  Created by mushroom on 2019/9/7.
//  Copyright © 2019 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMGLoginRegisterView : UIView
+(instancetype)loginView;
+(instancetype)registerView;
/**布尔类型判断是否注册页面*/
@property (nonatomic, assign) BOOL  isLogin;
@end

NS_ASSUME_NONNULL_END
