//
//  UserinfoHeader.m
//  QsQ
//
//  Created by 张小明 on 2017/3/27.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "UserinfoHeader.h"
#import "RZXXViewController.h"
#import "WDDSViewController.h"
#import "WYZQViewController.h"
#import "WDSZViewController.h"
#import "WDHYViewController.h"
#import "VIPViewController.h"
#import "UserInfoViewController.h"
@implementation UserinfoHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {   //这里直接初始化本类,并且确定view的边界
        self=[[UserinfoHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2+44+10)];
        [self createView];
    }
    return self;
}
-(void)setViewData:(NSDictionary *)obj{
    NSString * tx_url=[NSString stringWithFormat:@"%@",[obj valueForKey:@"iconUrl"]];
    if(tx_url!=NULL){
        [self.tximg sd_setImageWithURL:[NSURL URLWithString:tx_url] placeholderImage:[UIImage imageNamed:@"icon_mor"]];
    }else{
        self.tximg.image=[UIImage imageNamed:@"icon_mor"];
    }
    self.name.text=[NSString stringWithFormat:@"%@",[obj valueForKey:@"name"]==NULL?@"****":[obj valueForKey:@"name"]];
    
    NSUserDefaults * def=[NSUserDefaults standardUserDefaults];
    NSString *adr=[def objectForKey:@"location"];
    if([adr isEqualToString:@""]){
    adr=@"未知地址";
    
    }
    if([obj[@"address"] isEqualToString:@""]){
        self.adress.text=adr;
    }else{
        self.adress.text=obj[@"address"];
    }
    
    
    NSString *sexIndex=[obj valueForKey:@"sex"];
    if(sexIndex!=NULL){
        if([sexIndex integerValue]==1){
            self.sex_img.image=[UIImage imageNamed:@"icon_boy"];
            _lv_view.backgroundColor=[UIColor colorWithHexString:@"#0AAFFF"];
        }else{
            _lv_view.backgroundColor=[UIColor colorWithHexString:@"#ff80ab"];
           self.sex_img.image=[UIImage imageNamed:@"icon_girl"];
        }
    }else{  //默认是男的
        self.sex_img.image=[UIImage imageNamed:@"icon_boy"];
        _lv_view.backgroundColor=[UIColor colorWithHexString:@"#0AAFFF"];
    }
    NSString * age=obj[@"age"];
    if([age isEqualToString:@""]){
        age=@"**";
    
    } 
    self.age.text=[NSString stringWithFormat:@"%@岁",age];
    
    NSInteger isvip=[[obj valueForKey:@"isvip"] integerValue];;
    if(isvip==0){
        [self.vipimg setHidden:YES];
//        [self.lv_view setHidden:YES];
    }else{
    
      [self.vipimg setHidden:NO];
    }
    
    


}
-(void)createView{
    
//    self.backgroundColor=[UIColor colorWithHexString:@"#ebebeb"];
    
 self.backgroundColor=[UIColor colorWithHexString:@"#ebebeb"];
    
    self.bgimg=[[UIImageView alloc] init];
    self.bgimg.image=[UIImage imageNamed:@"icon_mrbj"];
    
    
    self.tximg=[[UIImageView alloc] init];
    self.tximg.image=[UIImage imageNamed:@"icon_mor"];
    
    
    
    self.name=[[UILabel alloc]init];
    self.name.text=@"曾经沧海";
    self.name.textColor=[UIColor whiteColor];
    
    self.vipimg=[[UIImageView alloc] init];
    self.vipimg.image=[UIImage imageNamed:@"icon_vip"];
    
    
    UIView * info_view=[[UIView alloc]init];
    
    
    
    
    
    
   _lv_view=[[UIView alloc]init];
    _lv_view.layer.cornerRadius=3;
    _lv_view.layer.masksToBounds = YES;
    
    self.sex_img=[[UIImageView alloc]init];
    self.sex_img.image=[UIImage imageNamed:@"icon_girl"];
    
    self.vip_lv=[[UILabel alloc] init];
    self.vip_lv.text=@"LV1";
    self.vip_lv.textColor=[UIColor whiteColor];
    
    self.vip_lv.font=[UIFont systemFontOfSize:10];
    
    _lv_view.backgroundColor=[UIColor colorWithHexString:@"#ff80ab"];
    [_lv_view addSubview:self.sex_img];
    [_lv_view addSubview:self.vip_lv];
    
    
    [self.sex_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_lv_view);
        make.left.equalTo(_lv_view).offset(5);
        
        make.size.mas_equalTo(CGSizeMake(5, 9));
        
    }];
    [self.vip_lv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_lv_view);
        
        make.right.equalTo(_lv_view).offset(-3);
    }];
    
    self.age=[[UILabel alloc] init];
    self.age.textColor=[UIColor whiteColor];
    self.age.text=@"22岁";
    
    self.adress=[[UILabel alloc] init];
    self.adress.textColor=[UIColor whiteColor];
    self.adress.text=@"现居于深圳";
    
    [info_view addSubview:_lv_view];
    [info_view addSubview:self.age];
    [info_view addSubview:self.adress];
    
    
   
    
    
    [_lv_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(info_view);
        make.left.equalTo(info_view);
        make.bottom.equalTo(info_view);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    
    [self.age mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lv_view.mas_right).offset(10);
        make.top.equalTo(_lv_view);
        make.bottom.equalTo(_lv_view);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    [self.adress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(info_view);
        make.left.equalTo(self.age.mas_right).offset(10);
        make.bottom.equalTo(info_view);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    
    [self addSubview:_bgimg];
//    [self addSubview:left_top];
    [self addSubview:_tximg];
    [self addSubview:self.name];
    [self addSubview:_vipimg];
    [self addSubview:info_view];
    
    
    [self.bgimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.right.equalTo(self);
        make.left.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*1/2-90));
    }];
  
    
    
    [self.tximg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bgimg);
        make.size.mas_equalTo(CGSizeMake(66, 66));
    }];
    
    self.tximg.layer.cornerRadius=33;
    [self.tximg.layer setMasksToBounds:YES];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tximg.mas_bottom).offset(10);
        make.centerX.equalTo(self);
    }];
    
    [self.vipimg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.name.mas_right).offset(6);
        make.centerY.equalTo(self.name);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    
    
    
    
    [info_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.name.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(180, 15));
    }];
    
    
    
    
