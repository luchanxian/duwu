//
//  RecTableViewController.h
//  毒物哦
//
//  Created by 一羞 on 16/9/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecTableViewController : UITableViewController
@property (nonatomic) int index;
-(void)loadObjs;
@property (nonatomic) int count ;
@end
