//
//  CommentCell.h
//  毒物
//
//  Created by 一羞 on 16/9/20.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetaiObj.h"
@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *headView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic)  DetaiObj *obj;
@end
