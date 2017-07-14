//
//  ZJFKViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/6/22.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "ZJFKViewController.h"
#import "AFHttpSessionClient.h"
#import "GzCell.h"
@interface ZJFKViewController ()
@property UITableView *tableview;

@property NSMutableArray *view_data;

@end

@implementation ZJFKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"最近访客";
    self.tableview=[[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    
    self.tableview.separatorInset=UIEdgeInsetsMake(0, 66, 0, 10);//设置分割线缩进
    
    
    
}



-(void)viewWillAppear:(BOOL)animated{
 [self getViewData:@""];
}


-(void)viewWillDisappear:(BOOL)animated{
   [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)getViewData:(NSString *)type{
 
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHttpSessionClient *af=[AFHttpSessionClient sharedClient];
    NSMutableDictionary *req=[[NSMutableDictionary alloc]init];
    [req setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] forKey:@"id"];
//    [req setObject:type forKey:@"type"];
    [af post:getfw_url parameters:req actionBlock:^(NSDictionary *posts, NSError *error) {
        
        NSLog(@"%@",posts);
        
        NSInteger state=[posts[@"state"] integerValue];;
        
        if(state==1){
            
           
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.view_data=posts[@"data"];
            if(self.view_data.count==0){
              [self showEmoryView];
            }else{
              [self hidenEmoryView];
            }
            
            [self.tableview reloadData];
            
        }else{
            [self showEmoryView];
        
        }
     
    }];
    
    
    
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
    [item setItemData:_view_data[indexPath.row] type:@"fk"];
    
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
