//
//  RightCell.m
//  QsQ
//
//  Created by 张小明 on 2017/7/4.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "RightCell.h"
#import "XMNChatTextParser.h"
#import "XMNChatExpressionManager.h"
#import "MSSBrowseDefine.h"
#import "VIPViewController.h"
#import "ImageUtil.h"
@implementation RightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self createView];
    }
     [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    return self;
    
    
}


-(void)configMessage:(BaseMsg*) msg{
    self.itemMsg=msg;
    NSInteger type=[[msg valueForKey:@"msg_info_type"] integerValue];
    //设置头像
    NSString *imgurl=[[FMDConfig sharedInstance]getUserInfoWithId:[[NSUserDefaults standardUserDefaults] objectForKey:@"id"]][@"iconUrl"];
    
    
    [_Tx_img sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:[UIImage imageNamed:@"icon_mor"]];
    
    
    //首先移除父视图
    //    [self.content_View removeFromSuperview];
     NSString *message=[msg valueForKey:@"msg_content"];
     [_time_label setHidden:YES];
    
    if(type==[textMsg integerValue]){//文字
       
        
        //----------创建装载文字内容的yylabel---------------------
        YYLabel * msg_text=[[YYLabel alloc]init];
        msg_text.numberOfLines=0;
        msg_text.font=[UIFont systemFontOfSize:14.f];
        [msg_text setLineBreakMode:NSLineBreakByCharWrapping];
        msg_text.autoresizingMask = UIViewAutoresizingNone;
        msg_text.textAlignment = NSTextAlignmentRight;
        msg_text.textColor=[UIColor whiteColor];
        
        //设置textView 解析表情 解析link
        XMNChatTextParser *parser=[[XMNChatTextParser alloc]init];
        parser.emoticonMapper = [XMNChatExpressionManager sharedManager].qqGifMapper;
        parser.emotionSize = CGSizeMake(24.f, 24.f);
        parser.alignFont = [UIFont systemFontOfSize:14.f];
        parser.parseLinkEnabled = YES;
        msg_text.textParser = parser;
        
        //设置textView 固定行高
        YYTextLinePositionSimpleModifier *mod = [YYTextLinePositionSimpleModifier new];
        mod.fixedLineHeight = 26;
        msg_text.linePositionModifier = mod;
        [self.content_View addSubview:msg_text];
        //设置约束为内容view的边界
        [msg_text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.content_View);
        }];
        
        
        //-------------将文字消息转为富文本,并解析出表情----------
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:message];
        
        
        [msg_text.textParser parseText:one  selectedRange:NULL];
        one.yy_font = self.textLabel.font;
        one.yy_color=[UIColor whiteColor];
        YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(MessageMaxWidth, CGFLOAT_MAX)];
        container.linePositionModifier =msg_text.linePositionModifier;
        YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:one];
        msg_text.textLayout = layout;
        CGSize titleSize  = CGSizeMake(MIN(MIN(layout.textBoundingSize.width, MessageMaxWidth), msg_text.textLayout.textBoundingSize.width ), layout.rowCount * [(YYTextLinePositionSimpleModifier *)msg_text.linePositionModifier fixedLineHeight] );
        
        
        
        
        
        
        
        //-----------更新内容约束---------
        [self.content_View mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(titleSize.width,titleSize.height>30?titleSize.height:30));
            
        }];
        
        
            // 通知需要更新约束，但是不立即执行
            [self setNeedsUpdateConstraints];
            // 立即更新约束，以执行动态变换
            // update constraints now so we can animate the change
            [self updateConstraintsIfNeeded];
        
        
        
        
        
    }else if(type==[picterMsg integerValue]){//图片
//        NSString *img_url=[msg valueForKey:@""];
        
        
        _ImageView=[[UIImageView alloc]init];
       
        _ImageView.contentMode=UIStackViewAlignmentFill;
        [self.content_View addSubview:_ImageView];
        //设置约束为内容view的边界
        [_ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.content_View);
        }];
   
        [_ImageView sd_setImageWithURL:[NSURL URLWithString:message] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //图片加载出来之后,更新约束
            CGSize imgsize=image.size;
            //更新图片约束
            [self setupMessageConstraint:imgsize];
        }];
        
        
       
     [self setListener:_ImageView index:1];
        
        
        
    }else if(type==[aduioMsg integerValue]){ //音频
        [_time_label setHidden:NO];
        NSInteger scoen=[[msg valueForKey:@"msg_second"] integerValue];;
        _time_label.text=[NSString stringWithFormat:@"'%lu",scoen];
        
        
        _ImageView=[[UIImageView alloc]init];
        _ImageView.image=[UIImage imageNamed:@"message_voice_sender_playing_3"];
        
        [self.content_View addSubview:_ImageView];
        
       
        [_ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.content_View);
            make.right.equalTo(self.content_View);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        
        
        //初始化动画
        NSMutableArray * imgarr=[[NSMutableArray alloc]init];
        [imgarr addObject:[UIImage imageNamed:@"message_voice_sender_playing_1"]];
        [imgarr addObject:[UIImage imageNamed:@"message_voice_sender_playing_2"]];
        [imgarr addObject:[UIImage imageNamed:@"message_voice_sender_playing_3"]];
        self.ImageView.animationImages=imgarr;
        //动画重复次数
        self.ImageView.animationRepeatCount=scoen;
        //动画执行时间,多长时间执行完动画
        self.ImageView.animationDuration=1 ;
        
        
        
        CGFloat wd=0;
        if(scoen<=5){
            wd=50;
            
        }else if(scoen>5&&scoen<=8){
            wd=100;
        }else if(scoen>8&&scoen<15){
            wd=150;
        }else{
            wd=150;
        }
        
   
        
      
        
        
       
        
        //更新约束
        [self.content_View mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(wd, 30));
        }];
        [self setListener:self.content_View index:2];
        
        // 通知需要更新约束，但是不立即执行
        [self setNeedsUpdateConstraints];
        // 立即更新约束，以执行动态变换
        // update constraints now so we can animate the change
        [self updateConstraintsIfNeeded];
        
        
        
        
    }else if(type==[videoMsg integerValue]){ //视频
        
        _ImageView=[[UIImageView alloc]init];
        _ImageView.contentMode=UIViewContentModeRedraw;
        
        UIImageView* img=[[UIImageView alloc]init];
        UIImage* image=[UIImage imageNamed:@"icon_spi"];
        img.image=image;
        
        
        [self.content_View addSubview:_ImageView];
        [self.content_View addSubview:img];
        
        [_ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.content_View);
        }];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.ImageView);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        if(message==nil){
            NSString *videoUrl=[msg valueForKey:@"videoUrl"];
            //创建任务队列,一般是串行队列
            dispatch_queue_t queue=dispatch_queue_create("thunm_img_thread", NULL);
            dispatch_async(queue, ^{
                UIImage * img=[ImageUtil thumbnailImageForVideo:[NSURL URLWithString:videoUrl] atTime:1000];
                //        self.msg_img.backgroundColor=[UIColor blackColor];
                _ImageView.image=img;
                
                //更新约束
                CGSize imgsize=img.size;
                
                [self setupMessageConstraint:imgsize];
                
            });
        }else{
            [_ImageView sd_setImageWithURL:[NSURL URLWithString:message] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                //图片加载出来之后,更新约束
                CGSize imgsize=image.size;
                //更新图片约束
                [self setupMessageConstraint:imgsize];
            }];
            
        }

      
        
      [self setListener:_ImageView index:3];
        
        
        
        
        
    }
    
    
    
    
    
}





