//
//  SecurityUtil.h
//  Yelloweb
//
//  Created by allen on 2016/12/26.
//  Copyright © 2016年 allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanAES : NSObject

#pragma mark - base64
+(NSData *)AES256ParmEncryptWithKey:(NSData *)text;   //加密
+(NSData *)AES256ParmDecryptWithKey:(NSData *)text;   //解密
+(NSString *) aes256_encrypt:(NSString *)text;
+(NSString *) aes256_decrypt:(NSString *)text;

@end
