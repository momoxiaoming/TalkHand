//
//  JETXViewController.h
//  QsQ
//
//  Created by 张小明 on 2017/6/12.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JETXViewController : BaseViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tx_inout;
@property (weak, nonatomic) IBOutlet UILabel *zhye_txt;
@property (weak, nonatomic) IBOutlet UITextField *zfb_input;

- (IBAction)TxAction:(id)sender;



@property (nonatomic) NSString* moeny;
@end
