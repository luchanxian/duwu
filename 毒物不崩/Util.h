//
//  Util.h
//  毒物
//
//  Created by 一羞 on 16/9/23.
//  Copyright © 2016年 Apple. All rights reserved.
//
typedef void(^CallBack) (id obj);
#import <Foundation/Foundation.h>

@interface Util : NSObject
+(void)requequstwithNumber:(int)number sortNum:(int)sortNum rec:(CallBack)callback ;//请求首页
+(void)clickTo:sender;//sortView的响应
+(void)requequeswithString:(NSString*)str callback:(CallBack)callback;//首页点击cell后请求
+(void)requequstInfoWithNumber:(int)number sortNum:(int)sortNum rec:(CallBack)callback;
+(void)goOtherSort:sender;//第二个页面sortView的响应
+(void)requequstInfoDetaiWithId:(NSString*)did rec:(CallBack)callback;
+(void)requequstGunInfoWithId:(NSString*)uid rec:(CallBack)callback;
+(void)requequstGunInfoWithNumber:(int)number sortUid:(NSString*)uid rec:(CallBack)callback;
+(void)requestSeachResultWithString:(NSString*)string rec:(CallBack)callback;
@end
