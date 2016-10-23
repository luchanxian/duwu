//
//  F1TableViewCell.m
//  毒物哦
//
//  Created by 一羞 on 16/9/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "F1TableViewCell.h"
#define MAS_SHORTHAND_GLOBALS
#import "PhotoBroswerVC.h"
#import <UIImageView+WebCache.h>

@interface F1TableViewCell ()<UIScrollViewDelegate>
@property (nonatomic) UIPageControl *pageC;
@property (nonatomic) NSMutableArray *imagePath;
@end
@implementation F1TableViewCell
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    long int page = lroundf(scrollView.contentOffset.x / width);
   self.pageC.currentPage = page ;
}
- (void)awakeFromNib {
    
  
    }
-(void)setObj:(F1Object *)obj
{
    _obj = obj;
    self.heigtCons.constant = SW*obj.img_height/obj.img_width;
    self.scrollView.contentSize = CGSizeMake(SW, SW*obj.img_height/obj.img_width);
    NSArray *arr =    self.scrollView.subviews;
    for (UIView *view in arr)
    {
        [view removeFromSuperview];
    }
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SW, SW*obj.img_height/obj.img_width)];

    [imageView sd_setImageWithURL:[NSURL URLWithString:obj.img] placeholderImage:[UIImage imageNamed:@"欢迎回来@3x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.41381.000.00.@3x" ] options:SDWebImageRetryFailed];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    [manager downloadImageWithURL:[NSURL URLWithString:obj.img] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
       
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        
        
    }];
   [self.scrollView addSubview:imageView];
    self.titleLabel.text = [obj.goods_name stringByRemovingPercentEncoding];
    self.likeCount.text = obj.collect_count ;
    self.priceLabel.text = [NSString stringWithFormat:@"%@%@",@"￥",obj.goods_price];
    self.scrollView.userInteractionEnabled= NO;
    imageView.userInteractionEnabled = NO;
 
    
}
-(void)setDetailObj:(DetaiObj *)detailObj
{
    

    
    _detailObj = detailObj;
    if (!_detailObj ) {
        return;
    }
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator =NO;
    self.imagePath = [NSMutableArray new];
    self.scrollView.delegate = self;
   
    self.pageC = [[UIPageControl alloc]init];
    
     [self addSubview:self.pageC];
    self.pageC.pageIndicatorTintColor = [UIColor darkGrayColor];
    self.pageC.center=    CGPointMake(SW/2, SW-20);
    self.heigtCons.constant = SW;
   
    
    
    self.scrollView.contentSize = CGSizeMake(SW*(1+detailObj.gallery.count), SW);
   
    
    for (int i = 0; i<detailObj.gallery.count+1; i++) {
       
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(SW*(i), 0, SW, SW)];
        if (i==0) {
            
                [image sd_setImageWithURL:[NSURL URLWithString:detailObj.main_img] placeholderImage:[UIImage imageNamed:@"欢迎回来@3x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.41381.000.00.@3x" ] options:SDWebImageRetryFailed];
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            
            [manager downloadImageWithURL:[NSURL URLWithString:detailObj.main_img] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
             
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                
                
                
            }];

           image.contentMode = UIViewContentModeScaleAspectFit;
           [self.imagePath addObject:detailObj.main_img];
            
        }
        else
        {
        NSDictionary *dic = detailObj.gallery[i-1];
        
            
            [image sd_setImageWithURL:[NSURL URLWithString:dic[@"gal"]] placeholderImage:[UIImage imageNamed:@"欢迎回来@3x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.41381.000.00.@3x" ] options:SDWebImageRetryFailed];
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            
            [manager downloadImageWithURL:[NSURL URLWithString:dic[@"gal"]] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
               
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                
                
                
            }];

        image.contentMode = UIViewContentModeScaleAspectFit;
        [self.imagePath addObject:dic[@"gal"]];
        }
        [self.scrollView addSubview: image];
        image.tag = i;
   
            self.pageC.numberOfPages = self.imagePath.count;
        
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openPhotoVC:)];
        [image addGestureRecognizer:gesture];
        image.userInteractionEnabled = YES;
        
        
    }

    
    
    
   
    self.titleLabel.text = [detailObj.goods_name stringByRemovingPercentEncoding];
    self.likeCount.text = detailObj.collect_count ;
    self.priceLabel.text = [NSString stringWithFormat:@"%@%@",@"￥",detailObj.goods_price];
    [self.click setTitle:@"购买" forState:UIControlStateNormal];
    
   
}
-(void)openPhotoVC:(UITapGestureRecognizer*)tap
{
    UIImageView *iv = (UIImageView *)tap.view;
    //[UIApplication sharedApplication].keyWindow.rootViewController 得到的是当前程序window的根页面
    
    
    
    [PhotoBroswerVC show:[UIApplication sharedApplication].keyWindow.rootViewController type:PhotoBroswerVCTypeZoom index:iv.tag photoModelBlock:^NSArray *{
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:self.imagePath.count];
        
        
        for (NSUInteger i = 0; i< self.imagePath.count; i++) {
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i+1 ;
            
            NSString *path = self.imagePath[i];
            
            //设置查看大图的时候的图片地址
            pbModel.image_HD_U = path;
            
            //源图片的frame
            UIImageView *imageV =(UIImageView *) self.scrollView.subviews[i];
            pbModel.sourceImageView = imageV;
            [modelsM addObject:pbModel];
        }
        return modelsM;
        
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
