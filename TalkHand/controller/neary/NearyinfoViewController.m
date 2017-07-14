//
//  NearyinfoViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/4/18.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "NearyinfoViewController.h"
#import "HJTabViewControllerPlugin_HeaderScroll.h"
#import "HJTabViewControllerPlugin_TabViewBar.h"
#import "HJDefaultTabViewBar.h"
#import "PotoViewController.h"
#import "VideoCollectionView.h"
#import "NearyTopView.h"
#import "AFHttpSessionClient.h"
#import "PayViewController.h"
#import "PipViewController.h"
#import "ChatViewController.h"
@interface NearyinfoViewController ()<HJTabViewControllerDataSource, HJTabViewControllerDelagate, HJDefaultTabViewBarDelegate>
@property  NearyTopView * head;
@property  VideoCollectionView * videocell;
@property  PotoViewController * potocell;
@property NSDictionary * dirData;
@property UIImageView *img1;
@property UILabel *t1;
@end

@implementation NearyinfoViewController

//-(void)viewDidAppear:(BOOL)animated{
//   self.navigationController.navigationBar.alpha =0;
//
//}
//
//
-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.alpha =1;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //     self.navigationController.navigationBar.hidden=YES;
       self.title=@"资料";
    self.tabDataSource = self;
    self.tabDelegate = self;
    
    HJDefaultTabViewBar *tabViewBar = [HJDefaultTabViewBar new];
    tabViewBar.delegate = self;
    HJTabViewControllerPlugin_TabViewBar *tabViewBarPlugin = [[HJTabViewControllerPlugin_TabViewBar alloc] initWithTabViewBar:tabViewBar delegate:nil];
    [self enablePlugin:tabViewBarPlugin];
    
    [self enablePlugin:[HJTabViewControllerPlugin_HeaderScroll new]];
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initData];
        });
    });
    
   
    
   
    
    //
    //
    
    [self initBottomView];
    
}

-(void)initBottomView{
    UIView *main=[[UIView alloc]init];
    
    main.backgroundColor=[UIColor blackColor];
    
    UIView * item1=[[UIView alloc]init];
    _img1=[[UIImageView alloc]init];
    _img1.image=[UIImage imageNamed:@"icon_gz"];
//    UIImage *normal_img2=[UIImage imageNamed:@"icon_gz"];
//    UIImage *select_img2=[UIImage imageNamed:@"icon_gz_bl"];
    
    
    
   
    
    _t1=[[UILabel alloc]init];
    _t1.text=@"关注";
    UIView *sx1=[[UIView alloc]init];
    
    
    [item1 addSubview:_img1];
    [item1 addSubview:_t1];
    [item1 addSubview:sx1];
    
    [_img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item1);
        make.left.equalTo(item1).offset(20);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        
    }];
    
    [_t1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_img1);
