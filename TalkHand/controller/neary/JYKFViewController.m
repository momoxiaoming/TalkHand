//
//  JYKFViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/6/16.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "JYKFViewController.h"
#import "KFitemCollectionViewCell.h"
#import "AFHttpSessionClient.h"
#import "VIPViewController.h"
#import "NearyinfoViewController.h"

#define girl_tag 97777
#define body_tag 98888

@interface JYKFViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *N_table;
@property (weak, nonatomic) IBOutlet UICollectionView *nv_table;
@property (weak, nonatomic) IBOutlet UIButton *Btn;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property NSMutableArray * grils_data;
@property NSMutableArray * body_data;
- (IBAction)Kf_aciton:(id)sender;

@end

@implementation JYKFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//        self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initView];
    [self initData];
    
    [self reciveData];
    [self showProgress];
    
}
-(void)viewWillAppear:(BOOL)animated{

    [self.navigationController.navigationBar setAlpha:1];
}

-(void)reciveData{
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    NSMutableDictionary * parm=[[NSMutableDictionary alloc]init];
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    
    [parm setObject:[def objectForKey:@"id"] forKey:@"id"];
    [as post:getkf_url parameters:parm actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
        
        int state=[posts[@"state"] intValue];
        NSInteger isapply=[posts[@"isApply"] integerValue];;
        [self.Btn setEnabled:isapply==1?YES:NO];
        [self hideProgress];
        if(state==1){
            NSArray* body=posts[@"boy"];
            NSArray * grl=posts[@"girl"];
            [self.body_data setArray:body];
            [self.grils_data setArray:grl];
            [self.nv_table reloadData];
            [self.N_table reloadData];
        }
        
    }];
    
}
//报名
-(void)BaomData{
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    NSMutableDictionary * parm=[[NSMutableDictionary alloc]init];
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    
    [parm setObject:[def objectForKey:@"id"] forKey:@"id"];
    [as post:getkf_url parameters:parm actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
        
        int state=[posts[@"state"] intValue];
        NSInteger isapply=[posts[@"isApply"] integerValue];;
        [self.Btn setEnabled:isapply==1?NO:YES];
          [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(state==1){
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"恭喜你报名成功,具体结果敬请留意通知!" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"报名失败,请重试!" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }];
    
}




-(void)initData{
    
    self.grils_data=[[NSMutableArray alloc]init];
    self.body_data=[[NSMutableArray alloc]init];
//    self.nanadpter=[[NanAdpter alloc]init];
    
//    self.N_table.delegate=self.nanadpter;
//    self.N_table.dataSource=self.nanadpter;
    self.N_table.dataSource=self;
    self.N_table.delegate=self;
    self.N_table.tag=body_tag;
    
    self.nv_table.delegate=self;
    self.nv_table.dataSource=self;
    self.nv_table.tag=girl_tag;
    [self.nv_table registerClass:[KFitemCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.N_table registerClass:[KFitemCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}



-(void)initView{
    self.title=@"今夜附近开房";
    
    UIImage *normal_img2=[UIColor createImage:@"#2fb9c3"];
    UIImage *select_img2=[UIImage imageNamed:@"#1082f4"];
    [self.Btn setBackgroundImage:normal_img2 forState:UIControlStateNormal];
    [self.Btn setBackgroundImage:select_img2 forState:UIControlStateSelected];
    self.Btn.tintColor=[UIColor whiteColor];
//    [self.Btn setTitle:@"立即支付" forState:UIControlStateNormal];
    self.Btn.layer.cornerRadius=6;
    self.Btn.layer.masksToBounds = YES;
    
      self.textView.backgroundColor=[UIColor colorWithHexString:@"#ebebeb"];
    _textView.text=[NSString stringWithFormat:@"说明:\n每天每个城市报名20人进行今夜开房匹配,报名开始时间8:00,结束时间20:00.\n2.今夜开房属于自愿交友原则,平台不保证用户质量和不保证安全,请用户注意安全.\n3.今夜开房匹配成功系统会自动发送私信给对方,双方进行沟通见面细节."];
    
    

}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger tag=collectionView.tag;
    
    if(tag==body_tag){
        return self.body_data.count;
    }else if(tag==girl_tag){
        return self.grils_data.count;
    }
    return 0;
    
}
//设置每个cell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);   //注意,我们这里的宽度时,我们中间边距的距离只需要算一个即可,这样算出来的才会每个方向的间距都会相同
}

//设置每个cell的边距
-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section
{
    return UIEdgeInsetsMake ( 10 , 10 , 10 , 10 );   //上,左,下,右
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSInteger isvip=[[[NSUserDefaults standardUserDefaults] objectForKey:@"vip"] integerValue];
    isvip=1;
    if(isvip==1){  //vip
        
       
        
        NearyinfoViewController *con=[[NearyinfoViewController alloc]init];
        if(collectionView.tag==body_tag){
            con.owerid=self.body_data[indexPath.row][@"account"];
        }else{
            con.owerid=self.grils_data[indexPath.row][@"account"];

        }
       
        [self goNextController:con];
        
        
        
    }else{
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"会员方可查看,请开通会员!" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"开通会员" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self goNextController:[[VIPViewController alloc]init] ];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //            [self.controller.navigationController pushViewController:[[VIPViewController alloc] init] animated:YES ];
        }]];
        [self presentViewController:alert animated:YES completion:nil];

    
    }
    
    
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    KFitemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if(cell==nil){
        cell=[[KFitemCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    }
        NSInteger tag=collectionView.tag;
    if(tag==body_tag){
         [cell setData:self.body_data[indexPath.row]];
    }else if(tag==girl_tag){
        [cell setData:self.grils_data[indexPath.row]];
    }
    
    
  
    
    
    return cell;
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

- (IBAction)Kf_aciton:(id)sender {
    
  
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
           [self BaomData];
        });
    });
    
}
@end
