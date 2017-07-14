//
//  VideoCollectionView.m
//  QsQ
//
//  Created by 张小明 on 2017/3/30.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "VideoCollectionView.h"
#import "VideoCollectionViewCell.h"
#import "PlayerViewController.h"
@implementation VideoCollectionView


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
    
    [self.collview registerClass:[VideoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
   
    
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
    
//    UIView * uiv=[[UIView alloc]init];

}


-(UIView *)ErrorView{
    UIView * eroview=[[UIView alloc]init];
    eroview.backgroundColor=[UIColor whiteColor];
    UIImageView *bgview=[[UIImageView alloc]init];
    bgview.image=[UIImage imageNamed:@"icon_nopt"];
    
    
    UILabel *title=[[UILabel alloc]init];
    title.text=@"他还没有视频呢";
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
   
    
    return self.vdieodata.count;
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


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if(cell==nil){
        cell=[[VideoCollectionViewCell alloc] init];
    }
    
     NSLog(@"cell-->%@---video---%@",cell,self.vdieodata[indexPath.row]);
    
    if(self.vdieodata.count!=0){
        NSLog(@"2222cell-->%@---video---%@",cell,self.vdieodata[indexPath.row]);
        
       [cell setinfoData:self.vdieodata[indexPath.row]];
    }
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dir=  self.vdieodata[indexPath.row];
    NSString * ur=dir[@"url"];
    
    //    PlayerViewController * player=[[PlayerViewController alloc]init];
    //
    //    player.url=ur;
    //
    //    [self goNextController:player];
    
    
    AVPlayerViewController * pl=[[AVPlayerViewController alloc]init];
    
    pl.player=[AVPlayer playerWithURL:[NSURL URLWithString:ur]];
    
    
    [self goNextController:pl];
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
