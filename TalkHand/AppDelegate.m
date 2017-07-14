//
//  AppDelegate.m
//  QsQ
//
//  Created by 张小明 on 2017/3/24.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "AppDelegate.h"


#import "BaseNavigationController.h"

#import "WelcomControllerViewController.h"

#import "AFHttpSessionClient.h"

#import "MainTabBarController.h"

#import "IMClientManager.h"

#define IS_iOS8 ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
@interface AppDelegate ()
@property(strong, nonatomic)NSTimer *mTimer;
@property(assign, nonatomic)UIBackgroundTaskIdentifier backIden;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    
     [IQKeyboardManager sharedManager].enable = YES;  //打开IQKeyboardManager键盘管理器
   


//    [ALDatabase initialize]; //初始化缓存数据库
    
    [FMDConfig sharedInstance];
    
    [self setwindow];
    

//     [self listenNetWorkingStatus];  //监听网络是否可用
    
  
    if (IS_iOS8) {  //ios8之后需要获取app的通知权限
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
    
    return YES;
}




 
-(void)setwindow{
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    WelcomControllerViewController * main=[[WelcomControllerViewController alloc]init];
//
//  
    BaseNavigationController *na = [[BaseNavigationController alloc]initWithRootViewController:main];
//    MainTabBarController * tab=[[MainTabBarController alloc]init];
  
    self.window.rootViewController=na;
    // 显示窗口
    [self.window makeKeyAndVisible];
    // makeKeyAndVisible底层实现
    // 1. application.keyWindow = self.window
    // 2. self.window.hidden = NO;
 
}








- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    // 在这里写跳转代码
    // 如果是应用程序在前台,依然会收到通知,但是收到通知之后不应该跳转
    if (application.applicationState == UIApplicationStateActive) return;
    
    if (application.applicationState == UIApplicationStateInactive) {
        // 当应用在后台收到本地通知时执行的跳转代码
//        [self jumpToSession];
         [self setwindow];
    }
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    FMDConfig * fmd=[FMDConfig sharedInstance];
    NSMutableArray<MsgListEntity*> *arr=[fmd getAllConversation];
    //    if(arr!=NULL&&arr.count!=0){
    //        [self.msgData setArray:arr];
    //        [self.tableview reloadData];
    //    }
    
    NSInteger badgeNum=0;
    
    
    for (int i=0; i<arr.count; i++) {
        MsgListEntity* entiy=  arr[i];
        badgeNum+= [entiy.readnum integerValue];;
        
    }

    
      [application setApplicationIconBadgeNumber:badgeNum];  //清除app消息未读数
    
  _mTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_mTimer forMode:NSRunLoopCommonModes];
    [self beginTask];
    
}
//计时
-(void)countAction{
//    NSLog(@"%li",count++);
}

//申请后台
-(void)beginTask
{
    NSLog(@"begin=============");
  [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        //在时间到之前会进入这个block，一般是iOS7及以上是3分钟。按照规范，在这里要手动结束后台，你不写也是会结束的（据说会crash）
        NSLog(@"将要挂起=============");
        [self endBack];
    }];
}
//注销后台
-(void)endBack
{
    NSLog(@"end=============");
    [[UIApplication sharedApplication] endBackgroundTask:_backIden];
    _backIden = UIBackgroundTaskInvalid;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
