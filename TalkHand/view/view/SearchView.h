//
//  SearchView.h
//  TalkQQ
//
//  Created by 张小明 on 2017/7/10.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIView

//开始动画
-(void)startHh:(NSInteger)count dict:(CGFloat)dict;
-(void)ceateView;
//开始动画
-(void)stopHh;
-(void)addUserView;

-(void)setUserImgUrl:(NSArray*) dir;



//显示搜索到的用户
-(void)showUser;


-(void)hidenAllUserView;

//所有的imgview
@property NSMutableArray *userArr;

//选取的五个imgview
@property NSMutableArray *findUserArr;

@property UIImageView  *userImgView;
@property CAShapeLayer  *layer1;
@property CAShapeLayer  *layer2;
@property CAShapeLayer  *layer3;
@property CAShapeLayer  *layer4;
@property CAShapeLayer  *layer5;
@end
