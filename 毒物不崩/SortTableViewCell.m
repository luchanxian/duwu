//
//  SortTableViewCell.m
//  毒物哦
//
//  Created by 一羞 on 16/9/18.
//  Copyright © 2016年 Apple. All rights reserved.
//
#import "Util.h"
#import "SortTableViewCell.h"
@interface SortTableViewCell ()<UIScrollViewDelegate>
@property (nonatomic) NSArray *sortImages;
@end


@implementation SortTableViewCell

- (void)awakeFromNib {
    self.sortImages = @[@"推荐",@"男装",@"女装",@"男鞋"
                        ,@"女鞋",@"箱包",@"配饰",@"数码",@"设计",@"玩具",@"滑板",@"其他",@"更多"];
    int count = 0;
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<5; j++) {
            if (i==1&&j==2) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                self.backB = button;
                [button setBackgroundColor:[UIColor darkGrayColor]];
                [button setTitle:@"<<" forState:UIControlStateNormal];
                [button setFrame:CGRectMake(8+j*(8+(SW-6*8)/5), i*(8+(SW-6*8)/5), (SW-6*8)/5, (SW-6*8)/5)];
                
                [self addSubview:button];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
                break;
            }
            if  (i==1&&j>2) {
                break;
            }
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            [button setBackgroundImage:[UIImage imageNamed: self.sortImages[count+5]] forState:UIControlStateNormal];
            [button setTitle:self.sortImages[count+5] forState:UIControlStateNormal];
            [button setFrame:CGRectMake(8+j*(8+(SW-6*8)/5), ((SW-6*8)/5+8)*i, (SW-6*8)/5, (SW-6*8)/5)];
            button.tag = count+5;
            count++;
            [button addTarget:[Util class] action:@selector(clickTo:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:button];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
            
            
            
            // [button setFrame:CGRectMake(8+j*(8+(SW-6*8)/5), 8+((SW-6*8)/5+8)*(i+1), (SW-6*8)/5, (SW-6*8)/5)];
            
        }
    }

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
