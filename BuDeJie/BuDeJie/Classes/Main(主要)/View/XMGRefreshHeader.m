//
//  XMGRefreshHeader.m
//  BuDeJie
//
//  Created by mushroom on 2019/9/17.
//  Copyright © 2019 xiaomage. All rights reserved.
//

#import "XMGRefreshHeader.h"

@implementation XMGRefreshHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置状态文字颜色
        self.stateLabel.textColor = [UIColor blueColor];
        self.stateLabel.font = [UIFont systemFontOfSize:17];
        [self setTitle:@"赶紧下拉刷新" forState:MJRefreshStateIdle];
        [self setTitle:@"松开🐴上刷新" forState:MJRefreshStatePulling];
        [self setTitle:@"正在拼命刷新..." forState:MJRefreshStateRefreshing];
        // 隐藏时间
        self.lastUpdatedTimeLabel.hidden = YES;
        // 自动切换透明度
        self.automaticallyChangeAlpha = YES;
    }
    return self;
}
@end
