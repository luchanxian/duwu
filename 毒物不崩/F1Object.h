//
//  F1Object.h
//  毒物哦
//
//  Created by 一羞 on 16/9/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface F1Object : JSONModel<NSCoding>
@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *collect_count;
@property (nonatomic, strong) NSString *user_img;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *sort_number;
@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, assign) double img_width;
@property (nonatomic, strong) NSString *goods_link;
@property (nonatomic, strong) NSString *goods_price;
@property (nonatomic, assign) double img_height;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *share_id;
@property (nonatomic, strong) NSString *img_thumb;
@property (nonatomic, assign) double likestatus;

@end
