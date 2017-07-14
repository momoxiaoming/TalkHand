//
//  FMDConfig.h
//  ChatApp
//
//  Created by 张小明 on 2017/2/6.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "MsgListEntity.h"
#import "BaseMsg.h"


@interface FMDConfig : NSObject

@property FMDatabase * db;

+(FMDConfig *)sharedInstance;
-(void) createTable;


//保存用户信息
-(void)saveUserInfo:(NSDictionary*)dir;

//根据id获取某个用户信息
-(NSDictionary*)getUserInfoWithId:(NSString *)account;



//保存一条会话数据
-(void)saveAndUpdateConversation:(MsgListEntity*)dir;

//取出所有会话数据
-(NSMutableArray<MsgListEntity * > *)getAllConversation;


//根据id保存一条聊天信息
-(void)saveMessageWithOtherId:(BaseMsg*)msg;

//根据id获取所有聊天信息
-(NSMutableArray<BaseMsg * > *)getAllMsgWithOtherId:(NSString *)otherid;

//根据消息id更新消息的本地语音地址
-(void)updateMessage:(BaseMsg *)basemsg;


@end
