//  ----------------------------------------------------------------------
//  Copyright (C) 2015 Jack Jiang The MobileIMSDK Project.
//  All rights reserved.
//  Project URL:  https://github.com/JackJiang2011/MobileIMSDK
//
//  openmob.net PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
//
//  You can contact author with jack.jiang@openmob.net or jb2011@163.com.
//  ----------------------------------------------------------------------
//
//  IMClientManager.m
//  MobileIMSDK4iDemo
//
//  Created by JackJiang on 15/11/8.
//  Copyright © 2015年 openmob.net. All rights reserved.
//

#import "IMClientManager.h"
#import "ClientCoreSDK.h"
#import "ConfigEntity.h"


///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 私有API
///////////////////////////////////////////////////////////////////////////////////////////

@interface IMClientManager ()

/* MobileIMSDK是否已被初始化. true表示已初化完成，否则未初始化. */
@property (nonatomic) BOOL _init;
//
//


@end


///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 本类的代码实现
///////////////////////////////////////////////////////////////////////////////////////////

@implementation IMClientManager

// 本类的单例对象
static IMClientManager *instance = nil;

+ (IMClientManager *)sharedInstance
{
    if (instance == nil)
    {
        instance = [[super allocWithZone:NULL] init];
    }
    return instance;
}

/*
 *  重写init实例方法实现。
 *
 *  @return
 *  @see [NSObject init:]
 */
- (id)init
{
    if (![super init])
        return nil;
    
    [self initMobileIMSDK];
    
    return self;
}

- (void)initMobileIMSDK
{
    if(!self._init)
    {
        // 设置AppKey
        [ConfigEntity registerWithAppKey:@"e9c7a90c1143c1ba9c"];
        
        // 设置服务器ip和服务器端口
        [ConfigEntity setServerIp:@"192.168.1.123"];
        [ConfigEntity setServerPort:7901];
        // 开启DEBUG信息输出
        [ClientCoreSDK setENABLED_DEBUG:YES];
        
        // 设置事件回调
        self.msgEvent=[[BaseMsgEvent alloc]init];
        [ClientCoreSDK sharedInstance].chatBaseEvent = self.msgEvent;
        [ClientCoreSDK sharedInstance].chatTransDataEvent = self.msgEvent;
        [ClientCoreSDK sharedInstance].messageQoSEvent =self.msgEvent;
        
        
       
        
        self._init = YES;
    }
}

- (void)releaseMobileIMSDK
{
    [[ClientCoreSDK sharedInstance] releaseCore];
}



@end
