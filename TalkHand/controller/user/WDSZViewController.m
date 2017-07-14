//
//  WDSZViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/4/18.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "WDSZViewController.h"
#import "AFHttpSessionClient.h"
@interface WDSZViewController ()

@end

@implementation WDSZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=NSLocalizedString(@"user_center_item5_str", nil);
    [self createView];
    
    //防止导航栏遮住控件
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.alpha=1;
    
    
    
}
-(void)createView{
    SeleView * item1=[[SeleView alloc]initColor:[UIColor whiteColor] PresColor:[UIColor colorWithHexString:@"#e5e5e5"]];
  
    
    UITapGestureRecognizer *item1Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemAction)];
    item1Gesture.numberOfTapsRequired = 1;
    item1Gesture.cancelsTouchesInView = NO;
    [item1 addGestureRecognizer:item1Gesture];
    
    
    
    UILabel * t1=[[UILabel alloc]init];
    t1.textColor=[UIColor colorWithHexString:@"#333333"];
    t1.text=NSLocalizedString(@"set_str", nil);
    UIView *lin1=[[UIView alloc] init];
    lin1.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    
    [item1 addSubview:t1];
    [item1 addSubview:lin1];
    [self.view addSubview:item1];
    [item1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(0, 44));
    }];
    [t1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item1);
        make.left.equalTo(item1).offset(20);
    }];
    [lin1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(item1);
        make.size.mas_equalTo(CGSizeMake(0, 0.5));
        make.right.equalTo(item1);
        make.left.equalTo(item1);
    }];
    
    //--------
    SeleView * item2=[[SeleView alloc]initColor:[UIColor whiteColor] PresColor:[UIColor colorWithHexString:@"#e5e5e5"]];
  
    UITapGestureRecognizer *item2Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemAction2)];
    item2Gesture.numberOfTapsRequired = 1;
    item2Gesture.cancelsTouchesInView = NO;
    [item2 addGestureRecognizer:item2Gesture];
    
    
    
    
    UILabel * t2=[[UILabel alloc]init];
    t2.textColor=[UIColor colorWithHexString:@"#333333"];
    t2.text=NSLocalizedString(@"set_str2", nil);
    UIView *lin2=[[UIView alloc] init];
    lin2.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    UIImageView *left=[[UIImageView alloc]init];
    left.image=[UIImage imageNamed:@"icon_yjr"];
    
    [item2 addSubview:t2];
    [item2 addSubview:lin2];
    [item2 addSubview:left];
    [self.view addSubview:item2];
    
    [item2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item1.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(0, 44));
    }];
    [t2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item2);
        make.left.equalTo(item2).offset(20);
    }];
    [lin2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(item2);
        make.size.mas_equalTo(CGSizeMake(0, 0.5));
        make.right.equalTo(item2);
        make.left.equalTo(item2);
    }];
    [left  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item2);
        make.right.equalTo(item2).offset(-20);
    }];
   
