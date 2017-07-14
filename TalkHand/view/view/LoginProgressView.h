//
//  LoginProgressView.h
//  MSN
//
//  Created by 张小明 on 2017/1/7.
//  Copyright © 2017年 张小明. All rights reserved.
//  登录进度窗口

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "CompletionDefine.h"
#import "MBProgressHUD.h"
@interface LoginProgressView : NSObject
//控制系登陆进度窗的显示
-(void)showProgressView:(BOOL) isshow onParent:(UIView *) view title:(NSString *)title;
//超时回调
//@property (nonatomic,copy)ObserverCompletion timeoutObserver;
@property (nonatomic) MBProgressHUD * HUD;
/* 登陆超时定时器 */
@property (nonatomic, retain) NSTimer *timer;
@end
