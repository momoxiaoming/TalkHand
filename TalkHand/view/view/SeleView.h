//
//  SeleView.h
//  QsQ
//
//  Created by 张小明 on 2017/4/18.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeleView : UIView<UIGestureRecognizerDelegate>
//初始化的时候就设置背景颜色,按下的颜色
-(instancetype)initColor:(UIColor *) bgcolor PresColor:(UIColor *) prescolor;
@property UIColor* normcolor;   //正常颜色
@property UIColor * prescolor;   //按下的颜色
@end
