//
//  BaseViewController.h
//  QsQ
//
//  Created by 张小明 on 2017/3/25.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
-(void)goNextController:(UIViewController *)controller;

-(void)showProgress;

-(void)hideProgress;

-(void)back;


-(void)showEmoryView;
-(void)hidenEmoryView;
@end
