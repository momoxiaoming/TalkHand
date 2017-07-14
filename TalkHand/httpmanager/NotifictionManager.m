//
//  NotifictionManager.m
//  TalkHand
//
//  Created by 张小明 on 2017/7/10.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "NotifictionManager.h"

@implementation NotifictionManager

+(instancetype)sharpManager{
    static NotifictionManager * manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[NotifictionManager alloc]init];
    });

    return manager;
}

-(void)addNotification:(NSString *)body title:(NSString *)title{
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
    NSLog(@"消息未读数-->%lu",badgeNum);
 
    
    
    
    // 1.创建一个本地通知
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    
    // 2.设置本地通知的一些属性(通知发出的时间/通知的内容)
    // 2.1.设置通知发出的时间
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:0];
    // 2.2.设置通知的内容
    localNote.alertBody = body;
    // 2.3.设置锁屏界面的文字
    localNote.alertAction = body;
    // 2.4.设置锁屏界面alertAction是否有效
    localNote.hasAction = YES;
    // 2.5.设置通过点击通知打开APP的时候的启动图片(无论字符串设置成什么内容,都是显示应用程序的启动图片)
    localNote.alertLaunchImage = @"111";
    // 2.6.设置通知中心通知的标题
    localNote.alertTitle = title;
    // 2.7.设置音效
    localNote.soundName = UILocalNotificationDefaultSoundName;
    // 2.8.设置应用程序图标右上角的数字
    localNote.applicationIconBadgeNumber = badgeNum;
    // 2.9.设置通知之后的属性
    localNote.userInfo = @{@"name" : @"张三", @"toName" : @"李四"};
    
    // 3.调度通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];

}


@end
