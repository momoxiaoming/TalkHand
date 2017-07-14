//
//  ExpView.h
//  QsQ
//
//  Created by 张小明 on 2017/6/28.
//  Copyright © 2017年 张小明. All rights reserved.
//  表情
//

#import <UIKit/UIKit.h>
#import "FaceItemDelete.h"
#import "ExpClickDelete.h"
@interface ExpView : UIView<UIPageViewControllerDataSource,FaceItemDelete>

@property UIPageControl *pageControl;

@property UIScrollView *scrollView;

@property UIButton * sendBtn;

//@property NSMutableArray *expData;

@property NSMutableArray *faceData;

@property id<ExpClickDelete> expDelete;

@end
