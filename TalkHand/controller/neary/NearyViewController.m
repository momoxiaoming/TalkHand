
#import "NearyViewController.h"
#import "NearyCell.h"
#import "Neary_fj_Cell.h"

#define ID_1 @"nrcell"
#define ID_2 @"fjcell"

#import <MJRefresh/MJRefreshNormalHeader.h>
#import <MJRefresh/MJRefreshComponent.h>
#import <MJRefresh/MJRefreshAutoNormalFooter.h>

#import "RZXXViewController.h"
#import "NearyinfoViewController.h"

#import "AFHttpSessionClient.h"
#import "Toast.h"
#import "JYKFViewController.h"
#import "ChatViewController.h"

@interface NearyViewController ()
@property UITableView *table;
@property int page;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property NSString * city;

@end

@implementation NearyViewController
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.alpha=1;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _page=0;
    
    self.neary_data=[[NSMutableArray alloc]init];
    
    self.table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.table.delegate=self;
    self.table.dataSource=self;
//    self.table.separatorInset=UIEdgeInsetsMake(10, 10, 10, 0);//设置分割线缩进

    self.table.backgroundColor=[UIColor colorWithHexString:@"#ebebeb"];
    [self.view addSubview:self.table];
    
//    [self.table registerNib:[UINib nibWithNibName:@"NearyCell" bundle:nil] forCellReuseIdentifier:ID_1];
//    [self.table registerNib:[UINib nibWithNibName:@"Neary_fj_Cell" bundle:nil] forCellReuseIdentifier:ID_2];
    
//       [self.table registerClass:[Neary_fj_Cell class] forCellReuseIdentifier:ID_2];
    
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码
            // 结束刷新
//            [self.table.mj_header endRefreshing];
         [MBProgressHUD hideHUDForView:self.view animated:YES];
           self.page=1;
            [self initData];
            
            
  
    }];
    
    
    self.table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        
        [self moreData];
        
    }];
   
    // Enter the refresh status immediately
//    [self.table.mj_header beginRefreshing];
    [self.table.mj_footer setHidden:true];
    
    [self alertSexSelector];
   
}


-(void)alertSexSelector{
      NSUserDefaults * def=[NSUserDefaults standardUserDefaults];
    
    NSString * sex=[def objectForKey:@"sex"];
    if(sex==NULL){
    
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"请选择您的性别" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *body=[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
      
        [def setObject:@"1" forKey:@"sex"];
      [def synchronize];
         [self startLocation];
    }];
    UIAlertAction *grils=[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
         [self startLocation];
        [def setObject:@"2" forKey:@"sex"];
             [def synchronize];
    }];

    [alert addAction:body];
    [alert addAction:grils];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    }else{
       [self startLocation];
    }
    
}


//开始定位
- (void)startLocation {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if ([CLLocationManager locationServicesEnabled]) {
        //        CLog(@"--------开始定位");
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        //控制定位精度,越高耗电量越
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        // 总是授权
        [self.locationManager requestAlwaysAuthorization];
        self.locationManager.distanceFilter = 10.0f;
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    NSLog(@"buttonIndex :%d",buttonIndex);
    
    NSLog(@"index--%ld",(long)buttonIndex);
    if(buttonIndex==1){  //设置
    
        UIApplication *app = [UIApplication sharedApplication];
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([app canOpenURL:settingsURL]) {
            [app openURL:settingsURL];
        }
    }else{
         [self.table.mj_header beginRefreshing];
    
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {

//       [[Toast makeText:@"无法获取您的定位信息,请在设置中打开软件定位!"] showWithType:LongTime];
//        [self.table.mj_header beginRefreshing];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无法获取您的定位权限,请在iPhone的“设置->隐私->位置”中允许访问位置信息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消", @"设置", nil];
        [alertView show];
    }
    

    
    if ([error code] == kCLErrorLocationUnknown) {
    [[Toast makeText:@"无法获取地理信息"] showWithType:ShortTime];
//           NSLog(@"无法获取地理信息");
         [self.table.mj_header beginRefreshing];
        
    }
}
//定位代理经纬度回调
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = locations[0];
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            //获取城市
           _city = placemark.locality;
            if (!_city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                _city = placemark.administrativeArea;
//                NSMutableDictionary * user=[[NSMutableDictionary alloc]init];
//                [user setObject:_city forKey:@"adress"];
//                [[FMDConfig sharedInstance]saveDirData:user idstr:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"id"]]];
                   NSLog(@"为直辖市city = %@", _city);
            }else{
                 NSLog(@"已定位到城市city = %@", _city);
            
            }
                [self.table.mj_header beginRefreshing];
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
    
}






-(void)moreData{
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    NSMutableDictionary * parm=[[NSMutableDictionary alloc]init];

    
    [parm setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] forKey:@"id"];
    [parm setValue:_city forKey:@"location"];
    [parm setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"sex"] forKey:@"sex"];
    [parm setValue:[NSString stringWithFormat:@"%d",self.page++] forKey:@"page"];
    
  
    
    [as post:NEARY_Url parameters:parm actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
 
        int state=[posts[@"state"] intValue];
        if(state==1){
            NSArray *rows = posts[@"userData"];
            [self.neary_data addObjectsFromArray:rows];
            [self.table.mj_footer endRefreshing];
            [self.table reloadData];
        }else{
            _page--;
             [self.table.mj_footer endRefreshing];
        }
     
    }];

}

