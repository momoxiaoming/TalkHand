//
//  TXViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/5/17.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "TXViewController.h"
#import "MainTabBarController.h"
@interface TXViewController ()

@end

@implementation TXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   self.title=@"头像上传";
    [self initview];
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.alpha =0;
    


}


-(void)initview{
    UILabel * right_txt=[[UILabel alloc]init];
    right_txt.text=@"跳过";
    right_txt.textColor=[UIColor colorWithHexString:@"#2fb9c3"];
    
    
    
    
    UIImageView * topimg=[[UIImageView alloc] init];
    topimg.image=[UIImage imageNamed:@"icon_qieh"];
    
    UILabel * censtr=[[UILabel alloc]init];
    censtr.text=@"上传头像,可以让更多人主动和你搭讪哦";
    censtr.font=[UIFont systemFontOfSize:14];
    censtr.textColor=[UIColor colorWithHexString:@"#999999"];
    
    
    
    UIButton *pzsc=[[UIButton alloc]init];
    UIImage *normal_img2=[UIColor createImage:@"#0abaf4"];
    UIImage *select_img2=[UIImage imageNamed:@"#1082f4"];
    [pzsc setBackgroundImage:normal_img2 forState:UIControlStateNormal];
    [pzsc setBackgroundImage:select_img2 forState:UIControlStateSelected];
    pzsc.tintColor=[UIColor whiteColor];
    [pzsc setTitle:@"拍照上传" forState:UIControlStateNormal];
    pzsc.layer.cornerRadius=6;
    pzsc.layer.masksToBounds = YES;

    
    UIButton *xcxq=[[UIButton alloc]init];
 
    
    [xcxq setBackgroundImage:normal_img2 forState:UIControlStateNormal];
    [xcxq setBackgroundImage:select_img2 forState:UIControlStateSelected];
    xcxq.tintColor=[UIColor whiteColor];
    [xcxq setTitle:@"相册选取" forState:UIControlStateNormal];
    xcxq.layer.cornerRadius=6;
    xcxq.layer.masksToBounds = YES;
    
    [self.view addSubview:right_txt];
    [self.view addSubview:topimg];
    [self.view addSubview:censtr];
    [self.view addSubview:pzsc];
    [self.view addSubview:xcxq];
    
    [right_txt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.view).offset(30);
        
    }];
    
    
    
    [topimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(116);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150, 123));
    }];
    
    [censtr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topimg.mas_bottom).offset(40);
        make.centerX.equalTo(self.view);
        
    }];
    
    
    [pzsc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(censtr.mas_bottom).offset(66);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.size.mas_equalTo(CGSizeMake(0, 45));
    }];
    [xcxq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pzsc.mas_bottom).offset(25);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.size.mas_equalTo(CGSizeMake(0, 45));
    }];



    [self setListener:right_txt index:1];


}

-(void)setListener:(UIView *) arr index:(NSInteger) index{
    
    arr.tag=index;   //设置传递的参数
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuAction:)];
    //    tableViewGesture.view.tag=index;
    arr.userInteractionEnabled=YES;
    [arr addGestureRecognizer:tableViewGesture];
    
}


-(void)menuAction:(id)sender{
//    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    
//    UIView *views = (UIView*) tap.view;
    
//    NSUInteger index = views.tag;   //获取上面view设置的tag
 
    
    [self goNextController:[[MainTabBarController alloc]init]];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
