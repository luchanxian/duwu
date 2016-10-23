//
//  Model1.m
//  毒物
//
//  Created by 一羞 on 16/9/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "Model1.h"
static NSString *s;
static NSString *p;
static NSString *g;

@implementation Model1
-(instancetype)init
{
    self = [super init];
    if (self) {
        BmobUser *user = [BmobUser currentUser];
        self.headImage = [user objectForKey:@"nick"];
        self.userName = [user objectForKey:@"name"];
        NSNumber *p = [user objectForKey:@"p"];
        NSNumber *g = [user objectForKey:@"g"];
        NSNumber *s = [user objectForKey:@"s"];
        self.g =g.stringValue;
        self.p =p.stringValue;
        self.s =s.stringValue;
        if (!p) {
            self.p = @"0";
        }
        if (!g) {
            self.g = @"0";
        }
        if (!s) {
            self.s = @"0";
        }
    }
    return self;
  
}
@end
