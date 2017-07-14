//
//  ChatViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/3/25.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "ChatViewController.h"
#import "MSSBrowseDefine.h"
#import "VIPViewController.h"
#import <AVKit/AVKit.h>
#import "LocalUDPDataSender.h"
#import "CompressionImge.h"
#import "AFHttpSessionClient.h"
#import "BaseMsg.h"
#import "NearyinfoViewController.h"
#import "XMNChatRecordProgressHUD.h"

#import "LeftCell.h"
#import "RightCell.h"
#import "XMNChatExpressionManager.h"

@interface ChatViewController ()
@property  UITableView *table_view;
@property BOOL inoutType;
@property UIView * lin;
@property BOOL  keyBoardlsVisible;



@property  NSString *filePath;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    self.navigationController.navigationBar.alpha=1;
    
    self.inoutType=false;
    
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self registerNotification];
}
//  注册键盘通知方法
- (void)registerNotification
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardWillHideNotification object:nil];
    [center addObserver:self selector:@selector(handleKeyboard:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [center addObserver:self selector:@selector(send_face_action) name:@"send_face" object:nil];
    
    //  给keyBoardlsVisible赋初值
    _keyBoardlsVisible = NO;
}

-(void)send_face_action{
    NSString *inoutstr=self.bot_view.input_text.text;
    if(![inoutstr isEqualToString:@""]){
    //        [self sendMsg:inouttext];
    [self sendManager:0 second:0 content:inoutstr];
    }
}


//  键盘弹出触发该方法
- (void)keyboardDidShow
{
    NSLog(@"键盘弹出");
    _keyBoardlsVisible = YES;
}
//  键盘隐藏触发该方法
- (void)keyboardDidHide
{
    NSLog(@"键盘隐藏");
    _keyBoardlsVisible =NO;
}
/**
 *  处理键盘frame改变通知
 *
 *  @param
 */
- (void)handleKeyboard:(NSNotification *)aNotification {
    
    CGRect keyboardFrame = [aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    self.chatBarBConstraint.constant = -([UIScreen mainScreen].bounds.size.height - keyboardFrame.origin.y);
    NSLog(@"键盘改变-->通知--%f",keyboardFrame.origin.y);
    [self UpdateConstraint:keyboardFrame];
    /** 增加监听键盘大小变化通知,并且让tableView 滚动到最底部 */
    [self.view layoutIfNeeded];
    [self scrollBottom:YES];
}




-(void)initUserInfo{
    if(self.titleName!=NULL&&![self.titleName isEqualToString:@""]){
        self.title=self.titleName;
        
    }else{
        self.title= [[FMDConfig sharedInstance]getUserInfoWithId:self.account][@"name"];
    }
    
}


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.alpha=1;
    [self initUserInfo];
    [self initData];
    
//    [self scrollBottom:YES];
    
    /** 首次出现让tableView滚动到底部 */
    [self.table_view reloadData];
    [self.table_view setContentOffset:CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX)];
}




//键盘弹出时,更新约束
-(void)UpdateConstraint:(CGRect)keyboardFrame {
    
    [self.bot_view setFrame:CGRectMake(0,  keyboardFrame.origin.y-50, SCREEN_WIDTH, 50)];
    //    [self.bot_view mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.bottom.equalTo(self.view);
    //        make.left.equalTo(self.view);
    //        make.right.equalTo(self.view);
    //        make.size.mas_equalTo(CGSizeMake(0, 50));
    //    }];
    [self.lin setFrame:CGRectMake(0,  keyboardFrame.origin.y-50-0.5, SCREEN_WIDTH, 0.5)];
    
    [self.table_view setFrame:CGRectMake(0,  0, SCREEN_WIDTH, keyboardFrame.origin.y-50.5)];
    //    [_lin mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.bottom.equalTo(self.bot_view.mas_top);
    //        make.left.equalTo(self.view);
    //        make.right.equalTo(self.view);
    //        make.size.mas_equalTo(CGSizeMake(0, 0.5));
    //    }];
    //    [_table_view mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.view);
    //        make.right.equalTo(self.view);
    //        make.top.equalTo(self.view);
    //         make.top.equalTo(self.view);
    //    }];
}


