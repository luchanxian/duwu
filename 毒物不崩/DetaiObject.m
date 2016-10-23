//
//  DetaiObject.m
//  毒物哦
//
//  Created by 一羞 on 16/9/18.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "DetaiObject.h"
NSString *const kInfoGoodsName = @"goods_name";
NSString *const kInfoGallery = @"gallery";
NSString *const kInfoGoodsContent = @"goods_content";
NSString *const kInfoUid = @"uid";
NSString *const kInfoCollectCount = @"collect_count";
NSString *const kInfoMainImgWidth = @"main_img_width";
NSString *const kInfoBrand = @"brand";
NSString *const kInfoUserImg = @"user_img";
NSString *const kInfoTbkLink = @"tbk_link";
NSString *const kInfoMainImgHeight = @"main_img_height";
NSString *const kInfoUserName = @"user_name";
NSString *const kInfoGoodsLink = @"goods_link";
NSString *const kInfoCategoryName = @"category_name";
NSString *const kInfoMainImg = @"main_img";
NSString *const kInfoGoodsPrice = @"goods_price";
NSString *const kInfoCreateTime = @"create_time";
NSString *const kInfoShareId = @"share_id";
NSString *const kInfoImgThumb = @"img_thumb";
NSString *const kInfoLikestatus = @"likestatus";

@implementation DetaiObject
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.goodsName = [self objectOrNilForKey:kInfoGoodsName fromDictionary:dict];
        
        
        self.gallery = [dict objectForKey:kInfoGallery];
        self.goodsContent = [self objectOrNilForKey:kInfoGoodsContent fromDictionary:dict];
        self.uid = [self objectOrNilForKey:kInfoUid fromDictionary:dict];
        self.collectCount = [self objectOrNilForKey:kInfoCollectCount fromDictionary:dict];
        self.mainImgWidth = [[self objectOrNilForKey:kInfoMainImgWidth fromDictionary:dict] doubleValue];
        self.brand = [self objectOrNilForKey:kInfoBrand fromDictionary:dict];
        self.userImg = [self objectOrNilForKey:kInfoUserImg fromDictionary:dict];
        self.tbkLink = [self objectOrNilForKey:kInfoTbkLink fromDictionary:dict];
        self.mainImgHeight = [[self objectOrNilForKey:kInfoMainImgHeight fromDictionary:dict] doubleValue];
        self.userName = [self objectOrNilForKey:kInfoUserName fromDictionary:dict];
        self.goodsLink = [self objectOrNilForKey:kInfoGoodsLink fromDictionary:dict];
        self.categoryName = [self objectOrNilForKey:kInfoCategoryName fromDictionary:dict];
        self.mainImg = [self objectOrNilForKey:kInfoMainImg fromDictionary:dict];
        self.goodsPrice = [self objectOrNilForKey:kInfoGoodsPrice fromDictionary:dict];
        self.createTime = [self objectOrNilForKey:kInfoCreateTime fromDictionary:dict];
        self.shareId = [self objectOrNilForKey:kInfoShareId fromDictionary:dict];
        self.imgThumb = [self objectOrNilForKey:kInfoImgThumb fromDictionary:dict];
        self.likestatus = [[self objectOrNilForKey:kInfoLikestatus fromDictionary:dict] doubleValue];
        
    }
    
    return self;
    
}
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}
@end
