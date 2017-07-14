//
//  NearyTopView.m
//  QsQ
//
//  Created by 张小明 on 2017/5/18.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "NearyTopView.h"
#import "ImageUtil.h"
#import "VIPViewController.h"
@implementation NearyTopView

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
        self=[[NearyTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260+180)];
        [self createView];
    }
    return self;
}

-(void)setViewData:(NSDictionary *)obj{
    self.id_str.text=[NSString stringWithFormat:@"%@",obj[@"account"]];
    self.name.text=[NSString stringWithFormat:@"%@",obj[@"name"]];
    self.adress.text=[NSString stringWithFormat:@"%@",obj[@"address"]];
    self.age.text=[NSString stringWithFormat:@"%@岁",obj[@"age"]];
    NSString * tx_url=[NSString stringWithFormat:@"%@",[obj valueForKey:@"iconUrl"]];
    if(tx_url!=nil){
         [self.tx_img sd_setImageWithURL:[NSURL URLWithString:tx_url] placeholderImage:[UIImage imageNamed:@"icon_mor"]];
    }else{
        self.tx_img.image=[UIImage imageNamed:@"icon_mor"];
    }
   
   self.wx_str.text=[NSString stringWithFormat:@"%@",@"********"];
    self.phone_str.text=[NSString stringWithFormat:@"%@",@"********"];
    self.jysm_str.text=[NSString stringWithFormat:@"%@",obj[@"makeFriend"]];

    NSInteger isvip=[obj[@"isvip"] integerValue];;
    
    if(isvip==0){
        [self.vip_img setHidden:true];
    }else{
        
        self.wx_str.text=[NSString stringWithFormat:@"%@",obj[@"weChat"]];
        self.phone_str.text=[NSString stringWithFormat:@"%@",obj[@"phone"]];
    }
    
}







