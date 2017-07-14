//
//  AdressViewController.h
//  QsQ
//
//  Created by 张小明 on 2017/5/17.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "BaseViewController.h"

@interface AdressViewController : BaseViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property NSDictionary * userinfo;
@end
