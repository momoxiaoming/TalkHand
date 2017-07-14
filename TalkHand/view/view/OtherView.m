
//
//  OtherView.m
//  QsQ
//
//  Created by 张小明 on 2017/6/26.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "OtherView.h"
#import "OtherViewCell.h"
@implementation OtherView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{

    self=[super initWithFrame:frame];
    if(self){
      
        [self createView];
    
    }
    return self;
}

-(void)createView{
    [self initData];
    [self createCollView];
    
    
    
    

}

-(void)initData{
    self.itemData=[[NSMutableArray alloc]init];
    
    NSMutableDictionary *item1=[[NSMutableDictionary alloc]init];
    [item1 setObject:@"icon_zp" forKey:@"url"];
    [item1 setObject:@"照片" forKey:@"name"];
    [self.itemData addObject:item1];
    

    NSMutableDictionary *item2=[[NSMutableDictionary alloc]init];
    [item2 setObject:@"icon_ps" forKey:@"url"];
    [item2 setObject:@"拍照" forKey:@"name"];
    [self.itemData addObject:item2];
    
    NSMutableDictionary *item3=[[NSMutableDictionary alloc]init];
    [item3 setObject:@"icon_add" forKey:@"url"];
    [item3 setObject:@"位置" forKey:@"name"];
    [self.itemData addObject:item3];
    
    
    NSMutableDictionary *item4=[[NSMutableDictionary alloc]init];
    [item4 setObject:@"icon_stop" forKey:@"url"];
    [item4 setObject:@"小视频" forKey:@"name"];
    [self.itemData addObject:item4];
}


-(void)createCollView{
    UICollectionViewFlowLayout * layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setMinimumInteritemSpacing:0];
    [layout setMinimumLineSpacing:0];
    _collView=[[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    //    [collview setCollectionViewLayout:layout];
    [_collView registerClass:[OtherViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    _collView.delegate=self;  //添加代理
    _collView.dataSource=self;  //添加数据代理
    
    
    _collView.backgroundColor=[UIColor whiteColor];
    
    [self addSubview:self.collView];
  
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
   
    return 1;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemData.count;
}


//设置每个cell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/4, SCREEN_WIDTH/4);   //注意,我们这里的宽度时,我们中间边距的距离只需要算一个即可,这样算出来的才会每个方向的间距都会相同
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    OtherViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if(cell==nil){
        cell=[[OtherViewCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/4, SCREEN_WIDTH/4)];
    }
//    cell.backgroundColor=[UIColor redColor];
    [cell setItemData:self.itemData[indexPath.row]];
    
    return cell;
    

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    
    [_otherItemDelete ItemClick:indexPath.row];
    

}



@end
