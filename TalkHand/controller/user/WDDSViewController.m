//
//  WDDSViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/4/15.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "WDDSViewController.h"
#import "WDDS_TableViewCell.h"
#import "WDDS_TX_ViewController.h"
#import "AFHttpSessionClient.h"
@interface WDDSViewController ()<UITableViewDelegate,UITableViewDataSource>
@property UITableView * tabiew;
@property  UILabel * label;
@property NSString * dsprice;
@end

@implementation WDDSViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我要打赏";
    [self createView];
    
    
    //防止导航栏遮住控件
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initData];
    [self getDsData];
    self.dsprice=@"0";
}

-(void)initData{
    self.arry=[[NSMutableArray alloc]init];
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    
    NSMutableDictionary * parm=[[NSMutableDictionary alloc]init];
    NSUserDefaults *def=[[NSUserDefaults alloc]init];
   NSString * acount= [def objectForKey:@"id"];
    
    
    [parm setValue:acount forKey:@"id"];
   
    
    [as post:getds_url parameters:parm actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
        NSInteger state=[posts[@"state"] integerValue];
        
        if(state==1){
            NSArray * arr=posts[@"data"];
            if(arr.count==0){
                [self.tabiew setHidden:YES];
            }else{
            [self.arry setArray:arr];
            
            [self.tabiew reloadData];
            }
            
            
        }
        
        
     
    }];
}

//获取打赏用户金额
-(void)getDsData{
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    NSMutableDictionary * parm=[[NSMutableDictionary alloc]init];
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    NSString * account=  [de objectForKey:@"id"];
    [parm setObject:account forKey:@"id"];
    [parm setObject:@"2" forKey:@"type"];
    [as post:wyds_url parameters:parm actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
        
        int state=[posts[@"state"] intValue];
        if(state==1){
            NSString * mon=posts[@"money"];
            self.label.text=[NSString stringWithFormat:@"打赏金额:¥%@",mon];
            self.dsprice=mon;
        }
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.alpha=1;
    
}
-(void)createView{
    UIView * item1=[[UIView alloc] init];
    item1.backgroundColor=[UIColor whiteColor];
    _label=[[UILabel alloc]init];
    _label.text=@"打赏金额:¥0";
//    UILabel * label2=[[UILabel alloc]init];
//    label2.text=@"100";
    
    UIButton * next=[[UIButton alloc]init];
    UIImage *normal_img=[UIColor createImage:@"#0abaf4"];
    UIImage *select_img=[UIImage imageNamed:@"#1082f4"];
    
    [next setBackgroundImage:normal_img forState:UIControlStateNormal];
    [next setBackgroundImage:select_img forState:UIControlStateSelected];
    next.tintColor=[UIColor whiteColor];
    [next setTitle:@"提现" forState:UIControlStateNormal];
    next.layer.cornerRadius=6;
    next.layer.masksToBounds = YES;
    
    next.userInteractionEnabled=YES;
    UITapGestureRecognizer *click=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topAction)];   //初始化一个点击动作
    [next addGestureRecognizer:click];   //为图片添加点击事件
    
    
    [item1 addSubview:_label];
    [item1 addSubview:next];
    
    _tabiew=[[UITableView alloc] init];
    _tabiew.backgroundColor=[UIColor whiteColor];
    _tabiew.delegate=self;
    _tabiew.dataSource=self;
    
    [self.view addSubview:item1];
    [self.view addSubview:_tabiew];

    
    [item1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(30);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(0, 200));
       }];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item1).offset(73);
        make.centerX.equalTo(item1);
        
    }];
    
    [next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(item1);
        make.bottom.equalTo(item1).offset(-40);
        make.size.mas_equalTo(CGSizeMake(130, 30));
    }];
    
    
    [_tabiew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item1.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
 
}

-(void)topAction{

    WDDS_TX_ViewController * con=[[WDDS_TX_ViewController alloc]init];
    con.dsprcie=self.dsprice;
    
    [self.navigationController pushViewController:con animated:YES];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

      UITableViewCell *cell=[WDDS_TableViewCell tgcellWithTableView:tableView];
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.arry.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return 42;
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
