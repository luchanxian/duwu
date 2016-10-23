//
//  SecondTableViewCell.m
//  毒物
//
//  Created by 一羞 on 16/9/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "SecondTableViewCell.h"
#import "DetaiObj.h"
#import "DetailViewController.h"
int b = 0;
@interface SecondTableViewCell ()


@end
@implementation SecondTableViewCell
- (void)awakeFromNib {
    

}

-(void)setCount:(int)count
{
    NSUserDefaults *ud =[NSUserDefaults standardUserDefaults];
    NSMutableArray *arr = [ud objectForKey:@"likes"];
    
    if (arr.count!=0) {
        
        
        self.showImageView.hidden = YES;
        
        NSArray *arrr = self.contentView.subviews;
        for (int a = 0; a<arrr.count; a++) {
//            
            
                UIView *view =arrr[a];
            if (!(view.tag>=100)) {
                 [view removeFromSuperview];
            }
            
           
           
            
        }
        for(int a= 0 ; a<arr.count;a++)
        {
            
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            NSString *str = [ud objectForKey:[NSString stringWithFormat:@"image%d",a]];
            
            int row = a%3;
            int section = a/3;
            UIButton *imageView = [[UIButton alloc]initWithFrame:CGRectMake(5+((SW-20)/3+5)*row, 35+5+((SW-20)/3+5)*section, (SW-20)/3, (SW-20)/3)];
            imageView.tag = a;
            [imageView sd_setBackgroundImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal];
            [ self.contentView addSubview:imageView];
            
            
              [imageView addTarget:self action:@selector(goTO:) forControlEvents:UIControlEventTouchUpInside];
            
            [Util requequeswithString:arr[a] callback:^(id obj) {
                
                
                NSMutableArray *comments = obj;
                DetaiObj *dobj  = comments[0];
                //                int row = a%3;
                //                int section = a/3;
                //                UIButton *imageView = [[UIButton alloc]initWithFrame:CGRectMake(5+((SW-20)/3+5)*row, 35+5+((SW-20)/3+5)*section, (SW-20)/3, (SW-20)/3)];
                //                imageView.tag = a;
                [imageView sd_setBackgroundImageWithURL:[NSURL URLWithString:dobj.main_img] forState:UIControlStateNormal];
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud setObject:dobj.main_img forKey:[NSString stringWithFormat:@"image%d",a]];
                [ud synchronize];
                //                [ self.contentView addSubview:imageView];
                
                
              
                
            }];

            
        }
        
    }
    else
    {
        NSArray *arrr = self.contentView.subviews;
        for (int a = 0; a<arrr.count; a++) {
            //
            
            UIView *view =arrr[a];
            if (!(view.tag>=100)) {
                [view removeFromSuperview];
            }
            
            
            
            
        }
        self.showImageView.hidden =NO;
    }
}
-(void)goTO:(UIButton *)sender
{
    
    NSUserDefaults *ud =[NSUserDefaults standardUserDefaults];
    NSMutableArray *arr = [ud objectForKey:@"likes"];
    DetailViewController *vc = [DetailViewController new];
    vc.shareId = arr[sender.tag];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
    UITabBarController *tabC = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *naviC = (UINavigationController*)tabC.viewControllers.lastObject;
    [naviC presentViewController:navi animated:YES completion:nil];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
