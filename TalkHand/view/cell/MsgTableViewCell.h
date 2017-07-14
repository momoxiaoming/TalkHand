//
//  MsgTableViewCell.h
//  QsQ
//
//  Created by 张小明 on 2017/4/1.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgListEntity.h"
#import "BaseMsg.h"
@interface MsgTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *tx_img;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *msg;

@property (weak, nonatomic) IBOutlet UILabel *time;


@property (weak, nonatomic) IBOutlet UILabel *msg_num;
@property (weak, nonatomic) IBOutlet UIView *numView;

-(void)setItemData:(MsgListEntity*) dir;

+(instancetype) tgcellWithTableView:(UITableView *) tableview;
@end
