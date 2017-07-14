//
//  SearchView.m
//  TalkQQ
//
//  Created by 张小明 on 2017/7/10.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "SearchView.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#import "UIColor+Hex.h"

@implementation SearchView


-(instancetype)initWithFrame:(CGRect)frame{

    self =[super initWithFrame:frame];
    if(self ){
        [self ceateView];
        self.userArr=[[NSMutableArray alloc]init];
        _findUserArr=[[NSMutableArray alloc]init];
         [self addUserView];
       
    }
    return self;
}

-(void)ceateView{
   
    
    
    for (CGFloat i=1; i<=5; i++) {
         CGFloat sx=1.5; //缩小系数
        
         CAShapeLayer *sp=[[CAShapeLayer alloc]init];
         UIColor *clo=[UIColor colorWithHexString:@"#ffffff" alpha:0.3*((5-i)/5)>0.05?0.3*((5-i)/5):0.05];
         sp.backgroundColor=clo.CGColor;
         sp.position=CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2);
        if(i==1){
         sp.bounds=CGRectMake(0, 0, self.bounds.size.width*(i/5), self.bounds.size.width*(i/5));
            sp.masksToBounds=YES;
            sp.cornerRadius=self.bounds.size.width*(i/5)/2;
        }else{
         sp.bounds=CGRectMake(0, 0, self.bounds.size.width*(i/5)/sx, self.bounds.size.width*(i/5)/sx);
            sp.masksToBounds=YES;
            sp.cornerRadius=self.bounds.size.width*(i/5)/2/sx;
        }
        
        
        
        
        int j=(int)i;
        
        switch (j) {
            case 1:
                self.layer1=sp;
              
                [self.layer addSublayer:self.layer1];
                break;
            case 2:
                self.layer2=sp;
                [self.layer addSublayer:self.layer2];
                break;
            case 3:
                self.layer3=sp;
                [self.layer addSublayer:self.layer3];
                break;
            case 4:
                self.layer4=sp;
                [self.layer addSublayer:self.layer4];
                break;
            case 5:
                self.layer5=sp;
                [self.layer addSublayer:self.layer5];
                break;
            default:
                break;
        }
    }
    
    
    
//创建最中间的的用户头像
    CGFloat x=self.bounds.size.width/2.f;
    CGFloat y=self.bounds.size.width/2.f;
    CGFloat w=self.bounds.size.width*0.14;
    CGFloat h=self.bounds.size.width*0.14;
    
    
   UIImageView* ig=[[UIImageView alloc]init];
    ig.image=[UIImage imageNamed:@"icon_mor"];
    
   
    
    ig.center=CGPointMake(x, y);
    ig.bounds=CGRectMake(0, 0, w, h);
   
     [self addSubview:ig];

    
    NSString *userid=[[NSUserDefaults standardUserDefaults] valueForKey:@"id"];
    NSDictionary *user_data=  [[FMDConfig sharedInstance] getUserInfoWithId:userid];
    NSString *url=[user_data valueForKey:@"iconUrl"];
    

    if(url==NULL){
        ig.image=[UIImage imageNamed:@"icon_mor"];
    }else{
        [ig sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon_mor"]];
    }
    
    
    ig.layer.masksToBounds=YES;
    ig.layer.cornerRadius=self.bounds.size.width*0.14/2;
    

   
    
 
}


-(void)setUserInfo{



}

-(void)hidenAllUserView{
  
    [self.userArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *objImg=obj;
        [objImg setHidden:YES];
    }];
}


