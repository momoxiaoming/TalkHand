//
//  WDDS_TX_ViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/4/25.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "WDDS_TX_ViewController.h"
#import "AFHttpSessionClient.h"
@interface WDDS_TX_ViewController ()

@property UITextField * bel2_1;  //提现金额
@property UILabel * bel1_1;   //余额
@end

@implementation WDDS_TX_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我的打赏";
    [self initView];
    
    //防止导航栏遮住控件
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.bel1_1.text=[NSString stringWithFormat:@"¥%@",self.dsprcie];
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.alpha=1;

}






-(void)initView{
    UIView * item1=[[UIView alloc]init];
    item1.backgroundColor=[UIColor whiteColor];
    UILabel * bel1=[[UILabel alloc]init];
    bel1.text=NSLocalizedString(@"wdds_tx_t1", nil);
    bel1.textColor=[UIColor colorWithHexString:@"#4d4d4d"];
    bel1.font=[UIFont systemFontOfSize:14];
    
    
     _bel1_1=[[UILabel alloc]init];
    _bel1_1.text=@"¥0";
    _bel1_1.textColor=[UIColor colorWithHexString:@"#4d4d4d"];
    _bel1_1.font=[UIFont systemFontOfSize:14];
    
    
    UILabel * bel2=[[UILabel alloc]init];
    bel2.text=NSLocalizedString(@"wdds_tx_t2", nil);
    bel2.textColor=[UIColor colorWithHexString:@"#4d4d4d"];
    bel2.font=[UIFont systemFontOfSize:14];
    
    _bel2_1=[[UITextField alloc] init];
//    _bel2_1.text=@"111";
    _bel2_1.borderStyle=UITextBorderStyleRoundedRect;
    
    self.bel2_1.keyboardType=UIKeyboardTypeNumberPad;
    
    UIButton * next2=[[UIButton alloc]init];
    UIImage *normal_img2=[UIColor createImage:@"#2fb9c3"];
    UIImage *select_img2=[UIImage imageNamed:@"#1082f4"];
    
    [next2 setBackgroundImage:normal_img2 forState:UIControlStateNormal];
    [next2 setBackgroundImage:select_img2 forState:UIControlStateSelected];
    next2.tintColor=[UIColor whiteColor];
    [next2 setTitle:@"确定提现" forState:UIControlStateNormal];
    next2.layer.cornerRadius=6;
    next2.layer.masksToBounds = YES;
    
    
    
    
    [item1 addSubview:bel1];
    [item1 addSubview:_bel1_1];
    [item1 addSubview:bel2];
    [item1 addSubview:_bel2_1];
    [item1 addSubview:next2];
    
    
    
    UIView * item2=[[UIView alloc]init];
    item2.backgroundColor=[UIColor whiteColor];

    UILabel * item2_le1=[[UILabel alloc]init];
    item2_le1.text=NSLocalizedString(@"wdds_tx_t3", nil);
    item2_le1.textColor=[UIColor colorWithHexString:@"#3d3d3d"];
    item2_le1.font=[UIFont systemFontOfSize:14];
    
    
    UILabel * item2_le2=[[UILabel alloc]init];
    item2_le2.text=NSLocalizedString(@"wdds_tx_t4", nil);
    item2_le2.textColor=[UIColor colorWithHexString:@"#3d3d3d"];
    item2_le2.font=[UIFont systemFontOfSize:14];
    item2_le2.numberOfLines = 0;//表示label可以多行显示
   
    
    UILabel * item2_le3=[[UILabel alloc]init];
    item2_le3.text=NSLocalizedString(@"wdds_tx_t5", nil);
    item2_le3.textColor=[UIColor colorWithHexString:@"#3d3d3d"];
    item2_le3.font=[UIFont systemFontOfSize:14];
    
    UILabel * item2_le4=[[UILabel alloc]init];
    item2_le4.text=NSLocalizedString(@"wdds_tx_t6", nil);
    item2_le4.textColor=[UIColor colorWithHexString:@"#3d3d3d"];
    item2_le4.font=[UIFont systemFontOfSize:14];
    
    
    [item2 addSubview:item2_le1];
     [item2 addSubview:item2_le2];
     [item2 addSubview:item2_le3];
     [item2 addSubview:item2_le4];
    
    
    [self.view addSubview:item1];
    [self.view addSubview:item2];

     [item1 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.view).offset(10);
         make.left.equalTo(self.view);
         make.right.equalTo(self.view);
         make.size.mas_offset(CGSizeMake(0, 200));
         
     }];
    
    [bel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item1).offset(50);
        make.left.equalTo(item1).offset(20);
        
    }];
    
    [_bel1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bel1);
        make.left.equalTo(bel1.mas_right).offset(15);
        
    }];
    
    [bel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bel1.mas_bottom).offset(32);
        make.left.equalTo(item1).offset(20);
        
    }];
    
    [_bel2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bel2);
        make.left.equalTo(bel2.mas_right).offset(15);
        make.size.mas_equalTo(CGSizeMake(120, 25));
//        make.height.equalTo(bel2);
//        make.right.equalTo(item1).offset(-30);
//        make.size.mas_equalTo(CGSizeMake(120, 0));
//        make.right.equalTo(item1).offset(-30);
    }];
    
    
    
    
    [next2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(item1);
        make.bottom.equalTo(item1.mas_bottom).offset(-20);
        make.size.mas_offset(CGSizeMake(133, 34));
    }];
    
    [item2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item1.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(0, 150));
        
    }];
    
    
    [item2_le1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item2).offset(23);
        make.left.equalTo(item2).offset(20);
       
        
    }];
    
    [item2_le2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item2_le1.mas_bottom).offset(5);
        make.left.equalTo(item2).offset(20);
         make.right.equalTo(item2).offset(-58);
        
    }];
    [item2_le3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item2_le2.mas_bottom).offset(5);
        make.left.equalTo(item2).offset(20);
        
    }];
    [item2_le4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item2_le3.mas_bottom).offset(5);
        make.left.equalTo(item2).offset(20);
        
    }];
    
//    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tx_action)];
    [next2 addTarget:self action:@selector(tx_action) forControlEvents:UIControlEventTouchUpInside];
}

-(void)tx_action{
    NSInteger ntx_prcie=[self.bel2_1.text integerValue];
    NSInteger max=[self.dsprcie integerValue];
    if(ntx_prcie>=100&&ntx_prcie<=max&&(ntx_prcie%100)==0){
        
        
        
    }else {
    
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"提现信息有误!" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
       
          [self presentViewController:alert animated:YES completion:nil];
    }
    

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
