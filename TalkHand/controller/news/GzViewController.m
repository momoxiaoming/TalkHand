//
//  GzViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/6/22.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "GzViewController.h"
#import "GzCell.h"
#import "AFHttpSessionClient.h"
@interface GzViewController ()
@property (weak, nonatomic) IBOutlet UIView *left_view;
@property (weak, nonatomic) IBOutlet UIView *right_view;
@property (weak, nonatomic) IBOutlet UILabel *left_label;
@property (weak, nonatomic) IBOutlet UILabel *right_lable;
@property (weak, nonatomic) IBOutlet UIView *lefht_line;
@property (weak, nonatomic) IBOutlet UIView *right_line;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property NSMutableArray *view_data;



@end

@implementation GzViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"我的关注";
    [self initView];
    
}
-(void)viewWillAppear:(BOOL)animated{

    [self getViewData:@"1"];
}
-(void)viewWillDisappear:(BOOL)animated{
      [MBProgressHUD hideHUDForView:self.view animated:YES];


}
-(void)initView{
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.tableview.separatorInset=UIEdgeInsetsMake(0, 66, 0, 10);//设置分割线缩进
    [self selectView:@"1"];
    
    
    [self setListener:self.right_view index:2];
    [self setListener:self.left_view index:1];
 
    
    self.view_data=[[NSMutableArray alloc]init];
}



-(void)getViewData:(NSString *)type{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHttpSessionClient *af=[AFHttpSessionClient sharedClient];
    NSMutableDictionary *req=[[NSMutableDictionary alloc]init];
    [req setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] forKey:@"id"];
    [req setObject:type forKey:@"type"];
    [af post:getgz_url parameters:req actionBlock:^(NSDictionary *posts, NSError *error) {
        
        NSLog(@"%@",posts);
        
        NSInteger state=[posts[@"state"] integerValue];;
        
        if(state==1){
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view_data setArray:posts[@"data"]];
            [self.tableview reloadData];
            
        }
        
        
        
        
        
        
    }];
    


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
        [self selectView:@"1"];
        [self getViewData:@"1"];
    }else{
        [self selectView:@"2"];
        [self getViewData:@"2"];

    }
    
}





//切换view
-(void)selectView:(NSString *)index{
    if([index isEqualToString:@"1"]){
        [_lefht_line setHidden:NO];
        _left_label.textColor=[UIColor colorWithHexString:@"#2fb9c3"];
        
        [_right_line setHidden:YES];
        _right_lable.textColor=[UIColor colorWithHexString:@"#999999"];
    
    }else{
        [_lefht_line setHidden:YES];
        _left_label.textColor=[UIColor colorWithHexString:@"#999999"];
        
        [_right_line setHidden:NO];
        _right_lable.textColor=[UIColor colorWithHexString:@"#2fb9c3"];
        
    
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 70;
}

//tableview mak
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _view_data.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     GzCell *item=  [GzCell tgcellWithTableView:tableView];
    [item setItemData:_view_data[indexPath.row] type:@"gz"];
    
    return item;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{



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
