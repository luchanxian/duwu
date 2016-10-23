//
//  DetaiObject.h
//  毒物哦
//
//  Created by 一羞 on 16/9/18.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetaiObject : NSObject
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, strong) NSArray *gallery;
@property (nonatomic, strong) NSString *goodsContent;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *collectCount;
@property (nonatomic, assign) double mainImgWidth;
@property (nonatomic, strong) NSString *brand;
@property (nonatomic, strong) NSString *userImg;
@property (nonatomic, strong) NSString *tbkLink;
@property (nonatomic, assign) double mainImgHeight;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *goodsLink;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSString *mainImg;
@property (nonatomic, strong) NSString *goodsPrice;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *shareId;
@property (nonatomic, strong) NSString *imgThumb;
@property (nonatomic, assign) double likestatus;


- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