-(void)setListener:(UIView *) arr index:(NSInteger) index{
    
    arr.tag=index;   //设置传递的参数
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuAction:)];
    //    tableViewGesture.view.tag=index;
    arr.userInteractionEnabled=YES;
    [arr addGestureRecognizer:tableViewGesture];
    
}


-(void)menuAction:(id)sender{
    
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    
    UIView *views = (UIView*) tap.view;
    
    NSUInteger index = views.tag;   //获取上面view设置的tag
    
    
    if(index==1){
        NSInteger isvis=1;
        if(isvis==1){
            // 加载网络图片
            NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
            //            UIImageView *imageView = [self.view viewWithTag:100];
            MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
            browseItem.bigImageUrl =[self.itemMsg valueForKey:@"msg_content"] ;// 加载网络图片大图地址
            browseItem.smallImageView =_ImageView;// 小图
            [browseItemArray addObject:browseItem];
            MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:0];
            //    bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
            [bvc showBrowseViewController];
        }else{
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"开通会员即可查看所有图片,是否开通会员?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *qx=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *qd=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                VIPViewController *vip=[[VIPViewController alloc]init];
                
                [self.controller.navigationController pushViewController:vip animated:YES];
                
            }];
            
            [alert addAction:qx];
            [alert addAction:qd];
            [self.controller presentViewController:alert animated:YES completion:nil];
        }
        
        
    }else if(index==2){  //音频
     [_cellDelete cellClick:5 isright:0 object:self.itemMsg];
    
        
        [self.ImageView startAnimating];
        
    }else if(index==3){
        [_cellDelete cellClick:2 isright:0 object:self.itemMsg];
    }
}





