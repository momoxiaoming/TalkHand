//
//  PipViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/6/14.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "PipViewController.h"
#import "AFHttpSessionClient.h"
#import "PhoneViewController.h"
@interface PipViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *left_img;
@property (weak, nonatomic) IBOutlet UIImageView *right_img;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation PipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImage *normal_img2=[UIColor createImage:@"#2fb9c3"];
    UIImage *select_img2=[UIImage imageNamed:@"#1082f4"];
    [self.btn setBackgroundImage:normal_img2 forState:UIControlStateNormal];
    [self.btn setBackgroundImage:select_img2 forState:UIControlStateSelected];
    self.btn.tintColor=[UIColor whiteColor];
    [self.btn setTitle:@"取消连接" forState:UIControlStateNormal];
    self.btn.layer.cornerRadius=6;
    self.btn.layer.masksToBounds = YES;
    
    
    [self.btn addTarget:self action:@selector(btn_aciton) forControlEvents:UIControlEventTouchUpInside];
    [self getUserData];
    [self getUserData2];
    
    
    self.left_img.layer.cornerRadius=60;
    self.left_img.layer.masksToBounds=YES;
    self.right_img.layer.cornerRadius=60;
    self.right_img.layer.masksToBounds=YES;
    
      [self tx_springAni:10];
    
}
-(void)viewWillAppear:(BOOL)animated{
  
    self.navigationController.navigationBar.alpha=0;
  
}


-(void)btn_aciton{
//    [self goNextController:nil];
    [self.navigationController popViewControllerAnimated:YES];
    Toast * toast=[Toast makeText:@"您已取消连接"];
    [toast showWithType:ShortTime];
    
}


- (void)tx_springAni:(NSInteger) num{
    CABasicAnimation * ani = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    ani.toValue =[NSNumber numberWithFloat:0.3];
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation * ani2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    ani2.toValue =[NSNumber numberWithFloat:1];
    ani2.removedOnCompletion = NO;
    ani2.fillMode = kCAFillModeForwards;
    ani2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
   
    
    CAAnimationGroup * groupAni = [CAAnimationGroup animation];
    groupAni.animations = @[ani, ani2];
    groupAni.duration = 2;
    groupAni.repeatCount=num; //动画的执行次数
    groupAni.fillMode = kCAFillModeForwards;
    groupAni.removedOnCompletion = NO;
 
    groupAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.left_img.layer addAnimation:groupAni forKey:@"groupAni"];
    
    [self.right_img.layer addAnimation:groupAni forKey:@"groupAni"];
}

-(void)getUserData{
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    NSUserDefaults * def=[NSUserDefaults standardUserDefaults];
//    NSString * acount1=[def objectForKey:@"id"];
    NSMutableDictionary * msdir=[[NSMutableDictionary alloc]init];
    
    [msdir setObject:self.acount forKey:@"otherId"];
    [msdir setObject:@"" forKey:@"ownerId"];
    
    
    
    
    [as post:getUserinfo_url parameters:msdir actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
    
        NSInteger state=[posts[@"state"]integerValue];
        if(state==1){
            [self.left_img sd_setImageWithURL:[NSURL URLWithString:posts[@"iconUrl"]] placeholderImage:[UIImage imageNamed:@"icon_mor"]];
        }
        
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            PhoneViewController * pv=[[PhoneViewController alloc]init];
            pv.imgUrl=posts[@"iconUrl"];
            [self goNextController:pv];
        });
    }];
}

-(void)getUserData2{
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    NSUserDefaults * def=[NSUserDefaults standardUserDefaults];
    NSString * acount=[def objectForKey:@"id"];
    NSMutableDictionary * msdir=[[NSMutableDictionary alloc]init];
    [msdir setObject:@"" forKey:@"otherId"];
    [msdir setObject:acount forKey:@"ownerId"];
    
    
    
    
    [as post:getUserinfo_url parameters:msdir actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
        
        NSInteger state=[posts[@"state"]integerValue];
        if(state==1){
            [self.right_img sd_setImageWithURL:[NSURL URLWithString:posts[@"iconUrl"]] placeholderImage:[UIImage imageNamed:@"icon_mor"]];
            
            
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
