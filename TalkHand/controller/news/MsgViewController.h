//
//  MsgViewController.h
//  QsQ
//
//  Created by 张小明 on 2017/3/24.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgListEntity.h"
@interface MsgViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property NSMutableArray<MsgListEntity *> *msgData;
@end
