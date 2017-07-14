//
//  RegiestViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/5/17.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "RegiestViewController.h"
#import "AdressViewController.h"
#import "SexViewController.h"

@interface RegiestViewController ()
@property UITextField *input;
@property UIButton * doneButton;
@property UILabel *jg_str;
@end

@implementation RegiestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"填写昵称";
    
    [self initView];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
}




-(void)initView{
 
    UILabel * top_str=[[UILabel alloc] init];
    top_str.text=@"该怎么称呼您呢?";
    top_str.textColor=[UIColor colorWithHexString:@"#404040"];
    
    self.input=[[UITextField alloc]init];
    self.input.borderStyle=UITextBorderStyleNone;
    self.input.placeholder=@"请填写昵称"; //文字填充
    self.input.adjustsFontSizeToFitWidth=YES;//UITextField的文字自适应
    self.input.clearsOnBeginEditing=NO;//UITextField的是否出现一件清除按钮
    self.input.returnKeyType=UIReturnKeyDone;   //设置软键盘返回键样式
    self.input.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.input.delegate=self;   //设置UITextFieldDelegate协议
    
    
    UIView * line=[[UIView alloc]init];
    line.backgroundColor=[UIColor colorWithHexString:@"898B8D"];
    
    _jg_str=[[UILabel alloc]init];
    _jg_str.text=@"输入昵称过短,过长或输入非法字符,请重新输入!";
    _jg_str.textColor=[UIColor redColor];
    _jg_str.font=[UIFont systemFontOfSize:13];
    [_jg_str setHidden:YES];
    
    
    UIButton *login_btn=[[UIButton alloc]init];
    UIImage *normal_img2=[UIColor createImage:@"#0abaf4"];
    UIImage *select_img2=[UIImage imageNamed:@"#1082f4"];
    
    [login_btn setBackgroundImage:normal_img2 forState:UIControlStateNormal];
    [login_btn setBackgroundImage:select_img2 forState:UIControlStateSelected];
    login_btn.tintColor=[UIColor whiteColor];
    [login_btn setTitle:@"下一步" forState:UIControlStateNormal];
    login_btn.layer.cornerRadius=6;
    login_btn.layer.masksToBounds = YES;

    [self.view addSubview:top_str];
    [self.view addSubview:self.input];
    [self.view addSubview:line];
    [self.view addSubview:login_btn];
    [self.view addSubview:_jg_str];
    
    
    [top_str mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(27);
        
    }];
    
    [self.input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(top_str.mas_bottom).offset(54);
        make.left.equalTo(self.view).offset(20.5);
        make.right.equalTo(self.view).offset(-20);
        make.size.mas_equalTo(CGSizeMake(0, 40));
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.input.mas_bottom).offset(0);
        make.right.equalTo(self.input);
        make.left.equalTo(self.view).offset(20);
        make.size.mas_equalTo(CGSizeMake(0, 1));
        
    }];

    [_jg_str mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(33);
        make.left.equalTo(line);
        
    }];
    [login_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(173);
        make.left.equalTo(line);
        make.right.equalTo(line);
        make.size.mas_equalTo(CGSizeMake(0, 45));
    }];
    
    
    
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentTableViewTouchInSide)];
    self.view.userInteractionEnabled=YES;
    [self.view addGestureRecognizer:tableViewGesture];
    
    [self.input addTarget:self action:@selector(textchang) forControlEvents:UIControlEventEditingChanged];
    
    [self setListener:login_btn index:1];
}


-(void)textchang{
  
    [self.jg_str setHidden:YES];
}
-(void)setListener:(UIView *) arr index:(NSInteger) index{
    
    arr.tag=index;   //设置传递的参数
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuAction:)];
    //    tableViewGesture.view.tag=index;
     arr.userInteractionEnabled=YES;
    [arr addGestureRecognizer:tableViewGesture];
    
}


-(void)menuAction:(id)sender{
    NSString * instr=self.input.text;
  
    if (instr.length>8&&instr!=nil) {
        //跳转住址
        
        SexViewController * adress=[[SexViewController alloc]init];
        NSMutableDictionary * info=[[NSMutableDictionary alloc]init];
        
        [info setValue:instr forKey:@"name"];
        [adress setUserinfo:info];
        [self goNextController:adress];;
    }else{
       
        [_jg_str setHidden:NO];
    }
    
}



//点击table空白处隐藏键盘
- (void)commentTableViewTouchInSide{
    [self.input resignFirstResponder];
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