//    self.bgimg=[[UIImageView alloc] init];
//    self.bgimg.image=[UIImage imageNamed:@"icon_mrbj"];
//    
//    
//    _tximg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 66, 66)];
//    _tximg.image=[UIImage imageNamed:@"icon_mor"];
//    self.tximg.contentMode=UIViewContentModeScaleToFill;
//    //菜单,item
//
    
    
    UIFont * fon=[UIFont systemFontOfSize:12];
    UIView * item=[[UIView alloc]init];
    item.backgroundColor=[UIColor whiteColor];
    
    
    UIView *item1=[[UIView alloc] init];
    UIImageView *item1_img=[[UIImageView alloc] init];
    item1_img.image=[UIImage imageNamed:@"icon_rz"];
    UILabel * item1_lab=[[UILabel alloc] init];
    item1_lab.text=NSLocalizedString(@"user_center_item1_str", nil);
    item1_lab.textAlignment=NSTextAlignmentCenter;
    item1_lab.font=fon;
    [item1 addSubview:item1_img];
    [item1 addSubview:item1_lab];
    
    UIView *item2=[[UIView alloc] init];
    UIImageView *item2_img=[[UIImageView alloc] init];
    item2_img.image=[UIImage imageNamed:@"icon_mys"];
    UILabel * item2_lab=[[UILabel alloc] init];
    item2_lab.text=NSLocalizedString(@"user_center_item2_str", nil);
    item2_lab.textAlignment=NSTextAlignmentCenter;
    item2_lab.font=fon;
    [item2 addSubview:item2_img];
    [item2 addSubview:item2_lab];
    
    UIView *item3=[[UIView alloc] init];
    UIImageView *item3_img=[[UIImageView alloc] init];
    item3_img.image=[UIImage imageNamed:@"icon_hy"];
    UILabel * item3_lab=[[UILabel alloc] init];
    item3_lab.text=NSLocalizedString(@"user_center_item3_str", nil);
    item3_lab.textAlignment=NSTextAlignmentCenter;
    item3_lab.font=fon;
    [item3 addSubview:item3_img];
    [item3 addSubview:item3_lab];
    
    
    UIView *item4=[[UIView alloc] init];
    UIImageView *item4_img=[[UIImageView alloc] init];
    item4_img.image=[UIImage imageNamed:@"icon_sz"];
    UILabel * item4_lab=[[UILabel alloc] init];
    item4_lab.text=NSLocalizedString(@"user_center_item4_str", nil);
    item4_lab.textAlignment=NSTextAlignmentCenter;
    item4_lab.font=fon;
    [item4 addSubview:item4_img];
    [item4 addSubview:item4_lab];
    
    UIView *item5=[[UIView alloc] init];
    UIImageView *item5_img=[[UIImageView alloc] init];
    item5_img.image=[UIImage imageNamed:@"icon_zhumm"];
    UILabel * item5_lab=[[UILabel alloc] init];
    item5_lab.text=NSLocalizedString(@"user_center_item5_str", nil);
    item5_lab.textAlignment=NSTextAlignmentCenter;
    item5_lab.font=fon;
    [item5 addSubview:item5_img];
    [item5 addSubview:item5_lab];
    
    [item addSubview:item1];
    [item addSubview:item2];
    [item addSubview:item3];
    [item addSubview:item4];
    [item addSubview:item5];
    
