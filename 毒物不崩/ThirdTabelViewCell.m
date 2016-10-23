//
//  ThirdTabelViewCell.m
//  毒物
//
//  Created by 一羞 on 16/9/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ThirdTabelViewCell.h"
#import "LogViewController.h"
#import "TabViewController.h"
@implementation ThirdTabelViewCell
- (IBAction)LogOut:(id)sender {
    
    [BmobUser logout];
    LogViewController *vc = [LogViewController new];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
    TabViewController *tabC = (TabViewController*)[UIApplication sharedApplication].keyWindow.rootViewController ;
    [tabC addChildViewController:navi];
    navi.tabBarItem.image = [UIImage imageNamed:@"我的icon@3x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.42316.000.00.@3x.png"]; 
    [tabC setViewControllers:@[tabC.viewControllers[0],tabC.viewControllers[1],tabC.viewControllers[3]]];

    
}

@end
