//
//  XMGAdViewController.m
//  BuDeJie
//
//  Created by mushroom on 2019/9/5.
//  Copyright © 2019 xiaomage. All rights reserved.
//

#import "XMGAdViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "XMGADItem.h"
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
#import "XMGTabBarController.h"

#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"
/*
 1.广告业务逻辑
 2.占位视图思想:有个控件不确定尺寸,但是曾是结果已经确定,就可以使用占位视图思想
 3.屏幕适配,通过屏幕高度判断
 */
@interface XMGAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContainView;
/**创建imageView*/
@property (nonatomic,weak) UIImageView *adView;

/**创建模型属性*/
@property (nonatomic,strong) XMGADItem *item;

/**定时器都是用weak*/
@property (nonatomic,weak) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;



@end

@implementation XMGAdViewController
- (IBAction)click_Jump:(id)sender {
    
    //销毁广告界面,进入主界面
    XMGTabBarController *tabBarVc = [[XMGTabBarController alloc] init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
    //销毁定时器
    [_timer invalidate];
    
}

-(UIImageView *)adView{
    if(!_adView){
        UIImageView *adView = [[UIImageView alloc] init];
        [self.adContainView addSubview:adView];
        //弹出的广告图片点击触发事件用手势完成
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [adView addGestureRecognizer:tap];
        adView.userInteractionEnabled = YES;
        _adView =adView;
    }
    return _adView;
}
//点击广告界面调用
-(void)tap{
    //跳转到界面 =>safari
    NSLog(@"打印plist中的广告跳转%@",_item.ori_curl);
    NSURL *url = [NSURL URLWithString:_item.ori_curl];
    UIApplication *app =  [UIApplication sharedApplication];
    if( [app canOpenURL:url]){
        [app openURL:url];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   //设置启动图片
    [self setupLaunchImage];
    
    //加载广告数据 =>拿到活动时间 =>服务器 =>查看接口文档1.判断接口对不对 2.解析数据(w_picurl,ori_curl:跳转广告界面,w,h) =>请求数据(AFN)
    
     [self loadAdData];
    //导入AFN框架:cocoapods
    //cocoapods:管理第三方库,cocoapods做的事情:导入一个框架,会把这个框架依赖的所有框架都导入
    
    //cocoapods步骤:
    //1.podfile:描述需要导入那些框架touch podfile
    //2.打开podfile描述: open podfile
    //3.搜索需要导入框架描述 pod search
    //4.安装第三方框架 pod install --no-repo-update
    //5.只能用xcworkspace
    
    //--no-repo-update Skip running 'pod repo update' before install
    //podfile.lock:第一次pod就会自动生成这个文件,描述当前导入框架版本
    //pod install:根据Podfile.lock去加载,第一次会根据podfile文件加载
    //pod update:去查看之前导入框架有没有新的俄版本,如果有新的版本就会去加载,并且更新pod.lock
    //pod repo :管理第三方仓库的索引,去寻找框架有没有最新版本,有就记录
   
    //创建定时器
   _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    
    
}

-(void)timeChange
{
    static int i = 3;
    //设置跳转按钮的文字
    [_jumpBtn setTitle:[NSString stringWithFormat:@"跳转(%d)",i] forState:UIControlStateNormal];
    
    
    if(i ==0){
        
        [self click_Jump:nil];
        
      
    }
    i--;
}

/*
 http://mobads.baidu.com/cpro/ui/mads.php?code2=phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam
 */

#pragma mark --加载广告数据
-(void)loadAdData{
    //1.创建请求会话管理者
   // AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    //3.发送请求
//   [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//       NSLog(@"%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 添加这句代码
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       // NSLog(@"%@",responseObject);
        //请求数据->解析数据(写成plist文件)->设计模型->字典转模型->展示数据->
//        [responseObject writeToFile:@"/Users/lei/Desktop/GitHub/BuDeJie/BuDeJie/BuDeJie/ad.plist" atomically:YES];
        //读取假数据进行测试
        //1.获取路径
        NSString *path=[NSString stringWithFormat:@"/Users/lei/Desktop/GitHub/BuDeJie/ad.plist"];

        //2.获取plist文件的dict
        NSMutableDictionary *plistDic=[NSMutableDictionary dictionaryWithContentsOfFile:path];
        
//       NSDictionary *plistDic = [NSDictionary dictionaryWithContentsOfFile:path];
//        NSLog(@"-------数据在哪里:%@",plistDic);
        //[responseObject writeToFile:@"/Users/lei/Desktop/ad.plist" atomically:YES];
        //获取字典/Users/lei/Desktop/ad.plist
        //NSDictionary *adDict = [responseObject[@"ad"] lastObject];
        
        
        
//        //字典转模型
       _item = [XMGADItem mj_objectWithKeyValues:plistDic[@"ad"][0]];

        //NSLog(@"%@",plistDic);
        
        
       // NSArray *items = [XMGADItem mj_objectArrayWithKeyValuesArray:plistDic[@"ad"]];
       // NSLog(@"%@",items);
//        NSLog(@"item中的值是------------%lf",item.w);
        //创建UIImageView展示图片
        CGFloat h = XMGScreenW/_item.w * _item.h;
       // CGFloat h = XMGScreenH;

        self.adView.frame = CGRectMake(0, 0, XMGScreenW, h);
        //加载广告网页
        [self.adView sd_setImageWithURL:[NSURL URLWithString:_item.w_picurl]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"%@",error);
    }];
    
    
}

//设置启动图片
-(void)setupLaunchImage
{
    // 6p:LaunchImage-800-Portrait-736h@3x.png
    // 6:LaunchImage-800-667h@2x.png
    // 5:LaunchImage-568h@2x.png
    // 4s:LaunchImage@2x.png
    if(iphone6P){//6p
            self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x.png"];
    }else if(iphone6){//6
            self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h@2x.png"];
    }else if(iphone5){//5
            self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-568h@2x.png"];
    }else if(iphone4){//4
            self.launchImageView.image = [UIImage imageNamed:@"LaunchImage@2x.png"];
    }
    

}

@end