-(void)initData{
    self.msgarray =[[NSMutableArray alloc]init];
    
    NSMutableArray *allmsg=[[FMDConfig sharedInstance]getAllMsgWithOtherId:self.account];
    
    [self.msgarray setArray:allmsg];
    
    
}

-(void)initView{
    

    
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
//    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    _table_view =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50.5)];
    self.table_view.backgroundColor=[UIColor colorWithHexString:@"#ebebeb"];
    self.table_view.delegate=self;
    self.table_view.dataSource=self;
    
    
    //开启高度自适应
    self.table_view.estimatedRowHeight = 250.0f;
    self.table_view.rowHeight = UITableViewAutomaticDimension;
    [self.table_view setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //    if (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)) {
    //        self.edgesForExtendedLayout = UIRectEdgeNone;
    //        self.automaticallyAdjustsScrollViewInsets = NO;
    //    }
    //
    //
    //    self.table_view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    
    
    
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    _lin=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50-0.5, SCREEN_WIDTH, 0.5)];
    
    _lin.backgroundColor=[UIColor colorWithHexString:@"#919191"];
    
//    [self.table_view registerClass:[ChatMsgCell class] forCellReuseIdentifier:@"chatmsgcell"];
//    [self.table_view registerClass:[ChatImageMsgCell class] forCellReuseIdentifier:@"ChatImageMsgCell"];
//    [self.table_view registerClass:[ChatVideoCell class] forCellReuseIdentifier:@"ChatVideoCell"];
//    [self.table_view registerClass:[ChatAudioCell class] forCellReuseIdentifier:@"ChatAudioCell"];
    
        [self.table_view registerClass:[RightCell class] forCellReuseIdentifier:@"RightCell"];
        [self.table_view registerClass:[LeftCell class] forCellReuseIdentifier:@"LeftCell"];
    
    _bot_view =[[ChatBotmView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
    _bot_view.botDelete=self;
    _bot_view.input_text.delegate=self;
    
    
    _otherView=[[OtherView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/4)];
    _otherView.otherItemDelete=self;
    
    
    _faceView=[[ExpView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/8*3+20+40.5)];
    _faceView.expDelete=self;
    
    
    
    [self.view addSubview:self.table_view];
    [self.view addSubview:_bot_view];
    [self.view addSubview:_lin];
    
    //    [[UIApplication sharedApplication] statusBarFrame].size.width
    //    [[UIApplication sharedApplication] statusBarFrame].size.height
    //
    //
    //
    //    self.navigationController.navigationBar.frame.size.width
    //    self.navigationController.navigationBar.frame.size.height
    //
    
    //    [self.bot_view mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.bottom.equalTo(self.view);
    //        make.left.equalTo(self.view);
    //        make.right.equalTo(self.view);
    //        make.size.mas_equalTo(CGSizeMake(0, 50));
    //    }];
    
    
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentTableViewTouchInSide)];
    tableViewGesture.numberOfTapsRequired = 1;
    tableViewGesture.cancelsTouchesInView = NO;
    [self.table_view addGestureRecognizer:tableViewGesture];
    
    
    
    
}

-(void)commentTableViewTouchInSide{
    [self closeKeyBordy];

}


//其他视图点击回调接口
-(void)ItemClick:(NSInteger)index{
    switch (index) {
        case 0:
            [self video_action:3];
            break;
        case 1:
            [self video_action:2];
            break;
        case 2:
            
            break;
        case 3:
            [self video_action:1];
            break;
        default:
            break;
    }
    
}







//// will begin Editing Action
//-(BOOL)textFieldShouldBeginEditing:(UITextField* )textField
//{
//    NSLog(@"将要开始编辑时执行的方法%@", textField.text);
//    //系统是否响应这个动作
//    return YES;
//}

