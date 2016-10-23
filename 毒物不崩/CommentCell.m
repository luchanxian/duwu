//
//  CommentCell.m
//  毒物
//
//  Created by 一羞 on 16/9/20.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (IBAction)clickTo:(id)sender {
}

- (void)awakeFromNib {
    // Initialization code
}
-(void)setObj:(DetaiObj *)obj
{
    _obj = obj;
  
    [self.headView sd_setBackgroundImageWithURL:[NSURL URLWithString:obj.user_img] forState:UIControlStateNormal placeholderImage:nil options:SDWebImageRetryFailed];
    self.userName.text = obj.user_name;
    self.detailLabel.text = obj.goods_content;
    self.timeLabel.text = obj.create_time;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
