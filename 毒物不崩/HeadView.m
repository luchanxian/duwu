//
//  HeadView.m
//  毒物哦
//
//  Created by 一羞 on 16/9/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "HeadView.h"
#import "Util.h"
#import "F1Object.h"
#import <UIButton+WebCache.h>
#import "DetailViewController.h"
#import "RecTableViewController.h"

@interface HeadView ()<UIScrollViewDelegate>
@property (nonatomic) NSMutableArray *arr;
@property (nonatomic) UIPageControl *pageControll;
@property (nonatomic)  RecTableViewController *recVc;
@property (nonatomic) NSArray *datas;
@end
@implementation HeadView
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    long int page = lroundf(scrollView.contentOffset.x / width);
    // 2 1 2 1
    if (page == 0) {
        [scrollView setContentOffset:CGPointMake(3*width, 0) animated:NO];
        return;
    }
    if (page == 4) {
        [scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
        return;
    }
    self.pageControll.currentPage = page - 1;

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    long int page = lroundf(scrollView.contentOffset.x / width);
    // 2 1 2 1
    if (page == 0) {
        return;
    }
    if (page == 4) {
        return;
    }
    self.pageControll.currentPage = page - 1;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        
        NSData *data = [ud objectForKey:@"headView"];
        if (data) {
            self.datas = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            self.scrollView.delegate = self;
            self.pageControll = [[UIPageControl alloc] init];
            self.pageControll.numberOfPages = 3;
            self.pageControll.center = CGPointMake(0, SW-10);
            self.pageControll.currentPageIndicatorTintColor = [UIColor lightGrayColor];
            [self.scrollView setContentOffset:CGPointMake(SW, 0)];
            
            [self addSubview:self.pageControll];
        }

        [Util requequstwithNumber:10 sortNum:0 rec:^(id obj) {
            self.datas = obj;
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.datas];
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:data forKey:@"headView"];
            [ud synchronize];

            self.scrollView.delegate = self;
            //self.pageControll = [[UIPageControl alloc] init];
            //self.pageControll.numberOfPages = 3;
            //self.pageControll.center = CGPointMake(SW/2, SW-10);
            //self.pageControll.currentPageIndicatorTintColor = [UIColor lightGrayColor];
            //[self.scrollView setContentOffset:CGPointMake(SW, 0)];
            
            //[self addSubview:self.pageControll];
        }];
              
       [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changeOffset:) userInfo:nil repeats:YES];
        
        [self sortView];
        
        
    }
    return self;
}
- (void)changeOffset:sender{
    //动画修改偏移量   Duration:动画时长
    [UIView animateWithDuration:0.5 animations:^{
        //动画终结状态时,视图的样式
        self.scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x + _scrollView.frame.size.width, 0);
    } completion:^(BOOL finished) {
        //动画结束后,调用
        [self scrollViewDidEndDecelerating:_scrollView];
    }];
}