-(void)createView{
    
    self.backgroundColor=[UIColor colorWithHexString:@"#ebebeb"];
    
    UIImageView *left_top=[[UIImageView alloc] init];
    left_top.image=[UIImage imageNamed:@"icon_fh"];
    
    self.bg_img=[[UIImageView alloc] init];
    self.bg_img.image=[UIImage imageNamed:@"icon_mrbj"];
    
    
    self.tx_img=[[UIImageView alloc] init];
    self.tx_img.image=[UIImage imageNamed:@"icon_mor"];
  
    
    
    self.name=[[UILabel alloc]init];
    self.name.text=@"****";
    self.name.textColor=[UIColor whiteColor];
    
    self.vip_img=[[UIImageView alloc] init];
    self.vip_img.image=[UIImage imageNamed:@"icon_vip"];
    
    
    UIView * info_view=[[UIView alloc]init];
    
    
    UIView * lv_view=[[UIView alloc]init];
    lv_view.layer.cornerRadius=3;
    lv_view.layer.masksToBounds = YES;
    
    self.sex_img=[[UIImageView alloc]init];
    self.sex_img.image=[UIImage imageNamed:@"icon_girl"];
    
    self.vip_lv=[[UILabel alloc] init];
    self.vip_lv.text=@"LV18";
    self.vip_lv.textColor=[UIColor whiteColor];
    
    self.vip_lv.font=[UIFont systemFontOfSize:10];
    
    lv_view.backgroundColor=[UIColor colorWithHexString:@"#ff80ab"];
    [lv_view addSubview:self.sex_img];
    [lv_view addSubview:self.vip_lv];
    [self.sex_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lv_view);
        make.left.equalTo(lv_view).offset(5);
        
        make.size.mas_equalTo(CGSizeMake(5, 9));
        
    }];
    [self.vip_lv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(lv_view);
        
        make.right.equalTo(lv_view).offset(-3);
    }];
    
    self.age=[[UILabel alloc] init];
    self.age.textColor=[UIColor whiteColor];
    self.age.text=@"****";
    
    self.adress=[[UILabel alloc] init];
    self.adress.textColor=[UIColor whiteColor];
    self.adress.text=@"******";
    
    [info_view addSubview:lv_view];
    [info_view addSubview:self.age];
    [info_view addSubview:self.adress];
    
    [lv_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(info_view);
        make.left.equalTo(info_view);
        make.bottom.equalTo(info_view);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    
    [self.age mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lv_view.mas_right).offset(10);
        make.top.equalTo(lv_view);
        make.bottom.equalTo(lv_view);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    [self.adress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(info_view);
        make.left.equalTo(self.age.mas_right).offset(10);
        make.bottom.equalTo(info_view);
         make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    
    
    
    
    UIView * cenView=[[UIView alloc ]init];
    
    
    
    UIView * item1=[[UIView alloc ]init];
    item1.backgroundColor=[UIColor whiteColor];
        UIView * item2=[[UIView alloc ]init];
      item2.backgroundColor=[UIColor whiteColor];
        UIView * item3=[[UIView alloc ]init];
      item3.backgroundColor=[UIColor whiteColor];
        UIView * item4=[[UIView alloc ]init];
      item4.backgroundColor=[UIColor whiteColor];
    
    UILabel * Id_lb=[[UILabel alloc]init];
    Id_lb.text=@"ID:";
    Id_lb.font=[UIFont systemFontOfSize:14];
    Id_lb.textColor=[UIColor colorWithHexString:@"#333333"];
    
     UILabel * wx_lb=[[UILabel alloc]init];
    wx_lb.text=@"微信:";
    wx_lb.font=[UIFont systemFontOfSize:14];
    wx_lb.textColor=[UIColor colorWithHexString:@"#333333"];
     UILabel * sj_lb=[[UILabel alloc]init];
    sj_lb.text=@"手机:";
    sj_lb.font=[UIFont systemFontOfSize:14];
    sj_lb.textColor=[UIColor colorWithHexString:@"#333333"];
     UILabel * jysm_lb=[[UILabel alloc]init];
    jysm_lb.text=@"交友说明:";
    jysm_lb.font=[UIFont systemFontOfSize:14];
    jysm_lb.textColor=[UIColor colorWithHexString:@"#333333"];
    
    self.self.id_str=[[UILabel alloc]init];
    self.wx_str=[[UILabel alloc]init];

    self.phone_str=[[UILabel alloc]init];
    self.jysm_str=[[UILabel alloc]init];
    self.id_str.font=[UIFont systemFontOfSize:14];
    self.id_str.textColor=[UIColor colorWithHexString:@"#333333"];
    self.wx_str.font=[UIFont systemFontOfSize:14];
    self.wx_str.textColor=[UIColor colorWithHexString:@"#333333"];
    self.phone_str.font=[UIFont systemFontOfSize:14];
    self.phone_str.textColor=[UIColor colorWithHexString:@"#333333"];

    self.jysm_str.font=[UIFont systemFontOfSize:14];
    self.jysm_str.textColor=[UIColor colorWithHexString:@"#333333"];
    
    
  
    
    UILabel *wx_btn=[[UILabel alloc]init];
    wx_btn.text=@"获取";
    wx_btn.textColor=[UIColor colorWithHexString:@"#2fb9c3"];
    wx_btn.font=[UIFont systemFontOfSize:12];
    wx_btn.layer.cornerRadius=3;
    wx_btn.layer.masksToBounds = YES;
    //    sj_btn.currentTitle=@"获取";
    wx_btn.textAlignment=NSTextAlignmentCenter;
    

    UILabel *sj_btn=[[UILabel alloc]init];
    sj_btn.text=@"获取";
    sj_btn.textColor=[UIColor colorWithHexString:@"#2fb9c3"];
    sj_btn.font=[UIFont systemFontOfSize:12];
    sj_btn.layer.cornerRadius=3;
    sj_btn.layer.masksToBounds = YES;
    //    sj_btn.currentTitle=@"获取";
    sj_btn.textAlignment=NSTextAlignmentCenter;
    
    [wx_btn.layer setBorderColor:[UIColor colorWithHexString:@"#e5e5e5"].CGColor];
    [wx_btn.layer setBorderWidth:1];
    [wx_btn.layer setMasksToBounds:YES];
    
    [sj_btn.layer setBorderColor:[UIColor colorWithHexString:@"#e5e5e5"].CGColor];
    [sj_btn.layer setBorderWidth:1];
    [sj_btn.layer setMasksToBounds:YES];
    
    
    [item1 addSubview:Id_lb];
    [item1 addSubview:self.id_str];
    
    [Id_lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item1);
        make.left.equalTo(item1).offset(20);
    }];
    [self.id_str mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Id_lb.mas_left).offset(70);
        make.centerY.equalTo(Id_lb);
    }];
    
    
    
    
    [item2 addSubview:wx_lb];
    [item2 addSubview:self.wx_str];
    [item2 addSubview:wx_btn];
    [wx_lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item2);
        make.left.equalTo(item2).offset(20);
    }];
    [self.wx_str mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item2);
        make.left.equalTo(wx_lb.mas_left).offset(70);
    }];
    [wx_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item2);
        make.right.equalTo(item2).offset(-20);
         make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
    
    
    [item3 addSubview:sj_lb];
    [item3 addSubview:self.phone_str];
    [item3 addSubview:sj_btn];
    
    [sj_lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item3);
        make.left.equalTo(item3).offset(20);
    }];
    [self.phone_str mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item3);
        make.left.equalTo(sj_lb.mas_left).offset(70);
    }];
    [sj_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item3);
        make.right.equalTo(item3).offset(-20);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
    
    
    
    
    [item4 addSubview:jysm_lb];
    [item4 addSubview:self.jysm_str];
    [jysm_lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item4);
        make.left.equalTo(item4).offset(20);
    }];
    [self.jysm_str mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(jysm_lb.mas_left).offset(70);
        make.centerY.equalTo(jysm_lb);
    }];
    
    UIView * lin1=[[UIView alloc]init];
    UIView * lin2=[[UIView alloc]init];
    UIView * lin3=[[UIView alloc]init];
    
    lin1.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
        lin2.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
        lin3.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    
    
    [cenView addSubview:item1];
    [cenView addSubview:lin1];
     [cenView addSubview:item2];
    [cenView addSubview:lin2];
     [cenView addSubview:item3];
    [cenView addSubview:lin3];
     [cenView addSubview:item4];
    
     [item1 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(cenView);
         make.left.equalTo(cenView);
         make.right.equalTo(cenView);
         make.size.mas_equalTo(CGSizeMake(0, 40));
         
     }];
    [lin1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(item1.mas_bottom);
        make.right.equalTo(item1).offset(-20);
        make.left.equalTo(item1).offset(20);
        make.size.mas_equalTo(CGSizeMake(0, 0.5));
    }];
    
    [item2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lin1.mas_bottom);
        make.left.equalTo(cenView);
        make.right.equalTo(cenView);
        make.size.mas_equalTo(CGSizeMake(0, 40));
        
    }];
    [lin2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(item2.mas_bottom);
        make.right.equalTo(item2).offset(-20);
        make.left.equalTo(item2).offset(20);
        make.size.mas_equalTo(CGSizeMake(0, 1));
    }];
    
    [item3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lin2.mas_bottom);
        make.left.equalTo(cenView);
        make.right.equalTo(cenView);
        make.size.mas_equalTo(CGSizeMake(0, 40));
        
    }];
    [lin3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(item3.mas_bottom);
        make.right.equalTo(item3).offset(-20);
        make.left.equalTo(item3).offset(20);
        make.size.mas_equalTo(CGSizeMake(0, 0.5));
    }];
    [item4 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(lin3.mas_bottom);
        make.left.equalTo(cenView);
        make.right.equalTo(cenView);
        make.size.mas_equalTo(CGSizeMake(0, 40));
        
    }];
    
    

    
    
    
    
  
   
    
  
    [self addSubview:_bg_img];
    [self addSubview:left_top];
    [self addSubview:_tx_img];
    [self addSubview:self.name];
    [self addSubview:_vip_img];
    [self addSubview:info_view];
   
    [self addSubview:cenView];
    
    
    [left_top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30);
        
        make.left.equalTo(self).offset(20);
        make.size.mas_equalTo(CGSizeMake(10, 25));
    }];
    
    [self.bg_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.right.equalTo(self);
        make.left.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(0, 219));
    }];
    
    
    [self.tx_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bg_img);
        make.size.mas_equalTo(CGSizeMake(66, 66));
    }];
    
    self.tx_img.layer.cornerRadius=33;
     [self.tx_img.layer setMasksToBounds:YES];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tx_img.mas_bottom).offset(5);
        make.centerX.equalTo(self);
    }];
    
    [self.vip_img mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.name.mas_right).offset(6);
        make.centerY.equalTo(self.name);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
   
    
   
    
    [info_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.name.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(140, 15));
    }];
    
    
    
    [cenView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.bg_img.mas_bottom).offset(10);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(0, 180));
    
    }];
   
    
    [self setListener:wx_btn index:1];
    [self setListener:sj_btn index:2];
    [self setListener:left_top index:3];
}




