//
//  JETXViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/6/12.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "JETXViewController.h"

@interface JETXViewController ()

@end

@implementation JETXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //防止导航栏遮住控件
//        self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title=@"提现";
    
    self.tx_inout.keyboardType = UIKeyboardTypeNumberPad;
    
     self.zfb_input.keyboardType = UIKeyboardTypeEmailAddress;
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
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

- (IBAction)TxAction:(id)sender {
    NSString * je=self.tx_inout.text;
    
    NSInteger num=[je intValue];
    
    NSString *zfb=self.zfb_input.text;
    
    NSInteger max=[self.moeny integerValue];;
    
    if(num>=100&&num<=max){   //可提现
        if([zfb isEqualToString:@""]){
          [self doAlert:@"提现账号不能为空!"];
          
        }else{
             [self doAlert:@"您的提现申请已提交,我们将在三个工作日内处理"];
        }
    
    }else{
        [self doAlert:@"提现金额有误!"];
    
    }
  
    
    
    
}

-(void)doAlert:(NSString *)sender{
    UIAlertController * dialog=[UIAlertController alertControllerWithTitle:@"警告" message:sender preferredStyle:UIAlertControllerStyleAlert];
UIAlertAction * action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    
  }];
    [dialog addAction:action];
    [self presentViewController:dialog animated:YES completion:nil];
    
  
    
}


@end
