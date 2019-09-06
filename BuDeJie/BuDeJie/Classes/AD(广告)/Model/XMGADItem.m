//
//  XMGADItem.m
//  BuDeJie
//
//  Created by mushroom on 2019/9/5.
//  Copyright © 2019 xiaomage. All rights reserved.
//

#import "XMGADItem.h"

@implementation XMGADItem

//重写构造方法 此方法是固定的
-(instancetype)initWithDict:(NSDictionary *)dict{
    
    /*
     //@property (nonatomic, strong) NSString *w_picurl;
    
    //@property (nonatomic, strong) NSString *ori_curl;
    
    //@property (nonatomic, assign) CGFloat w;
    
    //@property (nonatomic, assign) CGFloat h;
     
     */
    
    if (self = [super init]) {
        self.w_picurl = dict[@"w_picurl"];
        self.ori_curl = dict[@"ori_curl"];
        self.w = [dict[@"w"] floatValue];
        self.h = [dict[@"h"] floatValue];
    }
    return self;
}
//提供一个类时,最好提供一个类方法(即静态方法),调用构造方法快速创建类对象
+(instancetype)modelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@ %@",self.w_picurl,self.ori_curl];
}

@end