#pragma mark - chatbotomdelete
-(void)ImageClick:(NSInteger)index{
    
    NSLog(@"点击了-->%lu",index);
    
    if(index==1){
        if(!_inoutType){
            //语音模式
            [self closeKeyBordy];
           
            [self.bot_view.center_btn setHidden:NO];
            
            [self.bot_view.input_text setHidden:YES];
            
            [self.bot_view.left_img setImage:[UIImage imageNamed:@"icon_jp"]];
            
            _inoutType=YES;
        }else{
            //输入框模式
            [self showKeyBordy];
            
            
            [self.bot_view.center_btn setHidden:YES];
            
            [self.bot_view.input_text setHidden:NO];
            
            [self.bot_view.left_img setImage:[UIImage imageNamed:@"icon_yy"]];
            
            _inoutType=false;
            
        }
        
        
        
        
    }else if(index==2){ //点击表情按钮
        self.bot_view.input_text.inputView = _faceView;
        [self.bot_view.input_text reloadInputViews];
        [self.bot_view.input_text becomeFirstResponder]; //弹出键盘
    }else if(index==3){ //点击其他按钮
        
        
        
        self.bot_view.input_text.inputView = self.otherView;
        [self.bot_view.input_text reloadInputViews];
        [self.bot_view.input_text becomeFirstResponder]; //弹出键盘
        
        
        
    }else if(index==4){//点击输入框
        //输入框模式
        NSLog(@"输入框响应");
        [self showKeyBordy];
        
    }else if(index==101){  //松开操作
        

        [self stopRecord:1];
        
  

    }else if(index==102){  //按下操作
   
     [self startRecord];
//        [self startAudio];
    }else if(index==103){  //拖动取消操作
      
        [self stopRecord:2];
    }
    
}


//-(void)startAudio{
//    //1.获取沙盒地址
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    
//    NSTimeInterval time=[[NSDate date]timeIntervalSince1970];  //获取当前时间戳
//    
//    //    long long time_num= [[NSNumber numberWithDouble:time] longLongValue];
//    NSString *timestr=[NSString stringWithFormat:@"/%f",time];
//    timestr=  [timestr stringByAppendingString:@".wav"];
//    _filePath = [path stringByAppendingString:timestr];
////    NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:@"download/aaa"];
//    
//    [[EMCDDeviceManager sharedInstance] asyncStartRecordingWithFileName:_filePath completion:^(NSError *error)
//     {
//         if (error) {
////             NSLog(@"%@",NSEaseLocalizedString(@"message.startRecordFail", @"failure to start recording"));
//             
//             
//         }
//     }];
//
//    
//    
//   
//
//}
//
//-(void)stopAudio{
//    [[EMCDDeviceManager sharedInstance] asyncStopRecordingWithCompletion:^(NSString *recordPath, NSInteger aDuration, NSError *error) {
//        
//    }];
//
//}
//


- (void)startRecord {
    NSLog(@"开始录音");
     [XMNChatRecordProgressHUD show];
    //录制amr格式语音
//    [self.recorder setEncoderType:XMNAudioEncoderTypeAMR];
//    [self.recorder startRecording];
    
    
    
}
- (void)stopRecord:(NSInteger)index {

    if(index==1){
        
//        if (self.recorder.isRecording) {
//            [self.recorder stopRecording];
//             [XMNChatRecordProgressHUD dismissWithMessage:@"录音完成"];
//     
//            CGFloat time=self.recorder.seconds;
//          
//            NSString* url=[[self.recorder filePath] stringByAppendingPathComponent:[self.recorder filename]];
//            
//            
//            
////            NSLog(@"录音成功--文件名=%@,文件地址=%@,录音时间=%f",name,path_URL,time);
//            
//            if(url){
//                [self upAudioLoadFile:url time:time];
//            }
//           
//            return;
//        }
    }else if(index==2){
        [XMNChatRecordProgressHUD dismissWithMessage:@"录音取消"];
    }
    
    
    
    
}




//弹出键盘
-(void)showKeyBordy{
    self.bot_view.input_text.inputView = nil;
    [self.bot_view.input_text reloadInputViews];
    [self.bot_view.input_text becomeFirstResponder]; //弹出键盘
}
//关闭键盘
-(void)closeKeyBordy{
    //语音模式
    [self.bot_view.input_text resignFirstResponder];   //回收键盘
}


//-(BOOL)textFieldShouldClear:(UITextField *)textField{
//
//
//}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.msgarray.count;
}


