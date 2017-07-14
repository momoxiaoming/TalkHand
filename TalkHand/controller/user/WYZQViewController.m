//
//  WYZQViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/4/15.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "WYZQViewController.h"
#import "ADCollectionViewCell.h"
#import "AFHttpSessionClient.h"
#import "JETXViewController.h"
#import "VIPViewController.h"
@interface WYZQViewController ()

@end

@implementation WYZQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我要赚钱";
    self.ardata=[[NSMutableArray alloc]init];
    
    [self createView];
    //防止导航栏遮住控件
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initData];
    
    [self showProgress];
}
-(void)initData{
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    NSMutableDictionary * parm=[[NSMutableDictionary alloc]init];
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    NSString * account=  [de objectForKey:@"id"];
    [parm setObject:account forKey:@"id"];
  
    [as post:wyzq_url parameters:parm actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
        
        int state=[posts[@"state"] intValue];
        [self hideProgress];
        if(state==1){
            [self.ardata setArray:posts[@"data"]];
            _iscank=[posts[@"canClick"]intValue];
            [self.collview reloadData];
        }
       
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{

    [self.navigationController.navigationBar setAlpha:1];
}

-(void)createView{

    UIView * item1=[[UIView alloc] init];
    item1.backgroundColor=[UIColor whiteColor];
    item1.layer.cornerRadius=6;
    
    UILabel * text=[[UILabel alloc] init];
    text.text=@"已赚金额";
     _text2=[[UILabel alloc] init];
    
     NSString * pri_num= [[NSUserDefaults standardUserDefaults] valueForKey:@"wyzq_price"];
    if(pri_num!=NULL){
           _text2.text=[NSString stringWithFormat:@"¥%@",pri_num];
    }else{
           _text2.text=[NSString stringWithFormat:@"¥ %i",0];
    }
 
    
    UIButton * next=[[UIButton alloc]init];
    UIImage *normal_img=[UIColor createImage:@"#2fb9c3"];
    UIImage *select_img=[UIImage imageNamed:@"#1082f4"];
    
    [next setBackgroundImage:normal_img forState:UIControlStateNormal];
    [next setBackgroundImage:select_img forState:UIControlStateSelected];
    next.tintColor=[UIColor whiteColor];
    [next setTitle:@"提现" forState:UIControlStateNormal];
    next.layer.cornerRadius=6;
    next.layer.masksToBounds = YES;
    
    [item1 addSubview:text];
    [item1 addSubview:_text2];
    [item1 addSubview:next];
    
    UIView* item2=[[UIView alloc] init];
    item2.backgroundColor=[UIColor whiteColor];
    item2.layer.cornerRadius=6;
    UILabel * title=[[UILabel alloc] init];
    title.text=NSLocalizedString(@"wyzq_str2", nil);
    title.font=[UIFont systemFontOfSize:14];
    title.textColor=[UIColor blackColor];
    
    UICollectionView* colv=[self createCollView];
    colv.layer.cornerRadius=6;
    
    
    
    
    
    [item2 addSubview:title];
    [item2 addSubview:colv];
    
    
//-----
    UILabel * jssm=[[UILabel alloc] init];
    jssm.text=NSLocalizedString(@"wyzq_str", nil);
    jssm.textColor=[UIColor colorWithHexString:@"#666666"];
    jssm.font=[UIFont systemFontOfSize:13];
    jssm.numberOfLines = 0;//表示label可以多行显示
//--
    UIButton * next2=[[UIButton alloc]init];
    UIImage *normal_img2=[UIColor createImage:@"#0abaf4"];
    UIImage *select_img2=[UIImage imageNamed:@"#1082f4"];
    
    [next2 setBackgroundImage:normal_img2 forState:UIControlStateNormal];
    [next2 setBackgroundImage:select_img2 forState:UIControlStateSelected];
    next2.tintColor=[UIColor whiteColor];
    [next2 setTitle:@"开通会员" forState:UIControlStateNormal];
    next2.layer.cornerRadius=6;
    next2.layer.masksToBounds = YES;
    

    
    
    
    
    [self.view addSubview:item1];
    [self.view addSubview:item2];
    [self.view addSubview:jssm];
    [self.view addSubview:next2];
    
    
    
    
    
    [item1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.size.mas_equalTo(CGSizeMake(0, 60));
    
    }];
    
    [text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item1);
        make.left.equalTo(item1).offset(20);
        
    }];
    [_text2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item1);
        make.left.equalTo(text.mas_right).offset(16);
        
    }];
    [next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item1);
        make.right.equalTo(item1).offset(-20);
        make.size.mas_equalTo(CGSizeMake(86, 33));
    }];

    [item2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item1.mas_bottom).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.left.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.view).offset(-135);
    }];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item2).offset(13);
        make.centerX.equalTo(item2);
    }];
    
    [colv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).offset(13);
        make.right.equalTo(item2);
        make.left.equalTo(item2);
        make.bottom.equalTo(item2);
    }];
    
    [next2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.size.mas_equalTo(CGSizeMake(0, 45));
    }];
    
    [jssm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(next2);
  
        make.left.equalTo(next2);
        make.top.equalTo(item2.mas_bottom).offset(20);
    }];
    
    [self setListener:next index:1];
    [self setListener:next2 index:2];
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
        JETXViewController * je=[[JETXViewController alloc]init];
        je.moeny=@"1";
        
        [self goNextController:je];
    
    }else if(index==2){
        [self goNextController:[[VIPViewController alloc]init]];
    
    }
}


