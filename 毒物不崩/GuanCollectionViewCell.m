//
//  GuanCollectionViewCell.m
//  毒物不崩
//
//  Created by 一羞 on 16/9/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "GuanCollectionViewCell.h"

@implementation GuanCollectionViewCell
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
        self.lanel.text = [info objectForKey:@"introduce"];
    }];
    
}
@end
