//
//  AdressViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/5/17.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "AdressViewController.h"
#import "SexViewController.h"
@interface AdressViewController ()

@property  UIPickerView *adress_Picker;
@property (nonatomic,strong) NSMutableArray * sf_array;

@property (nonatomic,strong) NSMutableArray * cs_array;

@property (nonatomic,strong) NSMutableArray * data;

@property NSInteger index1;

@property NSInteger index2;

@property (nonatomic,copy) NSString * sf;
@property (nonatomic,copy) NSString * cs;
@end

@implementation AdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"地址";
    [self initData];
    [self initview];
    
}
-(void)initData{
    
    //获取资源文件,相对于工作目录,放在assest下的也算
    NSString *path = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"json"];
    NSLog(@"%@",path);
    NSString *jsonStr = [NSString stringWithContentsOfFile:path usedEncoding:nil error:nil];
    
    NSData* xmlData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    
    self.data=[NSJSONSerialization JSONObjectWithData:xmlData options:NSJSONReadingAllowFragments error:nil];  //将结果转为地点数据
    self.index1=0;
    self.index2=0;
    self.sf_array=[[NSMutableArray alloc] init];
    self.cs_array=[self getArray:0];
    for(NSDictionary * d in self.data){
        
        NSString * name= [[d allKeys] firstObject];
        [self.sf_array addObject:name];
    }
    
    
    NSLog(@"333");
    
    
    
}
//传入对应的row,取得城市列表
-(NSMutableArray *)getArray:(NSInteger) row{
    
    NSMutableArray * csarray=[[NSMutableArray alloc] init];
    NSDictionary * dict=[self.data objectAtIndex:row] ;
    
    NSArray * array= [[dict allValues] objectAtIndex:0];
    
    if(row==0||row==1){  //这里主要是为了解析北京和天津两个直辖市,因为他们的数据结构不同
        NSDictionary * dc=[array objectAtIndex:0];
        NSArray * ay= [[dc allValues] firstObject];
        for(NSString * d in ay){
            
            [csarray addObject:d];
            
        }
        return csarray;
    }else{
        
        for(NSDictionary * d in array){
            NSString * str= [[d allKeys] firstObject];
            [csarray addObject:str];
            
        }
    }
    
    return csarray;
}

-(void)initview{
    UILabel * topstr=[[UILabel alloc]init];
    topstr.text=@"请问你的年龄是?";
    topstr.textColor=[UIColor blackColor];
    
    self.adress_Picker=[[UIPickerView alloc]init];
   
    self.adress_Picker.delegate=self;
    self.adress_Picker.dataSource=self;
    //让pickerview滚动到指定的某一行
    [self.adress_Picker selectRow:0 inComponent:1 animated:YES];
    //    [self.adress_Picker selectRow:10 inComponent:0 animated:YES];
    //边框线的高度
    [self.adress_Picker.subviews objectAtIndex:1].layer.borderWidth = 0.5f;
    [self.adress_Picker.subviews objectAtIndex:2].layer.borderWidth = 0.5f;
    
    //
    //边框线的颜色
    [self.adress_Picker.subviews objectAtIndex:1].layer.borderColor = [UIColor colorWithRed:186/255.0f green:186/255.0f blue:186/255.0f alpha:1.0f].CGColor;
    [self.adress_Picker.subviews objectAtIndex:2].layer.borderColor = [UIColor colorWithRed:186/255.0f green:186/255.0f blue:186/255.0f alpha:1.0f].CGColor;
    
    
    
    
    
    
    UIButton *login_btn=[[UIButton alloc]init];
    UIImage *normal_img2=[UIColor createImage:@"#0abaf4"];
    UIImage *select_img2=[UIImage imageNamed:@"#1082f4"];
    
    [login_btn setBackgroundImage:normal_img2 forState:UIControlStateNormal];
    [login_btn setBackgroundImage:select_img2 forState:UIControlStateSelected];
    login_btn.tintColor=[UIColor whiteColor];
    [login_btn setTitle:@"下一步" forState:UIControlStateNormal];
    login_btn.layer.cornerRadius=6;
    login_btn.layer.masksToBounds = YES;
    
    [self.view addSubview:topstr];
    [self.view addSubview:self.adress_Picker];
    [self.view addSubview:login_btn];
    
    [topstr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(26);
        make.left.equalTo(self.view).offset(20);
        
    }];
    
    [self.adress_Picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topstr).offset(46);
        make.left.equalTo(topstr);
        make.right.equalTo(self.view).offset(-20);
        
        make.size.mas_equalTo(CGSizeMake(0, 210));
        
    }];
    [login_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.adress_Picker.mas_bottom).offset(73);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.size.mas_equalTo(CGSizeMake(0, 45));
    }];
    [login_btn addTarget:self action:@selector(nextaction) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)nextaction{

   [ self goNextController:[[SexViewController alloc ]init]];
}


//picker

//一共有多少列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

//一列有多少行
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component==0){
        return [self.sf_array count];
        
    }else{
        return [self.cs_array count];
    }
}
//每列每行对应显示的数据是什么
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    //      //1.获取当前的列
    //       NSArray *arayM= self.foods[component];
    //        //2.获取当前列对应的行的数据
    //       NSString *name=arayM[row];
    if(component==0){
        NSString * com1=[self.sf_array objectAtIndex:row];
        return com1;
    }else{
        
        
        NSString * com2=[self.cs_array objectAtIndex:row];
        
        
        return com2;
    }
    
    
    
}

//宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return 150;
    
}
//item高度
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 40;
}

//-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//
//
//
//
//}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    if(component==0){
        self.index1=row;
        [self.cs_array removeAllObjects];
        self.cs_array=[self getArray:self.index1];
        //重点！更新第二个轮子的数据
        [self.adress_Picker reloadComponent:1];
    }else{
        self.index2=row;
    }
    
    //    NSLog(@"allen-选中row%d--com-%d",row,component);
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
