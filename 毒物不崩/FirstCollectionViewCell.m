//
//  FirstCollectionViewCell.m
//  毒物
//
//  Created by 一羞 on 16/9/21.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "FirstCollectionViewCell.h"
#import "ImageView.h"
#import "Util.h"
static int tag = 0;
@interface FirstCollectionViewCell  ()<UIScrollViewDelegate>
@property (nonatomic) UIScrollView *PageScrollView;
@property (nonatomic)  UIScrollView *SortScrollView;
@property (nonatomic) UIPageControl *pageController;
@property (nonatomic) NSArray *arr;

@end

@implementation FirstCollectionViewCell
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
    self.pageController.currentPage = page - 1;
    
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
    self.pageController.currentPage = page - 1;
}
- (void)changeOffset:sender{
    //动画修改偏移量  Duration:动画时长
    [UIView animateWithDuration:0.5 animations:^{
        //动画终结状态时,视图的样式
        self.PageScrollView.contentOffset = CGPointMake( self.PageScrollView.contentOffset.x +  self.PageScrollView.frame.size.width, 0);
    } completion:^(BOOL finished) {
        //动画结束后,调用
        [self scrollViewDidEndDecelerating: self.PageScrollView];
    }];
}
-(void)loadOther:(UIButton*)sender
{
    if (tag == 0) {
        sender.selected = YES;
        tag = @(sender.tag).intValue;
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIView *view = [self.SortScrollView viewWithTag:tag+100];
        view.hidden = NO;
    }
    if (tag!=0) {
        UIButton *button =   [self.SortScrollView viewWithTag:tag];
        button.selected = NO;
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        UIView *view = [self.SortScrollView viewWithTag:tag+100];
        view.hidden = YES;
    }
    sender.selected = YES;
    tag = @(sender.tag).intValue;
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIView *view = [self.SortScrollView viewWithTag:tag+100];
    view.hidden = NO;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
        self.PageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SW, SW*213.0/321)];
        self.PageScrollView.pagingEnabled =YES;
        self.PageScrollView.showsHorizontalScrollIndicator = NO;
        self.PageScrollView.contentSize = CGSizeMake(SW*5,SW*213.0/321 );
        self.PageScrollView.delegate = self;
        [self addSubview: self.PageScrollView];
        self.SortScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SW*213.0/321, SW, 48)];
        self.SortScrollView.contentSize = CGSizeMake(SW/6*11, 48);
        NSArray *titiles = @[@"推荐",@"独家",@"潮讯",@"潮着",@"手表",@"毒鞋",@"APP",@"动向",@"怪趣",@"买物",@"人物志"];
        NSArray *ids = @[@"1000",@"1038",@"225",@"15",@"1016",@"1045",@"1037",@"1007",@"1047",@"1041",@"1043"];
        for (int i = 0;i<titiles.count;i++) {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i*SW/6, 0, SW/6, 48)];
            UIView *lightView = [[UIView alloc]init];
            lightView.backgroundColor = [UIColor orangeColor];
            [lightView setFrame:CGRectMake(0, 0, SW/6-30, 5)];
            double centerX = button.center.x;
            lightView.center =CGPointMake(centerX, 48-2.5);
            lightView.hidden = YES;
            
            lightView.tag = [ids[i] intValue]+100;
            [self.SortScrollView addSubview:lightView];
            self.SortScrollView.showsHorizontalScrollIndicator = NO;
            [button setTitle:titiles[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor darkGrayColor]  forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor]  forState:UIControlStateHighlighted];
            if (i == 0) {
                lightView.hidden = NO;
                button.selected = YES;
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                tag = 1000;
            }
            button.tag = [ids[i] intValue];
            self.moreBt = button;
            [button addTarget:self action:@selector(loadOther:) forControlEvents:UIControlEventTouchUpInside];
            [button addTarget:[Util class] action:@selector(goOtherSort:) forControlEvents:UIControlEventTouchUpInside];
            [self.SortScrollView addSubview:button];
            
        }
        
        self.PageScrollView.contentOffset = CGPointMake(SW, 0);
        [self addSubview:self.SortScrollView];
        self.pageController = [[UIPageControl alloc]init];
        self.pageController.numberOfPages = 3;
        self.pageController.center = CGPointMake(SW/2,SW*213.0/321 -10);
        [self addSubview:self.pageController];
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changeOffset:) userInfo:nil repeats:YES];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        
        NSData *data = [ud objectForKey:@"InfoHead"];
        if (data) {
            self.arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            for (int i = 0; i<5; i++) {
                if (i == 0) {
                    InfoObj *obj = self.arr[2];
                    ImageView *imageView = [[ImageView alloc]initWithFrame:CGRectMake(i*SW,0,SW, SW*213.0/321)];
                    imageView.obj = obj;
                    [self.PageScrollView addSubview:imageView];
                }
                else if(i == 4)
                {
                    
                    InfoObj *obj = self.arr[0];
                    ImageView *imageView = [[ImageView alloc]initWithFrame:CGRectMake(i*SW,0,SW, SW*213.0/321)];
                    imageView.obj = obj;
                    [self.PageScrollView addSubview:imageView];
                    
                }
                else
                {
                    InfoObj *obj = self.arr[i-1];
                    ImageView *imageView = [[ImageView alloc]initWithFrame:CGRectMake(i*SW,0,SW, SW*213.0/321)];
                    imageView.obj = obj;
                    [self.PageScrollView addSubview:imageView];
                    
                }
                
                
                
            }

        }
        
        

        [Util requequstInfoWithNumber:1 sortNum:225 rec:^(id obj) {
            self.arr = obj;
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.arr];
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:data forKey:@"InfoHead"];
            [ud synchronize];

            for (int i = 0; i<5; i++) {
                if (i == 0) {
                    InfoObj *obj = self.arr[2];
                    ImageView *imageView = [[ImageView alloc]initWithFrame:CGRectMake(i*SW,0,SW, SW*213.0/321)];
                    imageView.obj = obj;
                    [self.PageScrollView addSubview:imageView];
                }
                else if(i == 4)
                {
                    
                    InfoObj *obj = self.arr[0];
                    ImageView *imageView = [[ImageView alloc]initWithFrame:CGRectMake(i*SW,0,SW, SW*213.0/321)];
                  imageView.obj = obj;
                    [self.PageScrollView addSubview:imageView];
                    
                }
                else
                {
                    InfoObj *obj = self.arr[i-1];
                    ImageView *imageView = [[ImageView alloc]initWithFrame:CGRectMake(i*SW,0,SW, SW*213.0/321)];
                    imageView.obj = obj;
                    [self.PageScrollView addSubview:imageView];
                    
                }
                
                
                
            }
            
            
        }];
        
        
        
    }
    return self;
}

-(void)loadFirst
{
   }
-(double)height

{
    if (_height == 0) {
        _height = SW*213.0/321+48;
    }
    return _height;
}
@end