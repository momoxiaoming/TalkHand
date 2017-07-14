//
//  NearyTopView.h
//  QsQ
//
//  Created by 张小明 on 2017/5/18.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearyTopView : UIView
@property UIImageView *bg_img;
@property UIImageView *sex_img;

@property UIImageView *vip_img;
@property UILabel * name;
@property UILabel *age;
@property UILabel *adress;
@property UIImageView *tx_img;
@property UILabel *vip_lv;

@property UILabel *wx_str;
@property UILabel *jysm_str;
@property UILabel *id_str;
@property UILabel *phone_str;
@property (strong) UIViewController * controller;


-(void)setViewData:(NSDictionary *)obj;

@end
