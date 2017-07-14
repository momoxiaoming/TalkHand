//
//  WYZQViewController.h
//  QsQ
//
//  Created by 张小明 on 2017/4/15.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "BaseViewController.h"

@interface WYZQViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property NSMutableArray * ardata;

@property UILabel *text2;

@property UICollectionView* collview;

@property int iscank;

@end