//        make.right.equalTo(item1).offset(-20);
        make.left.equalTo(_img1.mas_right).offset(10);
        
    }];
    
    [sx1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(item1);
        make.centerY.equalTo(_img1);
        make.size.mas_equalTo(CGSizeMake(1, 20));
    }];
    
    
    UIView * item2=[[UIView alloc]init];
    UIImageView *img2=[[UIImageView alloc]init];
    img2.image=[UIImage imageNamed:@"icon_chat"];
    UILabel *t2=[[UILabel alloc]init];
    t2.text=@"聊天";
    UIView *sx2=[[UIView alloc]init];
    
    
    [item2 addSubview:img2];
    [item2 addSubview:t2];
    [item2 addSubview:sx2];
    
    [img2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item2);
        make.left.equalTo(item2).offset(20);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        
    }];
    
    [t2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(img2);
        make.right.equalTo(item2).offset(-20);
        
    }];
    
    [sx2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(item2);
        make.centerY.equalTo(img2);
        make.size.mas_equalTo(CGSizeMake(1, 20));
    }];
    
    
    UIView * item3=[[UIView alloc]init];
    UIImageView *img3=[[UIImageView alloc]init];
    img3.image=[UIImage imageNamed:@"icon_sl"];
    UILabel *t3=[[UILabel alloc]init];
    t3.text=@"打赏";
     UIView *sx3=[[UIView alloc]init];
    [item3 addSubview:img3];
    [item3 addSubview:t3];
    [item3 addSubview:sx3];
    
    [img3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item3);
        make.left.equalTo(item3).offset(20);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        
    }];
    
    [t3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(img3);
        make.right.equalTo(item3).offset(-20);
        
    }];
    
    [sx3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(item3);
        make.centerY.equalTo(img3);
        make.size.mas_equalTo(CGSizeMake(1, 20));
    }];
    
    
    
    UIView * item4=[[UIView alloc]init];
    UIImageView *img4=[[UIImageView alloc]init];
    img4.image=[UIImage imageNamed:@"icon_shp"];
    UILabel *t4=[[UILabel alloc]init];
    t4.text=@"视频";
    UIView *sx4=[[UIView alloc]init];
    [item4 addSubview:img4];
    [item4 addSubview:t4];
//    [item4 addSubview:sx4];
    [img4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item4);
        make.left.equalTo(item4).offset(20);
        make.size.mas_equalTo(CGSizeMake(18, 10));
        
    }];
    
    [t4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(img4);
        make.right.equalTo(item4).offset(-20);
        
    }];
    
//    [sx4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(item4);
//        make.centerY.equalTo(img4);
//        make.size.mas_equalTo(CGSizeMake(1, 20));
//    }];
    
    
    

    [main addSubview:item4];
    [main addSubview:item2];
    [main addSubview:item1];
    [main addSubview:item3];
    
    
    [item1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(main);
        make.top.equalTo(main);
        make.bottom.equalTo(main);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/4, 0));
    }];
    [item2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(item1.mas_right);
        make.top.equalTo(main);
        make.bottom.equalTo(main);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/4, 0));
    }];
    [item3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(item2.mas_right);
        make.top.equalTo(main);
        make.bottom.equalTo(main);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/4, 0));
    }];
    [item4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(item3.mas_right);
        make.top.equalTo(main);
        make.bottom.equalTo(main);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/4, 0));
    }];
    
    
    [self.view addSubview:main];
    
    [main mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.height.mas_equalTo(48);
    }];
    
    _t1.font=[UIFont systemFontOfSize:13];
    _t1.textColor=[UIColor colorWithHexString:@"#999999"];
    
    t2.font=[UIFont systemFontOfSize:13];
    t2.textColor=[UIColor colorWithHexString:@"#999999"];
    
    t3.font=[UIFont systemFontOfSize:13];
    t3.textColor=[UIColor colorWithHexString:@"#999999"];
    
    t4.font=[UIFont systemFontOfSize:13];
    t4.textColor=[UIColor colorWithHexString:@"#999999"];
    
    sx1.backgroundColor=[UIColor colorWithHexString:@"#999999"];
    sx2.backgroundColor=[UIColor colorWithHexString:@"#999999"];
        sx3.backgroundColor=[UIColor colorWithHexString:@"#999999"];
        sx4.backgroundColor=[UIColor colorWithHexString:@"#999999"];
    
    [self setListener:item1 index:1];
      [self setListener:item2 index:2];
      [self setListener:item3 index:3];
      [self setListener:item4 index:4];
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
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self gzUser];
            break;
        case 2:
            [self talk];
            break;
        case 3:
            [self dsPrice];
            break;
        case 4:
            [self doVideo];
            break;
        default:
            break;
    }
    
}
-(void)gzUser{

    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    
    NSMutableDictionary * parm=[[NSMutableDictionary alloc]init];
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    
    [parm setValue:[def valueForKey:@"id"] forKey:@"id"];
    [parm setValue:self.owerid forKey:@"otherId"];
    
    
    [as post:getUserinfo_url parameters:parm actionBlock:^(NSDictionary *posts, NSError *error) {
        
        NSLog(@"%@",posts);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.dirData=posts;
        NSInteger state=[posts[@"state"] integerValue];;
        if(state==1){
            self.img1.image=[UIImage imageNamed:@"icon_gz_bl"];
            self.t1.text=@"已关注";
        }
        
    }];


}
//聊天
-(void)talk{
    ChatViewController *pip1=[[ChatViewController alloc]init];
//    pip1.navigationController.navigationBar.alpha=1;
//    pip1.navigationController.navigationBar.backgroundColor=[UIColor blackColor];
    if(self.dirData!=NULL){
          NSString * ac=[self.dirData valueForKey:@"account"];
          NSString * name=[self.dirData valueForKey:@"name"];
        if(ac!=NULL){
//            pip1.account=ac;
            pip1.account=ac;
            pip1.titleName=name;
            [self.navigationController pushViewController:pip1 animated:YES];
        }
    }

}

