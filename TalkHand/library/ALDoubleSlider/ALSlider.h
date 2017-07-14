//
//  ALSlider.h
//  JLDoubleSliderDemo
//
//  Created by 张小明 on 2017/6/17.
//  Copyright © 2017年 linger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALSlider : UIView
+ (instancetype)initWithFrameIndex:(CGRect)frame setminIndex:(NSInteger)minIndex setMaxIndex:(NSInteger)maxIndex;

-(void)setMinIndex:(NSInteger )minIndex setMaxIndex:(NSInteger )maxIndex;

-(NSString *)getAgeSection;

@end