//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    BaseMsg* en=[self.msgarray objectAtIndex:indexPath.row];
//    int type=[[en valueForKeyPath:@"msg_info_type"]intValue];;
//    
//    if(type==[textMsg intValue]){
//           NSString * constr=[en valueForKeyPath:@"msg_content"];
//        //设置文本内容,先转为富文本
//        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:constr];
////        //解析富文本
////        [self.msg_text.textParser parseText:one
////                              selectedRange:NULL];
//        //设置富文本的字体大小
//        one.yy_font =[UIFont systemFontOfSize:14];
//        //定义一个富文本边界
//        YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(SCREEN_WIDTH - 150, CGFLOAT_MAX)];
//        //设置textView 固定行高
//        YYTextLinePositionSimpleModifier *mod = [YYTextLinePositionSimpleModifier new];
//        mod.fixedLineHeight = 26;
////        self.msg_text.linePositionModifier = mod;
//        container.linePositionModifier =mod;
//        //定义一个layoutview
//        YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:one];
////        self.msg_text.textLayout = layout;
//        
//        CGSize titleSize  = CGSizeMake(MIN(MIN(layout.textBoundingSize.width , SCREEN_WIDTH - 150), layout.textBoundingSize.width ), layout.rowCount * 26 );
//   
////        CGSize titleSize = [constr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-150, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
//        if((titleSize.height+20)>45){
//            if(layout.rowCount==1){
//                return 65;
//            }
//            return 20+titleSize.height+20;
//        }
//        
//        return 45+20;
//    }else if(type==[aduioMsg intValue]){
//        
//        return 45+20;
//        
//        
//    }else if(type==[picterMsg intValue]){
//        
//        return 250+20;
//        
//        
//    }else if(type==[videoMsg intValue]){
//        
//        return 250+20;
//        
//    }
//    return 0;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    ChatMsgCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
//    BaseMsg* en=[self.msgarray objectAtIndex:indexPath.row];
//    int type=[[en valueForKeyPath:@"msg_info_type"]intValue];;
//    
//    if(type==[textMsg intValue]){
//        
//        ChatMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chatmsgcell"] ;
//        
//        if(cell){
//            
//            cell=[[ChatMsgCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"chatmsgcell"];
//        }
//        cell.msgdelete=self;
//        [cell setCellMsg:en];
//        //         cell.userInteractionEnabled = NO;
//        return cell;
//    }else if(type==[aduioMsg intValue]){ //语音
//        ChatAudioCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatAudioCell"] ;
//        
//        if(cell){
//            
//            cell=[[ChatAudioCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ChatAudioCell"];
//        }
//        [cell setCellMsg:nil];
//        //        cell.userInteractionEnabled = NO;
//        return cell;
//        
//    }else if(type==[picterMsg intValue]){ //图片
//        ChatImageMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatImageMsgCell"] ;
//        
//        if(cell){
//            
//            cell=[[ChatImageMsgCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ChatImageMsgCell"];
//        }
//        
//        
//        [cell setCellMsg:en ViewController:self];
//        //         cell.userInteractionEnabled = NO;
//        return cell;
//        
//        
//        
//    }else if(type==[videoMsg intValue]){ //视频
//        ChatVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatVideoCell"] ;
//        
//        if(cell){
//            
//            cell=[[ChatVideoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ChatVideoCell"];
//        }
//        cell.celldelete=self;
//        [cell setCellMsg:en];
//        //        cell.userInteractionEnabled = NO;
//        return cell;
//        
//    }
    
    
    BaseMsg* en=[self.msgarray objectAtIndex:indexPath.row];
    int type=[[en valueForKeyPath:@"msg_isor"]intValue];;
    
    if(type==0){ //发送
        
        RightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RightCell"] ;
        
        if(cell){
            
            cell=[[RightCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"RightCell"];
        }
//        cell.msgdelete=self;
//        [cell setCellMsg:en];
        cell.controller=self;
        [cell configMessage:en];
        cell.cellDelete=self;
        return cell;
    }else if(type==1){//接收
        LeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftCell"] ;
        
        if(cell){
            
            cell=[[LeftCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"LeftCell"];
        }
        //        cell.msgdelete=self;
        //        [cell setCellMsg:en];
         cell.cellDelete=self;
        [cell configMessage:en];
        
        return cell;
        
    }

    
    
    return nil;
    
}

#pragma mark - UITableViewDelegate





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"dianji");
    [self closeKeyBordy];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