//---------
    //--------
   SeleView * item3=[[SeleView alloc]initColor:[UIColor whiteColor] PresColor:[UIColor colorWithHexString:@"#e5e5e5"]];
    UITapGestureRecognizer *item3Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemAction3)];
    item3Gesture.numberOfTapsRequired = 1;
    item3Gesture.cancelsTouchesInView = NO;
    [item3 addGestureRecognizer:item3Gesture];
    
    UILabel * t3=[[UILabel alloc]init];
    t3.textColor=[UIColor colorWithHexString:@"#333333"];
    t3.text=NSLocalizedString(@"set_str3", nil);
    UIView *lin3=[[UIView alloc] init];
    lin3.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    UIImageView *left3=[[UIImageView alloc]init];
    left3.image=[UIImage imageNamed:@"icon_yjr"];
    
    [item3 addSubview:t3];
    [item3 addSubview:lin3];
    [item3 addSubview:left3];
    [self.view addSubview:item3];
    
    [item3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item2.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(0, 44));
    }];
    [t3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item3);
        make.left.equalTo(item3).offset(20);
    }];
    [lin3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(item3);
        make.size.mas_equalTo(CGSizeMake(0, 0.5));
        make.right.equalTo(item3);
        make.left.equalTo(item3);
    }];
    [left3  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item3);
        make.right.equalTo(item3).offset(-20);
    }];

    //--------
    SeleView * item4=[[SeleView alloc]initColor:[UIColor whiteColor] PresColor:[UIColor colorWithHexString:@"#e5e5e5"]];
    UITapGestureRecognizer *item4Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemAction4)];
    item4Gesture.numberOfTapsRequired = 1;
    item4Gesture.cancelsTouchesInView = NO;
    [item4 addGestureRecognizer:item4Gesture];
    UILabel * t4=[[UILabel alloc]init];
    t4.textColor=[UIColor colorWithHexString:@"#333333"];
    t4.text=NSLocalizedString(@"set_str4", nil);
    UIView *lin4=[[UIView alloc] init];
    lin4.backgroundColor=[UIColor colorWithHexString:@"#e5e5e5"];
    UIImageView *left4=[[UIImageView alloc]init];
    left4.image=[UIImage imageNamed:@"icon_yjr"];
    
    [item4 addSubview:t4];
    [item4 addSubview:lin4];
    [item4 addSubview:left4];
    [self.view addSubview:item4];
    
    [item4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item3.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(0, 44));
    }];
    [t4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item4);
        make.left.equalTo(item4).offset(20);
    }];
    [lin4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(item4);
        make.size.mas_equalTo(CGSizeMake(0, 0.5));
        make.right.equalTo(item4);
        make.left.equalTo(item4);
    }];
    [left4  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item4);
        make.right.equalTo(item4).offset(-20);
    }];

    UIButton * next2=[[UIButton alloc]init];
    UIImage *normal_img2=[UIColor createImage:@"#0abaf4"];
    UIImage *select_img2=[UIImage imageNamed:@"#1082f4"];
    
    [next2 setBackgroundImage:normal_img2 forState:UIControlStateNormal];
    [next2 setBackgroundImage:select_img2 forState:UIControlStateSelected];
    next2.tintColor=[UIColor whiteColor];
    [next2 setTitle:@"退出登录" forState:UIControlStateNormal];
    next2.layer.cornerRadius=6;
    next2.layer.masksToBounds = YES;
    [self.view addSubview:next2];
    [next2 setHidden:YES];
    
    [next2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.bottom.equalTo(self.view).offset(-48);
        make.size.mas_equalTo(CGSizeMake(0, 45));
    }];
    
    
}


-(void)itemAction{
   
    NSLog(@"点击了");
    
    
}
-(void)itemAction2{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Set the label text.
    hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    // You can also adjust other label properties if needed.
    // hud.label.font = [UIFont italicSystemFontOfSize:16.f];
    
    [self doSomeWork:hud];
    
    
}
-(void)itemAction3{
    
    NSLog(@"点击了");
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Set the label text.
    hud.label.text = @"检查更新....";
    // You can also adjust other label properties if needed.
    // hud.label.font = [UIFont italicSystemFontOfSize:16.f];
    
    [self doSomeWork:hud];
    
}
-(void)itemAction4{
    
    NSLog(@"点击了");
    
    
}

-(void)doSomeWork:(MBProgressHUD *)hub{
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    
    NSMutableDictionary * parm=[[NSMutableDictionary alloc]init];
    
    [parm setValue:@"1" forKey:@"verCode"];
    [parm setValue:@"1" forKey:@"ukey"];
//    [parm setValue:_city forKey:@"location"];
//    [parm setValue:@"男" forKey:@"sex"];
//    [parm setValue:@"1" forKey:@"page"];
    
    [as post:getupdate_url parameters:parm actionBlock:^(NSDictionary *posts, NSError *error) {
        
         [hub hideAnimated:YES];
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
