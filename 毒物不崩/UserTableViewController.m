//
//  UserTableViewController.m
//  毒物
//
//  Created by 一羞 on 16/9/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UserTableViewController.h"
#import "AddNameAndPicViewController.h"
#import "SecondTableViewCell.h"
#import "ThirdTabelViewCell.h"
#import "FirstTableViewCell.h"
#import "Model1.h"
#import "MyUserTableViewController.h"
#import "MyInfoCollectionViewController.h"

#import "DetaiObj.h"
@interface UserTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) Model1 *model;
@property (nonatomic) float height;



@end

@implementation UserTableViewController
-(void)viewWillAppear:(BOOL)animated
{
    
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
  self.model = [[Model1 alloc]init];
    [self.tableView reloadData];
    self.tabBarController.tabBar.hidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
     self.navigationController.tabBarItem.image = [UIImage imageNamed:@"我的icon@3x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.42316.000.00.@3x.png"];
        self.tableView.estimatedRowHeight = 200;
    [self.tableView registerNib:[UINib nibWithNibName:@"FirstTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell0"];
   [ self.tableView registerNib:[UINib nibWithNibName:@"SecondTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell1"];
    [ self.tableView registerNib:[UINib nibWithNibName:@"ThirdTabelViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell2"];
    self.tableView.allowsSelection = NO;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)changeImage
{
    
        AddNameAndPicViewController *addVc = [AddNameAndPicViewController new];
    [self.navigationController pushViewController:addVc animated:YES];
    
}
-(void)goToS
{
    UICollectionViewFlowLayout *lauout = [[UICollectionViewFlowLayout alloc]init];
    MyInfoCollectionViewController *vc = [[MyInfoCollectionViewController alloc]initWithCollectionViewLayout:lauout];
     [self.navigationController pushViewController:vc animated:YES];
}
-(void)goToG
{
    MyUserTableViewController *VC = [MyUserTableViewController new];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0"];
        [cell.goToG addTarget:self action:@selector(goToG) forControlEvents:UIControlEventTouchUpInside];
        [cell.goToS addTarget:self action:@selector(goToS) forControlEvents:UIControlEventTouchUpInside];
        cell.model = self.model;
        [cell.gesture addTarget:self action:@selector(changeImage)];
        return cell;
    }
    if (indexPath.section == 1) {
       SecondTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell1.count =1;
        return  cell1;
    }
    ThirdTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        NSUserDefaults *ud =[NSUserDefaults standardUserDefaults];
        NSMutableArray *arr = [ud objectForKey:@"likes"];
        
        if (arr.count<7) {
            return 40+((SW-20)/3+5)*((6-1)/3+1);
        }
        return 40+((SW-20)/3+5)*((arr.count-1)/3+1);
    }
    return UITableViewAutomaticDimension;
}


@end
