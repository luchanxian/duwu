//
//  TabViewController.m
//  毒物
//
//  Created by 一羞 on 16/9/22.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "TabViewController.h"
#import "UserTableViewController.h"
@interface TabViewController ()

@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.backgroundImage = [UIImage imageNamed:@"透明"];
    self.tabBar.shadowImage = [UIImage imageNamed:@"透明"];
    UIView  *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.7;
    [self.tabBar insertSubview:view atIndex:0];
    if ([BmobUser currentUser]) {
        UserTableViewController *vc = [UserTableViewController new];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
            [self addChildViewController:navi];
       navi.tabBarItem.image = [UIImage imageNamed:@"我的icon@3x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.42316.000.00.@3x.png"];
        [self addChildViewController:navi];
        [self setViewControllers:@[self.viewControllers[0],self.viewControllers[1],self.viewControllers[3]]];
        
    }
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage imageNamed:@"欢迎页.png"];
    [self.view addSubview:imageView];
    [UIView animateWithDuration:3 animations:^{
        imageView.alpha = 0;
        imageView.transform = CGAffineTransformScale(imageView.transform, 1.5,1.5);
    }];
    
    
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
