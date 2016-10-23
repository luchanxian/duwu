//
//  InfoWebViewController.m
//  毒物
//
//  Created by 一羞 on 16/9/22.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "InfoWebViewController.h"
#import "InfoDetailObj.h"
#import <UIScrollView+SVPullToRefresh.h>
#import "Util.h"
@interface InfoWebViewController ()<UIWebViewDelegate>
@property (nonatomic) UIActivityIndicatorView *activityIndicator;
@property (nonatomic) UIWebView *webView;
@property (nonatomic,copy) NSString *imgUrl;
@end

@implementation InfoWebViewController
-(void)viewDidAppear:(BOOL)animated
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setBackgroundImage:[UIImage imageNamed:@"喜欢 1"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 32, 32)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    [button1 setFrame:CGRectMake(0, 0, 32, 32)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arr = [NSMutableArray array];
    arr = [ud objectForKey:@"shous"];
    int mark = 0;
    for(NSString *string in arr)
    {
        if ([string isEqualToString:self.did]) {
            mark = 1;
        }
    }
    if (mark == 1) {
        [button setBackgroundImage:[UIImage imageNamed:@"喜欢 2"] forState:UIControlStateNormal];
                        [button removeTarget:self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
                        [button addTarget: self action:@selector(cancelLike:) forControlEvents:UIControlEventTouchUpInside];

        
    }
    else
    {
        
                        [button setBackgroundImage:[UIImage imageNamed:@"喜欢 1"] forState:UIControlStateNormal];
                        [button removeTarget:self action:@selector(cancelLike:) forControlEvents:UIControlEventTouchUpInside];
                        [button addTarget: self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
        
    }

//    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Collection"];
//    [bquery whereKey:@"did" equalTo:self.did
//     ];
//    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//        
//        for (BmobObject *obj in array){
//            if (obj) {
//                [button setBackgroundImage:[UIImage imageNamed:@"喜欢 2"] forState:UIControlStateNormal];
//                [button removeTarget:self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
//                [button addTarget: self action:@selector(cancelLike:) forControlEvents:UIControlEventTouchUpInside];
//                
//            }
//            else
//            {
//                [button setBackgroundImage:[UIImage imageNamed:@"喜欢 1"] forState:UIControlStateNormal];
//                [button removeTarget:self action:@selector(cancelLike:) forControlEvents:UIControlEventTouchUpInside];
//                [button addTarget: self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
//            }
//        }
//        
//        
//    }];

}
-(void)cancelLike:(UIButton*)sender
{
    [sender setBackgroundImage:[UIImage imageNamed:@"喜欢 1"] forState:UIControlStateNormal];
    [sender removeTarget:self action:@selector(cancelLike:) forControlEvents:UIControlEventTouchUpInside];
    [sender addTarget: self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObjectsFromArray:[ud objectForKey:@"shous"]];
    for (int i = 0; i<arr.count; i++) {
        if ([arr[i] isEqualToString:self.did])  {
            [arr removeObjectAtIndex:i];
            [ud setObject:arr forKey:@"shous"];
            [ud synchronize];
            
        }
    }

//    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Collection"];
//    [bquery whereKey:@"user" equalTo:[BmobUser currentUser]];
//    [bquery whereKey:@"did" equalTo:self.did];
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
//                    [query whereKeyExists:@"did"];
//                    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//                        NSMutableArray *arr = [NSMutableArray array];
//                        for(BmobObject *obj in array)
//                        {
//                            NSString *str = [obj objectForKey:@"did"];
//                            [arr addObject:str];
//                        }
//                        [ud setObject:arr forKey:@"shous"];
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
-(void)like:(UIButton*)sender
{
    if ([BmobUser currentUser]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"喜欢 2"] forState:UIControlStateNormal];
        [sender removeTarget:self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
        [sender addTarget: self action:@selector(cancelLike:) forControlEvents:UIControlEventTouchUpInside];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObjectsFromArray:[ud objectForKey:@"shous"]];
        
        int mark = 0;
        for(NSString *string in arr)
        {
            if ([string isEqualToString:self.did]) {
                mark = 1;
            }
            
        }
        if (mark == 0) {
            [arr addObject:self.did];
            [ud setObject:arr forKey:@"shous"];
            [ud synchronize];
        }

//        BmobObject *obj = [BmobObject objectWithClassName:@"Collection"];
//        [obj setObject:self.did forKey:@"did"];
//        [obj setObject:[BmobUser currentUser] forKey:@"user"];
//        [obj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//            if (isSuccessful) {
//                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//                
//                BmobQuery *query = [BmobQuery queryWithClassName:@"Collection"];
//                [query whereKey:@"user" equalTo:[BmobUser currentUser]];
//                [query whereKeyExists:@"did"];
//                [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//                    NSMutableArray *arr = [NSMutableArray array];
//                    for(BmobObject *obj in array)
//                    {
//                        NSString *str = [obj objectForKey:@"did"];
//                        [arr addObject:str];
//                    }
//                    [ud setObject:arr forKey:@"shous"];
//                    
//                    
//                }];
//                
//                
//            }
//            if (error) {
//                NSLog(@"%@",error);
//            }
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
-(void)goback
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.webView.delegate = self;
  // self.webView.scalesPageToFit =YES;
    
   
    
    
    
 
    [self.view addSubview:self.webView];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *data = [ud objectForKey:self.did];
    if (data) {
        InfoDetailObj *object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSString *titleHtml  = @"<Vp><p style=\"font-size:20px; margin-top: 10px; margin-bottom: 10px; padding: 0px; clear: both; line-height: 1.6em; max-width: 100%; text-align: center; box-sizing: border-box !important; word-wrap: break-word !important;\">";
        NSString *subTitleHtml = @"<Vp><p style=\"color:gray; margin-top: 0px; margin-bottom: 30px; padding: 0px; clear: both; line-height: 1.6em; max-width: 100%; text-align: right; box-sizing: border-box !important; word-wrap: break-word !important;\">";
        NSString *html = [NSString stringWithFormat:@"<html><head></head><body>\%@%@\%@%@\%@</body></html>",titleHtml,object.title,subTitleHtml,object.user_name,object.content];
        [self.webView loadHTMLString:html baseURL:nil];
    }
    
    [Util requequstInfoDetaiWithId:self.did rec:^(id obj) {
        InfoDetailObj *object = obj;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:data forKey:self.did];
        [ud synchronize];
        NSString *titleHtml  = @"<Vp><p style=\"font-size:20px; margin-top: 10px; margin-bottom: 10px; padding: 0px; clear: both; line-height: 1.6em; max-width: 100%; text-align: center; box-sizing: border-box !important; word-wrap: break-word !important;\">";
        NSString *subTitleHtml = @"<Vp><p style=\"color:gray; margin-top: 0px; margin-bottom: 30px; padding: 0px; clear: both; line-height: 1.6em; max-width: 100%; text-align: right; box-sizing: border-box !important; word-wrap: break-word !important;\">";
        NSString *html = [NSString stringWithFormat:@"<html><head></head><body>\%@%@\%@%@\%@</body></html>",titleHtml,object.title,subTitleHtml,object.user_name,object.content];
        [self.webView loadHTMLString:html baseURL:nil];
        
      
      
    }];
    
    
    // Do any additional setup after loading the view.
}




#pragma mark UIActionSheetDelegate


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void) webViewDidStartLoad:(UIWebView *)webView
//{
//    //创建UIActivityIndicatorView背底半透明View
//    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [view setTag:108];
//    [view setBackgroundColor:[UIColor darkGrayColor]];
//    [view setAlpha:0.5];
//    [self.view addSubview:view];
//    
//    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
//    [self.activityIndicator setCenter:view.center];
//    [self.activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
//    [view addSubview:self.activityIndicator];
//    
//   // [self.activityIndicator startAnimating];
//}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *js = @"function imgAutoFit() { \
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; ++i) {\
    var img = imgs[i];   \
    img.style.maxWidth = %f;   \
    } \
    }";
    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width - 20];
    [_webView stringByEvaluatingJavaScriptFromString:js];
    
    [_webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
}

//- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    [self.activityIndicator stopAnimating];
//    UIView *view = (UIView*)[self.view viewWithTag:108];
//    [view removeFromSuperview];
//    
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
