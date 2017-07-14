//
//  SeleView.m
//  QsQ
//
//  Created by 张小明 on 2017/4/18.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "SeleView.h"

@implementation SeleView

-(instancetype)initColor:(UIColor *) bgcolor PresColor:(UIColor *) prescolor{
    self=[super init];
    if (self) {
        self=[[SeleView alloc]init];
        self.backgroundColor=bgcolor;
        self.normcolor=bgcolor;
        self.prescolor=prescolor;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    UILongPressGestureRecognizer *tapRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(changeColor:)];
    tapRecognizer.minimumPressDuration = 0;//Up to you;
    tapRecognizer.cancelsTouchesInView = NO;
    tapRecognizer.delegate = self;
    [self addGestureRecognizer:tapRecognizer];
}

-(void) changeColor:(UIGestureRecognizer *)gestureRecognizer{
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
      
        self.backgroundColor = self.prescolor;
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        self.backgroundColor = self.normcolor;
    }
}


//下面三个函数用于多个GestureRecognizer 协同作业，避免按下的手势影响了而别的手势不响应
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
