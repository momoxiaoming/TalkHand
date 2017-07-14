//
//  LoginController.h
//  MSN
//
//  Created by 张小明 on 2017/1/5.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"
@interface LoginController : BaseViewController<UITextFieldDelegate>



//处理登陆回调
//@property (nonatomic, copy) ObserverCompletion loginObserver;// block代码块一定要用copy属性，否则报错
@end
