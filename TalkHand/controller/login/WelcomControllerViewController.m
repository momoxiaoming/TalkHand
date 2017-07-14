//
//  WelcomControllerViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/6/5.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "WelcomControllerViewController.h"
#import "MainTabBarController.h"
#import "AFHttpSessionClient.h"
#import "FMDConfig.h"
#import "ConfigEntity.h"
#import "LocalUDPDataSender.h"
#import "IMClientManager.h"
@interface WelcomControllerViewController ()

@end

@implementation WelcomControllerViewController
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
        NSLog(@"viewWillAppear");
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
    NSLog(@"viewWillDisappear");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    // Do any additional setup after loading the view.
    
   [[IMClientManager sharedInstance] initMobileIMSDK]; //初始化聊天
    bool isInit=false;
    while(!isInit){
      isInit  =[IMClientManager sharedInstance].isinit;
    }

    
    if(isInit){
        UIImageView *bg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        bg.image=[UIImage imageNamed:@"icon_qdym"];
        [self.view addSubview:bg];
        
        NSUserDefaults * defa=[NSUserDefaults standardUserDefaults];
        NSString * name=[defa valueForKey:@"id"];
        NSString * pwd=[defa valueForKey:@"password"];
        if(name!=NULL&&pwd!=NULL){
            NSLog(@"name-->%@--pwd--%@",name,pwd);
            
            [self getUserinfo];
            int code=1;
            int num=0;
            while (code!=0&&num<5) {
                num++;
                code= [self login:name pwd:pwd];
            }
            
            
            
            MainTabBarController * tab=[[MainTabBarController alloc]init];
            //切换根视图
            UIApplication.sharedApplication.delegate.window.rootViewController=tab;
            
        }else{
            [self moreData];
            [self getUserinfo];
        }
    }
    
 
}

-(void)getUserinfo{
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    NSMutableDictionary * parm=[[NSMutableDictionary alloc]init];
    //获取NSUserDefaults对象
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //读取数据
    NSString *own = [userDefaults objectForKey:@"id"];
    
    [parm setValue:own forKey:@"ownerId"];
    [parm setValue:@"" forKey:@"otherId"];
    
    
    [as post:getUserinfo_url parameters:parm actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
        
        NSInteger state=[posts[@"state"]integerValue];
        
        
        if(state==1){
            
            [[FMDConfig sharedInstance] saveUserInfo:posts ];
            
          
        }else {
            posts=[[FMDConfig sharedInstance]getUserInfoWithId:own];
            
            
        }
        
        
        
        
    }];
    
    
    
}





//登陆
-(int)login:(NSString *)name pwd:(NSString*)pwd{
    int code = [[LocalUDPDataSender sharedInstance] sendLogin:name withPassword:pwd];
    
    
    
    
    NSLog(@"登陆状态码:%i",code);
    
    return code;
}




-(void)initAppData{
   
    
    
    
    
    

}



-(void)moreData{
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    NSMutableDictionary * data=[[NSMutableDictionary alloc]init];
    [as post:getAccount_url parameters:data actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
        
        
        
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        //存数据，不需要设置路劲，NSUserDefaults将数据保存在preferences目录下
        
        [userDefaults setObject:posts[@"account"] forKey:@"id"];
        
        [userDefaults setObject:posts[@"password"] forKey:@"password"];
        
        //立刻保存（同步）数据（如果不写这句话，会在将来某个时间点自动将数据保存在preferences目录下）
        
        [userDefaults synchronize];
        
       int code= [self login:posts[@"account"] pwd:posts[@"password"]];
        if(code==0){
            MainTabBarController * tab=[[MainTabBarController alloc]init];
            //切换根视图
            UIApplication.sharedApplication.delegate.window.rootViewController=tab;
        }
        
       
        
       
  
        

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
