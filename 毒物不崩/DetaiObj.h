//
//  DetaiObj.h
//  毒物
//
//  Created by 一羞 on 16/9/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface DetaiObj : JSONModel
@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSArray *gallery;
@property (nonatomic, strong) NSString *goods_content;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *collect_count;
@property (nonatomic, assign) double main_img_width;
@property (nonatomic, strong) NSString *brand;
@property (nonatomic, strong) NSString *user_img;
@property (nonatomic, strong) NSString *tbk_link;
@property (nonatomic, assign) double main_img_height;
@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *goods_link;
@property (nonatomic, strong) NSString *category_name;
@property (nonatomic, strong) NSString *main_img;
@property (nonatomic, strong) NSString *goods_price;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, strong) NSString *share_id;
@property (nonatomic, strong) NSString *img_thumb;
@property (nonatomic, assign) double likestatus;
@end
