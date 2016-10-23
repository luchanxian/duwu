//
//  MyUserTableViewCell.m
//  毒物不崩
//
//  Created by 一羞 on 16/9/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MyUserTableViewCell.h"

@implementation MyUserTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setUid:(NSString *)uid
{
    _uid = uid;
    [Util requequstGunInfoWithId:uid rec:^(id obj) {
        NSDictionary *info = obj;
        self.userName.text = [info objectForKey:@"user_name"];
        NSString *imagePath = [info objectForKey:@"user_img"];
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:imagePath]];
        self.detail.text = [info objectForKey:@"introduce"];
    }];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
