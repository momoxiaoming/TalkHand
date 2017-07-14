//
//  PhoneViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/6/14.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "PhoneViewController.h"
#import "VIPViewController.h"
#import "Toast.h"
@interface PhoneViewController ()
@property (weak, nonatomic) IBOutlet UIButton *qx_btn;
@property (weak, nonatomic) IBOutlet UIButton *jt_btn;
- (IBAction)qx_aciton:(id)sender;
- (IBAction)jt_aciton:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *bg_img;

@end

@implementation PhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor blackColor];
    
    
    UIImage *normal_img1=[UIColor createImage:@"#666666"];
    UIImage *select_img1=[UIImage imageNamed:@"#1082f4"];
    [self.qx_btn setBackgroundImage:normal_img1 forState:UIControlStateNormal];
    [self.qx_btn setBackgroundImage:select_img1 forState:UIControlStateSelected];
    self.qx_btn.tintColor=[UIColor whiteColor];
    [self.qx_btn setTitle:@"挂断" forState:UIControlStateNormal];
    self.qx_btn.layer.cornerRadius=6;
    self.qx_btn.layer.masksToBounds = YES;
    
    UIImage *normal_img2=[UIColor createImage:@"#2fb9c3"];
    UIImage *select_img2=[UIImage imageNamed:@"#1082f4"];
    [self.jt_btn setBackgroundImage:normal_img2 forState:UIControlStateNormal];
    [self.jt_btn setBackgroundImage:select_img2 forState:UIControlStateSelected];
    self.jt_btn.tintColor=[UIColor whiteColor];
    [self.jt_btn setTitle:@"接听" forState:UIControlStateNormal];
    self.jt_btn.layer.cornerRadius=6;
    self.jt_btn.layer.masksToBounds = YES;
    
    
    [_bg_img sd_setImageWithURL:[NSURL URLWithString:self.imgUrl] placeholderImage:[UIImage imageNamed:@"icon_qdym"]];
    
    [self tx_springAni:100];
    
}

- (void)tx_springAni:(NSInteger) num{
    CABasicAnimation * ani = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    ani.toValue =[NSNumber numberWithFloat:0.8];
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation * ani2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    ani2.toValue =[NSNumber numberWithFloat:1.5];
    ani2.removedOnCompletion = NO;
    ani2.fillMode = kCAFillModeForwards;
    ani2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation * ani3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    ani3.toValue =[NSNumber numberWithFloat:1];
    ani3.removedOnCompletion = NO;
    ani3.fillMode = kCAFillModeForwards;
    ani3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup * groupAni = [CAAnimationGroup animation];
    groupAni.animations = @[ani, ani2,ani3];
    groupAni.duration = 10;
    groupAni.repeatCount=num; //动画的执行次数
    groupAni.fillMode = kCAFillModeForwards;
    groupAni.removedOnCompletion = NO;
    
    groupAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.bg_img.layer addAnimation:groupAni forKey:@"groupAni"];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];

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

- (IBAction)qx_aciton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    Toast * toast=[Toast makeText:@"您已取消视频聊天"];
    [toast showWithType:ShortTime];
}

- (IBAction)jt_aciton:(id)sender {
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"您还不是会员用户哦,是否马上开通会员?会员可享用无线一对一视频特权哦!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * qx=[UIAlertAction actionWithTitle:@"忍心拒绝" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    
    UIAlertAction * qd=[UIAlertAction actionWithTitle:@"马上开通" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self goNextController:[[VIPViewController alloc]init] ];
    }];
    
    [alert addAction:qx];
    [alert addAction:qd];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}
@end