-(void)addUserView{
    CGFloat scre=1.2f;
    
    
    
    CGFloat temp=self.center.x/5;
    
    NSLog(@"temep=%f",self.layer1.position.x);
    
    UIImageView *img1=[[UIImageView alloc]init];
    CALayer * sh=img1.layer;
    sh.position=CGPointMake(temp, self.bounds.size.height/2);
    sh.bounds=CGRectMake(0, 0, temp, temp);
    sh.masksToBounds=YES;
    sh.cornerRadius=temp/2;
    sh.backgroundColor=[UIColor redColor].CGColor;
    [self.layer addSublayer:sh];
    
    UIImageView *img2=[[UIImageView alloc]init];
    CALayer * sh2=img2.layer;
  
    sh2.position=CGPointMake(temp*5-(cos(45)*temp*4),temp*5-(sin(45)*temp*4));
    sh2.bounds=CGRectMake(0, 0, temp*scre, temp*scre);
    sh2.masksToBounds=YES;
    sh2.cornerRadius=temp*scre/2;
    sh2.backgroundColor=[UIColor redColor].CGColor;
    [self.layer addSublayer:sh2];
    
    UIImageView *img3=[[UIImageView alloc]init];
    CALayer * sh3=img3.layer;
    sh3.position=CGPointMake(temp*5-cos(45)*temp*4,temp*5+cos(45)*temp*4);
    sh3.bounds=CGRectMake(0, 0, temp, temp);
    sh3.masksToBounds=YES;
    sh3.cornerRadius=temp/2;
    sh3.backgroundColor=[UIColor redColor].CGColor;
    [self.layer addSublayer:sh3];
   
    scre=1.1f;
    UIImageView *img4=[[UIImageView alloc]init];
    CALayer * sh4=img4.layer;
    sh4.position=CGPointMake(temp*3,temp*5);
    sh4.bounds=CGRectMake(0, 0, temp*scre, temp*scre);
    sh4.masksToBounds=YES;
    sh4.cornerRadius=temp*scre/2;
    sh4.backgroundColor=[UIColor redColor].CGColor;
    [self.layer addSublayer:sh4];
    
    scre=1.1f;
    UIImageView *img5=[[UIImageView alloc]init];
    CALayer * sh5=img5.layer;
    sh5.position=CGPointMake(temp*5,temp*3);
    sh5.bounds=CGRectMake(0, 0, temp*scre, temp*scre);
    sh5.masksToBounds=YES;
    sh5.cornerRadius=temp*scre/2;
    sh5.backgroundColor=[UIColor redColor].CGColor;
    [self.layer addSublayer:sh5];
    
    
    NSLog(@"sin==%f",sin(30)*temp*2);
    
    scre=0.9f;
    UIImageView *img6=[[UIImageView alloc]init];
    CALayer * sh6=img6.layer;
    sh6.position=CGPointMake(temp*5-(sin(60)*temp*2),temp*5-temp*2*sin(30));
    sh6.bounds=CGRectMake(0, 0, temp*scre, temp*scre);
    sh6.masksToBounds=YES;
    sh6.cornerRadius=temp*scre/2;
    sh6.backgroundColor=[UIColor redColor].CGColor;
    [self.layer addSublayer:sh6];
    
    
    scre=1.2f;
    UIImageView *img7=[[UIImageView alloc]init];
    CALayer * sh7=img7.layer;
    sh7.position=CGPointMake(temp*5+(sin(45)*temp*3),temp*5-temp*3*cos(45));
    sh7.bounds=CGRectMake(0, 0, temp*scre, temp*scre);
    sh7.masksToBounds=YES;
    sh7.cornerRadius=temp*scre/2;
    sh7.backgroundColor=[UIColor redColor].CGColor;
    [self.layer addSublayer:sh7];
    
    scre=0.9f;
    UIImageView *img8=[[UIImageView alloc]init];
    CALayer * sh8=img8.layer;
    sh8.position=CGPointMake(temp*9,temp*5);
    sh8.bounds=CGRectMake(0, 0, temp*scre, temp*scre);
    sh8.masksToBounds=YES;
    sh8.cornerRadius=temp*scre/2;
    sh8.backgroundColor=[UIColor redColor].CGColor;
    [self.layer addSublayer:sh8];
    
    
    scre=0.8f;
    UIImageView *img9=[[UIImageView alloc]init];
    CALayer * sh9=img9.layer;
    sh9.position=CGPointMake(temp*5+(cos(30)*temp*4),temp*5+(temp*4*sin(30)));
    sh9.bounds=CGRectMake(0, 0, temp*scre, temp*scre);
    sh9.masksToBounds=YES;
    sh9.cornerRadius=temp*scre/2;
    sh9.backgroundColor=[UIColor redColor].CGColor;
    [self.layer addSublayer:sh9];
    
//
    scre=1.3f;
    UIImageView *img10=[[UIImageView alloc]init];
    CALayer * sh10=img10.layer;
    sh10.position=CGPointMake(temp*5+(sin(45)*temp*4),temp*5+(temp*4*cos(45)));
    sh10.bounds=CGRectMake(0, 0, temp*scre, temp*scre);
    sh10.masksToBounds=YES;
    sh10.cornerRadius=temp*scre/2;
    sh10.backgroundColor=[UIColor redColor].CGColor;
    [self.layer addSublayer:sh10];
    
    
    
    [self.userArr addObject:img1];
    [self.userArr addObject:img2];
    [self.userArr addObject:img3];
    [self.userArr addObject:img4];
    [self.userArr addObject:img5];
    [self.userArr addObject:img6];
    [self.userArr addObject:img7];
    [self.userArr addObject:img8];
    [self.userArr addObject:img9];
    [self.userArr addObject:img10];

    
 
    
    [self hidenAllUserView];
    
}

