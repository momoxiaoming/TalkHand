//
//  Util.h
//  QsQ
//
//  Created by 张小明 on 2017/6/27.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

//返回秒数时间搓
+(NSString *)get1970Time;

//字符串转字典
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//字典转字符串
+ (NSString *)jsonStringWithObject:(id)jsonObject;
@end
