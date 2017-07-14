//
//  Face_1_view.h
//  QsQ
//
//  Created by 张小明 on 2017/6/29.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceItemDelete.h"
@interface Face_1_view : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property UICollectionView * collview;

@property NSMutableArray *faceData;


@property NSInteger index;

-(void)setExpData:(NSArray *)arr;


@property id<FaceItemDelete> faceDelete;
@end
