//
//  BaseViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/3/25.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property UIView *mb;
@end

@implementation BaseViewController

-(void)viewDidAppear:(BOOL)animated{

 [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = YES;  //根据页面高度,自动调整view的起始坐标
    
    //防止导航栏遮住控件
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    //同意设置背景颜色
    self.view.backgroundColor=[UIColor colorWithHexString:@"#ebebeb"];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    
    
    
    //网络监测
    
    //网络监控句柄
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    //要监控网络连接状态，必须要先调用单例的startMonitoring方法
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //status:
        //AFNetworkReachabilityStatusUnknown          = -1,  未知
        //AFNetworkReachabilityStatusNotReachable     = 0,   未连接
        //AFNetworkReachabilityStatusReachableViaWWAN = 1,   3G
        //AFNetworkReachabilityStatusReachableViaWiFi = 2,   无线连接
        NSLog(@"网络监测%ld", (long)status);
    }];

}

-(void)goNextController:(UIViewController *)controller{


    [self.navigationController pushViewController:controller animated:YES];


    
}







-(void)back{

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)showProgress{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   
}

-(void)hideProgress{
    [MBProgressHUD hideHUDForView:self.view animated:YES];;
}
-(void)hidenEmoryView{
    [_mb setHidden:YES];
    [self.view willRemoveSubview:_mb];

}

-(void)showEmoryView{
     _mb=[[UIView alloc]init];
    
    UIImageView *img=[[UIImageView alloc]init];
    img.image=[UIImage imageNamed:@"icon_nopt"];
    
    
    UILabel *txt=[[UILabel alloc]init];
    txt.text=@"没有数据,请检查网络连接";
    
    [self.view addSubview:_mb];
    
    [_mb addSubview:img];
    [_mb addSubview:txt];
    

    [_mb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(120, 80));
        
    }];
    
    [txt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(img.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
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
