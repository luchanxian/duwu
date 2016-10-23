//
//  InfoDetailObj.h
//  毒物
//
//  Created by 一羞 on 16/9/22.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface InfoDetailObj : JSONModel
@property (nonatomic,copy)NSString  *title;
@property (nonatomic,copy)NSString  *user_name;
@property (nonatomic,copy) NSString *content;
@end
