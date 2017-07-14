//
//  LeftCell.h
//  TalkQQ
//
//  Created by 张小明 on 2017/7/3.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CellitemClickDelete.h"
#import "BaseMsg.h"
@interface LeftCell : UITableViewCell

@property (nonatomic,strong)UIImageView *Tx_img;

@property (nonatomic,strong)UIImageView *msg_bg_img;

@property (nonatomic,strong)UIView *content_View;

//时间.只有消息为语音的时候才有
@property (nonatomic,strong)UILabel *time_label;

//消息类型为图片
@property (nonatomic,strong)UIImageView *ImageView;




@property id<CellitemClickDelete> cellDelete;

@property BaseViewController *controller;

@property BaseMsg * itemMsg;

-(void)configMessage:(BaseMsg*) msg;
@end
