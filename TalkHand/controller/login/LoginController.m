//
//  LoginController.m
//  MSN
//
//  Created by 张小明 on 2017/1/5.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "LoginController.h"

#import "LoginProgressView.h"
#import "Toast.h"
#import "RegiestViewController.h"
#import "BaseNavigationController.h"
#import "MainTabBarController.h"
#import "AFHttpSessionClient.h"
@interface LoginController ()

@property (nonatomic)LoginProgressView* loginprogress;

@property (nonatomic) UIButton * login_btn;

@property (nonatomic) UIButton * regist_btn;

@property (nonatomic) UITextField * name_txt;

@property (nonatomic) UITextField * pwd_txt;
@property int userid;
@end

@implementation LoginController


    


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
  
    
    [self initView];
    
//    self.view.backgroundColor=[UIColor redColor];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//    });
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField ==self.name_txt){  //如果是密码框
        [self.pwd_txt becomeFirstResponder];  //切换到下一个输入框
    }else{
        [textField resignFirstResponder]; //否者隐藏
    }
    return true;
}


-(void)initView{
    
    UIImageView *bgv=[[UIImageView alloc] init];
    bgv.image=[UIImage imageNamed:@"icon_qdym"];
    
    UIView * inputview=[[UIView alloc]init];
    inputview.autoresizesSubviews=YES;
    self.name_txt=[[UITextField alloc] init];
    self.name_txt.borderStyle=UITextBorderStyleNone;
//    self.name_txt.placeholder=@"请输入登陆id";
    self.name_txt.textColor=[UIColor whiteColor];
    self.name_txt.adjustsFontSizeToFitWidth=YES;//UITextField的文字自适应
     self.name_txt.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.name_txt.delegate=self;
    
    
    
    self.name_txt.returnKeyType=UIReturnKeyNext;   //设置软键盘返回键样式
//    self.name_txt.clearButtonMode=UITextFieldViewModeWhileEditing;
    NSString * holderText=@"请输入登陆ID";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                       value:[UIColor colorWithHexString:@"#A7AAAd"]
                       range:NSMakeRange(0, holderText.length)];
    self.name_txt.attributedPlaceholder = placeholder;
    
    self.name_txt.inputAccessoryView = [[UIView alloc] init];
    
    
    UIView *line1=[[UIView alloc]init];
    line1.backgroundColor=[UIColor whiteColor];
    UIView *line2=[[UIView alloc]init];
    line2.backgroundColor=[UIColor whiteColor];
    
    
    self.pwd_txt=[[UITextField alloc] init];
    self.pwd_txt.borderStyle=UITextBorderStyleNone;
    self.pwd_txt.textColor=[UIColor whiteColor];
    self.pwd_txt.returnKeyType=UIReturnKeyDone;   //设置软键盘返回键样式
    self.pwd_txt.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.pwd_txt.delegate=self;
    NSString * holderText2=@"请输入密码";
    NSMutableAttributedString *placeholder2 = [[NSMutableAttributedString alloc]initWithString:holderText2];
    [placeholder2 addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorWithHexString:@"#A7AAAd"]
                        range:NSMakeRange(0, holderText2.length)];
    
    self.pwd_txt.attributedPlaceholder = placeholder2;
     self.pwd_txt.inputAccessoryView = [[UIView alloc] init];
    
    
    [inputview addSubview:self.name_txt];
    [inputview addSubview:line1];
    [inputview addSubview:self.pwd_txt];
    [inputview addSubview:line2];
  
    
    
    self.login_btn=[[UIButton alloc]init];
    UIImage *normal_img2=[UIColor createImage:@"#0abaf4"];
    UIImage *select_img2=[UIImage imageNamed:@"#1082f4"];
    
    [self.login_btn setBackgroundImage:normal_img2 forState:UIControlStateNormal];
    [self.login_btn setBackgroundImage:select_img2 forState:UIControlStateSelected];
    self.login_btn.tintColor=[UIColor whiteColor];
    [self.login_btn setTitle:@"登陆" forState:UIControlStateNormal];
    self.login_btn.layer.cornerRadius=6;
    self.login_btn.layer.masksToBounds = YES;
    
    UILabel * reg=[[UILabel alloc] init];
    reg.text=@"新用户注册";
    reg.textColor=[UIColor whiteColor];
    UILabel * fowd=[[UILabel alloc] init];
    fowd.text=@"忘记密码";
    fowd.textColor=[UIColor whiteColor];
    UILabel * or=[[UILabel alloc] init];
    or.text=@"or";
    or.textColor=[UIColor whiteColor];
    
    UIImageView *qq=[[UIImageView alloc] init];
    qq.image=[UIImage imageNamed:@"icon_QQ"];
    UIImageView *wx=[[UIImageView alloc] init];
    wx.image=[UIImage imageNamed:@"icon_weix"];
    
    UILabel * sm=[[UILabel alloc] init];
    sm.text=@"通过注册即同意";
    sm.textColor=[UIColor whiteColor];
    UILabel * xy=[[UILabel alloc] init];
    xy.text=@"使用协议";
    xy.textColor=[UIColor blueColor];
    
    UIView * botsm=[[UIView alloc]init];
    [botsm addSubview:sm];
    [botsm addSubview:xy];
    

    
    [self.view addSubview:bgv];
    [self.view addSubview:inputview];
   
   
       [self.view addSubview:self.login_btn];
       [self.view addSubview:reg];
       [self.view addSubview:fowd];
       [self.view addSubview:or];
       [self.view addSubview:qq];
       [self.view addSubview:wx];
       [self.view addSubview:botsm];
    
    
    
    [bgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
    }];
    

    
    
    [self.name_txt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputview);
        make.right.equalTo(inputview);
        make.left.equalTo(inputview).offset(0.5);
       
         make.size.mas_equalTo(CGSizeMake(0, 40));
    }];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(inputview);
        make.top.equalTo(self.name_txt.mas_bottom);
        make.right.equalTo(inputview);
        make.size.mas_equalTo(CGSizeMake(0, 0.5));
    }];
    
    [self.pwd_txt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(20);
        make.right.equalTo(inputview);
        make.left.equalTo(inputview).offset(0.5);
        make.size.mas_equalTo(CGSizeMake(0, 40));
    }];
    
    
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(inputview);
        make.top.equalTo(self.pwd_txt.mas_bottom);
        make.right.equalTo(inputview);
        make.size.mas_equalTo(CGSizeMake(0, 0.5));
    }];
 
    [inputview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(190);
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
        make.size.mas_equalTo(CGSizeMake(0, 101));
    }];
    
    
    [self.login_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(40);
        make.right.equalTo(self.view).offset(-40);
        make.left.equalTo(self.view).offset(40);
        make.size.mas_equalTo(CGSizeMake(0, 40));
    }];
    
    [reg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.login_btn.mas_bottom).offset(30);
  
        make.right.equalTo(self.view.mas_centerX).offset(-20);
        
    }];
    [fowd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.login_btn.mas_bottom).offset(30);
        make.left.equalTo(self.view.mas_centerX).offset(20);
        
    }];
    
    [or mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(reg.mas_bottom).offset(42);
        make.centerX.equalTo(self.view);
    }];
    
    [qq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(or.mas_bottom).offset(40);
        make.right.equalTo(self.view.mas_centerX).offset(-20);
        
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [wx mas_makeConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(or.mas_bottom).offset(40);
        make.left.equalTo(self.view.mas_centerX).offset(20);
        
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [sm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(botsm);
        make.left.equalTo(botsm);
        make.bottom.equalTo(botsm);
    }];
    
    [xy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(botsm);
        make.left.equalTo(sm.mas_right);
        make.right.equalTo(botsm);
        make.bottom.equalTo(botsm);
    }];
    
    
    [botsm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-10);
    
    }];
    
    
    //设置点击事件
    [self setListener:self.login_btn index:1];
     [self setListener:reg index:2];
    [self setListener:fowd index:3];
     [self setListener:qq index:4];
     [self setListener:wx index:5];
   [self setListener:xy index:6];
    
    
    
    

    
    //点击空白隐藏键盘
     [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
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
    
    
    
    switch (index) {
        case 1:
            //关闭键盘
            [self.pwd_txt resignFirstResponder];
            [self.name_txt resignFirstResponder];

            [self goNextController:[[MainTabBarController alloc]init]];
            NSLog(@"登陆");
            break;
        case 2:
          
           
            [self goNextController:[[RegiestViewController alloc] init]];
           
            
            NSLog(@"注册");
            break;
        case 3:
            NSLog(@"忘记密码");
            break;
        case 4:
            NSLog(@"qq");
            break;
        case 5:
            NSLog(@"wx");
            break;
        case 6:
            NSLog(@"协议");
            break;
        default:
            break;
    }
}

