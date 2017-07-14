//
//  UserinfoHeader.h
//  QsQ
//
//  Created by 张小明 on 2017/3/27.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserinfoHeader : UIView
@property UIImageView *bgimg;
@property UIImageView *tximg;
@property UIImageView *vipimg;
@property UILabel * name;
@property UILabel *vip_lv;
@property (nonatomic) UILabel *age;
@property (nonatomic) UILabel *adress;
@property UIImageView *sex_img;

@property  UIView * lv_view;

@property (strong) UIViewController * controller;

-(void)setViewData:(NSDictionary *)obj;

@end
