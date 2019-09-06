//
//  XMGSettingViewController.m
//  BuDeJie
//
//  Created by mushroom on 2019/9/4.
//  Copyright © 2019 xiaomage. All rights reserved.
//

#import "XMGSettingViewController.h"

@interface XMGSettingViewController ()

@end

@implementation XMGSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条左边按钮
    
   // self.navigationItem.leftBarButtonItem =  [UIBarButtonItem backItemWithimage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(back) title:@"返回"];
    
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton setTitle:@"返回" forState:UIControlStateNormal];
//    [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
//    [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
//    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//    [backButton sizeToFit];
//    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
//    
//    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    

}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}


@end
