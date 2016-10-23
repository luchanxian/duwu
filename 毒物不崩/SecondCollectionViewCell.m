//
//  SecondCollectionViewCell.m
//  毒物
//
//  Created by 一羞 on 16/9/22.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "SecondCollectionViewCell.h"
@interface SecondCollectionViewCell  ()
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *titileLabel;
@end
@implementation SecondCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CW, CW)];
        
        self.titileLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CW-20, 30)];
        [self addSubview:self.imageView];
        [self addSubview:self.titileLabel];
        
    }
    
    return self;
}
-(void)setObj:(InfoObj *)obj
{
    _obj  = obj;
  
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:obj.thumb] placeholderImage:[UIImage imageNamed:@"欢迎回来@3x.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.41381.000.00.@3x" ] options:SDWebImageRetryFailed];

    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
       self.titileLabel.numberOfLines = 2;
    self.titileLabel.text = obj.title;
    self.titileLabel.font = [UIFont systemFontOfSize:10];
    self.titileLabel.textColor = [UIColor darkGrayColor];
    self.titileLabel.textAlignment = NSTextAlignmentCenter;
    //[self.titileLabel sizeToFit];
    
    self.titileLabel.center = CGPointMake(CW/2, CW+20);
    
}
@end
