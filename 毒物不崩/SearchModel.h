//
//  SearchModel.h
//  毒物不崩
//
//  Created by 一羞 on 16/9/29.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SearchModel : JSONModel
@property (nonatomic,copy )NSString *share_id;
@property (nonatomic,copy )NSString *thumb;
@property (nonatomic,copy )NSString *name;
@end
