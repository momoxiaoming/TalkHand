//
//  ImageUtil.h
//  QsQ
//
//  Created by 张小明 on 2017/6/5.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accelerate/Accelerate.h>
#import <AVFoundation/AVFoundation.h>
@interface ImageUtil : NSObject
//根据视频url获取第一帧图像
+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;
//高斯模糊效果
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;
@end
