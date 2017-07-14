//
//  UserInfoViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/6/20.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "UserInfoViewController.h"
#import "AFHttpSessionClient.h"
@interface UserInfoViewController ()
@property NSMutableDictionary *infoDir;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"个人信息";
    
 
    
    self.infoDir=[[NSMutableDictionary alloc]init];
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    //右边收藏按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    rightButton.frame = CGRectMake(0, 0, 20, 20);
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(bc_action)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
 
    [self initData];
    
     [self getUserinfo];
    
}



-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.alpha=1;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //读取数据
    NSString *own = [userDefaults objectForKey:@"id"];
    
    NSDictionary * posts=[[FMDConfig sharedInstance]getUserInfoWithId:own];
    if(posts){
        [self updateData:posts];
    }
    
}

-(void)updateData:(NSDictionary *)posts{
    
    
    NSUserDefaults * def=[NSUserDefaults standardUserDefaults];
    NSString *adr=[def objectForKey:@"location"];
    NSString *ac=posts[@"account"]==NULL?@"":[NSString stringWithFormat:@"%@",posts[@"account"]];
    NSString *adress=posts[@"adress"]==NULL?adr:posts[@"address"];
    NSString *name=posts[@"name"]==NULL?@"":posts[@"name"];
    NSString *icon=posts[@"iconUrl"]==NULL?@"":posts[@"iconUrl"];
    NSString *weChat=posts[@"weChat"]==NULL?@"":posts[@"weChat"];
    NSString *phone=posts[@"phone"]==NULL?@"":posts[@"phone"];
    NSString *makeFriend=posts[@"makeFriend"]==NULL?@"****":posts[@"makeFriend"];
    NSString *age=posts[@"age"]==NULL?@"":[NSString stringWithFormat:@"%@",posts[@"age"]];
    [self.tximg sd_setImageWithURL:[NSURL URLWithString:icon] placeholderImage:[UIImage imageNamed:@"icon_mor"]];
    
    [self.infoDir setObject:icon forKey:@"iconUrl"];
    [self.infoDir setObject:adress forKey:@"adress"];
    [self.infoDir setObject:phone forKey:@"phone"];
    [self.infoDir setObject:name forKey:@"name"];
    [self.infoDir setObject:weChat forKey:@"weChat"];
    [self.infoDir setObject:makeFriend forKey:@"makeFriend"];
    [self.infoDir setObject:age forKey:@"age"];
    [self.infoDir setObject:ac forKey:@"id"];
    
    [self.friend_input setText:makeFriend];
    [self.name_input setText:name];
    [self.wx_input setText:weChat];
    [self.acount setText:ac];
    [self.phone_input setText:phone];
    [self.age_input setText:age];
    [self.sz_input setText:adress];

}

-(void)XgUserData{
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
  
//    NSMutableDictionary * msdir=[[NSMutableDictionary alloc]init];
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
   
    NSString *phoe=self.phone_input.text==NULL?@"":self.phone_input.text;
    NSString *age=self.age_input.text==NULL?@"":self.age_input.text;
    NSString *name=self.name_input.text==NULL?@"":self.name_input.text;
    NSString *wx=self.wx_input.text==NULL?@"":self.wx_input.text;
    NSString *fri=self.friend_input.text==NULL?@"":self.friend_input.text;
      NSString *adress=self.sz_input.text==NULL?@"":self.sz_input.text;
 
    [self.infoDir setObject:phoe forKey:@"phone"];
    [self.infoDir setObject:[def objectForKey:@"id"] forKey:@"id"];
    [self.infoDir setObject:name forKey:@"name"];
    [self.infoDir setObject:age forKey:@"age"];
    [self.infoDir setObject:wx forKey:@"weChat"];
    [self.infoDir setObject:fri forKey:@"makeFriend"];
    [self.infoDir setObject:adress forKey:@"address"];
//    [msdir setObject:@"" forKey:@"iconUrl"];
    
    [as post:updateUserInfo_URL parameters:self.infoDir actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSInteger state=[posts[@"state"]integerValue];
        if(state==1){
            
            [[FMDConfig sharedInstance]saveUserInfo:posts];
            
            
            
            
//            NSString *iid=[def objectForKey:@"id"];
//            NSMutableDictionary * info=[[FMDConfig sharedInstance]getDirDataWithidstr:iid];
//            
//            [info setObject:phoe forKey:@"phone"];
//            [info setObject:[def objectForKey:@"id"] forKey:@"id"];
//            [info setObject:name forKey:@"name"];
//            [info setObject:age forKey:@"age"];
//            [info setObject:wx forKey:@"weChat"];
//            [info setObject:fri forKey:@"makeFriend"];
//            [info setObject:adress forKey:@"address"];
//            
//            
//            
//              [[FMDConfig sharedInstance]saveDirData:info idstr:posts[@"account"]];
            
            
            
            [self back];
        }
    }];
}