//视频连接
-(void)doVideo{
    PipViewController *pip2=[[PipViewController alloc]init];
//    self.navigationController.navigationBar.alpha=0;

    if(self.dirData!=NULL){
        NSString * ac=[self.dirData valueForKey:@"account"];
        if(ac!=NULL){
        pip2.acount=ac;
        [self.navigationController pushViewController:pip2 animated:YES];
        }
    }

}
//打赏
-(void) dsPrice{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"是否打赏金额:9.99元" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * qx=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * qd=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        PayViewController * pay=[[PayViewController alloc]init];
//         self.navigationController.navigationBar.alpha=1;
        pay.price=@"9.99";
        [self.navigationController pushViewController:pay animated:YES];
    }];
   
    [alert addAction:qx];
    [alert addAction:qd];
    
    [self presentViewController:alert animated:YES completion:nil];;
}

-(void)initData{
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    
    NSMutableDictionary * parm=[[NSMutableDictionary alloc]init];
    
    [parm setValue:@"" forKey:@"ownerId"];
    [parm setValue:self.owerid forKey:@"otherId"];

    
    [as post:getUserinfo_url parameters:parm actionBlock:^(NSDictionary *posts, NSError *error) {
     
        NSLog(@"%@",posts);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.dirData=posts;
        NSInteger state=[posts[@"state"] integerValue];;
        if(state==1){
            
            //保存该用户的信息
           [[FMDConfig sharedInstance] saveUserInfo:posts];
           
         }
        if(error==NULL||state!=1){
            posts=[[FMDConfig sharedInstance]getUserInfoWithId:self.owerid];

        }
        
        
        if(posts!=NULL){
            [self.head setViewData:posts];
        }
        NSMutableArray * d=posts[@"video"];
        
        if(d!=nil&&d.count!=0){
            [_videocell setVideo:d];
        }
        
        NSMutableArray * d2=posts[@"alumn"];
        if(d2!=nil&&d2.count!=0){
            [_potocell setVideo:d2];
        }
        
        if([posts[@"isAten"] integerValue]==1){
            
            self.t1.text=@"已关注";
            self.img1.image=[UIImage imageNamed:@"icon_gz_bl"];
        }
        
    }];
}

