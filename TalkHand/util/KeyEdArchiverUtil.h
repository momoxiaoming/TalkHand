//
//  KeyEdArchiverUtil.h
//  Yelloweb
//
//  Created by allen on 2016/12/26.
//  Copyright © 2016年 allen. All rights reserved.
//

#import <Foundation/Foundation.h>


//只有实现了nskeyedarchiver归档协议的对象才可以使用该存储
@interface KeyEdArchiverUtil : NSObject


+(void)saveObjectforFile:(id) obj;   //保存对象

+(id)getObjectforFile;   //获取对象


@end
