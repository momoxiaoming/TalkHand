//
//  Toast.m
//  Planning Design Survey System
//
//  Created by flame_thupdi on 13-4-21.
//  Copyright (c) 2013年 flame_thupdi. All rights reserved.
//

#import "Toast.h"
#import <QuartzCore/CALayer.h>
static Toast * _toast = nil;
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@implementation Toast

- (id)initWithText:(NSString*)text
{
    self = [super init];
    if (self) {
        _text = [text copy];
        // Initialization code
        UIFont *font = [UIFont systemFontOfSize:16];
        CGSize textSize = [_text sizeWithFont:font constrainedToSize:CGSizeMake(280, 60)];
        //leak;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, textSize.width, textSize.height)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = font;
        label.text = _text;
        label.numberOfLines = 0;
        label.shadowColor = [UIColor darkGrayColor];
        label.shadowOffset = CGSizeMake(1, 1);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        CGRect rect;
        rect.size = CGSizeMake(textSize.width + 20, textSize.height + 10);
        rect.origin = CGPointMake(SCREEN_WIDTH/2-(textSize.width + 20)/2, SCREEN_HEIGHT-30-64);
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [self setFrame:rect];
        [self addSubview:label];
    }
    return self;
}


+(Toast *)makeText:(NSString *)text{
    @synchronized(self){
        if(_toast == nil){
            _toast = [[Toast alloc]initWithText:text];
        }
    }
    return _toast;
}

-(void)showWithType:(enum TimeType)type{
    if (type == LongTime) {
        _time = 3.0f;
    }
    else{
        _time = 1.0f;
    }
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    NSTimer *timer1 = [NSTimer timerWithTimeInterval:(_time/4.0f)  target:self selector:@selector(removeToast) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:timer1 forMode:NSDefaultRunLoopMode];
    [window addSubview:self];
}

-(void)removeToast
{
    [UIView animateWithDuration:_time animations:^{
            if (_toast.alpha!=0.0f) {
                _toast.alpha -= 0.3f;
            }
        }
        completion:^(BOOL finished) {
        [_toast setAlpha:0];
        [_toast removeFromSuperview];
        _toast = nil;
        }
    ];
}

@end
