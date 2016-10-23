//
//  DetailViewController.m
//  毒物
//
//  Created by 一羞 on 16/9/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "DetailViewController.h"
#import "UIViewExt.h"
#import "F1TableViewCell.h"
#import "Util.h"
#import "CommentCell.h"
#import "WebViewController.h"
#import "GuanCollectionViewController.h"
@interface DetailViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;//32
@property (weak, nonatomic) IBOutlet UITextField *textfiled;
@property (nonatomic) NSMutableArray *comments;
@property (nonatomic) NSMutableArray *commenttts;
@property (nonatomic) NSArray *datas;
@property (nonatomic) DetaiObj *obj;
@property (nonatomic) NSMutableArray *likes;


- (IBAction)shouqi:(id)sender;


@end

@implementation DetailViewController

- (IBAction)clic:(UIButton*)sender {
    switch (sender.tag) {
        case 0:
        {
           
            if ([BmobUser currentUser]) {
                if (![self.textfiled.text isEqualToString:@""]) {
                    BmobObject *obj = [BmobObject objectWithClassName:@"Comment"];
                    [obj setObject:self.textfiled.text forKey:@"comment"];
                    [obj setObject:[BmobUser currentUser] forKey:@"user"];
                    [obj setObject:self.shareId forKey:@"shareId"];
                    [obj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                        if (isSuccessful) {
                            NSString *string = [NSString stringWithFormat:@"评论成功"];
                            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
                            UIAlertAction *certain = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                [self loadCom2];
                                
                                
                            }];
                            [ac addAction:certain];
                            [self presentViewController:ac animated:YES completion:nil];
                        }
                        
                    }];
                    
                    
                    [self.textfiled resignFirstResponder ];
                }

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
            break;
        case 1:
        {
            if ([BmobUser currentUser]) {
                [sender setBackgroundImage:[UIImage imageNamed:@"喜欢 2"] forState:UIControlStateNormal];
                [sender removeTarget:self action:@selector(clic:) forControlEvents:UIControlEventTouchUpInside];
                [sender addTarget: self action:@selector(cancelLike:) forControlEvents:UIControlEventTouchUpInside];
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                self.likes = [NSMutableArray array];
                [self.likes addObjectsFromArray:[ud objectForKey:@"likes"]];
                
                int mark = 0;
                for(NSString *string in self.likes)
                {
                    if ([string isEqualToString:self.shareId]) {
                        mark = 1;
                    }
                    
                }
                if (mark == 0) {
                    [self.likes addObject:self.shareId];
                    [ud setObject:self.likes forKey:@"likes"];
                     [ud synchronize];
                }
                
               
                
//                BmobObject *obj = [BmobObject objectWithClassName:@"Collection"];
//                [obj setObject:self.shareId forKey:@"shareId"];
//                [obj setObject:[BmobUser currentUser] forKey:@"user"];
//                [obj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//                    if (isSuccessful) {
//                        
//                        
//                        BmobQuery *query = [BmobQuery queryWithClassName:@"Collection"];
//                        [query orderByAscending:@"createdAt"];
//                        [query whereKey:@"user" equalTo:[BmobUser currentUser]];
//                        [query whereKeyExists:@"shareId"];
//                        [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//                            NSMutableArray *arr = [NSMutableArray array];
//                            for(BmobObject *obj in array)
//                            {
//                                NSString *str = [obj objectForKey:@"shareId"];
//                                [arr addObject:str];
//                            }
//                            [ud setObject:arr forKey:@"xihuans"];
//                            
//                            
//                        }];
//                        
//                        
//                    }
//                    if (error) {
//                        NSLog(@"%@",error);
//                    }
//                }];
            }
            else{
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"请登录" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [ac addAction: action];
                [self presentViewController:ac animated:YES completion:nil];
                

            }
            
            
        }
            break;
        case 2:
        {
            WebViewController *vc = [WebViewController new];
            vc.webPath = self.obj.goods_link;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
       
    }
}
-(void)cancelLike:(UIButton*)sender
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObjectsFromArray:[ud objectForKey:@"likes"]];
    for (int i = 0; i<arr.count; i++) {
        if ([arr[i] isEqualToString:self.shareId])  {
            [arr removeObjectAtIndex:i];
            [ud setObject:arr forKey:@"likes"];
            [ud synchronize];

        }
    }
    
   

   [sender setBackgroundImage:[UIImage imageNamed:@"喜欢 1"] forState:UIControlStateNormal];
    [sender removeTarget:self action:@selector(cancelLike:) forControlEvents:UIControlEventTouchUpInside];
    [sender addTarget: self action:@selector(clic:) forControlEvents:UIControlEventTouchUpInside];
    
    //    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Collection"];
