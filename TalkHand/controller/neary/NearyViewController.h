//
//  NearyViewController.h
//  QsQ
//
//  Created by 张小明 on 2017/3/24.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface NearyViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,UIAlertViewDelegate>

@property (nonatomic ) NSMutableArray * neary_data;
@end
