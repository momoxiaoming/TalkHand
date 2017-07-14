//
//  AgeViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/5/17.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "AgeViewController.h"

@interface AgeViewController ()
@property UIPickerView *age_picker;

@property (nonatomic,strong) NSMutableArray *array;
@property NSInteger index;
@property NSString* age;
@end

@implementation AgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"年龄";
    [self initview];
    [self initData];
}
-(void) initData{
    self.array=[[NSMutableArray alloc] init];
    for(int i=5 ;i<100;i++)
    {
        [self.array addObject:[NSString stringWithFormat:@"%d",i]];
        
        
    }
    
}
-(void)initview{
    UILabel * topstr=[[UILabel alloc]init];
    topstr.text=@"请问你的年龄是?";
    topstr.textColor=[UIColor blackColor];
    
   self.age_picker=[[UIPickerView alloc]init];
    self.age_picker.delegate=self;
    self.age_picker.dataSource=self;
    
    [self.age_picker selectRow:19 inComponent:0 animated:YES];
    self.index=19;
    
    
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
    [self.view addSubview:self.age_picker];
    [self.view addSubview:login_btn];
    
    [topstr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(26);
        make.left.equalTo(self.view).offset(20);
        
    }];
    
    [self.age_picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topstr).offset(46);
        make.left.equalTo(topstr);
        make.right.equalTo(self.view).offset(-20);
    
        make.size.mas_equalTo(CGSizeMake(0, 210));
        
    }];
    [login_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.age_picker).offset(73);
        make.left.equalTo(topstr);
        make.right.equalTo(topstr);
        
    }];
    

}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.index=row;
    
}
//picker

//一共有多少列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//一列有多少行
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.array count];;
}

//每列每行对应显示的数据是什么
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.array objectAtIndex:row];
}

//item高度
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 40;
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
