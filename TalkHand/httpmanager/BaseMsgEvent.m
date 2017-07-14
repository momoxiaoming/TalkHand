//
//  BaseMsgEvent.m
//  QsQ
//
//  Created by 张小明 on 2017/6/23.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "BaseMsgEvent.h"
#import "BaseMsg.h"
#import "NotifictionManager.h"
@implementation BaseMsgEvent

//登陆回调通知
-(void)onLinkCloseMessage:(int)dwErrorCode{
  NSLog(@"网络连断开了，error：%d", dwErrorCode);
}

-(void)onLoginMessage:(int)dwUserId withErrorCode:(int)dwErrorCode{
    if (dwErrorCode == 0)
        NSLog(@"登录成功，当前分配的user_id=%d！", dwUserId);
    else
        NSLog(@"登录失败，错误代码：%d", dwErrorCode);
}


//实时消息
-(void)onErrorResponse:(int)errorCode withErrorMsg:(NSString *)errorMsg{
//      NSLog(@"收到服务端错误消息，errorCode=%d, errorMsg=%@", errorCode, errorMsg);
}

-(void)onTransBuffer:(NSString *)fingerPrintOfProtocal withUserId:(int)dwUserid andContent:(NSString *)dataContent{
     NSLog(@"收到来自用户%d的消息:%@", dwUserid, dataContent);
    

    NSData* xmlData = [dataContent dataUsingEncoding:NSUTF8StringEncoding];  //string 转nsdata
    NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:xmlData options:NSJSONReadingAllowFragments error:nil];  //将json'字符串转为字典
    BaseMsg *msg=[[BaseMsg alloc]init];
    msg.otherid=[NSString stringWithFormat:@"%i",dwUserid];
    msg.msg_isor=@"1";
    msg.isread=@"0";
    msg.msg_content=dict[@"content"];
    msg.msg_info_type=dict[@"type"];
    msg.msg_second=dict[@"second"];
    msg.msg_time=[Util get1970Time];
    msg.videoUrl=dict[@"videoUrl"];
    
    [[FMDConfig sharedInstance]saveMessageWithOtherId:msg];
    
    
    NSString *content=@"";
    if([msg.msg_info_type integerValue]==[textMsg integerValue]){ //文本消息
        content=msg.msg_content;
    }else if([msg.msg_info_type integerValue]==[aduioMsg integerValue]){
        content=@"[语音消息]";
        
    }else if([msg.msg_info_type integerValue]==[videoMsg integerValue]){
        content=@"[视频消息]";
        
    }else if([msg.msg_info_type integerValue]==[picterMsg integerValue]){
        content=@"[图片消息]";
        
    }
    
    
    NSLog(@"本地消息通知");
    
    [[NotifictionManager sharpManager] addNotification:content title:@"您的好友给你发了新的消息"];
  
    
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"msg" object:msg];
    
}


//-(void)analysisContent:(NSString *)content{
//    NSData* xmlData = [content dataUsingEncoding:NSUTF8StringEncoding];  //string 转nsdata
//    NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:xmlData options:NSJSONReadingAllowFragments error:nil];  //将json'字符串转为字典
//    BaseMsg *msg=[[BaseMsg alloc]init];
//    msg.otherid=[NSString stringWithFormat:@"%i",dwUserid];
//    msg.msg_isor=0;
//    msg.isread=0;
//    msg.msg_content=dict[@"content"];
//    msg.msg_type=dict[@"type"];
//    msg.msg_second=dict[@"second"];
//   
//    
//    
//    
//}


//消息状态通知
-(void)messagesLost:(NSArray *)lostMessages{
//    NSLog(@"收到系统的未实时送达事件通知，当前共有%li个包QoS保证机制结束，判定为【无法实时送达】！"
//          , (unsigned long)[lostMessages count]);
}
-(void)messagesBeReceived:(NSString *)theFingerPrint{
    if(theFingerPrint != nil)
    {
//        NSLog(@"收到对方已收到消息事件的通知，fp=%@", theFingerPrint);
    }
}
@end