-(void)textViewDidEndEditing:(YYTextView *)textView{
    NSLog(@"textViewDidEndEditing");

}
-(void)textViewDidBeginEditing:(YYTextView *)textView{
    NSLog(@"textViewDidBeginEditing");
}

//由于textView 没有监听return键的回调函数,无法获取return的按键监听,但我们可以获取他的换行监听,当器按下return时,会调用该函数进行换行
-(BOOL)textView:(YYTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSString * inoutstr=textView.text;  //获取已有内容
    
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        if(inoutstr.length==0){
            NSLog(@"内容为空不能发送");
            
        }else{
            //        [self sendMsg:inouttext];
            [self sendManager:0 second:0 content:inoutstr];
            
        }
        
        
        NSLog(@"shouldChangeTextInRange");
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}




//消息发送管理器
-(void)sendManager:(NSInteger) type second:(NSInteger)mindex content:(NSString*)contnet{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    BaseMsg * msg=[[BaseMsg alloc]init];
    msg.msg_info_type=[NSString stringWithFormat:@"%lu",type];
    msg.msg_content=contnet;
    msg.msg_time=[Util get1970Time];
    msg.msg_second=[NSString stringWithFormat:@"%lu",mindex];
    msg.msg_isor=@"0";
    msg.otherid=self.account;
    msg.isread=@"1";
    //保存消息
    [[FMDConfig sharedInstance]saveMessageWithOtherId:msg];
    
    [self.msgarray addObject:msg];
    
    NSLog(@"发送消息--小写内容-%@",msg);
    
    //刷新列表数据
    [_table_view reloadData];
    
    self.bot_view.input_text.text=@"";
    
    [self scrollBottom:YES];
    
    //发送消息
    NSMutableDictionary *dir=[[NSMutableDictionary alloc]init];
    [dir setObject:[NSString stringWithFormat:@"%lu",type] forKey:@"type"];
    [dir setObject:contnet forKey:@"content"];
    [dir setObject:[NSString stringWithFormat:@"%lu",mindex] forKey:@"second"];
    [[LocalUDPDataSender sharedInstance] sendCommonDataWithStr:[dir mj_JSONString] toUserId:[self.account intValue] qos:YES fp:nil];
    
    
    
    
    
}
////发送图片消息
//-(NSString*)sendPickerMsg:(NSString*)str{
//    BaseMsg * msg=[[BaseMsg alloc]init];
//    msg.msg_info_type=textMsg;
//    msg.msg_content=str;
//    msg.msg_time=[Util get1970Time];
//    msg.msg_second=@"0";
//    msg.msg_isor=@"0";
//    msg.otherid=self.account;
//    msg.isread=@"1";
//    //保存消息
//    [[FMDConfig sharedInstance]saveMessageWithOtherId:msg];
//
//    [self.msgarray addObject:msg];
//
//    //刷新列表数据
//    [_table_view reloadData];
//
//    self.bot_view.input_text.text=@"";
//
//    [self scrollBottom:NO];
//
//    return str;
//}

////滚动到底部
//- (void)scrollBottom:(BOOL)animated {
//    
//    if (self.msgarray.count >= 1) {
//        [self.table_view scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:MAX(0, self.msgarray.count - 1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
//    }
//    
//    
//    
//}

#pragma mark  - 滑到最底部
-(void)scrollBottom:(BOOL)animated
{
    NSInteger s = [self.table_view numberOfSections];  //有多少组
    if (s<1) return;  //无数据时不执行 要不会crash
    NSInteger r = [self.table_view numberOfRowsInSection:s-1]; //最后一组有多少行
    if (r<1) return;
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];  //取最后一行数据
    [self.table_view scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated]; //滚动到最后一行
}




