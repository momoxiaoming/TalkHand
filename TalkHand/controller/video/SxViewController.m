//
//  SxViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/6/13.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "SxViewController.h"
#import "ALSlider.h"
@interface SxViewController ()


@property (weak, nonatomic) IBOutlet UILabel *sex_all;

@property (weak, nonatomic) IBOutlet UILabel *sex_nan;

@property (weak, nonatomic) IBOutlet UILabel *sex_nv;

@property (weak, nonatomic) IBOutlet UILabel *rz_all;
@property (weak, nonatomic) IBOutlet UILabel *rz_yes;
@property (weak, nonatomic) IBOutlet UILabel *rz_no;
@property (weak, nonatomic) IBOutlet UIView *qx_view;
@property (weak, nonatomic) IBOutlet UIView *yes_view;

@property (nonatomic) NSMutableDictionary *dir;
@property (weak, nonatomic) IBOutlet UIView *sdler_view;

@property ALSlider * jdslder;

@end

@implementation SxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dir=[[NSMutableDictionary alloc]init];
    [_dir setObject:0 forKeyedSubscript:@"sex"];
    [_dir setObject:@"" forKeyedSubscript:@"isAttest"];
    [_dir setObject:@""forKeyedSubscript:@"address"];
    [_dir setObject:@"" forKeyedSubscript:@"age"];
    
    [self initView];
 
}

-(void)initView{
//    self.qx_view.layer.cornerRadius=5;
//    self.qx_view.layer.masksToBounds = YES;
//    
//    self.yes_view.layer.cornerRadius=5;
//    self.yes_view.layer.masksToBounds = YES;
    
//    self.sex_nan.layer.c
    
    self.sex_all.layer.cornerRadius=5;
    self.sex_all.layer.masksToBounds = YES;

    self.sex_nv.layer.cornerRadius=5;
    self.sex_nv.layer.masksToBounds = YES;
    
    self.sex_nan.layer.cornerRadius=5;
    self.sex_nan.layer.masksToBounds = YES;
    
    
    self.rz_all.layer.cornerRadius=5;
    self.rz_all.layer.masksToBounds = YES;
    
    self.rz_no.layer.cornerRadius=5;
    self.rz_no.layer.masksToBounds = YES;
    
    self.rz_yes.layer.cornerRadius=5;
    self.rz_yes.layer.masksToBounds = YES;
    
    
    [self setListener:self.yes_view index:1];
    [self setListener:self.qx_view index:2];
    [self setListener:self.sex_nan index:3];
    [self setListener:self.sex_nv index:4];
    [self setListener:self.sex_all index:5];
    [self setListener:self.rz_yes index:6];
    [self setListener:self.rz_no index:7];
    [self setListener:self.rz_all index:8];
    
    

    self.jdslder = [[ALSlider alloc]initWithFrame:CGRectMake(108, 163+60+60-10, 228, 20)];
    [self.jdslder setMinIndex:0 setMaxIndex:40];
    [self.view addSubview:self.jdslder];
//    self.jdslder.backgroundColor=[UIColor redColor];
    
    
    
//
//    self.jdslder.unit = @"￥";
//    self.jdslder.minNum = 14;
//    self.jdslder.maxNum = 59;
//    self.jdslder.minTintColor = [UIColor redColor];
//    self.jdslder.maxTintColor = [UIColor blueColor];
//    self.jdslder.mainTintColor = [UIColor blackColor];
//    
//    [self.sdler_view addSubview:_jdslder];
//    
//    [_jdslder mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.sdler_view);
//        
//        make.size.mas_equalTo(CGSizeMake(228, 20));
//    }];
    
    
    
    
}




-(void)setListener:(UIView *) arr index:(NSInteger) index{
    
    arr.tag=index;   //设置传递的参数
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuAction:)];
    //    tableViewGesture.view.tag=index;
    arr.userInteractionEnabled=YES;
    [arr addGestureRecognizer:tableViewGesture];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"sx_data" object:nil];
}

-(void)menuAction:(id)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    
    UIView *views = (UIView*) tap.view;
    
    NSUInteger index = views.tag;   //获取上面view设置的tag
    
    if(index==1){
    //关闭该窗口,筛选数据到上一个页面
        [_dir setObject:@"111" forKey:@"data"];
        [_dir setObject:[self.jdslder getAgeSection] forKey:@"age"];
        [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sx_data" object:_dir];
        }];
    
    }else if(index==2){

//        [self dismissModalViewControllerAnimated:YES];
[self dismissViewControllerAnimated:YES completion:^{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"sx_data" object:_dir];
}];
    
    
    }else if(index==3){
        self.sex_nan.backgroundColor=[UIColor colorWithHexString:@"#cccccc"];
        self.sex_all.backgroundColor=[UIColor whiteColor];
        self.sex_nv.backgroundColor=[UIColor whiteColor];
        [_dir setObject:@"1" forKey:@"sex"];
        
    }else if(index==4){
        self.sex_nv.backgroundColor=[UIColor colorWithHexString:@"#cccccc"];
        self.sex_all.backgroundColor=[UIColor whiteColor];
        self.sex_nan.backgroundColor=[UIColor whiteColor];
           [_dir setObject:@"2" forKey:@"sex"];
    }else if(index==5){
        self.sex_all.backgroundColor=[UIColor colorWithHexString:@"#cccccc"];
        self.sex_nv.backgroundColor=[UIColor whiteColor];
        self.sex_nan.backgroundColor=[UIColor whiteColor];
           [_dir setObject:@"0" forKey:@"sex"];
    }else if(index==6){
        self.rz_yes.backgroundColor=[UIColor colorWithHexString:@"#cccccc"];
        self.rz_all.backgroundColor=[UIColor whiteColor];
        self.rz_no.backgroundColor=[UIColor whiteColor];
         [_dir setObject:@"1" forKey:@"isAttest"];
        
    }else if(index==7){
        self.rz_no.backgroundColor=[UIColor colorWithHexString:@"#cccccc"];
        self.rz_all.backgroundColor=[UIColor whiteColor];
        self.rz_yes.backgroundColor=[UIColor whiteColor];
         [_dir setObject:@"0" forKey:@"isAttest"];
    }else if(index==8){
        self.rz_all.backgroundColor=[UIColor colorWithHexString:@"#cccccc"];
        self.rz_no.backgroundColor=[UIColor whiteColor];
        self.rz_yes.backgroundColor=[UIColor whiteColor];
        [_dir setObject:@"" forKey:@"isAttest"];
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