-(UICollectionView*)createCollView{
    UICollectionViewFlowLayout * layout=[[UICollectionViewFlowLayout alloc] init];
   _collview=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
//    [collview setCollectionViewLayout:layout];
    [_collview registerClass:[ADCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

    _collview.delegate=self;  //添加代理
    _collview.dataSource=self;  //添加数据代理
   
    
    _collview.backgroundColor=[UIColor whiteColor];
    
      _collview.showsVerticalScrollIndicator=NO;  //隐藏滚动条
    return _collview;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.ardata.count==0){
        return 16;
    }
    return self.ardata.count;
}
//设置每个cell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(67, 67);   //注意,我们这里的宽度时,我们中间边距的距离只需要算一个即可,这样算出来的才会每个方向的间距都会相同
}

//设置每个cell的边距
-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section
{
    return UIEdgeInsetsMake ( 10 , 10 , 10 , 10 );   //上,左,下,右
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if(_iscank==1){  //点击
        [self showProgress];
        [self clickItemData:[self.ardata[indexPath.row] valueForKey:@"adID"] item:indexPath.row];
        
        
    }
    
    

}
-(void)viewDidAppear:(BOOL)animated{

    [self hideProgress];
}

-(void)clickItemData:(NSString * )adid item:(NSInteger) num{
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    NSMutableDictionary * parm=[[NSMutableDictionary alloc]init];
    NSUserDefaults *de=[NSUserDefaults standardUserDefaults];
    NSString * account=  [de objectForKey:@"id"];
    [parm setObject:account forKey:@"id"];
    [parm setObject:adid forKey:@"adID"];
    [as post:adclick_url parameters:parm actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
        
        int state=[posts[@"state"] intValue];
        [self hideProgress];
        if(state==1){
           
            NSUserDefaults * de=[NSUserDefaults standardUserDefaults];
            [de setObject:posts[@"money"] forKey:@"wyzq_price"];
            [de synchronize];
            self.iscank=[posts[@"canClick"] intValue];
            
            
            _text2.text=[NSString stringWithFormat:@"¥ %@",posts[@"money"]];
            
            NSMutableDictionary *md=[[NSMutableDictionary alloc]init];
            [md setValue:@"1" forKey:@"isClick"];
            [md setValue:self.ardata[num][@"adID"] forKey:@"adID"];
             [md setValue:self.ardata[num][@"iconUrl"] forKey:@"iconUrl"];
              
              
//            NSMutableDictionary *dir=self.ardata[num];
//            [dir setValue:@"1" forKey:@"isClick"];
//            [dir setObject:@"1" forKey:@"isClick"];
        
            [self.ardata setObject:md atIndexedSubscript:num];
            
            [self.collview reloadData];
            
            
            
        }
        
    }];
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ADCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if(cell==nil){
        cell=[[ADCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    }
    
    if(self.ardata.count!=0){
    
    [cell setData:self.ardata[indexPath.row]];
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

@end