-(void)video_action:(NSInteger) index{
    //触发事件：录像
    UIImagePickerController * imagepicker=[[UIImagePickerController alloc]init];
    imagepicker.delegate = self;
    //判断相机是否可用
    BOOL isCameraSupport = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if(isCameraSupport){
        //判断后置摄像头是否可用
        BOOL isRearSupport = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if(isRearSupport){
            
            
            if(index==1){
                //指定使用照相机模式,可以指定使用相册／照片库
                imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                //设置当拍照完或在相册选完照片后，是否跳到编辑模式进行图片剪裁。只有当showsCameraControls属性为true时才有效果
                imagepicker.allowsEditing = NO;
                //设置拍照时的下方的工具栏是否显示，如果需要自定义拍摄界面，则可把该工具栏隐藏
                imagepicker.showsCameraControls  = YES;
                //录像质量
                imagepicker.videoQuality = UIImagePickerControllerQualityTypeMedium;
                //录像最长时间
                imagepicker.videoMaximumDuration = 10.0f;
                //设置使用后置摄像头
                imagepicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                
                imagepicker.mediaTypes =  [[NSArray alloc] initWithObjects:(NSString*)kUTTypeMovie,nil];
                imagepicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo; //相机的模式 拍照/摄像
                
            }else if(index==2){
                //指定使用照相机模式,可以指定使用相册／照片库
                imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                //设置当拍照完或在相册选完照片后，是否跳到编辑模式进行图片剪裁。只有当showsCameraControls属性为true时才有效果
                imagepicker.allowsEditing = NO;
                //设置拍照时的下方的工具栏是否显示，如果需要自定义拍摄界面，则可把该工具栏隐藏
                imagepicker.showsCameraControls  = YES;
                imagepicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto; //相机的模式 拍照/摄像
                
            }else if(index==3){
                //设置选取的照片是否可编辑
                //                imagepicker.allowsEditing = YES;
                imagepicker.mediaTypes =  [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage,nil];
                
                //设置相册呈现的样式
                //照片的选取样式还有以下两种
                //UIImagePickerControllerSourceTypePhotoLibrary,直接全部呈现系统相册
                //UIImagePickerControllerSourceTypeCamera//调取摄像头
                imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            
            [self presentViewController:imagepicker animated:YES completion:^{
              
            }];
        }
        
    }
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //通过UIImagePickerControllerMediaType判断返回的是照片还是视频
    NSString* type = [info objectForKey:UIImagePickerControllerMediaType];
    //如果返回的type等于kUTTypeImage，代表返回的是照片,并且需要判断当前相机使用的sourcetype是拍照还是相册
    if ([type isEqualToString:(NSString*)kUTTypeMovie]) {
        // 视频处理
        NSURL *sourceURL = [info objectForKey:UIImagePickerControllerMediaURL];
        //        NSLog(@"%@",[NSString stringWithFormat:@"%f s", [self getVideoLength:sourceURL]]);
        //        NSLog(@"%@", [NSString stringWithFormat:@"%.2f kb", [self getFileSize:[sourceURL path]]]);
        NSURL *newVideoUrl ; //一般.mp4
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        
        newVideoUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]]] ;//这个是保存在app自己的沙盒路径里，后面可以选择是否在上传后删除掉。我建议删除掉，免得占空间。
        
        // 选择图片后手动销毁界面
        [picker dismissViewControllerAnimated:YES completion:^{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self convertVideoQuailtyWithInputURL:sourceURL outputURL:newVideoUrl completeHandler:nil ];

        }];
  
    }else if([type isEqualToString:(NSString*)kUTTypeImage]){
        UIImage *  image = info[UIImagePickerControllerOriginalImage];//获取原始照片
        
        CompressionImge *img=[[CompressionImge alloc]init];
        //        NSData *imageData =UIImageJPEGRepresentation(image,1);//图片对象转为nsdata
        //
        NSData *data=[img resetSizeOfImageData:image maxSize:200];
        UIImage *up_img = [UIImage imageWithData: data];
        
        [picker dismissViewControllerAnimated:YES completion:^{
//            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
           [self upLoadImgFile:up_img type:@"2"];
            
        }];
        
        
        
        
    }
    
}