- (UIScrollView *)scrollView {
    

   // NSLog(@"%@",self.datas);
    if(_scrollView == nil) {
       
       
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,SW, SW)];
        _scrollView.contentSize = CGSizeMake(SW*5, SW);
        [self addSubview:_scrollView];
        for (int i = 0; i < 5; i++) {
            if (i == 0) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                button.frame = CGRectMake(SW*i, 0, SW, SW);
                F1Object *obj =  self.datas[2];
                button.tag = 2;
                NSString *imagePath = obj.img;
               // NSLog(@"%@dd",imagePath);
                NSURL *imageURL = [NSURL URLWithString:imagePath];
                //NSLog(@"%@",self.arr);
                button.tag = i;
                
                
                [button sd_setBackgroundImageWithURL:imageURL forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"欢迎回来@3x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.41381.000.00.@3x" ] options:SDWebImageRetryFailed];

                
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                
                [manager downloadImageWithURL:imageURL options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                      
                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    
                    
                    
                }];
                
               
               
                [ button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                [_scrollView addSubview:button];
            }
            else if (i == 4)
            {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                button.frame = CGRectMake(SW*i, 0, SW, SW);
                F1Object *obj =  self.datas[0];
                button.tag = 0;
                NSString *imagePath = obj.img;
                NSURL *imageURL = [NSURL URLWithString:imagePath];
                button.tag = 2;
                [button sd_setBackgroundImageWithURL:imageURL forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"欢迎回来@3x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.41381.000.00.@3x" ] options:SDWebImageRetryFailed];
                
                 
                [ button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                [_scrollView addSubview:button];
            }
            else
            {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                button.frame = CGRectMake(SW*i, 0, SW, SW);
                F1Object *obj =  self.datas[i-1];
                button.tag = i-1;
                NSString *imagePath = obj.img;
                NSURL *imageURL = [NSURL URLWithString:imagePath];
                button.tag = i-1;
              
                 [button sd_setBackgroundImageWithURL:imageURL forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"欢迎回来@3x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.41381.000.00.@3x"] options:SDWebImageRetryFailed];
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                
                [manager downloadImageWithURL:imageURL options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    
                 
                    
                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    
                    
                    
                }];
                [ button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                [_scrollView addSubview:button];
            }
             _scrollView.showsHorizontalScrollIndicator = NO;
             _scrollView.pagingEnabled = YES;
        }
        
        
    }
    return _scrollView;
}
-(void)click:(UIButton*)sender
{
    DetailViewController *vc = [DetailViewController new];
    F1Object *obj = self.datas[sender.tag];
    vc.shareId = obj.share_id;
    vc.img = obj.img;
    UITabBarController *tabVc = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController ;
    self.recVc = tabVc.viewControllers.firstObject;
    UINavigationController *naviC = [[UINavigationController alloc]initWithRootViewController:vc];
    
    
    //self.definesPresentationContext = YES; //self is presenting view controller
    vc.view.alpha = 0;    //    testVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    naviC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    naviC.view.backgroundColor = [UIColor clearColor];
    
    
    [self.recVc presentViewController:naviC animated:NO completion:nil];
    

    
}
- (UIView *)sortView {
    if(_sortView == nil) {
        _sortView = [[UIView alloc] initWithFrame:CGRectMake(0, SW, SW, (SW-6*8)/5*3+16+8*2)];
        self.sortImages = @[@"推荐",@"男装",@"女装",@"男鞋"
                            ,@"女鞋",@"箱包",@"配饰",@"数码",@"设计",@"玩具",@"滑板",@"其他",@"更多"];
        for (int i = 0; i<5; i++) {
            if (i==4) {
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                [button setBackgroundImage:[UIImage imageNamed: self.sortImages[12]] forState:UIControlStateNormal];
                [button setTitle:self.sortImages[12] forState:UIControlStateNormal];
                [button setFrame:CGRectMake(8+i*(8+(SW-6*8)/5), 8, (SW-6*8)/5, (SW-6*8)/5)];
                self.moreBt = button;
                
                
                
                
                
                [_sortView addSubview:button];
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
                
                break;
            }
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            [button setBackgroundImage:[UIImage imageNamed: self.sortImages[i]] forState:UIControlStateNormal];
            [button setTitle:self.sortImages[i] forState:UIControlStateNormal];
            [button setFrame:CGRectMake(8+i*(8+(SW-6*8)/5), 8, (SW-6*8)/5, (SW-6*8)/5)];
            button.tag = i;
            [button addTarget:[Util class] action:@selector(clickTo:) forControlEvents:UIControlEventTouchUpInside];
            
            [_sortView addSubview:button];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        }
       
      
        [self addSubview:_sortView];
    }
    return _sortView;
}




       
        
    

-(double)height
{
    if (_height == 0) {
        return SW+(SW-6*8)/5+16;
    }
    return _height;
}
- (NSMutableArray *)arr {
	if(_arr == nil) {
        
       
		_arr = [[NSMutableArray alloc] init];
        	}
   
	return _arr
    ;
}





@end