//获取五个随机数
//n为要随机出来的个数
//max最大范围
//min 为最小范围
+(NSMutableArray*)getFiveNum:(NSInteger)n max:(NSInteger)max min:(NSInteger)min{
  
    
    NSMutableArray *fiveArr=[[NSMutableArray alloc]init];;
    
    NSInteger count=0;
    while(count<n){
        BOOL flg=true;
        //获取0-10的随机数
        NSInteger num= arc4random()%(max - min) + min;
        
        if(fiveArr.count==0){
            flg=true;
//            break;
        }else{
            for(int j=0;j<fiveArr.count;j++){
                
                
                NSString *ob=fiveArr[j];
                
                NSInteger b=[ob integerValue];
                if(num==b){
                    flg=false;
                    break;
                }
                
                
            }
        }
        
        if(flg){
            count++;
            [fiveArr addObject:[NSString stringWithFormat:@"%lu",num]];
        }
        
    }
    
    return fiveArr;


}
-(void)showUser{
    [self.findUserArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     UIImageView *img=obj;
     [img setHidden:NO];
 }];

}
-(void)setUserImgUrl:(NSArray *)dir{

    [_findUserArr removeAllObjects];
   NSArray *arr= [SearchView getFiveNum:5 max:10 min:1];
    
    
    for(int i=0;i<arr.count;i++){
        NSString *url=[dir[i] valueForKey:@"iconUrl"];
        
        UIImageView *img= [self.userArr objectAtIndex:[arr[i]integerValue]];
        [_findUserArr addObject:img];
        [img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon_mor"]];
        
        [img setHidden:YES];
    }
    
    


}

//开始动画
-(void)startHh:(NSInteger)count dict:(CGFloat)dict{

    
    CABasicAnimation *ani=[[CABasicAnimation alloc]init];
    ani.keyPath=@"transform.scale";
    ani.toValue=[NSNumber numberWithFloat:1.5];
    ani.fromValue=[NSNumber numberWithFloat:0.8f];

    ani.duration=dict;
    ani.removedOnCompletion = NO;
    ani.repeatCount=count;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.75 :0.75 :1.5 :1.5];

    [self.layer2 addAnimation:ani forKey:nil];
    [self.layer3 addAnimation:ani forKey:nil];
    [self.layer4 addAnimation:ani forKey:nil];
    [self.layer5 addAnimation:ani forKey:nil];
    
    
   
}
-(void)stopHh{
    
    [self hidenAllUserView];
    
    
    [self.layer1 removeAllAnimations];
    [self.layer2 removeAllAnimations];
    [self.layer3 removeAllAnimations];
    [self.layer4 removeAllAnimations];
    [self.layer5 removeAllAnimations];
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    //得到绘图对象,类似于画笔
//    CGContextRef ctx=UIGraphicsGetCurrentContext();
//    CGFloat px=0;
//    CGFloat py=0;
//    CGFloat pw=0;
//    CGFloat ph=0;
//    
//    //画出五个实心圆
//    for (CGFloat i=1; i<=self.maxNum; i++) {
//      
//         px=(5-i)/5*(SCREEN_WIDTH/2);
//         py=(5-i)/5*(SCREEN_WIDTH/2);
//         pw=SCREEN_WIDTH*(i/5);
//         ph=SCREEN_WIDTH*(i/5);
//        
//        UIImage *user=[UIImage imageNamed:@"icon_nan"];
//        
//        [user drawInRect:CGRectMake(SCREEN_WIDTH/2-25, SCREEN_WIDTH/2-25, 50, 50)];
//        
//        
//        //画出实心圆
//        CGContextAddEllipseInRect(ctx, CGRectMake(px, py, pw, ph));
//
//        UIColor *clo=[UIColor colorWithHexString:@"#ffffff" alpha:0.4*((5-i)/5)>0.1?0.4*((5-i)/5):0.1];
//        
//        //设置颜色
//        [clo set];
//        //渲染出图形
//        CGContextFillPath(ctx);
//    }
//    
//   
//}
@end
