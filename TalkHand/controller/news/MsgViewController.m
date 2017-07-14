//
//  MsgViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/3/24.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "MsgViewController.h"
#import "MsgTableViewCell.h"
#import <MJRefresh/MJRefreshNormalHeader.h>
#import <MJRefresh/MJRefreshComponent.h>
#import "ChatViewController.h"
#import "GzViewController.h"
#import "ZJFKViewController.h"
#import "FMDConfig.h"

@interface MsgViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic) UITableView *tableview;
@end

@implementation MsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    [self initView];
    self.msgData=[[NSMutableArray alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifAction:) name:@"msg" object:nil];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
//    [self refishData];


}


-(void)notifAction:(id)sender{   //接收到了消息通知,更新数据
    NSLog(@"收到通知-->%@",sender);
    
    [self refishData];
    
    
    
    
//    [self.onlineBtn setTitle:@"校长" forState:UIControlStateNormal];
//    
//    self.label.text=@"哈哈哈哈";

    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"name" object:nil] ;  //移除通知
    
}
-(void) initView{
    self.tableview=[[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;

    self.tableview.separatorInset=UIEdgeInsetsMake(0, 66, 0, 10);//设置分割线缩进


    [self.tableview setTableHeaderView:[self CreateHeader]];
    
    [self.view addSubview:self.tableview];
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self refishData];
            // 结束刷新
            [self.tableview.mj_header endRefreshing];
     
    }];

    
    // Enter the refresh status immediately
    [self.tableview.mj_header beginRefreshing];
}

//刷新聊天列表数据
-(void)refishData{
    NSLog(@"执行了refishData");
    FMDConfig * fmd=[FMDConfig sharedInstance];
    
    NSMutableArray<MsgListEntity*> *arr=[fmd getAllConversation];
    if(arr!=NULL&&arr.count!=0){
        [self.msgData setArray:arr];
        [self.tableview reloadData];
    }
    
    NSInteger badgeNum=0;
    
    
    for (int i=0; i<arr.count; i++) {
      MsgListEntity* entiy=  arr[i];
        badgeNum+= [entiy.readnum integerValue];;
        
    }
    NSLog(@"消息未读数-->%lu",badgeNum);
    if(badgeNum!=0){
         self.navigationController.tabBarItem.badgeValue=[NSString stringWithFormat:@"%lu",badgeNum];
    }else{
        self.navigationController.tabBarItem.badgeValue=nil;
    }
    
    
  

}

//创建headerview
-(UIView *)CreateHeader{
    UIView * item0=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    UIImageView * item0_img=[[UIImageView alloc] init];
    item0_img.image=[UIImage imageNamed:@"icon_zj"];
    UILabel * item0_label=[[UILabel alloc]init];
    item0_label.text=@"最近访客";
    [item0 addSubview:item0_img];
    [item0 addSubview:item0_label];
    [item0_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.equalTo(item0.mas_left).offset(11);
    }];
    
    [item0_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(item0_img.mas_right).offset(10);
        make.centerY.equalTo(item0_img);
        
    }];
    
    UIView * item1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    UIImageView * item1_img=[[UIImageView alloc] init];
    item1_img.image=[UIImage imageNamed:@"icon_guz"];
    UILabel * item1_label=[[UILabel alloc]init];
    item1_label.text=@"关注";
    
    [item1 addSubview:item1_img];
    [item1 addSubview:item1_label];
    [item1_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item1);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.equalTo(item1.mas_left).offset(11);
    }];
    
    [item1_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(item1_img.mas_right).offset(10);
        make.centerY.equalTo(item1_img);
        
    }];
    
    UIView * head=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 142)];
//    head.backgroundColor=[UIColor redColor]
    UIView *lin0=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    UIView *lin1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];

    lin0.backgroundColor=[UIColor colorWithHexString:@"#dcdcdc"];
    lin1.backgroundColor=[UIColor colorWithHexString:@"#dcdcdc"];
    
    [head addSubview:item0];
    [head addSubview:item1];
    [head addSubview:lin0];
    [head addSubview:lin1];
    
    [item0 mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.top.equalTo(head);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 70));
    }];
    
    [lin0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(head).offset(66);
        make.right.equalTo(head).offset(-10);
        make.top.equalTo(item0.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    
    
    [item1 mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.bottom.equalTo(head).offset(-1);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 70));
    }];

    [lin1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(head);
        make.left.equalTo(head).offset(66);
        make.right.equalTo(head).offset(-10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    
    [self setListener:item0 index:1];
    [self setListener:item1 index:2];
    
    return head;
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
       //最近访问可
        
        ZJFKViewController *fk=[[ZJFKViewController alloc]init];
        [self goNextController:fk];
        
        
    }else{
    //关注
        GzViewController *gz=[[GzViewController alloc]init];
        [self goNextController:gz];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 70;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return self.msgData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

     MsgTableViewCell *cell=  [MsgTableViewCell tgcellWithTableView:tableView];
    
    [cell setItemData:self.msgData[indexPath.row]];
    
    
    
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatViewController *con=[[ChatViewController alloc]init];
    MsgListEntity *entity=self.msgData[indexPath.row];
    NSString *sendId=[entity valueForKey:@"otherid"];
    
    
//    NSDictionary *userInfo= [[FMDConfig sharedInstance] getUserInfoWithId:sendId];
    con.account=sendId;
    con.titleName=@"";
    [self goNextController:con];
    
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
