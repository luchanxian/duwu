//
//  FirstTableViewCell.h
//  毒物
//
//  Created by 一羞 on 16/9/25.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model1.h"
@interface FirstTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *goToG;

@property (weak, nonatomic) IBOutlet UIButton *goToS;
@property (weak, nonatomic) IBOutlet UILabel *g;

@property (weak, nonatomic) IBOutlet UILabel *s;
@property (nonatomic) UITapGestureRecognizer *gesture;
@property (nonatomic)  Model1 *model;
@end
