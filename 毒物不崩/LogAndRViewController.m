//
//  LogAndRViewController.m
//  毒物
//
//  Created by 一羞 on 16/9/23.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "LogAndRViewController.h"
#import "UserTableViewController.h"
@interface LogAndRViewController ()
@property (weak, nonatomic) IBOutlet UIButton *logBt;
@property (weak, nonatomic) IBOutlet UIButton *regesterBt;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;

@end

@implementation LogAndRViewController
- (IBAction)hahah:(id)sender {
}
- (IBAction)logIn:(id)sender {
    [BmobUser loginInbackgroundWithAccount:self.userName.text andPassword:self.passWord.text block:^(BmobUser *user, NSError *error) {
        if (user) {
            NSString *string = [NSString stringWithFormat:@"登录成功"];
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *certain = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                if ([BmobUser currentUser]) {
                    UserTableViewController *vc = [UserTableViewController new];
                    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
                    [self.tabBarController addChildViewController:navi];
                   
                    navi.tabBarItem.image = [UIImage imageNamed:@"我的icon@3x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.42316.000.00.@3x.png"];
                    [self.tabBarController addChildViewController:navi];
                    [self.tabBarController setViewControllers:@[self.tabBarController.viewControllers[0],self.tabBarController.viewControllers[1],self.tabBarController.viewControllers[3]]];
                    
                }

//                UserTableViewController *vc = [[UserTableViewController alloc]init];
//                UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
//                navi.modalPresentationStyle = UIModalPresentationCurrentContext;
//            
//                [self presentViewController:navi animated:YES completion:nil];
            }];
            [ac addAction:certain];
            [self presentViewController:ac animated:YES completion:nil];

            NSLog(@"%@",user);
        } else {
            NSLog(@"%@",error);
            NSString *string = [NSString stringWithFormat:@"%@",error];
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *certain = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [ac addAction:certain];
            [self presentViewController:ac animated:YES completion:nil];

        }
    }];
    
}

- (IBAction)regester:(id)sender {
    BmobUser *user = [[BmobUser alloc] init];
    [user setUsername:self.userName.text];
    [user setPassword:self.passWord.text];
    [user signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
        if (isSuccessful){
            NSString *string = [NSString stringWithFormat:@"注册成功"];
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *certain = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [ac addAction:certain];
            [self presentViewController:ac animated:YES completion:nil];
            NSLog(@"Sign up successfully");
        } else {
            NSString *string = [NSString stringWithFormat:@"%@",error];
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *certain = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [ac addAction:certain];
            [self presentViewController:ac animated:YES completion:nil];
            NSLog(@"%@",error);
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    self.logBt.layer.cornerRadius = 24;
    self.regesterBt.layer.cornerRadius = 24;
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
