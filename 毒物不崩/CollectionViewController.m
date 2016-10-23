//
//  CollectionViewController.m
//  毒物
//
//  Created by 一羞 on 16/9/21.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "CollectionViewController.h"
#import "FirstCollectionViewCell.h"
#import "FallFlowLaout.h"
#import "SecondCollectionViewCell.h"
#import <SVPullToRefresh.h>
#import "InfoWebViewController.h"
#import "Util.h"
@interface CollectionViewController ()
@property (nonatomic) NSMutableArray *datas;
@property (nonatomic) FallFlowLaout *laout;
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";
-(void)viewDidAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
   self.collectionView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //self.collectionView.backgroundColor = [UIColor colorWithRed:247 green:247 blue:247 alpha:1];
    // Uncomment the following line to preserve selection between presentations

    self.laout = [[FallFlowLaout alloc]init];

    self.collectionView.collectionViewLayout = self.laout;
    self.laout.count = 1;
    [self.collectionView registerClass:[FirstCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
   [self.collectionView registerClass:[SecondCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
  
    __weak CollectionViewController *weakSelf = self;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSData *data = [ud objectForKey:@"Info"];
    if (data) {
        NSLog(@"dd");
       
        self.datas = [NSKeyedUnarchiver unarchiveObjectWithData:data];
         self.laout.count = @(self.datas.count).intValue+1;
        [self.collectionView reloadData];
    }

    
    
    [self.collectionView addInfiniteScrollingWithActionHandler:^{
        [weakSelf loadMore];
    }];
    [self.collectionView addPullToRefreshWithActionHandler:^{
        
        [weakSelf loadData];
        
    }];
    [self loadData];
    
    // Do any additional setup after loading the view.
}
-(void)loadFirst
{
    
}
-(void)loadData
{
    if (self.sortNum == 0) {
        self.sortNum  = 1000;
        
    }
    if (self.count == 0) {
        self.count  = 1;
    }
        [Util requequstInfoWithNumber:self.count sortNum:self.sortNum rec:^(id obj) {
        self.datas = obj;
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.datas];
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:data forKey:@"Info"];
            [ud synchronize];

        self.laout.count = @(self.datas.count).intValue+1;
        
        [self.collectionView reloadData];
        [self.collectionView.pullToRefreshView stopAnimating];
    }];
    

}
-(void)loadMore
{

    [Util  requequstInfoWithNumber:self.count+1 sortNum:self.sortNum rec:^(id obj) {
        [self.datas addObjectsFromArray:obj];
        self.laout.count = @(self.datas.count).intValue+1;
        
        [self.collectionView reloadData];
     
    }];
       [self.collectionView.infiniteScrollingView stopAnimating];
    self.count ++;
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    //NSLog(@"%ld",self.datas.count);
    return self.datas.count+1;
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   if (indexPath.row==0) {
        FirstCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor whiteColor];
     
        return cell;
    }
    else
    {
       
        SecondCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        
        cell.backgroundColor = [UIColor whiteColor];
         
        cell.obj = self.datas[indexPath.row-1];
       return cell;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        return ;
    }
   

    InfoWebViewController *vc = [[InfoWebViewController alloc]init];
     UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
    InfoObj *obj = self.datas[indexPath.row-1];
    vc.did = obj.did;
    
    [self presentViewController:navi animated:YES completion:nil];
    
    
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/
/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