-(void)upLoadImgFile:(UIImage *)img type:(NSString *)type{
    
    AFHttpSessionClient * af=[AFHttpSessionClient sharedClient ];
    //    NSData *video_data=[NSData dataWithContentsOfURL:url];
    NSMutableDictionary *dir=[[NSMutableDictionary alloc]init];
    [dir setObject:type forKey:@"type"];
    [af UploadImageFile:img parameters:dir path:upvideo_url actionBlock:^(NSDictionary *posts, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if([posts[@"state"] isEqualToString:@"1"]){

//             [self.tximg setImage:img];
            NSArray *url_list=posts[@"url"];
            NSString * video_url=[ url_list valueForKey:@"1"];
 
            
            
            [self.tximg sd_setImageWithURL:[NSURL URLWithString:video_url] placeholderImage:[UIImage imageNamed:@"icon_mor"]];
    
            [_infoDir setObject:video_url forKey:@"iconUrl"];
          

        }
        
    }];
}


-(void)bc_action{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self XgUserData];
}

-(void)initData{
  
    UITapGestureRecognizer * gr=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tx_action)];
    [self.Item1 addGestureRecognizer:gr];
    self.Item1.userInteractionEnabled=YES;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    
    
    


}
-(void)getUserinfo{
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    NSMutableDictionary * parm=[[NSMutableDictionary alloc]init];
    //获取NSUserDefaults对象
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //读取数据
    NSString *own = [userDefaults objectForKey:@"id"];
    
    
    
    [parm setValue:own forKey:@"ownerId"];
    [parm setValue:@"" forKey:@"otherId"];
 
    [as post:getUserinfo_url parameters:parm actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
        NSInteger state=[posts[@"state"] integerValue];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(state==1){
          
            [self updateData:posts];
        }
        
    }];
    
    
    
    
}





-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //info是所选择照片的信息
    
    //    UIImagePickerControllerEditedImage//编辑过的图片
    //    UIImagePickerControllerOriginalImage//原图
    
    //这里我们取出编辑过的图片
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
   
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self upLoadImgFile:resultImage type:@"2"];
    
//    self.tx_img.image=resultImage;
    
    
    //使用模态返回到软件界面
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    
    //这是捕获点击右上角cancel按钮所触发的事件，如果我们需要在点击cancel按钮的时候做一些其他逻辑操作。就需要实现该代理方法，如果不做任何逻辑操作，就可以不实现
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)xcSelctor:(NSInteger) type{
    
    //调用系统相册的类
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    
    
    //设置选取的照片是否可编辑
    pickerController.allowsEditing = YES;
    //设置相册呈现的样式
    pickerController.sourceType =  type;//图片分组列表样式
    //照片的选取样式还有以下两种
    //UIImagePickerControllerSourceTypePhotoLibrary,直接全部呈现系统相册
    //UIImagePickerControllerSourceTypeCamera//调取摄像头
    
    //选择完成图片或者点击取消按钮都是通过代理来操作我们所需要的逻辑过程
    pickerController.delegate =self;
    //使用模态呈现相册
    [self.navigationController presentViewController:pickerController animated:YES completion:^{
        
    }];
    
    
}

-(void)tx_action{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"请选择方式" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * qx=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * pz=[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self xcSelctor:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction * xc=[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self xcSelctor:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    
    [alert addAction:qx];
    [alert addAction:pz];
    [alert addAction:xc];
    [self presentViewController:alert animated:YES completion:nil];

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
