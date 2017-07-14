//
//  BaseMsgEvent.h
//  QsQ
//
//  Created by 张小明 on 2017/6/23.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatTransDataEvent.h"
#import "ChatBaseEvent.h"
#import "MessageQoSEvent.h"
@interface BaseMsgEvent : NSObject<ChatBaseEvent,ChatTransDataEvent,MessageQoSEvent>

@end
