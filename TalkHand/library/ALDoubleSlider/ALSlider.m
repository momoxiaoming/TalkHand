//
//  ALSlider.m
//  JLDoubleSliderDemo
//
//  Created by 张小明 on 2017/6/17.
//  Copyright © 2017年 linger. All rights reserved.
//
// 注意,这里有个缺陷,使用自定义布局之后,我们就无法正常获取组件的坐标值了,需要手动计算坐标,但是好处在于,外部控制器使用该自定义view的时候,也可以使用自定义布局进行布局.
//  假如我们这里上课用fram来布局,组件可以自动获取宽高,但是外部控制器引用该组件的时候,就无法使用自定义布局了,也必须使用fram来布局确定边界
//
#import "ALSlider.h"
#import "UIView+Dimension.h"
@interface ALSlider ()

#define maxHeight 40
#define defult_maxNum 100
#define defult_minNum 0

@property (nonatomic) UIView * mainLine;

@property UILabel * minNum;

@property UILabel * maxNum;


@property NSInteger min_X;

@property NSInteger max_X;

@property UIButton *minBtn;

@property UIButton *maxBtn;

@property NSInteger minIndex;

@property NSInteger maxIndex;

//记录最小滑块初始坐标
@property CGPoint startMinPoint;



//记录最大滑块初始坐标
@property CGPoint startMaxPoint;


@end


@implementation ALSlider


+(instancetype)initWithFrameIndex:(CGRect)frame setminIndex:(NSInteger)minIndex setMaxIndex:(NSInteger)maxIndex{
    
//    self =[super init];
//    
//    if (self) {
//        
//        [self createView];
//        
//        self.minIndex=defult_minNum;
//        self.maxIndex=defult_maxNum;
//    }
//    
    return nil;

}

- (id)initWithFrame:(CGRect)frame

{
    self =[super initWithFrame:frame];
    
    if (self) {
        
        [self createView];
        
        self.minIndex=defult_minNum;
        self.maxIndex=defult_maxNum;
    }
    
    return self;
   
    
}
//
//-(instancetype)initWithFrame:(CGRect)frame{
//    self=[super initWithFrame:frame];
//    if (self) {
////        if (frame.size.height < 80.0f) {
////            self.height = 80.0f;
////        }
//        self=[[ALSlider alloc]initWithFrame:frame];
//    }
//    
//    [self createView];
//
//    return self;
//}

-(void)setMinIndex:(NSInteger )minIndex setMaxIndex:(NSInteger )maxIndex{
    self.minIndex=minIndex;
    self.maxIndex=maxIndex;
    self.minNum.text=[NSString stringWithFormat:@"%lu",minIndex];
    self.maxNum.text=[NSString stringWithFormat:@"%lu",maxIndex];
//    NSLog(@"%f",  self.mas_width.view.bounds.size.width);
    
}


-(void)createView{
    
    self.minNum=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
        [self addSubview:self.minNum ];
    self.maxNum=[[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width-30, self.minNum.bounds.origin.y, 30, 20)];
  [self addSubview:self.maxNum];
    self.maxNum.textAlignment=NSTextAlignmentCenter;
    self.minNum.textAlignment=NSTextAlignmentCenter;
    
//    self.minNum.backgroundColor=[UIColor blueColor];
//    self.maxNum.backgroundColor=[UIColor blueColor];
    
    self.minNum.text=[NSString stringWithFormat:@"%i",defult_minNum];
    
    self.maxNum.text=[NSString stringWithFormat:@"%i+",defult_maxNum];
    self.minNum.font=[UIFont systemFontOfSize:12];
    self.minNum.textColor=[UIColor blackColor];
    self.maxNum.textColor=[UIColor blackColor];
    self.maxNum.font=[UIFont systemFontOfSize:12];


    _mainLine=[[UIView alloc] initWithFrame:CGRectMake(self.minNum.bounds.size.width, self.minNum.bounds.origin.y+self.minNum.bounds.size.height/2, self.bounds.size.width-self.minNum.bounds.size.width-self.maxNum.bounds.size.width, 2)];
    _mainLine.backgroundColor=[UIColor blackColor];
    
     [self addSubview:_mainLine];
    
    
  
  
    
//    [self.minNum mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(5);
//        make.left.equalTo(self);
//        make.size.mas_equalTo(CGSizeMake(30, 20));
//    }];
//    [self.maxNum mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self);
//        make.centerY.equalTo(self.minNum);
//        make.size.mas_equalTo(CGSizeMake(30, 20));
//    }];
//    [self.mainLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.minNum.mas_right).offset(10);
//        make.right.equalTo(self.maxNum.mas_left).offset(-10);
//        make.centerY.equalTo(self.minNum);
//        make.size.mas_equalTo(CGSizeMake(self.bounds.size.width-50,2));
//    }];

    
    NSLog(@"最小--%f",self.mainLine.bounds.origin.x);
    
    UIButton *minbtn = [[UIButton alloc]initWithFrame:CGRectMake(self.minNum.bounds.size.width, self.minNum.bounds.origin.y, 20, 20)];
    minbtn.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    minbtn.showsTouchWhenHighlighted = YES;
    minbtn.layer.cornerRadius =minbtn.bounds.size.width/2;
    minbtn.layer.masksToBounds = YES;
    minbtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    minbtn.layer.borderWidth = 0.5;
    UIPanGestureRecognizer *minSliderButtonPanGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panMinSliderButton:)];
    [minbtn addGestureRecognizer:minSliderButtonPanGestureRecognizer];
    [self addSubview:minbtn];
    
