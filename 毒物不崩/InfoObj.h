//
//  InfoObj.h
//  毒物
//
//  Created by 一羞 on 16/9/21.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface InfoObj : JSONModel<NSCoding>
@property (nonatomic,copy) NSString *did;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *thumb;

@end
