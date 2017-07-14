//
//  PayViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/6/13.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "PayViewController.h"

@interface PayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *paynum;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
- (IBAction)payAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *wx_raimg;
@property (weak, nonatomic) IBOutlet UIImageView *zfb_raimg;
@property (weak, nonatomic) IBOutlet UIView *wx_view;

@property (weak, nonatomic) IBOutlet UIView *zfb_view;
@property NSInteger type;

@end

@implementation PayViewController

-(void)viewWillAppear:(BOOL)animated{
  self.navigationController.navigationBar.alpha =1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"支付";
  
    self.type=1;
    
    UIImage *normal_img2=[UIColor createImage:@"#2fb9c3"];
    UIImage *select_img2=[UIImage imageNamed:@"#1082f4"];
    [self.payBtn setBackgroundImage:normal_img2 forState:UIControlStateNormal];
    [self.payBtn setBackgroundImage:select_img2 forState:UIControlStateSelected];
    self.payBtn.tintColor=[UIColor whiteColor];
    [self.payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    self.payBtn.layer.cornerRadius=6;
    self.payBtn.layer.masksToBounds = YES;
    
    
    
    [self setListener:self.wx_view index:1];
    [self setListener:self.zfb_view index:2];
    
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
        self.type=1;
        [self.wx_raimg setImage:[UIImage imageNamed:@"icon_dga"]];
          [self.zfb_raimg setImage:[UIImage imageNamed:@"icon_yuany"]];
    }else if(index==2){
        self.type=2;
        [self.wx_raimg setImage:[UIImage imageNamed:@"icon_yuany"]];
        [self.zfb_raimg setImage:[UIImage imageNamed:@"icon_dga"]];
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

//支付逻辑
- (IBAction)payAction:(id)sender {
    
    if(self.type==1){
    
    }else if(self.type==2){
    
    }
    
    
}
@end