//   [minbtn mas_makeConstraints:^(MASConstraintMaker *make) {
//       make.centerY.equalTo(self.minNum);
//       make.centerX.equalTo(self.mainLine.mas_left);
//       make.size.mas_equalTo(CGSizeMake(20, 20));
//   }];
//    
    
    UIButton *maxBtn =[[UIButton alloc]initWithFrame:CGRectMake(self.minNum.bounds.size.width+self.mainLine.bounds.size.width-20, self.minNum.bounds.origin.y, 20, 20)];
    maxBtn.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    maxBtn.showsTouchWhenHighlighted = YES;
    maxBtn.layer.cornerRadius =maxBtn.bounds.size.width/2;
    maxBtn.layer.masksToBounds = YES;
    maxBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    minbtn.layer.borderWidth = 0.5;
    UIPanGestureRecognizer *maxSliderButtonPanGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panMaxSliderButton:)];
    [maxBtn addGestureRecognizer:maxSliderButtonPanGestureRecognizer];
    
    [self addSubview:maxBtn];
    
//    [maxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.minNum);
//        make.centerX.equalTo(self.mainLine.mas_right);
//       
//        make.size.mas_equalTo(CGSizeMake(20, 20));
//    }];

    
    self.maxBtn=maxBtn;
    self.minBtn=minbtn;
   

    
    self.startMinPoint=self.minBtn.center;
    self.startMaxPoint=self.maxBtn.center;
   
}



-(void)panMinSliderButton:(UIPanGestureRecognizer *)sender{
   
     CGPoint point = [sender translationInView:self]; //绑定参考的视图坐标系

    NSLog(@"%f",point.x);
    static CGPoint leftPoint;
 
    if(sender.state==UIGestureRecognizerStateBegan){
        leftPoint=sender.view.center;
    
    }
    
    sender.view.center=CGPointMake(point.x+leftPoint.x, self.startMinPoint.y);
 
        if(sender.view.left<self.mainLine.left){
           sender.view.left=self.mainLine.left;
            
        }else {
            if(sender.view.right>self.maxBtn.left){
                sender.view.right=self.maxBtn.left;
             }
        }
    
    
    [self changMinText:sender.view.center setIndex:1];


   
}


-(void)panMaxSliderButton:(UIPanGestureRecognizer *)sender{
    CGPoint point = [sender translationInView:self]; //绑定参考的视图坐标系
    
    NSLog(@"%f",point.x);
    static CGPoint rightPoint;
    
    if(sender.state==UIGestureRecognizerStateBegan){
        rightPoint=sender.view.center;
        
    }
    
    sender.view.center=CGPointMake(point.x+rightPoint.x, self.startMaxPoint.y);
    
    if(sender.view.right>self.mainLine.right){
        sender.view.right=self.mainLine.right;
        
    }else {
        if(sender.view.left<self.minBtn.right){
            sender.view.left=self.minBtn.right;
        }
    }
    
    
    [self changMinText:sender.view.center setIndex:2];
    
}


-(void)changMinText:(CGPoint) centerPoint setIndex:(NSInteger) orer{
    
    NSInteger index=self.maxIndex-self.minIndex;
    
    CGFloat maxLin=self.mainLine.width-self.minBtn.width/2-self.maxBtn.width/2;
    
    
    
    if(orer==1){
        CGFloat removeIndex=centerPoint.x-self.startMinPoint.x;
        
        CGFloat bs=removeIndex/maxLin;
        
        CGFloat endIndex=bs*index;
        
        NSLog(@"移动的index-->%f",endIndex);
      
        NSInteger result=[[NSNumber numberWithFloat:endIndex] integerValue]+self.minIndex;
        
        self.minNum.text=[NSString stringWithFormat:@"%lu",result];
    }else{
        CGFloat removeIndex=self.startMaxPoint.x-centerPoint.x;
        
        CGFloat bs=removeIndex/maxLin;
        
        CGFloat endIndex=bs*index;
        
        NSLog(@"移动的index-->%f",endIndex);
        
           NSInteger result=self.maxIndex-[[NSNumber numberWithFloat:endIndex] integerValue];
        
        self.maxNum.text=[NSString stringWithFormat:@"%lu+",result];
    }
    
    
    
    
    
}
-(NSString *)getAgeSection{
   
    NSString * min=self.minNum.text;
    NSString * max=self.maxNum.text;

   NSString * max_value= [max substringWithRange:NSMakeRange(0, 2)];
    
    return [NSString stringWithFormat:@"%@,%@",min,max_value];
    
    
   

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
