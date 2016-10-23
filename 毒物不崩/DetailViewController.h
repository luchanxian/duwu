//
//  DetailViewController.h
//  毒物
//
//  Created by 一羞 on 16/9/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYTextView.h"
@interface DetailViewController : UIViewController
@property (nonatomic,copy) NSString *shareId;
@property (weak, nonatomic) IBOutlet UIButton *likeBt;
@property (nonatomic,copy) NSString  *img;
@property (nonatomic) int a ;
@end
