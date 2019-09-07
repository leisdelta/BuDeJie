//
//  XMGSubTagViewController.m
//  BuDeJie
//
//  Created by mushroom on 2019/9/6.
//  Copyright © 2019 xiaomage. All rights reserved.
//

#import "XMGSubTagViewController.h"
#import <AFHTTPSessionManager.h>
#import "XMGSubTagItem.h"
#import <MJExtension/MJExtension.h>
#import "XMGSubTagCell.h"
@interface XMGSubTagViewController ()

/**数据数组*/
@property (nonatomic,strong) NSArray *subTags;


@end

@implementation XMGSubTagViewController

static NSString * const ID = @"subTagCell";
//接口文档:请求url(基本url+请求参数)请求方式
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    //展示标签数据 -> 请求数据(接口文档)->解析数据(image_list,sub_number,theme_name)->字典转模型
    [self loadData];
    
    //注册cell,这里采取了注册的方式cellForRowAtIndexPath就不用再写if判断创造出cell
    [self.tableView registerNib:[UINib nibWithNibName:@"XMGSubTagCell" bundle:nil] forCellReuseIdentifier:ID];
    
    self.title = @"推荐标签";
    
    
    //处理cell分割线 1.自定义分割线2.系统属性
    //清空tableView分割线内边距 清空cell的约束边缘
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    
    
    
}
#pragma mar -请求数据
-(void)loadData
{
    //1.创建请求会话管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    //2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    //3.发送请求
    [mgr GET:@"http://api.budejie.com/api/api_open.php"  parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *  _Nullable responseObject) {
        //NSLog(@"新帖数据responseObject---------%@",responseObject);
        //写入到文件中
        [responseObject writeToFile:@"/Users/lei/Desktop/GitHub/BuDeJie/BuDeJie/BuDeJie/Classes/New\(新帖\)/View/tag.plist" atomically:YES];
        //把字典转化为模型
        
        
       _subTags =  [XMGSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        //NSLog(@"获取遍历出来的的数据----------------------%@",self.subTags[0]);
//        for(int i =0;i<_subTags.count;i++){
//           XMGSubTagItem *tag = _subTags[i];
//           // NSLog(@"遍历结果显示 %@",tag.theme_name);
//        }
        //刷新表格
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"新帖数据error-----%@",error);
    }];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subTags.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
   // NSLog(@"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");

    //自定义cell
    XMGSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //注意:如果cell从xib加载,一定要记得绑定标识符,使它能够被能被循环利用
    //注册cell
//    if(cell == nil){
//        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//        //自定义的cell,采用了xib方式创建的
//       cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XMGSubTagCell class]) owner:nil options:nil][0];
//    }
    //获取模型
    XMGSubTagItem *item = self.subTags[indexPath.row];
    cell.item =item;
   // NSLog(@"cell中的遍历数据显示结果 %@",item.theme_name);
    //cell.textLabel.text = item.theme_name;
    
    //NSLog(@"%p",cell);
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}



@end
