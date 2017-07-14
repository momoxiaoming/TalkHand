//
//  Face_1_view.m
//  QsQ
//
//  Created by 张小明 on 2017/6/29.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "Face_1_view.h"
#import "FaceCell.h"
@implementation Face_1_view
-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if(self){
        [self initData];
        [self createView];
        
    }
    return self;
}


-(void)setExpData:(NSArray *)arr{
    [self.faceData setArray:arr];
    [self.collview reloadData];

}


-(void)initData{
    self.faceData=[[NSMutableArray alloc]init];
    
    
    NSArray *array = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"QQIconNew" ofType:@"bundle"]] pathsForResourcesOfType:@"png" inDirectory:nil];
    
    
    NSLog(@"表情的个数-->%@",array[0]);
    [self.faceData setArray:array];
    
}

-(void)createView{
    UICollectionViewFlowLayout * layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setMinimumInteritemSpacing:0];
    [layout setMinimumLineSpacing:0];
    //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    _collview=[[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    //    [collview setCollectionViewLayout:layout];
    [_collview registerClass:[FaceCell class] forCellWithReuseIdentifier:@"cell"];
    
    _collview.delegate=self;  //添加代理
    _collview.dataSource=self;  //添加数据代理
    _collview.backgroundColor=[UIColor clearColor];
    
    
    NSInteger page=self.faceData.count/24;
    NSInteger page2=self.faceData.count%24;
    
    
    if(page2!=0){
        page=page+1;
    }

    [self addSubview:_collview];

    [_collview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.right.equalTo(self);
        make.left.equalTo(self);
        make.bottom.equalTo(self);
//        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/8*3));
    }];
    
    
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  
    return self.faceData.count;
}


//设置每个cell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/8, SCREEN_WIDTH/8);   //注意,我们这里的宽度时,我们中间边距的距离只需要算一个即可,这样算出来的才会每个方向的间距都会相同
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if(cell==nil){
        cell=[[FaceCell alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/8, SCREEN_WIDTH/8)];
    }
    //    cell.backgroundColor=[UIColor redColor];
    [cell setImage:self.faceData[indexPath.row]];
    
    return cell;
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *facName=self.faceData[indexPath.row];
    [_faceDelete faceClick:self.index str:facName];
    
    //    [_otherItemDelete ItemClick:indexPath.row];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
