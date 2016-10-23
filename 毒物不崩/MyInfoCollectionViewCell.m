//
//  MyInfoCollectionViewCell.m
//  毒物不崩
//
//  Created by 一羞 on 16/9/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MyInfoCollectionViewCell.h"
#import "InfoDetailObj.h"
@interface MyInfoCollectionViewCell  ()

@property (nonatomic) UILabel *titileLabel;
@end
@implementation MyInfoCollectionViewCell
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
-(void)setDid:(NSString *)did
{
    
     _did = did;
    [Util requequstInfoDetaiWithId:did rec:^(id obj) {
        InfoDetailObj *object = obj;
        self.titileLabel.text = object.title;
      self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titileLabel.numberOfLines = 2;
        
        self.titileLabel.font = [UIFont systemFontOfSize:10];
        self.titileLabel.textColor = [UIColor darkGrayColor];
        self.titileLabel.textAlignment = NSTextAlignmentCenter;
        //[self.titileLabel sizeToFit];
        
        self.titileLabel.center = CGPointMake(CW/2, CW+20);
        

        
    }];

    
    
   }
@end
