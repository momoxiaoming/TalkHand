//
//  UserInfoViewController.h
//  QsQ
//
//  Created by 张小明 on 2017/6/20.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : BaseViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *Item1;
@property (weak, nonatomic) IBOutlet UITextField *wx_input;
@property (weak, nonatomic) IBOutlet UITextField *phone_input;
@property (weak, nonatomic) IBOutlet UITextField *friend_input;
@property (weak, nonatomic) IBOutlet UIImageView *tximg;
@property (weak, nonatomic) IBOutlet UITextField *name_input;
@property (weak, nonatomic) IBOutlet UITextField *age_input;
@property (weak, nonatomic) IBOutlet UILabel *acount;
@property (weak, nonatomic) IBOutlet UILabel *sz_input;

@end