-(void)moreData{
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    NSMutableDictionary * parm=[[NSMutableDictionary alloc]init];
        [as post:NEARY_Url parameters:parm actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
        
        
    }];
    
}


-(void) initObserver{
  
    // 为了在block代码中安全地使用本类“self”，请在block代码中使用safeSelf
//    __weak LoginController *safeSelf = self;
//
//    
//    self.loginObserver=^(id observerble ,id arg1){
//        NSLog(@"登陆回调-->%@",arg1);
//        [safeSelf.loginprogress showProgressView:NO onParent:safeSelf.view];
//        int code=[(NSNumber *) arg1 intValue];
//        
//        if(code==0){
//           //登陆成功
//            
////            [CurAppDelegate SwitchToMainController];//跳转到主页
//
////            [safeSelf presentViewController:[[ChatController alloc] init] animated:YES completion:nil];
//        
//            [safeSelf performSegueWithIdentifier:@"mainforiden" sender:nil];
//            
////            [safeSelf showViewController:[[MainController alloc] init] sender:nil];
//            
//        }else{
//           //登陆失败
//            
//            [[Toast makeText:@"登陆失败"] showWithType:ShortTime];
//
//        }
//        
//        
//        
//        
//      
//    };
//    self.loginprogress=[[LoginProgressView alloc] init];
//    
//    self.loginprogress.timeoutObserver=^(id observerble ,id arg1){
////        NSLog(@"超时回调");
//        [safeSelf.loginprogress showProgressView:NO onParent:safeSelf.view]; //取消时,取消进度窗
//
//        [safeSelf showAlertWindow:@"提示" messsage:@"登陆超时，可能是网络故障或服务器无法连接，是否重试？" yestitle:@"重试" blockForYes:^(UIAlertAction * _Nonnull action) {
//            [safeSelf dologin];
//        } notitle:@"取消" blockForNo:^(UIAlertAction * _Nonnull action) {
//                    }];
//    };
//    
    
}

