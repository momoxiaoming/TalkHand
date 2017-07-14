//
//  AFHttpSessionClient.h
//  ChatApp
//
//  Created by 张小明 on 2017/2/13.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
@interface AFHttpSessionClient : AFHTTPSessionManager
+ (instancetype)sharedClient;

-(void)UploadImageFile:(UIImage *) image parameters:(NSDictionary *)parameters path:(NSString *) url actionBlock:(void (^)(NSDictionary *posts, NSError *error))block;

- (void)requestPost:(NSString *) url parameters:(NSDictionary *)parameters actionBlock:(void (^)(NSDictionary *posts, NSError *error))block;

- (void)requestGet:(NSString *) url parameters:(NSDictionary *)parameters actionBlock:(void (^)(NSDictionary *posts, NSError *error))block;

//这个post请求是自定义了请求体,主要是为了实现我们社交项目上的参数加密处理,平常我们主要使用requestPost 接口
-(void)post:(NSString *) url parameters:(NSDictionary *)parameters actionBlock:(void (^)(NSDictionary *posts, NSError *error))block;


-(void)UploadVideoFile:(NSData *)data path:(NSString *)url parameters:(NSDictionary *)parameters actionBlock:(void (^)(NSDictionary *posts, NSError *error))block;
-(void)UploadAudioFile:(NSData *)data path:(NSString *)url parameters:(NSDictionary *)parameters actionBlock:(void (^)(NSDictionary *, NSError *))block;

-(void)downFilepath:(NSString *)url parameters:(NSDictionary *)parameters actionBlock:(void (^)(NSDictionary *, NSError *))block;



@end
