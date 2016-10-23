//
//  SearchTableViewController.m
//  毒物不崩
//
//  Created by 一羞 on 16/9/29.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "SearchTableViewController.h"
#import "SearchModel.h"
#import "DetailViewController.h"
@interface SearchTableViewController ()<UISearchBarDelegate>
@property (nonatomic) NSMutableArray *arr ;
@property (nonatomic) int tag;
@property (nonatomic) NSMutableArray *searchResult;
@property (nonatomic) UISearchBar *searchBar;
@property (nonatomic) NSMutableArray *shareIdS;


@end

@implementation SearchTableViewController
-(void)goBack
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    self.searchBar.center = CGPointMake(SW/2, 20);
    self.searchBar.placeholder = @"搜单品";
    self.searchBar.delegate = self;
    [self.navigationController.navigationBar addSubview:self.searchBar];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(goBack)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"清除记录" style:UIBarButtonItemStylePlain target:self action:@selector(clear)];

    
}
-(void)clear
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [self.arr removeAllObjects];
    [ud setObject:self.arr forKey:@"history"];
    [self.tableView reloadData];

    
    
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    for (int i = 0; i<self.arr.count; i++) {
        if ([self.arr[i]isEqualToString:searchBar.text]) {
            [self.arr removeObjectAtIndex:i];
            }
    }
    [self.arr addObject:searchBar.text];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:self.arr forKey:@"history"];
    [ud synchronize];
    self.tag = 1;
    [Util requestSeachResultWithString:searchBar.text rec:^(id obj) {
                if (obj) {
                    NSArray *array = obj;
            for(SearchModel *object in array)
            {
                [self.searchResult addObject:object.name];
                [self.shareIdS addObject:object.share_id];
            }
        }
        [self.tableView reloadData];
        

    }];
 
    
    
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.tag = 0;
        self.arr = [NSMutableArray array];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [self.arr addObjectsFromArray: [ud objectForKey:@"history"]];
    if (self.arr) {
        [self.tableView reloadData];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
   
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (self.tag ==1) {
        return self.searchResult.count;
    }
    return self.arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.tag == 1) {
        cell.textLabel.text = self.searchResult[indexPath.row];
        
    }
    else
    {
    cell.textLabel.text = self.arr[self.arr.count-1-indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tag == 0) {
        self.searchBar.text = self.arr[self.arr.count-1-indexPath.row];
    }
    else
    {
        DetailViewController *vc = [DetailViewController new];
        vc.shareId = self.shareIdS[indexPath.row];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:navi animated:YES completion:nil];
    }
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


- (NSMutableArray *)searchResult {
	if(_searchResult == nil) {
		_searchResult = [[NSMutableArray alloc] init];
	}
	return _searchResult;
}

- (NSMutableArray *)shareIdS {
	if(_shareIdS == nil) {
		_shareIdS = [[NSMutableArray alloc] init];
	}
	return _shareIdS;
}

@end