- (void) convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                               outputURL:(NSURL*)outputURL
                         completeHandler:(void (^)(AVAssetExportSession*))handler
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    //  NSLog(resultPath);
    exportSession.outputURL = outputURL;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse= YES;
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
     {
         switch (exportSession.status) {
             case AVAssetExportSessionStatusCancelled:
                 NSLog(@"AVAssetExportSessionStatusCancelled");
                 break;
             case AVAssetExportSessionStatusUnknown:
                 NSLog(@"AVAssetExportSessionStatusUnknown");
                 break;
             case AVAssetExportSessionStatusWaiting:
                 NSLog(@"AVAssetExportSessionStatusWaiting");
                 break;
             case AVAssetExportSessionStatusExporting:
                 NSLog(@"AVAssetExportSessionStatusExporting");
                 break;
             case AVAssetExportSessionStatusCompleted:
                 NSLog(@"AVAssetExportSessionStatusCompleted");
//                [NSString stringWithFormat:@"%.2f kb", [self getFileSize:[outputURL path]]]);
                 
                 [self upLoadFile:outputURL type:@"3"];
                 break;
             case AVAssetExportSessionStatusFailed:
                 NSLog(@"AVAssetExportSessionStatusFailed");
                 break;
         }
         
     }];
    
}
-(void)upLoadImgFile:(UIImage *)img type:(NSString *)type {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    AFHttpSessionClient * af=[AFHttpSessionClient sharedClient ];
    //    NSData *video_data=[NSData dataWithContentsOfURL:url];
    NSMutableDictionary *dir=[[NSMutableDictionary alloc]init];
    [dir setObject:type forKey:@"type"];
    [af UploadImageFile:img parameters:dir path:upvideo_url actionBlock:^(NSDictionary *posts, NSError *error) {
        // 选择图片后手动销毁界面
      
        
     
        if([posts[@"state"] isEqualToString:@"1"]){
            Toast * t=[Toast makeText:@"图片发送成功"];
            [t showWithType:ShortTime];
            
            NSArray *url_list=posts[@"url"];
            
            NSString * video_url=[ url_list valueForKey:@"1"];
            NSLog(@"图片地址%@",video_url);
            //            if(![video_url isEqualToString:@""]){
            //发送图片信息
            [self sendManager:2 second:0 content:video_url];
            
            //            }
            
            
            //            [self showWindow:@"2" url:video_url];
        }else{
            Toast * t=[Toast makeText:@"图片发送失败"];
            [t showWithType:ShortTime];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        
        
        
        
    }];
}

-(void)upAudioLoadFile:(NSString *)url time:(CGFloat)time{
      [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHttpSessionClient * af=[AFHttpSessionClient sharedClient ];
    
//    [NSData dataWithContentsOfFile:url];
    
    
    NSData *video_data=[NSData dataWithContentsOfFile:url];
    NSMutableDictionary *dir=[[NSMutableDictionary alloc]init];
    
    [dir setObject:aduioMsg forKey:@"type"];
    [af UploadAudioFile:video_data path:upvideo_url parameters:dir actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
        
          [MBProgressHUD hideHUDForView:self.view animated:YES];
        if([posts[@"state"] isEqualToString:@"1"]){
            
            Toast * t=[Toast makeText:@"语音成功"];
            [t showWithType:ShortTime];
            NSArray *url_list=posts[@"url"];
            
            NSString * video_url=[ url_list valueForKey:@"1"];
            if(![video_url isEqualToString:@""]){
                
              [self sendManager:[aduioMsg integerValue] second:time content:video_url];
                
            }
            NSLog(@"语音地址%@",video_url);
            //            [self showWindow:@"2" url:video_url];
            
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            Toast * t=[Toast makeText:@"视频发送失败"];
            [t showWithType:ShortTime];
        }
        
    }];
}

-(void)upLoadFile:(NSURL *)url type:(NSString *)type{

    AFHttpSessionClient * af=[AFHttpSessionClient sharedClient ];
    NSData *video_data=[NSData dataWithContentsOfURL:url];
    NSMutableDictionary *dir=[[NSMutableDictionary alloc]init];
    
    [dir setObject:type forKey:@"type"];
    [af UploadVideoFile:video_data path:upvideo_url parameters:dir actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
       
        
        if([posts[@"state"] isEqualToString:@"1"]){
            
            Toast * t=[Toast makeText:@"视频发送成功"];
            [t showWithType:ShortTime];
            NSArray *url_list=posts[@"url"];
            
            NSString * video_url=[ url_list valueForKey:@"1"];
            if(![video_url isEqualToString:@""]){
                //发送语音消息
                [self sendManager:3 second:0 content:video_url];
                
            }
            NSLog(@"视频地址%@",video_url);
            //            [self showWindow:@"2" url:video_url];
            
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            Toast * t=[Toast makeText:@"视频发送失败"];
            [t showWithType:ShortTime];
        }
        
    }];
}

