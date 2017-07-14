//
//  VIPViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/6/13.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "VIPViewController.h"
#import "PayViewController.h"
@interface VIPViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *top_bg_img;
- (IBAction)vip1_aciton:(id)sender;
- (IBAction)vip2_aciton:(id)sender;
- (IBAction)vip3_aciton:(id)sender;

@end

@implementation VIPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"会员";
    
    
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{

//   [self.navigationController.navigationBar setHidden:NO];
    self.navigationController.navigationBar.alpha=1;
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

- (IBAction)vip1_aciton:(id)sender {
    
    PayViewController * pay=[[PayViewController alloc]init];
    pay.price=@"99";
    
    [self goNextController:pay];
    
}

- (IBAction)vip2_aciton:(id)sender {
    PayViewController * pay=[[PayViewController alloc]init];
    pay.price=@"199";
    
    [self goNextController:pay];
}

- (IBAction)vip3_aciton:(id)sender {
    PayViewController * pay=[[PayViewController alloc]init];
    pay.price=@"299";
    
    [self goNextController:pay];
}


-(void)doAlertPay:(NSString *)price{
    
  

}



@end
