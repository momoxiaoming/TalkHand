//
//  MsgListEntity.h
//  QsQ
//
//  Created by 张小明 on 2017/6/26.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseMsg.h"
@interface MsgListEntity : NSObject

@property NSString* list_id;
//聊天的人
@property NSString* owerid;

//和谁聊天
@property NSString* otherid;

//最新消息的时间
@property NSString *list_time;

//消息未读数---0是未读,1是已读
@property NSString *readnum;

//最新的消息
@property BaseMsg* list_msg;

@end
