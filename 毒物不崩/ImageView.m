//
//  ImageView.m
//  毒物
//
//  Created by 一羞 on 16/9/21.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ImageView.h"
#import "InfoWebViewController.h"
#import "CollectionViewController.h"
@interface ImageView  ()
@property (nonatomic) UILabel *label;
@property (nonatomic) UIView *frontView;
@end
@implementation ImageView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frontView = [[UIView alloc]initWithFrame:self.bounds];
        self.frontView .backgroundColor = [UIColor blackColor];
        self.frontView.alpha = 0.1;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:gesture];
        self.userInteractionEnabled =YES;
       
        [self addSubview:self.frontView];
        self.label = [[UILabel alloc]init];
         [self addSubview:self.label];
        
        
        
        

    }
    
    
    return self;
}
-(void)tap :(UIPanGestureRecognizer *)sender
{
    InfoWebViewController *vc1 = [[InfoWebViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc1];
    InfoObj *obj = self.obj;
    vc1.did = obj.did;
    CollectionViewController *vc =[CollectionViewController new];
    UINavigationController *naviC = [UINavigationController new];
    UITabBarController *tabVC = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController ;
    naviC = tabVC.viewControllers[1];
    vc = naviC.viewControllers[0];
    [vc presentViewController:navi animated:YES completion:nil];
}
-(void)setObj:(InfoObj *)obj
{
    _obj = obj;
    
     [self sd_setImageWithURL:[NSURL URLWithString:obj.thumb] placeholderImage:[UIImage imageNamed:@"欢迎回来@3x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.41381.000.00.@3x" ] options:SDWebImageRetryFailed];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [manager downloadImageWithURL:[NSURL URLWithString:obj.thumb] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
       
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        
        
    }];
    self.label.text = self.obj.title;
   
    self.label.textColor = [UIColor whiteColor];
    [self.label sizeToFit];
    self.label.bounds = CGRectMake(0, 0, SW-30, 0);
     self.label.font = [UIFont systemFontOfSize:25];
    self.label.numberOfLines =2;
    [self.label sizeToFit];
    self.label.textAlignment = NSTextAlignmentCenter;
   
    self.label.center = self.frontView.center;

}


@end
