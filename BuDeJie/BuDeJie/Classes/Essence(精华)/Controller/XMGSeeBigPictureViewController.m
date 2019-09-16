//
//  XMGSeeBigPictureViewController.m
//  BuDeJie
//
//  Created by mushroom on 2019/9/15.
//  Copyright © 2019 xiaomage. All rights reserved.
//

#import "XMGSeeBigPictureViewController.h"

@interface XMGSeeBigPictureViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

/**imageView*/
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UIImageView *imageView;
@end
@implementation XMGSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //scrollview
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    //由于父控件刚加载是600*600,所以scrollView不能覆盖整个手机屏幕,为了跟父控件一起变形
    //scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //另一种方法一开始就设置为屏幕的宽高
    scrollView.frame = [UIScreen mainScreen].bounds;
    //点击scrollView触发手势返回功能
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    
    scrollView.backgroundColor = [UIColor redColor];
    [self.view insertSubview:scrollView atIndex:0];
    self.scrollView = scrollView;
    
    //imageView
    UIImageView  *imageView = [[UIImageView alloc] init];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if(!image)return;
        self.saveButton.enabled = YES;
        
    }];
    imageView.xmg_width = scrollView.xmg_width;
    imageView.xmg_height =imageView.xmg_width * self.topic.height/self.topic.width;
    imageView.xmg_x = 0;
    if(imageView.xmg_height >XMGScreenH){//超过一个屏幕
        imageView.xmg_y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.xmg_height);
    }else{
        imageView.xmg_centerY = scrollView.xmg_height * 0.5;
    }
    self.imageView = imageView;
    [scrollView addSubview:imageView];
    
    //图片缩放
    CGFloat maxScale = self.topic.width /imageView.xmg_width;
    if(maxScale > 1){
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }
    
}
#pragma mark - <uiscrollViewDelegate>代理方法
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

#pragma mark - 监听点击
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save {
    
}

@end
