//
//  SexViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/5/17.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "SexViewController.h"
#import "TXViewController.h"
#import "AFHttpSessionClient.h"
#import "LoginProgressView.h"
@interface SexViewController ()
@property LoginProgressView * loginprogress;
@end

@implementation SexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"性别";
    [self initview];
}


-(void)initview{
    UILabel * topstr=[[UILabel alloc]init];
    
    topstr.textColor=[UIColor blackColor];
    topstr.text=@"请问您的性别是?";
    
    UIView * nview=[[UIView alloc] init];
    UIImageView * nv=[[UIImageView alloc]init];
    nv.image=[UIImage imageNamed:@"icon_nv"];
    UILabel * nvl=[[UILabel alloc]init];
    nvl.text=@"女";
    nvl.textColor=[UIColor colorWithHexString:@"#ff80ab"];
    nvl.textAlignment=NSTextAlignmentCenter;
    [nview addSubview:nv];
    [nview addSubview:nvl];
    
    UIView * nanview=[[UIView alloc] init];
    UIImageView * nanv=[[UIImageView alloc]init];
    nanv.image=[UIImage imageNamed:@"icon_nan"];
    UILabel * nanl=[[UILabel alloc]init];
    nanl.text=@"男";
    nanl.textColor=[UIColor colorWithHexString:@"#39b4ff"];
    nanl.textAlignment=NSTextAlignmentCenter;
    
    
    [nanview addSubview:nanv];
    [nanview addSubview:nanl];
    
    UILabel * botstr=[[UILabel alloc]init];
    botstr.text=@"注册成功后,性别不可以修改!";
    botstr.textColor=[UIColor colorWithHexString:@"#2fb9c3"];
     
    [self.view addSubview:topstr];
    [self.view addSubview:nview];
    [self.view addSubview:nanview];
    [self.view addSubview:botstr];
    
    
    [nv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nview);
        make.left.equalTo(nview);
        make.right.equalTo(nview);
        make.size.mas_equalTo(CGSizeMake(66, 66));
    }];
    [nvl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nv.mas_bottom).offset(20);
        make.centerX.equalTo(nview);
        make.size.mas_equalTo(CGSizeMake(33, 20));
    }];
    
    [nanv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nanview);
        make.left.equalTo(nanview);
        make.right.equalTo(nanview);
        make.size.mas_equalTo(CGSizeMake(66, 66));
    }];
    [nanl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nanv.mas_bottom).offset(20);
        make.centerX.equalTo(nanview);
        make.size.mas_equalTo(CGSizeMake(33, 20));
    }];

    [topstr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(26);
    }];
    
    
    [nview mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(topstr.mas_bottom).offset(32);
       make.left.equalTo(self.view).offset(73);
       make.size.mas_equalTo(CGSizeMake(66, 106));
   }];
    
    [nanview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topstr.mas_bottom).offset(32);
        make.right.equalTo(self.view).offset(-73);
        make.size.mas_equalTo(CGSizeMake(66, 106));
    }];
    
     [botstr mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(nanl.mas_bottom).offset(33);
         make.centerX.equalTo(self.view);
     }];
    
    
    
    [self setListener:nview index:1];
    [self setListener:nanview index:2];
    
    
    self.loginprogress=[[LoginProgressView alloc] init];
    
//    self.loginprogress.timeoutObserver=^(id observerble ,id arg1){
//        //        NSLog(@"超时回调");
//        [safeSelf.loginprogress showProgressView:NO onParent:safeSelf.view]; //取消时,取消进度窗
//        
//     
//    };
    
}

-(void)setListener:(UIView *) arr index:(NSInteger) index{
    
    arr.tag=index;   //设置传递的参数
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuAction:)];
    //    tableViewGesture.view.tag=index;
    arr.userInteractionEnabled=YES;
    [arr addGestureRecognizer:tableViewGesture];
    
}


-(void)menuAction:(id)sender{
    
    
    [self.loginprogress showProgressView:YES onParent:self.view title:@"注册中..."];  //弹出进度窗
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    
    UIView *views = (UIView*) tap.view;

    NSUInteger index = views.tag;   //获取上面view设置的tag
    NSString *sex;
    switch (index) {
        case 1:
           sex=@"2";
            break;
        case 2:
              sex=@"1";
            break;
        default:
            break;
    }
  
    
    
    
    
    
    [self SendData:sex name:self.userinfo[@"name"]];
}



-(void)SendData:(NSString *) sex name:(NSString *)name{
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    NSMutableDictionary * parm=[[NSMutableDictionary alloc]init];
//    [parm setValue:@"100" forKey:@"phone"];
    [parm setValue:name forKey:@"name"];
    [parm setValue:sex forKey:@"sex"];
    
    [as post:regiest_url parameters:parm actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
        
//        int state=[posts[@"state"] intValue];
        
        //获取NSUserDefaults对象
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        //存数据，不需要设置路劲，NSUserDefaults将数据保存在preferences目录下
        
        [userDefaults setObject:posts[@"id"] forKey:@"id"];
        
        [userDefaults setObject:posts[@""] forKey:@"phone"];
        
        //立刻保存（同步）数据（如果不写这句话，会在将来某个时间点自动将数据保存在preferences目录下）
        
        [userDefaults synchronize];
        
        [self.loginprogress showProgressView:NO onParent:self.view title:@"注册中"];
        TXViewController * tx=[[TXViewController alloc]init];
        
        [self goNextController:tx];;
    }];
    
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
