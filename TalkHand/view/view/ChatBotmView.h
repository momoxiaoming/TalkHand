//
//  ChatBotmView.h
//  QsQ
//
//  Created by 张小明 on 2017/5/22.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChatBotomDelete.h"
#import <YYText/YYText.h>
#import <YYImage.h>
@interface ChatBotmView : UIView



@property YYTextView * input_text;


@property UIImageView * left_img;

@property UIImageView * right2_img;

@property UIImageView *right1_img;

@property UIButton *center_btn;

@property id<ChatBotomDelete> botDelete;

@end