//    [self addSubview:_bgimg];
//    [self addSubview:_tximg];
    [self addSubview:item];
    
 
    
    [self.tximg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgimg);
        make.centerY.equalTo(self.bgimg);
        make.size.mas_equalTo(CGSizeMake(66, 66));
    }];
    self.tximg.layer.cornerRadius=33;
    [self.tximg.layer setMasksToBounds:YES];
     //中间item
    
    [item mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgimg.mas_bottom).offset(10);
        make.right.equalTo(self);
        make.left.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 80));
    }];
    
    //item1
    [item1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(item);
        make.top.equalTo(item);
        make.bottom.equalTo(item);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/5, 80));
        
    }];
    [item1_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item1).offset(8);
        make.centerX.equalTo(item1);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [item1_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item1_img.mas_bottom).offset(8);
        make.centerX.equalTo(item1);
    }];
    
    //item2
    [item2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(item1.mas_right);
        make.top.equalTo(item);
        make.bottom.equalTo(item);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/5, 80));
        
    }];
    [item2_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item2).offset(8);
        make.centerX.equalTo(item2);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [item2_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item2_img.mas_bottom).offset(8);
        make.centerX.equalTo(item2);
    }];
    //item3
    [item3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(item2.mas_right);
        make.top.equalTo(item);
        make.bottom.equalTo(item);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/5, 80));
        
    }];
    [item3_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item3).offset(8);
        make.centerX.equalTo(item3);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [item3_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item3_img.mas_bottom).offset(8);
        make.centerX.equalTo(item3);
    }];
    
    //item4
    [item4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(item3.mas_right);
        make.top.equalTo(item);
        make.bottom.equalTo(item);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/5, 80));
        
    }];
    [item4_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item4).offset(8);
        make.centerX.equalTo(item4);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [item4_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item4_img.mas_bottom).offset(8);
        make.centerX.equalTo(item4);
    }];
    
    //item4
    [item5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(item4.mas_right);
        make.top.equalTo(item);
        make.bottom.equalTo(item);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/5, 80));
        
    }];
    [item5_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item5).offset(8);
        make.centerX.equalTo(item5);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [item5_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item5_img.mas_bottom).offset(8);
        make.centerX.equalTo(item5);
    }];
    
    UIImageView *right_view=[[UIImageView alloc]init];
    right_view.image=[UIImage imageNamed:@"icon_bj"];
    
    
    [self addSubview:right_view];
    
    [right_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(46);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    
    
    
    
    UITapGestureRecognizer *tableViewGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click1)];
    item1.userInteractionEnabled=YES;
    [item1 addGestureRecognizer:tableViewGesture1];
    
    UITapGestureRecognizer *tableViewGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click2)];
    item2.userInteractionEnabled=YES;
    [item2 addGestureRecognizer:tableViewGesture2];
    
    UITapGestureRecognizer *tableViewGesture3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click3)];
    item3.userInteractionEnabled=YES;
    [item3 addGestureRecognizer:tableViewGesture3];
    
    UITapGestureRecognizer *tableViewGesture4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click4)];
    item4.userInteractionEnabled=YES;
    [item4 addGestureRecognizer:tableViewGesture4];
    
    UITapGestureRecognizer *tableViewGesture5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click5)];
    item5.userInteractionEnabled=YES;
    [item5 addGestureRecognizer:tableViewGesture5];
    
    UITapGestureRecognizer *tableViewGesture6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click6)];
    right_view.userInteractionEnabled=YES;
    [right_view addGestureRecognizer:tableViewGesture6];
    
}

-(void)click1{
    NSLog(@"clcik1");
    
    RZXXViewController * con=[[RZXXViewController alloc]init];
 
    self.controller.navigationController.navigationBar.alpha=1.0;
    [self.controller.navigationController pushViewController:con animated:YES];
//    [self.controller showViewController:con sender:self.controller];
    
    
}


-(void)click2{
    WDDSViewController * con=[[WDDSViewController alloc]init];
    
     [self.controller.navigationController.navigationBar setAlpha:1];
    [self.controller.navigationController pushViewController:con animated:YES];
    
}
-(void)click3{
    VIPViewController * con=[[VIPViewController alloc]init];
     [self.controller.navigationController.navigationBar setAlpha:1];
    
    [self.controller.navigationController pushViewController:con animated:YES];
    
}
-(void)click4{
    [self.controller.navigationController.navigationBar setAlpha:1];
    
    WYZQViewController * con=[[WYZQViewController alloc]init];
    
    
    [self.controller.navigationController pushViewController:con animated:YES];
    
}
-(void)click5{
    WDSZViewController * con=[[WDSZViewController alloc]init];
    
    
    [self.controller.navigationController pushViewController:con animated:YES];
    
}

-(void)click6{
    [self.controller.navigationController.navigationBar setAlpha:1];
    UserInfoViewController * info=[[UserInfoViewController alloc]init];
    
    [self.controller.navigationController pushViewController:info animated:YES];
    
}
@end