-(void)initData{
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    
    NSMutableDictionary * parm=[[NSMutableDictionary alloc]init];
    NSUserDefaults * def=[NSUserDefaults standardUserDefaults];
    [def setObject:_city forKey:@"location"];
    [def synchronize];
    NSString *sex=[def objectForKey:@"sex"];
    
    
    [parm setValue:@"100" forKey:@"id"];
      [parm setValue:_city forKey:@"location"];
     [parm setValue:sex forKey:@"sex"];
        [parm setValue:@"1" forKey:@"page"];
    
//    NSMutableArray * tb=[[NSMutableArray alloc]init];
//    [tb addObject:@"1"];
//     [tb addObject:@"2"];
//     [tb addObject:@"3"];
//    
//    [tb insertObject:[[NSDictionary alloc]init] atIndex:1];
    
    [as post:getNeryInfo_URL parameters:parm actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
           NSMutableArray * tb=[[NSMutableArray alloc]init];
       NSMutableArray *rows = posts[@"userData"];
        [tb setArray:rows];
         NSMutableArray *insert=posts[@"insertData"];
        for(int i=0;i<insert.count;i++){
            NSDictionary * dir=insert[i];
            //指定位置插入某素组
            NSInteger index=[dir[@"position"] integerValue]-1;
            [tb insertObject:dir atIndex:index];
    
        }

        if(tb.count>0){
        [self.table.mj_footer setHidden:false];
        }
//        [self.neary_data addObject:rows];
        [self.neary_data setArray:tb];
        
       [self.table.mj_header endRefreshing];
        [self.table reloadData];
    }];
}







-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.neary_data.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView cellForRowAtIndexPath:indexPath];
    NSString *acount=[self.neary_data[indexPath.row] valueForKey:@"id"];
    if(acount==NULL){
    
        return 140;
    }
    return 340;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *acount=[self.neary_data[indexPath.row] valueForKey:@"id"];
    if(acount==NULL){
//       Neary_fj_Cell *cell=[Neary_fj_Cell tgcellWithTableView:tableView];
        Neary_fj_Cell *cell = [Neary_fj_Cell tgcellWithTableView:tableView];

        [cell setItemData:_neary_data[indexPath.row]];
        
        return cell;
    }else{
//        _clickIndex=indexPath.row;
        NearyCell *cell = [NearyCell tgcellWithTableView:tableView];
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 3.3;
        //取消cell的选中效果
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if(self.neary_data.count!=0){
            [cell setCellData:_neary_data[indexPath.row]];
        }
//        cell.talk_btn.tag=acount;
//        [cell.talk_btn t];
        cell.talk_btn.tag=indexPath.row;
        [cell.talk_btn addTarget:self action:@selector(talk_action:) forControlEvents:UIControlEventTouchUpInside];
        cell.Gz_btn.tag=indexPath.row;
        [cell.Gz_btn addTarget:self action:@selector(gz_action:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
  
}

-(void)talk_action:(UIButton *)sender{
   NSInteger index= sender.tag;
    NSString *acount=  self.neary_data[index][@"id"];

    ChatViewController *chat=[[ChatViewController alloc]init];

    chat.titleName=self.neary_data[index][@"name"];
    chat.account=acount;

    [self goNextController:chat];
    

}

-(void)gz_action:(UIButton*)sender{
        NSLog(@"关注-->%@",sender);
    NSString *btn_title=sender.titleLabel.text;
    if([btn_title isEqualToString:@"已关注"]){
        return;
    }
    
    NSInteger index= sender.tag;
    NSString *acount= self.neary_data[index][@"id"];
    AFHttpSessionClient * click=[AFHttpSessionClient sharedClient];
    
    NSMutableDictionary * dir=[[NSMutableDictionary alloc]init];
    [dir setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] forKey:@"id"];
    [dir setObject:acount forKey:@"otherID"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [click post:getfollowOther_URL parameters:dir actionBlock:^(NSDictionary *posts, NSError *error) {
        NSInteger state=[posts[@"state"]intValue];
          [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(state==1){
            [sender setTitle:@"已关注" forState:UIControlStateNormal];
            
        }else{
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"关注失败,请重试!" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        
        
    }];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *acount=[self.neary_data[indexPath.row] valueForKey:@"id"];
    if(acount==NULL){
        JYKFViewController * jy=[[JYKFViewController alloc]init];
        [self goNextController:jy];
        
    }else{
    NearyinfoViewController *con=[[NearyinfoViewController alloc]init];
        con.owerid=acount;
    [self goNextController:con];
}

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
