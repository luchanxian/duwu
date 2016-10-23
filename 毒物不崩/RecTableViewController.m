//
//  RecTableViewController.m
//  毒物哦
//
//  Created by 一羞 on 16/9/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "DetailViewController.h"
#import "RecTableViewController.h"
#import "F1TableViewCell.h"
#import "HeadView.h"
#import "Util.h"
#import "SortTableViewCell.h"
#import <SVPullToRefresh/SVPullToRefresh.h>
#import "DetaiObject.h"
#import "SearchTableViewController.h"
int tag = 0;//分类是否展开


@interface RecTableViewController ()
@property (nonatomic) HeadView *headView;

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) NSMutableArray *datas;
@end

@implementation RecTableViewController
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"透明"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"透明"] ];
    UIView  *view = [[UIView alloc]initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, 64)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.7;
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 25)];
     self.imageView.image = [UIImage imageNamed:@"弹窗三角@3x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.1913.000.00.@3x.png"];
    self.navigationItem.titleView = self.imageView;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(search)];
    [self.imageView addGestureRecognizer:gesture];
    self.imageView.userInteractionEnabled = YES;
    [self.navigationController.navigationBar insertSubview:view atIndex:0];
    [self.tableView registerNib:[UINib nibWithNibName:@"F1TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SortTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell1"];
      self.tableView.estimatedRowHeight = 200;  //揣测高度,给个大值
  
    
   //self.tabBarController.tabBar.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self loadFirst];
 //[self getBackView:self.navigationController.navigationBar];
    __weak RecTableViewController *weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        
        [weakSelf loadObj];
        [UIView animateWithDuration:1 animations:^{
            weakSelf.imageView.transform = CGAffineTransformRotate(weakSelf.imageView.transform, M_PI);
            
        }];


    }];
    
    
    
    [self loadObj];
   
    
    //添加 上拉加载事件
   
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf loadMore];
    }];

   //[self getBackBarView:self.tabBarController.tabBar];
    //self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    //self.navigationController.navigationBar.alpha = 0.5;
    
    
    self.headView = [HeadView new];
    [self.headView setFrame:CGRectMake(0, 0, SW, self.headView.height)];
    self.tableView.tableHeaderView = self.headView;
    [self.headView.moreBt addTarget:self action:@selector(showCell) forControlEvents:UIControlEventTouchUpInside];
   
    
    
}
-(void)search
{
    UINavigationController *vc = [[UINavigationController alloc]initWithRootViewController:[[SearchTableViewController alloc]init] ];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
    
    
    
}
-(void)loadObjs
{
    [Util requequstwithNumber:1 sortNum:self.index rec:^(id obj) {
        self.datas = obj;
        [self.tableView reloadData];
        [self.tableView.pullToRefreshView stopAnimating];
        if(self.datas)
        {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }];
    

}
-(void)loadFirst
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSData *data = [ud objectForKey:@"rec"];
    if (data) {
        self.datas = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [self.tableView reloadData];
    }
 
    
}
-(void)loadObj
{
    [Util requequstwithNumber:1 sortNum:self.index rec:^(id obj) {
          self.datas  = obj;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.datas];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:data forKey:@"rec"];
        [ud synchronize];
               [self.tableView reloadData];
        [self.tableView.pullToRefreshView stopAnimating];
    }];
    
    
}
-(void)loadMore
{
    if (self.count == 0) {
        self.count = 2;
    }
    
    [Util requequstwithNumber:self.count sortNum:self.index rec:^(id obj) {
        [self.datas addObjectsFromArray:obj];
        
        [self.tableView reloadData];
         [self.tableView.infiniteScrollingView stopAnimating];
    }];
    self.count ++;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return (SW-6*8)/5*2+16;
    }
     
   
   
   
   
    return UITableViewAutomaticDimension;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 0) {
        if (tag == 1) {
            return 1;
        }
        else
        {
        return 0;
        }
    }
    else
    {
        return self.datas.count;
    }

    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0){
        
         SortTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        [cell.backB addTarget:self action:@selector(shouqi) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }
    else
    {
   
    
         F1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
       
        cell.obj = self.datas[indexPath.row];
       
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    DetailViewController *vc = [DetailViewController new];
    
    F1Object *obj = self.datas[indexPath.row];
    if (obj) {
        vc.shareId = obj.share_id;
        vc.img = obj.img;
        
        UINavigationController *naviC = [[UINavigationController alloc]initWithRootViewController:vc];
        
        
        //self.definesPresentationContext = YES; //self is presenting view controller
        vc.view.alpha = 0;    //    testVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        naviC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        naviC.view.backgroundColor = [UIColor clearColor];
        
        
        [self presentViewController:naviC animated:NO completion:nil];
    }
  
    
 
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    
    if (section == 1) {
        return 15;
    }
    return 0;
}

-(void)showCell
{
   
    tag = 1;
    UIButton *button = [self.headView.sortView.subviews lastObject];
    [button setTitle:@"女鞋" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"女鞋"] forState:UIControlStateNormal];
    [button setTintColor:[UIColor whiteColor]];
    
    [button addTarget:[Util class] action:@selector(clickTo:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 4;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic] ;
 
    
}
-(void)shouqi
{
    tag = 0;
   
    UIButton *button = [self.headView.sortView.subviews lastObject];
    [button setTitle:@"更多" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    [button removeTarget:[Util class] action:@selector(clickTo:)  forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(showCell) forControlEvents:UIControlEventTouchUpInside];
[button setTintColor:[UIColor whiteColor]];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic] ;
    
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
