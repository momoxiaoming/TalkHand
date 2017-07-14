//
//  UserInfoMenu.m
//  QsQ
//
//  Created by 张小明 on 2017/3/30.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "UserInfoMenu.h"
typedef CGFloat (^EasingFunction)(CGFloat, CGFloat, CGFloat, CGFloat);

#define kAnimationDelay 0.03
@implementation UserInfoMenu

-(id)initItemsAndBaseView:(NSArray *)items Cgrect:(CGRect )cgrect{
    self = [super initWithFrame:CGRectZero];
    if (self) {
//        self.Baseview=baseview;
        self.rect=cgrect;
        self.interval=5;
        self.items=items;
        
    }
    return self;
}



-(void)OpenMenu{
    _isOpen=YES;

    [self.items enumerateObjectsUsingBlock:^(UIView* item, NSUInteger idx, BOOL *  stop) {
        NSInteger temp;
        NSInteger index=  fmod(self.items.count, 2);
        NSInteger index_=index-idx;
        if(index_>0){
            temp=index_+index;
        }else if(index_==0){
            temp=index;
           
        }else{
             temp=index_+index;
        }
           [self performSelector:@selector(showItem:) withObject:item afterDelay:kAnimationDelay * temp];
    }];
    
    
}
-(void)CloseMenu{
    _isOpen=NO;
    [self.items enumerateObjectsUsingBlock:^(UIView* item, NSUInteger idx, BOOL *  stop) {
        
        [self performSelector:@selector(hideItem:) withObject:item afterDelay:kAnimationDelay * idx];
    }];
    
    
    
}
- (void)hideItem:(UIView *)item {
    CGPoint position = item.layer.position;
    
   position.x=self.rect.size.width/2;
        position.y += 0;
        
        [self animateLayer:item.layer
               withKeyPath:@"position.y"
                        to:position.y];
    
    
    item.layer.position = position;
    
    
    
    [item.layer performSelector:@selector(setOpacity:) withObject:[NSNumber numberWithFloat:0.0f] afterDelay:0.03f];
}


- (void)showItem:(UIView *)item {
    NSLog(@"showItem");
     NSLog(@"空键坐标%f-->",item.layer.bounds.origin.x);
    [NSObject cancelPreviousPerformRequestsWithTarget:item.layer];
    item.layer.opacity = 1.0f;
    
    CGPoint position = item.layer.position;
    position.x=self.rect.size.width/2;
    position.y +=0;
    
    [self animateLayer:item.layer
           withKeyPath:@"position.y"
                    to:position.y];
    item.layer.position = position;
    
    
    
    
}

- (void)setItems:(NSArray *)items {
    NSLog(@"setItems");
    // Remove all current items in case we are changing the menu items.
    for (UIView *item in items) {
        item.layer.opacity = 0;
        [item removeFromSuperview];
    }
    
    _items = items;

    
    for (UIView *item in items) {
        [self addSubview:item];
    }
}

-(void)layoutSubviews{
      [super layoutSubviews];
      NSLog(@"layoutSubviews");
    self.menuWidth=0;
    self.menuHeight=0;
    
    CGFloat __block bsHeight=0;
    
    [self.items enumerateObjectsUsingBlock:^(UIView* item, NSUInteger idx, BOOL *  stop) {
        self.menuWidth=MAX(self.menuWidth, item.bounds.size.width);
        bsHeight=MAX(bsHeight, item.bounds.size.height);
        
        self.menuHeight=bsHeight*self.items.count+ self.interval*(self.items.count-1);
    }];
    
    CGFloat x=0;
    CGFloat y=0;    //
    CGFloat centerX=0;   //中心点的x坐标
    x= self.rect.origin.x;
    NSLog(@"基准的y坐标%f--",self.rect.origin.y);
    y=self.rect.origin.y-self.menuHeight-self.interval;  //y坐标设为基准view的
    self.frame=CGRectMake(x, y, self.rect.size.width,self.menuHeight);  //宽度设为基准view的宽度
    centerX=self.rect.origin.x+self.rect.size.width/2;
    //便利所有位置
    [self.items enumerateObjectsUsingBlock:^(UIView * item, NSUInteger idx, BOOL *  stop) {
        [item setCenter:CGPointMake(centerX, self.interval*idx+bsHeight/2+idx*bsHeight)];
    }];
    
    NSLog(@"%f-%f-%f--%f",x,y,self.bounds.size.width,self.bounds.size.height);
//    self.backgroundColor=[UIColor redColor];
    
    
}


#pragma mark - Animation

- (void)animateLayer:(CALayer *)layer
         withKeyPath:(NSString *)keyPath
                  to:(CGFloat)endValue {
    
    CGFloat startValue = [[layer valueForKeyPath:keyPath] floatValue];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = 1.3f;
    
    
    CGFloat steps = 100;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:steps];
    CGFloat delta = endValue - startValue;
    EasingFunction function = easeOutElastic;
    
    for (CGFloat t = 0; t < steps; t++) {
        [values addObject:@(function(animation.duration * (t / steps), startValue, delta, animation.duration))];
    }
    
    animation.values = values;
    [layer addAnimation:animation forKey:nil];
}

static EasingFunction easeOutElastic = ^CGFloat(CGFloat t, CGFloat b, CGFloat c, CGFloat d) {
    CGFloat amplitude = 5;
    CGFloat period = 0.6;
    CGFloat s = 0;
    if (t == 0) {
        return b;
    }
    else if ((t /= d) == 1) {
        return b + c;
    }
    
    if (!period) {
        period = d * .3;
    }
    
    if (amplitude < fabs(c)) {
        amplitude = c;
        s = period / 4;
    }
    else {
        s = period / (2 * M_PI) * sin(c / amplitude);
    }
    
    return (amplitude * pow(2, -10 * t) * sin((t * d - s) * (2 * M_PI) / period) + c + b);
};

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