-(void)setListener:(UIView *) arr index:(NSInteger) index{
    
    arr.tag=index;   //设置传递的参数
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuAction:)];
    //    tableViewGesture.view.tag=index;
    arr.userInteractionEnabled=YES;
    [arr addGestureRecognizer:tableViewGesture];
    
    
}


-(void)menuAction:(id)sender{
    
    
    
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    
    UIView *views = (UIView*) tap.view;
    
    NSUInteger index = views.tag;   //获取上面view设置的tag
    if(index==1){
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"会员方可查看,请开通会员!" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"开通会员" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
            VIPViewController *vip=[[VIPViewController alloc] init];
            self.controller.navigationController.navigationBar.alpha=1;
            [self.controller.navigationController pushViewController:vip animated:YES ];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //            [self.controller.navigationController pushViewController:[[VIPViewController alloc] init] animated:YES ];
        }]];
        [self.controller presentViewController:alert animated:YES completion:nil];
    
    }else if (index==2){
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"会员方可查看,请开通会员!" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"开通会员" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            [alert dismissViewControllerAnimated:YES completion:nil];
            
            VIPViewController *vip=[[VIPViewController alloc] init];
            self.controller.navigationController.navigationBar.alpha=1;

            [self.controller.navigationController pushViewController:vip animated:YES ];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            [self.controller.navigationController pushViewController:[[VIPViewController alloc] init] animated:YES ];
        }]];
        [self.controller presentViewController:alert animated:YES completion:nil];
    }else if(index==3){
                [self.controller.navigationController popViewControllerAnimated:YES];
    }
    
    

    
    
}

@end
