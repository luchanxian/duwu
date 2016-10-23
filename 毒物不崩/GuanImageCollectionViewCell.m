//
//  GuanImageCollectionViewCell.m
//  毒物不崩
//
//  Created by 一羞 on 16/9/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "GuanImageCollectionViewCell.h"

@implementation GuanImageCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setObj:(GuanObj *)obj
{
    _obj = obj;
    [self.image sd_setImageWithURL:[NSURL URLWithString:self.obj.thumb]];
}
@end
