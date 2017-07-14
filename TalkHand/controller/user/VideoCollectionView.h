//
//  VideoCollectionView.h
//  QsQ
//
//  Created by 张小明 on 2017/3/30.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmtyView.h"
#import <AVKit/AVKit.h>
@interface VideoCollectionView : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,AVPlayerViewControllerDelegate>
@property  UICollectionView * collview;


@property NSMutableArray * vdieodata;

@property UIView * eroview;


-(void)setVideo:(NSMutableArray *) arr;
@end