//更新消息约束
-(void)setupMessageConstraint:(CGSize) imgsize{
    CGFloat hg=imgsize.height;
    CGFloat wd=imgsize.width;
    
    CGFloat max_wd=MessageMaxWidth;
    CGFloat max_hg=MessageMaxWidth;
    
    if(hg>wd){   //垂直
        CGFloat bl=wd/hg;
        if(hg>max_hg){
            hg=max_hg;
            wd=max_hg*bl;
        }
        
    }else if(hg<wd){ //水平
        CGFloat bl=wd/hg;  //1.5
        if(wd>max_wd){
            wd=max_wd;
            hg=max_wd/bl;
        }
    }else{  //正方形
        if(hg>max_wd){
            hg=max_wd;
            wd=max_wd;
        }
    }
    
    
    [self.content_View mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.Tx_img).offset(5);
//        make.right.equalTo(_Tx_img.mas_left).offset(-20);
        
//        make.height.lessThanOrEqualTo(@30);
        make.size.mas_equalTo(CGSizeMake(wd, hg));
//        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    
    
    
//    [self.msg_bg_img mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.content_View).offset(-5);
//        make.left.equalTo(self.content_View).offset(-5);
//        make.right.equalTo(self.content_View).offset(10);
//        make.bottom.equalTo(self.content_View).offset(5);
//        
//        
//    }];
    
    
  
    
    // 通知需要更新约束，但是不立即执行
    [self setNeedsUpdateConstraints];
    // 立即更新约束，以执行动态变换
    // update constraints now so we can animate the change
    [self updateConstraintsIfNeeded];
    
    [self setNeedsLayout];

    
    
}


-(void)createView{
   self.contentView.backgroundColor=[UIColor colorWithHexString:@"#ebebeb"];
    //初始化
    _Tx_img=[[UIImageView alloc]init];
    _msg_bg_img=[[UIImageView alloc]init];
    _content_View=[[UIView alloc]init];
    _time_label=[[UILabel alloc]init];
    _time_label.font=[UIFont systemFontOfSize:12];
    _time_label.textColor=[UIColor colorWithHexString:@"#999999"];
    
    _Tx_img.layer.cornerRadius = 22.5;
    [_Tx_img.layer setMasksToBounds:YES];
    _Tx_img.contentMode=UIViewContentModeScaleAspectFill;
    
    
    
    //设置图片
    UIImage *bg=[UIImage imageNamed:@"icon_qpl"];
    UIImage*newImageTest = [bg stretchableImageWithLeftCapWidth:20 topCapHeight:30];
    _msg_bg_img.image=newImageTest;
    
    
    //添加到view里面
    [self.contentView addSubview:_Tx_img];
    [self.contentView addSubview:_msg_bg_img];
    [self.contentView addSubview:_content_View];
     [self.contentView addSubview:_time_label];
    //先设置一个初始约束
    [_Tx_img mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    
    
    
    [self.content_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.Tx_img).offset(5);
        make.right.equalTo(_Tx_img.mas_left).offset(-25);
        make.height.lessThanOrEqualTo(@30);
        make.size.mas_equalTo(CGSizeMake(150, 150));
        make.bottom.equalTo(self.contentView).offset(-20);
    }];
    
    
    
    [self.msg_bg_img mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.content_View).offset(-5);
        make.left.equalTo(self.content_View).offset(-10);
        make.right.equalTo(self.content_View).offset(15);
        make.bottom.equalTo(self.content_View).offset(10);
        
        
    }];
    
    
    [_time_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.Tx_img);
        make.right.equalTo(self.msg_bg_img.mas_left).offset(-5);
    }];
    
    
    //默认这个为隐藏
    [_time_label setHidden:YES];
    
    
    //设置监听
    
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
