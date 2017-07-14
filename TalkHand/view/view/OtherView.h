//
//  OtherView.h
//  QsQ
//
//  Created by 张小明 on 2017/6/26.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OtherItemCilck.h"
@interface OtherView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property UICollectionView * collView;

@property NSMutableArray *itemData;

@property id<OtherItemCilck> otherItemDelete;
@end
