//
//  Util.m
//  QsQ
//
//  Created by 张小明 on 2017/6/27.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "Util.h"

@implementation Util

+(NSString *)get1970Time{
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970];
    
    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
    
    NSString *curTime = [NSString stringWithFormat:@"%llu",theTime];
    
    return curTime;
}

+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
/**
 *  带json格式的对象(字典)转化成json字符串
 *
 *  @param jsonObject json对象
 *
 *  @return 带json格式的字符串
 */
+ (NSString *)jsonStringWithObject:(id)jsonObject{
    // 将字典或者数组转化为JSON串
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    
    if ([jsonString length] > 0 && error == nil){
        return jsonString;
    }else{
        return nil;
    }
}
@end