//    [bquery whereKey:@"user" equalTo:[BmobUser currentUser]];
//    [bquery whereKey:@"shareId" equalTo:self.shareId];
//    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//        for (BmobObject *obj in array) {
//            
//            [obj deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
//                if (isSuccessful) {
//                    
//                    
//                    BmobQuery *query = [BmobQuery queryWithClassName:@"Collection"];
//                      [ query orderByAscending:@"createdAt"];
//                    [query whereKey:@"user" equalTo:[BmobUser currentUser]];
//                    [query whereKeyExists:@"shareId"];
//                    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//                        NSMutableArray *arr = [NSMutableArray array];
//                        for(BmobObject *obj in array)
//                        {
//                            NSString *str = [obj objectForKey:@"shareId"];
//                            [arr addObject:str];
//                        }
//                        [ud setObject:arr forKey:@"xihuans"];
//                        
//                        
//                    }];
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
-(void)viewDidAppear:(BOOL)animated
{    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];

    self.title = @"毒物";
    if (self.a!=1) {
               
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        [button1 setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
        [button1 setFrame:CGRectMake(0, 0, 32, 32)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
    }
  
    [UIView animateWithDuration:0.5 animations:^{
        self.view.alpha = 1;
    }];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    self.likes = [ud objectForKey:@"likes"];
    int mark = 0;
    for(NSString *string in self.likes)
    {
        if ([string isEqualToString:self.shareId]) {
            mark = 1;
        }
    }
    if (mark == 1) {
        [self.likeBt setBackgroundImage:[UIImage imageNamed:@"喜欢 2"] forState:UIControlStateNormal];
                    [self.likeBt removeTarget:self action:@selector(clic:) forControlEvents:UIControlEventTouchUpInside];
                    [self.likeBt addTarget: self action:@selector(cancelLike:) forControlEvents:UIControlEventTouchUpInside];

    }
    else
    {
        [self.likeBt setBackgroundImage:[UIImage imageNamed:@"喜欢 1"] forState:UIControlStateNormal];
                    [self.likeBt removeTarget:self action:@selector(cancelLike:) forControlEvents:UIControlEventTouchUpInside];
                    [self.likeBt addTarget: self action:@selector(clic:) forControlEvents:UIControlEventTouchUpInside];

    }
//    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Collection"];
//    [bquery whereKey:@"user" equalTo:[BmobUser currentUser]];
//    [bquery whereKey:@"shareId" equalTo:self.shareId];
//    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//        
//        for (BmobObject *obj in array){
//            if (obj) {
//            //
//        }
//        else
//        {
//            [self.likeBt setBackgroundImage:[UIImage imageNamed:@"喜欢 1"] forState:UIControlStateNormal];
//            [self.likeBt removeTarget:self action:@selector(cancelLike:) forControlEvents:UIControlEventTouchUpInside];
//            [self.likeBt addTarget: self action:@selector(clic:) forControlEvents:UIControlEventTouchUpInside];
//        }
//        }
//        
//        
//    }];
    [self loadObj];

 
}

-(void)share//分享
{
   
}
-(void)goback
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void)keyboardChangeAction:(NSNotification *)noti{
    
   // NSLog(@"%@",noti.userInfo);
    CGRect keyboardF = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //判断收软键盘
    if (keyboardF.origin.y==[UIScreen mainScreen].bounds.size.height) {
        //还原
        self.bottomView.transform = CGAffineTransformIdentity;
    }else{//软键盘弹出
        
        self.bottomView.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
    }
    
    
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.textfiled.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 200;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChangeAction:) name:UIKeyboardWillChangeFrameNotification object:nil];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"F1TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell1"];
  
    [self loadCom];
    
    
}
-(void)loadCom2
{
    BmobQuery *query = [BmobQuery queryWithClassName:@"Comment"];
    [query whereKey:@"shareId" equalTo:self.shareId];
    [query includeKey:@"user"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [self.commenttts removeAllObjects];
        for(BmobObject *obj in array)
        {
            BmobUser *user =[obj objectForKey:@"user"];
            DetaiObj *detaiObj = [DetaiObj new];
            
            
            detaiObj.user_name = [user objectForKey:@"name"];
            detaiObj.user_img = [user objectForKey:@"nick"];
            detaiObj.goods_content = [obj objectForKey:@"comment"];
            detaiObj.create_time = [obj objectForKey:@"createdAt"];
            NSLog(@"%@",detaiObj.create_time);
            [self.commenttts addObject:detaiObj];
            
        }
        if (array) {
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        }
       
        
    }];
    
    
}
-(void)loadCom
{
    BmobQuery *query = [BmobQuery queryWithClassName:@"Comment"];
    [query whereKey:@"shareId" equalTo:self.shareId];
    [query includeKey:@"user"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        for(BmobObject *obj in array)
        {
            BmobUser *user =[obj objectForKey:@"user"];
            DetaiObj *detaiObj = [DetaiObj new];
            
            
            detaiObj.user_name = [user objectForKey:@"name"];
            detaiObj.user_img = [user objectForKey:@"nick"];
            detaiObj.goods_content = [obj objectForKey:@"comment"];
            detaiObj.create_time = [obj objectForKey:@"createdAt"];
            NSLog(@"%@",detaiObj.create_time);
            [self.commenttts addObject:detaiObj];
            
        }
        if (array) {
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView scrollsToTop];

        }
        
    }];


}
-(void)loadObj
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *data = [ud objectForKey:self.shareId];
    if (data) {
        self.comments = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        self.obj = self.comments[0];
        [self.tableView reloadData];
    }
    
    [Util requequeswithString:self.shareId callback:^(id obj) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
      
        self.comments = obj;
        self.obj = self.comments[0];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.comments];
        [ud setObject:data forKey:self.shareId];
        [ud synchronize];
           [self.tableView reloadData];
       
     
       
        
    }];
    }
#pragma  mark - 2334 Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 2) {
        return self.commenttts.count;
    }
 
    return self.comments.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    if (indexPath.section == 0) {
        F1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
      

        cell.detailObj = self.obj;
        
        return  cell;
    }
    if (indexPath.section == 2) {
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        
        cell.obj = self.commenttts[indexPath.row];
        
        return cell;

    }
   
    NSLog(@"ddd");
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    
    cell.obj = self.comments[indexPath.row];
    [cell.headView addTarget:self action:@selector(goToUser) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        WebViewController *vc = [WebViewController new];
        vc.webPath = self.obj.goods_link;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
-(void)goToUser
{   NSLog(@"xx");
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    GuanCollectionViewController *vc = [[GuanCollectionViewController alloc]initWithCollectionViewLayout:layout];
    vc.uid = self.obj.uid;
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




- (IBAction)shouqi:(id)sender {
}



- (NSMutableArray *)commenttts {
	if(_commenttts == nil) {
		_commenttts = [[NSMutableArray alloc] init];
	}
	return _commenttts;
}



@end