-(void)cellClick:(NSInteger)tag isright:(NSInteger)isright object:(NSObject *)obj{
    if(isright==0){ //发送cell
        if(tag==2){
            AVPlayerViewController * pl=[[AVPlayerViewController alloc]init];
            pl.player=[AVPlayer playerWithURL:[NSURL URLWithString:[obj valueForKey:@"videoUrl"]]];
            [self goNextController:pl];
        }else if(tag==1){
            
        }else if(tag==5){  //播放音频
            NSString* audio_url=[obj valueForKey:@"msg_content"];
            NSLog(@"音频地址=%@",audio_url);
         
            
            
            
            
            
            
            AFHttpSessionClient *cliend=  [AFHttpSessionClient sharedClient];
            
            [cliend downFilepath:audio_url parameters:nil actionBlock:^(NSDictionary *dict, NSError * error) {
                [cliend downFilepath:audio_url parameters:nil actionBlock:^(NSDictionary *dict , NSError * error) {
                    if (!error) {
                        NSString * videoUrl=[dict valueForKey:@"filePath"];
                        
                      
                    }
                }];
            }];
        }
    }else if(isright==1){//接收cell
        if(tag==2){  //点击视频
            AVPlayerViewController * pl=[[AVPlayerViewController alloc]init];
            pl.player=[AVPlayer playerWithURL:[NSURL URLWithString:[obj valueForKey:@"videoUrl"]]];
            [self goNextController:pl];
        }else if(tag==4){  //点击头像
            NearyinfoViewController *con=[[NearyinfoViewController alloc]init];
            con.owerid=self.account;
            [self goNextController:con];
        }else if(tag==5){//播放音频
            NSString* audio_url=[obj valueForKey:@"msg_content"];
            NSLog(@"音频地址=%@",audio_url);
            
            AFHttpSessionClient *cliend=  [AFHttpSessionClient sharedClient];
            
            [cliend downFilepath:audio_url parameters:nil actionBlock:^(NSDictionary *dict , NSError * error) {
                if (!error) {
                     NSString * videoUrl=[dict valueForKey:@"filePath"];
                    
                    
                    
                }
            }];
        }
    }
    
    

}





//--------------表情点击回调------------

-(void)faceClick:(NSInteger)index str:(NSString *)str{
    NSLog(@"聊天收到表情--->%@",str);
    
    NSArray *com_arr= [str componentsSeparatedByString:@"/"];
   NSString* ex=com_arr[com_arr.count-1];
    ex= [ex substringWithRange:NSMakeRange(0, 3)];
    
    
    
    
    
    if(![ex isEqualToString:@"999"]){
//     NSString * str3=  self.bot_view.input_text.text;
//       str3= [str3 stringByAppendingString:[[ParserExp sharedExp] parserStrToExp:ex]];
//        
//        self.bot_view.input_text.text=@"";
//       
//        self.bot_view.input_text.text=str3;
        NSArray *qqexp=  [XMNChatExpressionManager sharedManager].qqEmotions;
        
        [qqexp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *values=  [obj allValues];
            NSString *fileName=values[0];
          
            if([fileName isEqualToString:ex]){
                NSArray *keys=  [obj allKeys];
                NSString *key=keys[0];
                NSString * str3=  self.bot_view.input_text.text;
                        self.bot_view.input_text.text=@"";
                self.bot_view.input_text.text=[NSString stringWithFormat:@"%@%@",str3,key];
                
                return ;
                
            }
            
        }];
        
        
    }else{
        //删除
       [self.bot_view.input_text deleteBackward];
        
        
        
    }
    
  
    
    
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
