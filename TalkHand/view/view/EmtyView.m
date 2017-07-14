//
//  EmtyView.m
//  QsQ
//
//  Created by 张小明 on 2017/6/9.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "EmtyView.h"

@implementation EmtyView

-(instancetype)init{
    self =[super init];
    if(self){
        self=[[EmtyView alloc] initWithFrame:CGRectZero];;
        [self createView];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)createView{
 
    UIImageView *bgview=[[UIImageView alloc]init];
    bgview.image=[UIImage imageNamed:@"icon_nopt"];

    
    UILabel *title=[[UILabel alloc]init];
    title.text=@"您还没有视频呢";
    
    
    UIButton *login_btn=[[UIButton alloc]init];
    UIImage *normal_img2=[UIColor createImage:@"#0abaf4"];
    UIImage *select_img2=[UIImage imageNamed:@"#1082f4"];
    [login_btn setBackgroundImage:normal_img2 forState:UIControlStateNormal];
    [login_btn setBackgroundImage:select_img2 forState:UIControlStateSelected];
    login_btn.tintColor=[UIColor whiteColor];
    [login_btn setTitle:@"立即上传" forState:UIControlStateNormal];
    login_btn.layer.cornerRadius=6;
    login_btn.layer.masksToBounds = YES;
    
    
    [self addSubview:bgview];
    
    [self addSubview:title];
    
    [self addSubview:login_btn];
    
  
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(120, 75));
    }];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgview.mas_bottom).offset(20);
        make.centerX.equalTo(self);
    
    }];
    
    
    [login_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).offset(12);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(120, 50));
    }];



}

@end
