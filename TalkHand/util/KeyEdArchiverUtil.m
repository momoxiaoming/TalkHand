
//
//  KeyEdArchiverUtil.m
//  Yelloweb
//
//  Created by allen on 2016/12/26.
//  Copyright © 2016年 allen. All rights reserved.
//

#import "KeyEdArchiverUtil.h"


#define EXITSPATH @"basedata.plist"
#define EXITSPATH_VIP @"vip.plist"
@implementation KeyEdArchiverUtil






+(void)saveObjectforFile:(id)obj{

    
    //获取文件路径
    NSString *docpath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    
    //设置保存的路径
    NSString *targetPath=[docpath stringByAppendingPathComponent:EXITSPATH];
    
    //将自定义对象保存到指定路径下
    [NSKeyedArchiver archiveRootObject:obj toFile:targetPath];

    
    
    

}


+(id)getObjectforFile{

    //获取文件路径
    NSString *docpath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    
    //设置保存的路径
    NSString *targetPath=[docpath stringByAppendingPathComponent:EXITSPATH];
    
   
    //通过NSKeyedUnarchiver 取出文件
    id basedata=[NSKeyedUnarchiver unarchiveObjectWithFile:targetPath];
    
    
    return basedata;
}

@end
