//
//  PotoViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/5/17.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "PotoViewController.h"
#import "PotoCollectionViewCell.h"
#import "MSSBrowseDefine.h"
#import "PicterViewController.h"
#import "VIPViewController.h"
@interface PotoViewController ()

@end

@implementation PotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor greenColor];
    self.vdieodata=[[NSMutableArray alloc]init];
    [self initView];
}

-(void)setVideo:(NSMutableArray *)arr{
    [self.vdieodata addObjectsFromArray:arr];
    [self.collview reloadData];
    if(_vdieodata.count==0){
        [self.eroview setHidden:NO];
        
    }else{
        [self.eroview setHidden:YES];
    }
    
    
    
}

-(void)initView{
    self.eroview=[self ErrorView];
    UICollectionViewFlowLayout * layout=[[UICollectionViewFlowLayout alloc] init];
    
    //高度减了64是出去了nabutom和状态栏的高度,否者会出现最后一行显示不全
    self.collview=[[UICollectionView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    
    [self.collview registerClass:[PotoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    self.collview.delegate=self;  //添加代理
    self.collview.dataSource=self;  //添加数据代理
    //注意这个颜色值是必须除以255.0f的,而且分子也要带0.f,因为是float类型
    
    self.collview.backgroundColor=[UIColor whiteColor];
    
    self.collview.showsVerticalScrollIndicator=NO;  //隐藏滚动条
    [self.view addSubview:self.collview];
    [self.view addSubview:self.eroview];
    
    
    [self.eroview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(0, 220));
        
    }];
}
-(UIView *)ErrorView{
    UIView * eroview=[[UIView alloc]init];
    eroview.backgroundColor=[UIColor whiteColor];
    UIImageView *bgview=[[UIImageView alloc]init];
    bgview.image=[UIImage imageNamed:@"icon_nopt"];
    
    
    UILabel *title=[[UILabel alloc]init];
    title.text=@"他还没有照片呢";
    title.textColor=[UIColor colorWithHexString:@"#999999"];
    title.font=[UIFont systemFontOfSize:13];
    
    
    
    
    [eroview addSubview:bgview];
    
    [eroview addSubview:title];
    
    
    
    
    
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(bgview.mas_bottom).offset(20);
        make.centerX.equalTo(eroview);
        make.bottom.equalTo(eroview).offset(-40);
        
    }];
    
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(eroview);
        make.bottom.equalTo(title.mas_top).offset(-20);
        make.size.mas_equalTo(CGSizeMake(150, 90));
    }];
    
    
    return eroview;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _vdieodata.count;
}
//设置每个cell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-30)/2, (SCREEN_WIDTH-30)/2);   //注意,我们这里的宽度时,我们中间边距的距离只需要算一个即可,这样算出来的才会每个方向的间距都会相同
}

//设置每个cell的边距
-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section
{
    return UIEdgeInsetsMake ( 10 , 10 , 10 , 10 );   //上,左,下,右
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSInteger isvip=1;
    
   NSDictionary *post= [[FMDConfig sharedInstance]getUserInfoWithId:[[NSUserDefaults standardUserDefaults] objectForKey:@"id"]];
    
    NSInteger isvip=[post[@"isVip"] integerValue];;
    if(isvip==1){
        // 加载网络图片
        NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
        //        int i=0;
        
        for(int i=0;i<[self.vdieodata count];i++){

            UIImageView *imageView = [self.view viewWithTag:i+100];
            MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
            browseItem.bigImageUrl =self.vdieodata[i][@"url"] ;// 加载网络图片大图地址
            browseItem.smallImageView = imageView;// 小图
            [browseItemArray addObject:browseItem];
        }
        
        MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:indexPath.row];
        //    bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
        [bvc showBrowseViewController];
        
        
    }else{
        
        
        NSInteger isvis=[self.vdieodata[indexPath.row][@"isVisible"] integerValue];
        if(isvis==1){
            // 加载网络图片
            NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
            UIImageView *imageView = [self.view viewWithTag:100];
            MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
            browseItem.bigImageUrl =self.vdieodata[indexPath.row][@"url"] ;// 加载网络图片大图地址
            browseItem.smallImageView = imageView;// 小图
            [browseItemArray addObject:browseItem];
            MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:indexPath.row];
            //    bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
            [bvc showBrowseViewController];
        }else{
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"开通会员即可查看所有图片,是否开通会员?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *qx=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *qd=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                VIPViewController *vip=[[VIPViewController alloc]init];
                [self goNextController:vip];
            }];
            
            [alert addAction:qx];
            [alert addAction:qd];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if(cell==nil){
        cell=[[PotoCollectionViewCell alloc] init];
    }
    if(self.vdieodata.count!=0){
        [cell setInfoData:self.vdieodata[indexPath.row]];
    }
    
    
    
    
    return cell;
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
