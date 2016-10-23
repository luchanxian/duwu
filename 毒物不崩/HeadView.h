//
//  HeadView.h
//  毒物哦
//
//  Created by 一羞 on 16/9/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadView : UIView
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIView *sortView;
@property (nonatomic) NSArray *sortImages;
@property (nonatomic) double height;

@property (nonatomic) UIButton *moreBt;
@end
