//
//  VideoViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/3/24.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "VideoViewController.h"
#import "SxViewController.h"
#import "AFHttpSessionClient.h"
#import "PipViewController.h"
#import "SearchView.h"
@interface VideoViewController ()
@property UILabel * pp_btn;
@property NSMutableDictionary *sx_dri;
@property NSMutableDictionary *send_data;
@property UILabel *num;
@property SearchView *search;
@property NSDictionary *finUser;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    _sx_dri=[[NSMutableDictionary alloc]init];
    [self createView];
    
}



-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sx_aciton:) name:@"sx_data" object:nil];
    
    if(_num!=NULL){
        NSInteger index = arc4random() % (3000)+2000;
        _num.text=[NSString stringWithFormat:@"%lu",index];
    
    }
    
    if(_search!=NULL){
        [_search stopHh];
        [_pp_btn setBackgroundColor:[UIColor colorWithHexString:@"0BE6FF"]];
//        [[Toast makeText:@"匹配失败,请重试!"]showWithType:ShortTime];
//        [_search stopHh];
        [_pp_btn setEnabled:true];
        [_pp_btn setText:@"开始匹配"];
    }
    
    
    
}



-(void)sx_aciton:(NSMutableDictionary*)sender{
  
    self.sx_dri=sender;
    
    NSLog(@"%@",sender);
   
}

-(void)createView{
    UILabel *title=[[UILabel alloc]init];
    title.text=@"在线视频";
    title.textColor=[UIColor whiteColor];
    title.font=[UIFont systemFontOfSize:20];
    
    UIView *item=[[UIView alloc]init];
    
    UILabel *inf=[[UILabel alloc]init];
    inf.text=@"一对一在线视频聊天人数:";
    inf.textColor=[UIColor whiteColor];
    inf.font=[UIFont systemFontOfSize:16];
    
    _num=[[UILabel alloc]init];
    _num.text=@"4560";
    _num.textColor=[UIColor colorWithHexString:@"#2fb9c3"];
    _num.font=[UIFont systemFontOfSize:16];
    
    
    UIView *sx_view=[[UIView alloc]init];
    UIImageView *sx_img=[[UIImageView alloc]init];
    sx_img.image=[UIImage imageNamed:@"icon_sx"];
    UILabel * sx_txt=[[UILabel alloc]init];
    sx_txt.text=@"筛选";
    sx_txt.textColor=[UIColor whiteColor];
    sx_txt.font=[UIFont systemFontOfSize:10];
    
    [sx_view addSubview:sx_img];
    [sx_view addSubview:sx_txt];
    
    
    
    [sx_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sx_view);
        make.bottom.equalTo(sx_view);
        make.left.equalTo(sx_view);
        make.size.mas_equalTo(CGSizeMake(20, 20));
      
    }];
    
    
    [sx_txt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sx_img.mas_right).offset(5);
        make.top.equalTo(sx_img);
        make.bottom.equalTo(sx_img);
        make.size.mas_equalTo(CGSizeMake(25, 40));
    }];
    
    [item addSubview:inf];
    [item addSubview:_num];
    [item addSubview:sx_view];
    
    [inf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(item).offset(20);
        make.centerY.equalTo(item);
    }];
    [_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item);
        make.left.equalTo(inf.mas_right).offset(5);
        
    }];
    [sx_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(item).offset(-10);
        make.centerY.equalTo(item);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    
    UIImageView * bgimgView=[[UIImageView alloc]init];
    bgimgView.image=[UIImage imageNamed:@"icon_content"];
    [self.view addSubview:bgimgView];
    [bgimgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view);
    }];

    
    
    _search=[[SearchView alloc]initWithFrame:CGRectMake(0, self.view.center.y-SCREEN_WIDTH/2, SCREEN_WIDTH, SCREEN_WIDTH)];
    
    [self.view addSubview:_search];
