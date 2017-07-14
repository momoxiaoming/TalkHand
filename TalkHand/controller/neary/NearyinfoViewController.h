//
//  NearyinfoViewController.h
//  QsQ
//
//  Created by 张小明 on 2017/4/18.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "HJTabViewController.h"

#import "UserInfoMenu.h"

@interface NearyinfoViewController : HJTabViewController
@property (nonatomic, assign) BOOL menuIsVisible;
@property (nonatomic, strong) UserInfoMenu *sideMenu;
@property (nonatomic) UIView *baseView;

@property (nonatomic)NSString * owerid;

@property UIImage *sex_img;
@property UILabel * name;
@property UILabel *age;
@property UILabel *adress;
@property UIImage *tx_img;


//@property NSObject * infodata;

@end
