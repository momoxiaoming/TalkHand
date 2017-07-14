//
//  LoginProgressView.m
//  MSN
//
//  Created by 张小明 on 2017/1/7.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "LoginProgressView.h"


static double RETRY_DELAY=6000;
@implementation LoginProgressView


/*
 * 登陆超时后要调用的方法。
 */
- (void)onTimeout
{
//    if(self.timeoutObserver != nil)
//        self.timeoutObserver(nil, nil);
}

- (void)showProgressView:(BOOL)isshow onParent:(UIView *)view title:(NSString *)title
{
    // 显示进度提示的同时即启动超时提醒线程
    if(isshow)
    {
        [self showLoginProgressGUI:YES onParent:view title:title];
        
        // 先无论如何保证timer在启动前肯定是处于停止状态
        [self stopTimer];
        // 启动(注意：执行延迟的单位是秒哦)
        self.timer = [NSTimer scheduledTimerWithTimeInterval:RETRY_DELAY / 1000
                                                      target:self
                                                    selector:@selector(onTimeout)
                                                    userInfo:nil
                                                     repeats:NO];
    }
    // 关闭进度提示
    else
    {
        // 无条件停掉延迟重试任务
        [self stopTimer];
        
        [self showLoginProgressGUI:NO onParent:view title:title];
    }
}

- (void)stopTimer
{
    if(self.timer != nil)
    {
        if([self.timer isValid])
            [self.timer invalidate];
        
        self.timer = nil;
    }
}

/*
 * 进度提示时要显示或取消显示的GUI内容。
 *
 * @param show true表示显示gui内容，否则表示结速gui内容显示
 */
- (void)showLoginProgressGUI:(BOOL)show onParent:(UIView *)view title:(NSString *) title
{
    // 显示登陆提示信息
    if(show)
    {
        if(self.HUD == nil)
        {
            // 实例化一个菊花。。。
            self.HUD = [[MBProgressHUD alloc] initWithView:view];
            [view addSubview:self.HUD];
            
            self.HUD.labelText =title;
        }
        
        [self.HUD show:YES];
    }
    // 关闭登陆提示信息
    else
    {
        if(self.HUD != nil)
            [self.HUD hide:NO];
    }
}

@end
