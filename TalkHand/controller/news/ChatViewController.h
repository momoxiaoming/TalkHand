//
//  ChatViewController.h
//  QsQ
//
//  Created by 张小明 on 2017/3/25.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatBotmView.h"
#import "ChatBotomDelete.h"
#import "OtherView.h"
#import "OtherItemCilck.h"
#import <AVFoundation/AVFoundation.h>
#import "BaseMsg.h"

#import "CellitemClickDelete.h"
#import "ExpView.h"
#import "ExpClickDelete.h"
#import <YYTextView.h>
#import "CellitemClickDelete.h"
@interface ChatViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,YYTextViewDelegate,ChatBotomDelete,OtherItemCilck,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CellitemClickDelete,ExpClickDelete>




@property ChatBotmView * bot_view;

@property NSMutableArray<BaseMsg *> * msgarray;

@property NSString * account;

@property NSString * titleName;

//@property NSDictionary *userInfo;


@property  OtherView * otherView;

@property  ExpView *faceView;  //表情view



@end
