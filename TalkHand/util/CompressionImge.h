//
//  CompressionImge.h
//  QsQ
//
//  Created by 张小明 on 2017/6/19.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompressionImge : NSObject
- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize;
@end