//    _findview=[[FingerWaveView alloc]init];
////    _findview.backgroundColor=[UIColor redColor];
//      [self.view addSubview:_findview];
//    [_findview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
////        make.centerX.equalTo(self.view);
//    }];
    
    _pp_btn=[[UILabel alloc]init];
    _pp_btn.text=@"开始匹配";
    _pp_btn.textColor=[UIColor whiteColor];
    _pp_btn.textAlignment=NSTextAlignmentCenter;
    _pp_btn.layer.masksToBounds = YES;
    _pp_btn.layer.cornerRadius = 3.3;
    _pp_btn.backgroundColor=[UIColor colorWithHexString:@"#0BE6FF"];
    
    [self.view addSubview:_pp_btn];
    [self.view addSubview:title];
    [self.view addSubview:item];
 
    
    
    
    
    [_pp_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-90);
        make.size.mas_equalTo(CGSizeMake(120, 40));
    }];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(40);
        make.centerX.equalTo(self.view);
    }];
    
    [item mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).offset(30);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(0, 20));
        
    }];
    
    
    
    
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentTableViewTouchInSide)];
    _pp_btn.userInteractionEnabled=YES;
    [_pp_btn addGestureRecognizer:tableViewGesture];
    
    UITapGestureRecognizer *tableViewGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sx_action)];
    sx_view.userInteractionEnabled=YES;
    [sx_view addGestureRecognizer:tableViewGesture2];
    
    
    
    

}
-(void)sx_action{
    SxViewController * pay=[[SxViewController alloc]init];
   

    pay.view.backgroundColor=[UIColor colorWithWhite:0 alpha:0.4];   //提前设置背景透明
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]>8.0){  //区分版本
        pay.modalPresentationStyle=UIModalPresentationOverCurrentContext;    //该句一定要
    }else{
        pay.modalPresentationStyle=UIModalPresentationCurrentContext;    //该句一定要
        
    }
    //    pay.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;   //这句设置弹出的动画效果
    [self presentViewController:pay animated:YES completion:^(void){
        pay.view.superview.backgroundColor=[UIColor clearColor];
        
    }];
}
-(void)commentTableViewTouchInSide{
    NSString *txt=_pp_btn.text;
    if([txt isEqualToString:@"开始匹配"]){
         [_pp_btn setBackgroundColor:[UIColor grayColor]];
        [_pp_btn setText:@"正在匹配.."];
        [_pp_btn setEnabled:false];
        [_search hidenAllUserView];
        
        
       NSInteger count= arc4random()%4+4;
        
        
        [_search startHh:count dict:1];
        [self sendData];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(count * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            if(self.finUser!=NULL){
                [_pp_btn setText:@"匹配完成.."];
                [_search showUser];
                [_pp_btn setEnabled:true];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    PipViewController * pip=[[PipViewController alloc]init];
                    pip.acount=self.finUser[@"account"];
                    [self goNextController:pip];
                });
                
                
            
            }else{
             [_pp_btn setBackgroundColor:[UIColor colorWithHexString:@"0BE6FF"]];
             [[Toast makeText:@"匹配失败,请重试!"]showWithType:ShortTime];
             [_search stopHh];
             [_pp_btn setEnabled:true];
             [_pp_btn setText:@"开始匹配"];
            
            }
           
        });
    }else{
        [[Toast makeText:@"正在匹配中.."]showWithType:ShortTime];
        return;
    }
    
   
//    [self position];
//    [self.findview tx_springAni];
//
//    
//    [self sendData];
 
    
    
    
    
    
}


-(void)sendData{
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    NSUserDefaults * def=[NSUserDefaults standardUserDefaults];
    NSString * acount=[def objectForKey:@"id"];
    if(_send_data==NULL){
        _send_data=[[NSMutableDictionary alloc]init];
        [_send_data setObject:@"0" forKeyedSubscript:@"sex"];
        [_send_data setObject:@"" forKeyedSubscript:@"isAttest"];
        [_send_data setObject:@""forKeyedSubscript:@"address"];
        [_send_data setObject:@"" forKeyedSubscript:@"age"];
         [_send_data setObject:acount forKeyedSubscript:@"id"];
    }else{
        [_send_data setObject:acount forKey:@"id"];
        [_send_data setObject:@""forKeyedSubscript:@"address"];
    }

    [as post:getvideo_url parameters:_send_data actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
    
        NSInteger state=[posts[@"state"]integerValue];
        if(state==1){
            NSArray * userData=posts[@"data"];
            
        
            
            NSInteger index = arc4random() % (userData.count);
            NSDictionary * dir=  [userData objectAtIndex:index];
         
            self.finUser=dir;
                [self.search setUserImgUrl:userData];
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
