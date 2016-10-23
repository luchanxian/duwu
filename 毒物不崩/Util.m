//
//  Util.m
//  毒物
//
//  Created by 一羞 on 16/9/23.
//  Copyright © 2016年 Apple. All rights reserved.
//
#import "GuanObj.h"
#import "Util.h"
#import <AFNetworking.h>
#import "F1Object.h"
#import "RecTableViewController.h"
#import "DetaiObj.h"
#import "InfoObj.h"
#import "CollectionViewController.h"
#import "InfoDetailObj.h"
#import "SearchModel.h"
@implementation Util
+(void)requequstGunInfoWithNumber:(int)number sortUid:(NSString *)uid rec:(CallBack)callback
{
    NSString *string =@"%2C1&action=usershares&_opv=10.0.1&_op=IOS";
    NSString *path = [NSString stringWithFormat:@"http://www.1626.com/hi1626/apps_api.php?uid=%@&p=%d&_ver=2.1.1&_udid=93FAA002-7ED0-4385-9646-92BF334F562B&_p=iPhone7%@",uid,number,string];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager POST:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        //NSLog(@"%@",dic);
        NSArray *info = dic[@"info"];
        NSArray *objs = [GuanObj arrayOfModelsFromDictionaries:info error:nil];
        
        
        
        
        
        
        callback(objs);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
+(void)requequstGunInfoWithId:(NSString*)uid rec:(CallBack)callback
{
    NSString *string =@"%2C1&action=userinfo&_opv=10.0.1&_op=IOS";
    NSString *path = [NSString stringWithFormat:@"http://www.1626.com/hi1626/apps_api.php?uid=%@&_ver=2.1.1&c_uid=349968&_udid=93FAA002-7ED0-4385-9646-92BF334F562B&_p=iPhone7%@",uid,string];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager POST:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        //NSLog(@"%@",dic);
        NSDictionary *info = dic[@"info"];
        
        
        
        
        
        callback(info);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
+(void)requequstwithNumber:(int)number sortNum:(int)sortNum rec:(CallBack)callback
{
    NSString *string =@"%2C1&action=lists&_op=IOS&cid=";
    NSString *path = [NSString stringWithFormat:@"http://www.1626.com/hi1626/apps_api.php?_opv=10.0.1&uid=349968&p=%d&_ver=2.1.1&_udid=93FAA002-7ED0-4385-9646-92BF334F562B&ver=2.0&_p=iPhone7%@%d",number,string,sortNum];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager POST:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        //NSLog(@"%@",dic);
        NSArray *info = dic[@"info"];
        
        NSArray *arr = [F1Object arrayOfModelsFromDictionaries:info error:nil];
        
        
        callback(arr);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
+(void)requequeswithString:(NSString *)str callback:(CallBack)callback
{
    NSString *string =@"http://www.1626.com/hi1626/apps_api.php?uid=&_ver=2.1.1&_udid=93FAA002-7ED0-4385-9646-92BF334F562B&_p=iPhone7%2C1&action=note&sid=";
    NSString *path = [NSString stringWithFormat:@"%@%@&_opv=10.0.1&_op=IOS",string,str];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager POST:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        // NSLog(@"%@",dic);
        NSDictionary *info = dic[@"info"];
        NSMutableArray *comments  = [NSMutableArray new];
    
        DetaiObj *obj = [[DetaiObj alloc]initWithDictionary:info error:nil];
        if (obj) {
            [comments addObject:obj];

        }
                         callback(comments);

        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
+(void)requequstInfoWithNumber:(int)number sortNum:(int)sortNum rec:(CallBack)callback
{
    NSString *string =@"%2C1&action=zixun_list&_op=IOS&cid=";
    NSString *path = [NSString stringWithFormat:@"http://www.1626.com/hi1626/apps_api.php?_opv=10.0.1&uid=349968&p=%d&_ver=2.1.1&_udid=93FAA002-7ED0-4385-9646-92BF334F562B&_p=iPhone7%@%d",number,string,sortNum];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager POST:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        // NSLog(@"%@",dic);
        NSArray *info = dic[@"info"];
        
        NSArray *arr = [InfoObj arrayOfModelsFromDictionaries:info error:nil];
        callback(arr);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
+(void)clickTo:(UIButton*)sender//
{
    NSLog(@"%ld",sender.tag);
    RecTableViewController *vc =[RecTableViewController new];
    UINavigationController *naviC = [UINavigationController new];
    UITabBarController *tabVC = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController ;
    naviC = tabVC.viewControllers.firstObject;
    vc = naviC.viewControllers.firstObject;
    vc.index = @(sender.tag).intValue ;
    vc.count = 2;

  
    [vc loadObjs];
    
    
    
}
+(void)requequstInfoDetaiWithId:(NSString*)did rec:(CallBack)callback
{
    NSString *string =@"%2C1&action=zixun_info&_opv=10.0.1&_op=IOS";
    NSString *path = [NSString stringWithFormat:@"http://www.1626.com/hi1626/apps_api.php?uid=349968&_ver=2.1.1&id=%@&_udid=93FAA002-7ED0-4385-9646-92BF334F562B&_p=iPhone7%@",did,string];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager POST:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        // NSLog(@"%@",dic);
        NSDictionary *info = dic[@"info"];
        
        InfoDetailObj *obj = [[InfoDetailObj alloc ]initWithDictionary:info error:nil];
        callback(obj);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
+(void)requestSeachResultWithString:(NSString*)string rec:(CallBack)callback
{
    NSString *sss = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *str =@"%2C1&_op=IOS&_opv=10.0.1";
    NSString *path = [NSString stringWithFormat:@"http://www.1626.com/hi1626/apps_api.php?uid=349968&type=goods&p=1&_udid=93FAA002-7ED0-4385-9646-92BF334F562B&_ver=2.1.1&kw=%@&action=search1&_p=iPhone7%@",sss,str];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager POST:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        // NSLog(@"%@",dic);
        NSDictionary *info = dic[@"info"];
        
        NSArray *list = info[@"list"];
        NSArray *arr = [SearchModel arrayOfModelsFromDictionaries:list error:nil];
        callback(arr);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}
+(void)goOtherSort:(UIButton*)sender
{
    NSLog(@"%ld",sender.tag);
    CollectionViewController *vc =[CollectionViewController new];
    UINavigationController *naviC = [UINavigationController new];
    UITabBarController *tabVC = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController ;
    naviC = tabVC.viewControllers[1];
    vc = naviC.viewControllers[0];
    vc.sortNum= @(sender.tag).intValue ;
    vc.count = 1;
    [vc loadData];
}
@end
