//
//  XMGSubTagCell.m
//  BuDeJie
//
//  Created by mushroom on 2019/9/6.
//  Copyright © 2019 xiaomage. All rights reserved.
//

#import "XMGSubTagCell.h"
#import "XMGSubTagItem.h"
#import <UIImageView+WebCache.h>
#import "UIImage+Antialias.h"

@interface XMGSubTagCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;


@property (weak, nonatomic) IBOutlet UILabel *nameView;

@property (weak, nonatomic) IBOutlet UILabel *numView;


@end

@implementation XMGSubTagCell
/*
 头像变成圆角:1.设置头像圆角 2.裁剪图片(生成新的图片->图形上下文才能够生成新的图片)
 处理数字
 */
-(void)setItem:(XMGSubTagItem *)item
{
    _item =item;
    //设置内容
    _nameView.text = item.theme_name;
    
    //判断下有没有>10000
    [self resolveNum];
    
    
    //对获取的图片进行裁剪的方法
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:SDWebImageQueryMemoryData completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //1.开启图形上下文
        //比例因素:当前点与像素比例0自适应
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        //2.描述裁剪区域
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        //3.设置裁剪区域
        [path addClip];
        //4.画图片
        [image drawAtPoint:CGPointZero];
        //5.取出图片
        image  = UIGraphicsGetImageFromCurrentImageContext();
        //6.关闭上下文
        UIGraphicsEndImageContext();
        //后面的方法是自定义消除锯齿效果
        _iconView.image = [image imageAntialias];
    }];
}
//处理订阅数据
-(void)resolveNum
{
    
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅",_item.sub_number ];
    NSInteger num =_item.sub_number.integerValue;
    if(num >10000){
        CGFloat numF = num/10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅",numF];
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    _numView.text = numStr;
    
}

//从xib加载就会只调用一次
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //设置头像圆角
//    _iconView.layer.cornerRadius=30;
//    _iconView.layer.masksToBounds = YES;
    
    
    //清空tableView分割线内边距 清空cell的约束边缘
    //_tableView.separatorInset = UIEdgeInsetsZero;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
