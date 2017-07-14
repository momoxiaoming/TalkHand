//
//  UserInfoMenu.h
//  QsQ
//
//  Created by 张小明 on 2017/3/30.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoMenu : UIView

@property (nonatomic, assign) CGFloat menuWidth;
@property (nonatomic, assign) CGFloat menuHeight;
@property (nonatomic,assign) CGFloat interval;   //间隔

@property (nonatomic) CGRect rect;   //设置显示的基准view

@property (nonatomic, assign, readonly) BOOL isOpen;
@property (nonatomic) NSArray * items;
-(void)OpenMenu;
-(void)CloseMenu;

-(id)initItemsAndBaseView:(NSArray *) items Cgrect:(CGRect) cgrect;   //设置要显示的items和基准view

@end