-(void)annim:(UIView *) mview{
    //创建一个CGAffineTransform  transform对象
    
    CGAffineTransform  transform;
    
    //设置旋转度数
    
    transform = CGAffineTransformRotate(mview.transform,M_PI/6.0);
    
    //动画开始
    
    [UIView beginAnimations:@"rotate" context:nil ];
    
    //动画时常
    
    [UIView setAnimationDuration:0.5];
    
    //添加代理
    
    [UIView setAnimationDelegate:self];
    
    //获取transform的值
    
    [mview setTransform:transform];
    
    //关闭动画
    
    [UIView commitAnimations];
    
    
}
-(void)Closeannim:(UIView *) mview{
    //创建一个CGAffineTransform  transform对象
    
    CGAffineTransform  transform;
    
    //设置旋转度数
    
    transform = CGAffineTransformRotate(mview.transform,-M_PI/6.0);
    
    //动画开始
    
    [UIView beginAnimations:@"rotate" context:nil ];
    
    //动画时常
    
    [UIView setAnimationDuration:0.5];
    
    //添加代理
    
    [UIView setAnimationDelegate:self];
    
    //获取transform的值
    
    [mview setTransform:transform];
    
    //关闭动画
    
    [UIView commitAnimations];
    
    
}


//点击table空白处隐藏键盘
- (void)commentTableViewTouchInSide{
    if (self.sideMenu.isOpen){
        [self Closeannim:self.baseView];
        [self.sideMenu CloseMenu];
    }else{
        [self annim:self.baseView];
        [self.sideMenu OpenMenu];
    }
}
#pragma mark -

- (NSInteger)numberOfTabForTabViewBar:(HJDefaultTabViewBar *)tabViewBar {
    return [self numberOfViewControllerForTabViewController:self];
}

- (id)tabViewBar:(HJDefaultTabViewBar *)tabViewBar titleForIndex:(NSInteger)index {
    NSString * tab_name=@"";
    if (index == 0) {
        tab_name=NSLocalizedString(@"user_tab_item1_str", nil);
    }else if(index==1){
        tab_name=NSLocalizedString(@"user_tab_item2_str", @"tab2");
    }
    return tab_name;
    //    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"网易云 5"];
    //    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(3, 2)];
    //    return attString;
}

- (void)tabViewBar:(HJDefaultTabViewBar *)tabViewBar didSelectIndex:(NSInteger)index {
    [self scrollToIndex:index animated:YES];
}

#pragma mark -

- (void)tabViewController:(HJTabViewController *)tabViewController scrollViewVerticalScroll:(CGFloat)contentPercentY {
    NSLog(@"contentPercentY-->%f",contentPercentY);
//    self.navigationController.navigationBar.alpha = contentPercentY;
}

- (NSInteger)numberOfViewControllerForTabViewController:(HJTabViewController *)tabViewController {
    return 2;
}

- (UIViewController *)tabViewController:(HJTabViewController *)tabViewController viewControllerForIndex:(NSInteger)index {
    //    TableViewController *vc = [TableViewController new];
    //    vc.index = index;
    //    BaseViewController * vc=nil;
    NSLog(@"分页--%lu",index);
    
    if(index==1){
     _videocell=[[VideoCollectionView alloc]init];
       
        return _videocell;
    }else if(index==0){
        _potocell=[[PotoViewController alloc]init];
//        NSMutableArray * d=[self.infodata valueForKey:@"video"];;
//        [_videocell setVdieodata:d];
        return _potocell;
    }
    return nil;
}

- (UIView *)tabHeaderViewForTabViewController:(HJTabViewController *)tabViewController {
    //    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 300)];
    //    headerView.image = [UIImage imageNamed:@"1"];
    //    headerView.contentMode = UIViewContentModeScaleAspectFill;
    //    headerView.userInteractionEnabled = YES;
    
     _head=[[NearyTopView alloc] init];
    //    head.image=[UIImage imageNamed:@"1"];
//    [_head setViewData:self.infodata];s
    [_head setController:self];
    return _head;
}

- (CGFloat)tabHeaderBottomInsetForTabViewController:(HJTabViewController *)tabViewController {
    return HJTabViewBarDefaultHeight + CGRectGetMaxY(self.navigationController.navigationBar.frame);
}

- (UIEdgeInsets)containerInsetsForTabViewController:(HJTabViewController *)tabViewController {
    return UIEdgeInsetsMake(0, 0, 0, 0);
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
