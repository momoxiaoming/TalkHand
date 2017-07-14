//
//  AFHttpSessionClient.m
//  ChatApp
//
//  Created by 张小明 on 2017/2/13.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "AFHttpSessionClient.h"
#import "LanAES.h"
static NSString * const AFAppDotNetAPIBaseURLString = @"http://qs.mgonb.com:9901/mfd";
//static NSString * const AFAppDotNetAPIBaseURLString = @"http://192.168.1.123:8082/mkfrd-web/";
//static NSString * const AFAppDotNetAPIBaseURLString = @"http://192.168.1.77:8082/mkfrd-web/";
@implementation AFHttpSessionClient
+(instancetype)sharedClient{

    static AFHttpSessionClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFHttpSessionClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.requestSerializer=[AFHTTPRequestSerializer serializer];
        _sharedClient.responseSerializer=[AFHTTPResponseSerializer serializer];
        
    });
    
    
  
    return _sharedClient;
}



-(void)UploadAudioFile:(NSData *)data path:(NSString *)url parameters:(NSDictionary *)parameters actionBlock:(void (^)(NSDictionary *, NSError *))block{
    
    
    [self POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData =data;//图片对象转为nsdata
        [formData appendPartWithFileData:imageData
                                    name:@"file"
                                fileName:@"file.amr"
                                mimeType:@"audio/AMR"
         ];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *res=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];   //将结果转为字符串
        
        res= [res stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSString * str= [LanAES aes256_decrypt:res];
        
        NSData* xmlData = [str dataUsingEncoding:NSUTF8StringEncoding];  //string 转nsdata
        NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:xmlData options:NSJSONReadingAllowFragments error:nil];  //将json'字符串转为字典
        if(block){
            block(dict, nil);
        }
        NSLog(@"上传成功%@",str);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败%@",error);
        if(block){
            block(nil, error);
            
        }
    }];
    
}


-(void)UploadVideoFile:(NSData *)data path:(NSString *)url parameters:(NSDictionary *)parameters actionBlock:(void (^)(NSDictionary *, NSError *))block{
    
    
    [self POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData =data;//图片对象转为nsdata
        [formData appendPartWithFileData:imageData
                                    name:@"file"
                                fileName:@"file.mp4"
                                mimeType:@"video/quicktime"
                                ];
       
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *res=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];   //将结果转为字符串
        
        res= [res stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSString * str= [LanAES aes256_decrypt:res];
        
        NSData* xmlData = [str dataUsingEncoding:NSUTF8StringEncoding];  //string 转nsdata
        NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:xmlData options:NSJSONReadingAllowFragments error:nil];  //将json'字符串转为字典
        if(block){
            block(dict, nil);
        }
        NSLog(@"上传成功%@",str);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败%@",error);
        if(block){
            block(nil, error);
            
        }
    }];
  
}

-(void)UploadImageFile:(UIImage *)image parameters:(NSDictionary *)parameters path:(NSString *)url actionBlock:(void (^)(NSDictionary *, NSError *))block{
    [self POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData =UIImageJPEGRepresentation(image,1);//图片对象转为nsdata
        [formData appendPartWithFileData:imageData
                                    name:@"file"
                                fileName:@"file.jpg"
                                mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *res=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];   //将结果转为字符串
        
        res= [res stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSString * str= [LanAES aes256_decrypt:res];
        
        NSData* xmlData = [str dataUsingEncoding:NSUTF8StringEncoding];  //string 转nsdata
        NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:xmlData options:NSJSONReadingAllowFragments error:nil];  //将json'字符串转为字典
        if(block){
            block(dict, nil);
        }
        NSLog(@"上传成功%@",str);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败%@",error);
        if(block){
            block(nil, error);
            
        }
    }];

}


-(void)requestPost:(NSString *)url parameters:(NSDictionary *)parameters actionBlock:(void (^)(NSDictionary *, NSError *))block{

    [self POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {   //json 其实是NSdata 类型,, 如果我们数据没有加密的话,我们可以直接jiangjson转为字典对象,而不用先转为字符串再转nsdata对象了

        NSString *res=[[NSString alloc] initWithData:JSON encoding:NSUTF8StringEncoding];   //将结果转为字符串
        
        res= [res stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        
        NSData *jsonData = [res dataUsingEncoding:NSUTF8StringEncoding];   //再将解密后的字符串转为nsdata,方便转为字典
        NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];  //将结果转为地点数据
        
        
        if (block) {
            block(dict, nil);
        }
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"返回失败--%@",error);
        if (block) {
            block(nil, error);
        }
    }];



}

-(void)requestGet:(NSString *)url parameters:(NSDictionary *)parameters actionBlock:(void (^)(NSDictionary *, NSError *))block{

    [self GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        
        NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingAllowFragments error:nil];
        if (block) {
            block(dict, nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"返回失败--%@",error);
        if (block) {
            block(nil, error);
        }
    }];
}

//这个post请求是自定义了请求体,主要是为了实现我们社交项目上的参数加密处理
-(void)post:(NSString *)url parameters:(NSDictionary *)parameters actionBlock:(void (^)(NSDictionary *, NSError *))block{
    NSError *error;
    
    //正常来说这里不需要填写全地址的,单手这里我们自定义了请求体,所以我们的initWithBaseURL 就失去作用了
    url=[NSString stringWithFormat:@"%@/%@",AFAppDotNetAPIBaseURLString,url];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //加密json字符串,
    NSString * data= [LanAES aes256_encrypt:jsonString];
    NSData * prepram=[data dataUsingEncoding:NSUTF8StringEncoding];  //组装参数
    
    
    //创建请求,
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters: nil error:nil];
    
    //设置请求头,并设置body参数
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    
    [req setHTTPBody:prepram];
    
    [[self dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            if(block){
                NSString *res=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];   //将结果转为字符串
                
                //                res= [res stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                NSString * str= [LanAES aes256_decrypt:res];
                
                NSData* xmlData = [str dataUsingEncoding:NSUTF8StringEncoding];  //string 转nsdata
                NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:xmlData options:NSJSONReadingAllowFragments error:nil];  //将json'字符串转为字典
                block(dict,nil);
            }
        } else {
            if(block){
                block(nil,error);
            }
            
        }
    }] resume];

}


-(void)downFilepath:(NSString *)url parameters:(NSDictionary *)parameters actionBlock:(void (^)(NSDictionary *, NSError *))block{
    //创建请求,
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"get" URLString:url parameters: nil error:nil];
    
    //设置请求头,并设置body参数
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    
//    [req setHTTPBody:prepram];
    
    [[self downloadTaskWithRequest:req progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"下载进度：%.0f％", downloadProgress.fractionCompleted * 100);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
     
        
        /* 下载路径 */
      NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        
        NSString *filePath = [path stringByAppendingPathComponent:url.lastPathComponent];
        
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if(!error){
            if(block){
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            [dict setObject:filePath forKey:@"filePath"];
            NSLog(@"下载完成--下载地址-->%@",filePath);
            block(dict,nil);
            }
        }else{
            if(block){
                block(nil,error);
            }
        }
        
       
    }] resume];;

}

@end
