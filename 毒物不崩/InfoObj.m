//
//  InfoObj.m
//  毒物
//
//  Created by 一羞 on 16/9/21.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "InfoObj.h"

@implementation InfoObj
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.did forKey:@"did"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.thumb forKey:@"thumb"];
    
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super init]) {
        self.did = [aDecoder decodeObjectForKey:@"did"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.thumb = [aDecoder decodeObjectForKey:@"thumb"];
           }
    return self;
    
}

@end
