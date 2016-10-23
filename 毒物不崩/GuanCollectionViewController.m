//
//  GuanCollectionViewController.m
//  毒物不崩
//
//  Created by 一羞 on 16/9/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "GuanCollectionViewController.h"
#import "GuanCollectionViewCell.h"
#import "GuanImageCollectionViewCell.h"
#import "DetailViewController.h"
int count = 2;
@interface GuanCollectionViewController ()
@property (nonatomic) NSMutableArray *collections;

@end

@implementation GuanCollectionViewController
static NSString * const reuseIdentifier = @"Cell";
-(void)viewDidAppear:(BOOL)animated
{
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    [button1 setFrame:CGRectMake(0, 0, 32, 32)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
    
}
-(void)goback
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"GuanCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"GuanImageCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell1"];
    
    [self load];
    __weak GuanCollectionViewController *weakSelf = self;
    
    [self.collectionView addInfiniteScrollingWithActionHandler:^{
        [weakSelf loadMore];
        
        
    }];
    
    // Do any additional setup after loading the view.
}
-(void)load
{
    [Util requequstGunInfoWithNumber:1 sortUid:self.uid rec:^(id obj) {
        self.collections  = obj;
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
        
    }];
}
-(void)loadMore
{
    [Util requequstGunInfoWithNumber:count sortUid:self.uid rec:^(id obj) {
        [self.collections addObjectsFromArray:obj];
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
        [self.collectionView.infiniteScrollingView stopAnimating];
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
- (void)like:(UIButton *)sender {
    if ([BmobUser currentUser]) {
        [sender setTitle:@"取消关注" forState:UIControlStateNormal];
        [sender removeTarget:self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
        [sender addTarget: self action:@selector(cancelLike:) forControlEvents:UIControlEventTouchUpInside];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObjectsFromArray:[ud objectForKey:@"guans"]];
        
        int mark = 0;
        for(NSString *string in arr)
        {
            if ([string isEqualToString:self.uid]) {
                mark = 1;
            }
            
        }
        if (mark == 0) {
            [arr addObject:self.uid];
            [ud setObject:arr forKey:@"guans"];
            [ud synchronize];
        }
        
        //        BmobObject *obj = [BmobObject objectWithClassName:@"Collection"];
        //        [obj setObject:self.uid forKey:@"uid"];
        //        [obj setObject:[BmobUser currentUser] forKey:@"user"];
        //        [obj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        //            if (isSuccessful) {
        //
        //                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        //
        //                BmobQuery *query = [BmobQuery queryWithClassName:@"Collection"];
        //                [query whereKey:@"user" equalTo:[BmobUser currentUser]];
        //                [query whereKeyExists:@"uid"];
        //                [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        //                    NSMutableArray *arr = [NSMutableArray array];
        //                    for(BmobObject *obj in array)
        //                    {
        //                        NSString *str = [obj objectForKey:@"uid"];
        //                        [arr addObject:str];
        //                    }
        //                    [ud setObject:arr forKey:@"guans"];
        //
        //
        //                }];
        //
        //
        //            }
        //            if (error) {
        //                NSLog(@"%@",error);
        //            }
        //
        //        }];
    }
    else
    {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"请登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [ac addAction: action];
        [self presentViewController:ac animated:YES completion:nil];
        
        
    }
    
    
    
}
-(void)cancelLike:(UIButton*)sender
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObjectsFromArray:[ud objectForKey:@"guans"]];
    for (int i = 0; i<arr.count; i++) {
        if ([arr[i] isEqualToString:self.uid])  {
            [arr removeObjectAtIndex:i];
            [ud setObject:arr forKey:@"guans"];
            [ud synchronize];
            
        }
    }
    [sender setTitle:@"关注" forState:UIControlStateNormal];
    
    [sender removeTarget:self action:@selector(cancelLike:) forControlEvents:UIControlEventTouchUpInside];
    [sender addTarget: self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
    
    //    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Collection"];
    //    [bquery whereKey:@"user" equalTo:[BmobUser currentUser]];
    //    [bquery whereKey:@"uid" equalTo:self.uid];
    //    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
    //        for (BmobObject *obj in array) {
    //
    //            [obj deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
    //                if (isSuccessful) {
    //
    //                    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    //
    //                    BmobQuery *query = [BmobQuery queryWithClassName:@"Collection"];
    //                    [query whereKey:@"user" equalTo:[BmobUser currentUser]];
    //                    [query whereKeyExists:@"uid"];
    //                    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
    //                        NSMutableArray *arr = [NSMutableArray array];
    //                        for(BmobObject *obj in array)
    //                       {
    //                          NSString *str = [obj objectForKey:@"uid"];
    //                           [arr addObject:str];
    //                       }
    //                        [ud setObject:arr forKey:@"guans"];
    //
    //
    //                    }];
    //
    //
    //
    //                }
    //                if (error) {
    //                    NSLog(@"%@",error);
    //                }
    //            }];
    //        }
    //    }];
    
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 2    ;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    if (section == 0) {
        return 1;
    }
    return self.collections.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        GuanCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.uid = self.uid;
        cell.backgroundColor = [UIColor whiteColor];
        [cell.button addTarget: self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSMutableArray *arr = [NSMutableArray array];
        arr = [ud objectForKey:@"guans"];
        int mark = 0;
        for(NSString *string in arr)
        {
            if ([string isEqualToString:self.uid]) {
                mark = 1;
            }
        }
        if (mark == 1) {
            [cell.button setTitle:@"取消关注" forState:UIControlStateNormal];
            [cell.button removeTarget:self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button addTarget: self action:@selector(cancelLike:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        else
        {
            
            [cell.button setTitle:@"关注" forState:UIControlStateNormal];
            
            [cell.button removeTarget:self action:@selector(cancelLike:) forControlEvents:UIControlEventTouchUpInside];
            [cell.button addTarget: self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        //        BmobQuery *bquery = [BmobQuery queryWithClassName:@"Collection"];
        //        [bquery whereKey:@"user" equalTo:[BmobUser currentUser]];
        //        [bquery whereKey:@"uid" equalTo:self.uid];
        //        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        
        
        //            for (BmobObject *obj in array){
        //                if (obj) {
        //
        //                    [cell.button setTitle:@"取消关注" forState:UIControlStateNormal];
        //                    [cell.button removeTarget:self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
        //                    [cell.button addTarget: self action:@selector(cancelLike:) forControlEvents:UIControlEventTouchUpInside];
        //
        //
        //                }
        //                else
        //                {
        //
        //                    [cell.button setTitle:@"关注" forState:UIControlStateNormal];
        //
        //                    [cell.button removeTarget:self action:@selector(cancelLike:) forControlEvents:UIControlEventTouchUpInside];
        //                    [cell.button addTarget: self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
        //
        //
        //
        //                }
        //            }
        
        
        //        }];
        return cell;
    }
    GuanImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    
    cell.obj = self.collections[indexPath.row];
    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return CGSizeMake((SW-5)/3, (SW-5)/3);
    }
    return CGSizeMake(SW, 150);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2.5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 ) {
        DetailViewController *vc = [DetailViewController new];
        GuanObj *obj = self.collections[indexPath.row];
        vc.shareId = obj.share_id ;
        vc.a = 1;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
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
