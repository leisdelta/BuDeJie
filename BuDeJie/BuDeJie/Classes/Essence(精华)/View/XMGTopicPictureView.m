//
//  XMGTopicPictureView.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/24.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTopicPictureView.h"
#import "XMGTopic.h"
#import <UIImageView+WebCache.h>
#import "XMGSeeBigPictureViewController.h"

@interface XMGTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;
@end

@implementation XMGTopicPictureView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 控制按钮内部的子控件对齐，不是用contentMode，是用以下2个属性
//    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    
    // 控件按钮内部子控件之间的间距
//    btn.contentEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
//    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
}

/*
 查看大图
 */
-(void)seeBigPicture
{
    XMGSeeBigPictureViewController *vc = [[XMGSeeBigPictureViewController alloc] init];
    vc.topic = self.topic;
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
   // [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}


-(void)setTopic:(XMGTopic *)topic
{
    _topic = topic;
    
    // 占位图片
    UIImage *placeholder = nil;
    
    //网络加载图片
    // 设置图片
    self.placeholderView.hidden = NO;
    [self.imageView  xmg_setOriginImage:topic.image1 thumbnailImage:topic.image0 placeholder:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return;
        self.placeholderView.hidden = YES;
        
        // 处理超长图片的大小
        if (topic.isBigPicture) {
            CGFloat imageW = topic.middleFrame.size.width;
            CGFloat imageH = imageW * topic.height / topic.width;
            
            // 开启上下文
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            // 绘制图片到上下文中
            [self.imageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            // 关闭上下文
            UIGraphicsEndImageContext();
        }
    }];
    
    // gif
    self.gifView.hidden = !topic.is_gif;
    // http://ww2.sinaimg.cn/bmiddle/005yUFpDjw1f297c6vgzig306y04rnpd.GIF
    //    if ([topic.image1.lowercaseString hasSuffix:@"gif"]) {
    //    if ([topic.image1.pathExtension.lowercaseString isEqualToString:@"gif"]) {
    //        self.gifView.hidden = NO;
    //    } else {
    //        self.gifView.hidden = YES;
    //    }
    
    
    // 点击查看大图
    NSLog(@"打印是否是大图的判断条件 %d -------%@",topic.bigPicture,topic.image1);
    if (topic.isBigPicture) { // 超长图
        self.seeBigPictureButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
        
      
    } else {
        self.seeBigPictureButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
        
    }
}
@end