//创建系统弹窗
-(void) showAlertWindow:(NSString *) title messsage:(NSString *) msg yestitle:(NSString*) yestitle blockForYes:(void (^)(UIAlertAction * _Nonnull action)) action1 notitle:(NSString *) notitle blockForNo:(void (^)(UIAlertAction * _Nonnull action)) action2{
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:yestitle style:UIAlertActionStyleDefault handler:action1]];
    [alert addAction:[UIAlertAction actionWithTitle:notitle style:UIAlertActionStyleDefault handler:action2]];
    [self presentViewController:alert animated:YES completion:nil];



}
-(void)dologin{

//    [[[IMClientManager sharedInstance] getBaseEventListener] setLoginOkForLaunchObserver:self.loginObserver];   //将回调设置到本类的loginobserver变量
//    
//    [self.loginprogress showProgressView:YES onParent:self.view];  //弹出进度窗
//
//    
//    
//    NSString * name_str=self.accpunt_input.text;
//    NSString * pwd_str=self.pwd_input.text;
//    
//    int code=[[LocalUDPDataSender sharedInstance] sendLogin:name_str withPassword:pwd_str];
//    
//    
//    if (code==COMMON_CODE_OK) {
//        NSLog(@"登陆请求已发出");
//        
//        [[Toast makeText:@"登陆中"] showWithType:ShortTime];
//    }else{
//        [[Toast makeText:@"登陆失败"] showWithType:ShortTime];
//        [self.loginprogress showProgressView:NO onParent:self.view];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   
}

//
//- (IBAction)loginAction:(id)sender {
//    
//    
//    [self dologin];
//}
//- (IBAction)Login_action:(id)sender {
//}
//
//- (IBAction)register_aciton:(id)sender {
//    [self performSegueWithIdentifier:@"login_to_reg" sender:nil];
//    
//}
//
//- (IBAction)xy_action:(id)sender {
//}


@end
