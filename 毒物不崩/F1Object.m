//
//  F1Object.m
//  毒物哦
//
//  Created by 一羞 on 16/9/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "F1Object.h"

@implementation F1Object
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.goods_name forKey:@"self.goods_name"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.collect_count forKey:@"collect_count"];
    [aCoder encodeObject:self.img forKey:@"img"];
    [aCoder encodeObject:self.sort_number forKey:@"sort_number"];
    [aCoder encodeDouble:self.img_width forKey:@"img_width"];
    [aCoder encodeObject:self.goods_link forKey:@"goods_link"];
    [aCoder encodeObject:self.goods_price forKey:@"goods_price"];
    [aCoder encodeDouble:self.img_height forKey:@"img_height"];
    [aCoder encodeObject:self.share_id forKey:@"share_id"];
    [aCoder encodeObject:self.img_thumb forKey:@"img_thumb"];
    [aCoder encodeDouble:self.likestatus forKey:@"likestatus"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super init]) {
        self.goods_name = [aDecoder decodeObjectForKey:@"goods_name"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.collect_count = [aDecoder decodeObjectForKey:@"collect_count"];
        self.img = [aDecoder decodeObjectForKey:@"img"];
        self.sort_number = [aDecoder decodeObjectForKey:@"sort_number"];
        self.img_width = [aDecoder decodeDoubleForKey:@"img_width"];
        self.goods_link = [aDecoder decodeObjectForKey:@"goods_link"];
        self.goods_price = [aDecoder decodeObjectForKey:@"goods_price"];
        self.img_height = [aDecoder decodeDoubleForKey:@"img_height"];
        self.share_id = [aDecoder decodeObjectForKey:@"share_id"];
        self.img_thumb = [aDecoder decodeObjectForKey:@"img_thumb"];
        self.likestatus = [aDecoder decodeDoubleForKey:@"likestatus"];
    }
    return self;
    
}

@end
