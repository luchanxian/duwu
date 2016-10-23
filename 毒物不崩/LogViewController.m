//
//  LogViewController.m
//  毒物
//
//  Created by 一羞 on 16/9/23.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "LogViewController.h"
#import "LogAndRViewController.h"
#import "UserTableViewController.h"
@interface LogViewController ()

@end

@implementation LogViewController
-(void)viewWillAppear:(BOOL)animated
{        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    
    
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        UIImageView *backGroundImage = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    backGroundImage.image = [UIImage imageNamed:@"我的未登录_白图层@2x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.50392.000.00.@2x"];
    imageView.image = [UIImage imageNamed:@"我的未登录_图片@3x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.42134.000.00.@3x"];

    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    button.center = CGPointMake(SW/2,SW*1236.0/960 );
    [button setBackgroundImage:[UIImage imageNamed:@"我的未登录_登录@3x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.50661.000.00.@3x"] forState:UIControlStateNormal
     ];
    [button addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 400, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(SW/2, SW*1236.0/960+80);
    label.font = [UIFont systemFontOfSize:14];
   
    label.text = @"发烧手册  /  尖儿货指南  /  达人社区";
    

    
     [self.view addSubview:backGroundImage];
    [self.view addSubview:imageView];
   
    [self.view addSubview:button];
    [self.view addSubview:label];
    [self.view bringSubviewToFront:backGroundImage];
    [self.view bringSubviewToFront:button];
    [self.view bringSubviewToFront:label];
    
}
-(void)login
{
    LogAndRViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle: nil] instantiateViewControllerWithIdentifier:@"stroy"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
