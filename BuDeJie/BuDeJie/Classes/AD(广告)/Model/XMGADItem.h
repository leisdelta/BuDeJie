//
//  XMGADItem.h
//  BuDeJie
//
//  Created by mushroom on 2019/9/5.
//  Copyright © 2019 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMGADItem : NSObject
/** 广告地址 */
@property (nonatomic, strong) NSString *w_picurl;
/** 点击广告跳转的界面 */
@property (nonatomic, strong) NSString *ori_curl;

@property (nonatomic, assign) CGFloat w;

@property (nonatomic, assign) CGFloat h;


//定义一个构造方法和一个快速创建对象的类方法
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)modelWithDict:(NSDictionary *)dict;
@end



NS_ASSUME_NONNULL_END
