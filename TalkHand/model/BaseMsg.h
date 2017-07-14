//
//  BaseMsg.h
//  QsQ
//
//  Created by 张小明 on 2017/6/26.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseMsg : NSObject
//消息类型
@property (nonatomic,copy)NSString * msg_info_type;

//消息id
@property (nonatomic,copy)NSString * msg_id;

//消息内容
@property (nonatomic,copy)NSString * msg_content;

//语音消息秒数
@property (nonatomic,copy)NSString * msg_second;

//消息发送或者接收,0是发送,1是接收
@property (nonatomic,copy)NSString * msg_isor;

//时间搓,毫秒
@property (nonatomic,copy)NSString * msg_time;

//会话表的索引
@property (nonatomic,copy)NSString * otherid;

//是否已读,0是未读,1是已读
@property (nonatomic,copy)NSString * isread;

//视频地址
@property (nonatomic,copy)NSString * videoUrl;

@end
