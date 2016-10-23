//
//  MyUserObj.h
//  毒物不崩
//
//  Created by 一羞 on 16/9/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MyUserObj : JSONModel
@property (nonatomic,copy) NSString *user_name;
@property (nonatomic,copy) NSString *user_img;
@property (nonatomic,copy) NSString *introduce;
@end
