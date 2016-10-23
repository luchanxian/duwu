//
//  FirstTableViewCell.m
//  毒物
//
//  Created by 一羞 on 16/9/25.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "FirstTableViewCell.h"
#import "AddNameAndPicViewController.h"
#import "TabViewController.h"
#import "MyUserTableViewController.h"
@interface FirstTableViewCell ()

@end
@implementation FirstTableViewCell



- (void)awakeFromNib {
     self.gesture = [[UITapGestureRecognizer alloc]init];
    self.headImage.userInteractionEnabled = YES;
    [self.headImage addGestureRecognizer:self.gesture];
    
}

-(void)setModel:(Model1 *)model
{
    _model = model;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.headImage]];
    self.userName.text = model.userName;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arr = [ud objectForKey:@"guans"];
    NSMutableArray *arrr = [ud objectForKey:@"shous"];
    self.g.text = @(arr.count).stringValue;
 
    self.s.text = @(arrr.count).stringValue;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
