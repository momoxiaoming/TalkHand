//
//  ChatBotmView.m
//  QsQ
//
//  Created by 张小明 on 2017/5/22.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "ChatBotmView.h"
#import "XMNChatTextParser.h"
#import "XMNChatExpressionManager.h"
@implementation ChatBotmView
//#ifndef kiOS7Later
//#define kiOS7Later (kSystemVersion >= 7)
//#endif
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {   //这里直接初始化本类,并且确定view的边界
//        self=[[ChatBotmView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
//        [self createView];
//    }
//    return self;
//}


-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        [self createView];
    }
    return self;
}


-(void)createView{
    self.backgroundColor=[UIColor colorWithHexString:@"#ebebeb"];
    self.left_img=[[UIImageView alloc]init];
    self.left_img.image=[UIImage imageNamed:@"icon_yy"];
    
     [self initYYTextView];
//    self.input_text=[[YYTextView alloc]init];
    
    self.right1_img=[[UIImageView alloc]init];
    self.right1_img.image=[UIImage imageNamed:@"icon_bq"];
    
    self.right2_img=[[UIImageView alloc]init];
    self.right2_img.image=[UIImage imageNamed:@"icon_tj"];
    
    self.center_btn=[[UIButton alloc]init];
    UIImage *normal_img2=[UIColor createImage:@"#ebebeb"];
    UIImage *select_img2=[UIColor createImage:@"#919191"];
    
   
   

    
    
    
    
    [self.center_btn setBackgroundImage:normal_img2 forState:UIControlStateNormal];
    [self.center_btn setBackgroundImage:select_img2 forState:UIControlStateSelected];
    
    [self.center_btn setTitleColor:[UIColor colorWithHexString:@"#919191"] forState:UIControlStateNormal];
    [self.center_btn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [self.center_btn setTitle:@"按住说话" forState:UIControlStateNormal];
    [self.center_btn setTitle:@"松手发送" forState:UIControlStateSelected];
    [self.center_btn setFont:[UIFont systemFontOfSize:16]];
    self.center_btn.layer.cornerRadius=3;
    
    
    [self.center_btn.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.center_btn.layer setBorderWidth:0.5];
    [self.center_btn.layer setMasksToBounds:YES];
    
    [self.center_btn setHidden:YES];
    

    [self addSubview:self.left_img];
    [self addSubview:self.right2_img];
    [self addSubview:self.right1_img];
    [self addSubview:_center_btn];
    [self addSubview:self.input_text];
    
    [self.left_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];

    [self.right2_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.right1_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right2_img.mas_left).offset(-10);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    
    [self.center_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right1_img.mas_left).offset(-10);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.left.equalTo(self.left_img.mas_right).offset(10);
     
    }];
    [self.input_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right1_img.mas_left).offset(-10);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.left.equalTo(self.left_img.mas_right).offset(10);
        
    }];
    
    [self setListener:self.left_img index:1];
    [self setListener:self.right1_img index:2];
    [self setListener:self.right2_img index:3];
    [self setListener:self.input_text index:4];
    
    [self.center_btn addTarget:self action:@selector(TouchDownAciton) forControlEvents:UIControlEventTouchDown];

    
     [self.center_btn addTarget:self action:@selector(TouchUpInsideAciton) forControlEvents:UIControlEventTouchUpInside];
    
    //拖动到外部操作
      [self.center_btn addTarget:self action:@selector(TouchDragExitAciton) forControlEvents:UIControlEventTouchDragExit];
//    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(meion)];
//    
//    
//    self.input_text.userInteractionEnabled=YES;
//    [self.input_text addGestureRecognizer:tableViewGesture];
}






-(void)initYYTextView{
    
    YYTextView *textView = [[YYTextView alloc]init];
    //设置textView 解析表情
    XMNChatTextParser *parser = [[XMNChatTextParser alloc] init];
    parser.emoticonMapper = [XMNChatExpressionManager sharedManager].qqMapper;
    parser.emotionSize = CGSizeMake(18.f, 18.f);
    parser.alignFont = [UIFont systemFontOfSize:16.f];
    parser.alignment = YYTextVerticalAlignmentBottom;
    textView.textParser = parser;
    //设置textView 固定行高
    YYTextLinePositionSimpleModifier *mod = [YYTextLinePositionSimpleModifier new];
    mod.fixedLineHeight = 20.f;
    textView.linePositionModifier = mod;
    
    textView.font = [UIFont systemFontOfSize:16.f];
    textView.returnKeyType = UIReturnKeySend;
    textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeNone;
    
    [textView.layer setBorderColor:[UIColor grayColor].CGColor];
    [textView.layer setBorderWidth:0.5];
    [textView.layer setMasksToBounds:YES];
    textView.layer.cornerRadius=3;
    textView.backgroundColor=[UIColor whiteColor];
    
    
    
//    NSMutableDictionary *mapper = [ParserExp sharedExp].exp_dir;
////    mapper[@":smile:"] = [self imageWithName:@"002"];
////    mapper[@":cool:"] = [self imageWithName:@"013"];
////    mapper[@":biggrin:"] = [self imageWithName:@"047"];
////    mapper[@":arrow:"] = [self imageWithName:@"007"];
////    mapper[@":confused:"] = [self imageWithName:@"041"];
////    mapper[@":cry:"] = [self imageWithName:@"010"];
////    mapper[@":wink:"] = [self imageWithName:@"085"];
//    
//    YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser new];
//    parser.emoticonMapper = mapper;
//    
//    YYTextLinePositionSimpleModifier *mod = [YYTextLinePositionSimpleModifier new];
//    mod.fixedLineHeight = 22;
//    
// 
//   
//    [textView.layer setBorderColor:[UIColor grayColor].CGColor];
//    [textView.layer setBorderWidth:0.5];
//    [textView.layer setMasksToBounds:YES];
//    textView.layer.cornerRadius=3;
//    textView.backgroundColor=[UIColor whiteColor];
////    textView.keyboardType=returnKeyType;
////    textView.keyboardType=UIKeyboardTypeDefault
//    textView.returnKeyType = UIReturnKeyDone;//Done按钮
//    
////    textView.text = @"Hahahah:001:, it\'s ";
//    textView.font = [UIFont systemFontOfSize:16];
//    textView.textParser = parser;
////    textView.size = self.view.size;
//    textView.linePositionModifier = mod;
////    textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
////    textView.delegate = self;
////    if (kiOS7Later) {
////        textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
////    }
//  
    self.input_text=textView;


}

-(void)TouchUpInsideAciton{
    NSLog(@"--抬起操作");
    [self.botDelete ImageClick:101];
    
}
-(void)TouchDragExitAciton{
  NSLog(@"--拖动到外部的操作");
    [self.botDelete ImageClick:103];
}

-(void)TouchDownAciton{
    NSLog(@"--按下操作");
  [self.botDelete ImageClick:102];
}

-(void)setListener:(UIView *) arr index:(NSInteger) index{
    
    arr.tag=index;   //设置传递的参数
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuAction:)];

    arr.userInteractionEnabled=YES;
    [arr addGestureRecognizer:tableViewGesture];
    
}


-(void)menuAction:(id)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    
    UIView *views = (UIView*) tap.view;
    
    NSUInteger index = views.tag;   //获取上面view设置的tag
    [self.botDelete ImageClick:index];
   
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
