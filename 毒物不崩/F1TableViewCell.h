//
//  F1TableViewCell.h
//  毒物哦
//
//  Created by 一羞 on 16/9/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F1Object.h"
#import "DetaiObj.h"
@interface F1TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *click;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heigtCons;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (nonatomic,copy)NSString  *img;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic)  F1Object *obj;
@property (nonatomic)  DetaiObj *detailObj;
@end
