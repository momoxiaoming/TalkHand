//
//  ExpView.m
//  QsQ
//
//  Created by 张小明 on 2017/6/28.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "ExpView.h"
#import "FaceCell.h"
#import "Face_1_view.h"
#import "XMNChatExpressionManager.h"
@implementation ExpView


-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{

    return nil;
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    return nil;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if(self){
         [self initData];
        [self createView];
       
    }
    return self;
}

-(void)initData{
    self.faceData=[[NSMutableArray alloc]init];
//
//   
    NSArray *array = [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"QQIconNew" ofType:@"bundle"]] pathsForResourcesOfType:@"png" inDirectory:nil];
//
//    
//    
//    NSLog(@"表情的个数-->%lu",array.count);
    
//    NSArray * aar= [XMNChatExpressionManager sharedManager].qqEmotions;
    
//    [aar enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        ns
//        
//        [self.faceData addObject:[obj.key];
//    }];
//    
    
    [self.faceData setArray:array];

}

-(void)createView{

    
    
    NSInteger page=(self.faceData.count-1)/23;
    NSInteger page2=self.faceData.count%23;
    if(page2!=0){
        page=page+1;
    }
    
    
    
    NSString * endimg=self.faceData[self.faceData.count-1];

    NSLog(@"page--%@",endimg);
    int x=0;
    
    for(int i=0;i<page;i++){
        
        if(i!=page-1){
           [self.faceData insertObject:endimg atIndex:23+x+(i*23)];
        }
        x++;
    }
   
    NSLog(@"加了后退图片的个数-->%lu",self.faceData.count);
    
    
    
    
    
    
    
    
    
    
    _scrollView=[[UIScrollView alloc]init];
    //设置内容大小,有多少页就设置屏幕宽度多少
    _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH*page, 0);
    
    //设置翻页效果，不允许反弹，不显示水平滑动条，设置代理为自己
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    
    
//    UIView *face1=[[Face_1_view alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/8*3)];
//    
//     UIView *face2=[[Face_2_view alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_WIDTH/8*3)];
    
    
//    [_scrollView addSubview:face1];
//      [_scrollView addSubview:face2];
    
    
//    初始化 UIPageControl 和 _scrollView 显示在 同一个页面中
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.numberOfPages = 6;//设置pageConteol 的page 和 _scrollView 上的图片一样多
    _pageControl.currentPage=0;
    
    _pageControl.tag = 201;
    
    
    self.sendBtn=[[UIButton alloc]init];
    self.sendBtn.backgroundColor=[UIColor colorWithHexString:@"#1082f4"];
    [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    //初始化senderButton的阴影
    self.sendBtn.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.sendBtn.layer.shadowOffset = CGSizeMake(-2, 0);
    self.sendBtn.layer.shadowOpacity = .6f;
    [self.sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lin=[[UIView alloc]init];
    lin.backgroundColor=[UIColor whiteColor];
    
    
    
    
    
    
    
    [self addSubview:lin];
    [self addSubview:self.sendBtn];
    [self addSubview:_scrollView];
 
//    [self addSubview:_collview];
    [self addSubview:_pageControl];
    
    
    
//    [_collview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(10);
//        make.right.equalTo(self);
//        make.left.equalTo(self);
//        make.bottom.equalTo(self).offset(-10);
//        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/8*3));
//    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.right.equalTo(self);
        make.left.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*page, SCREEN_WIDTH/8*3+20));
    }];
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.scrollView);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
    
    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.scrollView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.width, 0.5));
    }];
    
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.equalTo(lin.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(80, 40));
//        make.width.equalTo(@80);
      
    }];
    
    
    
    
    
    for(int i=0;i<page;i++){
        NSMutableArray *newarr=[[NSMutableArray alloc]init];
        
        for(int j=0;j<self.faceData.count;j++){
            if(j<(24+(24*i))&&j>=i*24){
              [newarr addObject:self.faceData[j]];
            }
        }
        
        
        
        Face_1_view *face1=[[Face_1_view alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_WIDTH/8*3)];
        face1.faceDelete=self;
        [face1 setIndex:i];
        [face1 setExpData:newarr];
        [_scrollView addSubview:face1];
        
        
        
    }
    
    
    
    
 
    
    
    
}


-(void)faceClick:(NSInteger)index str:(NSString *)str{
    NSLog(@"点击了图片--%@",str);
    [self.expDelete faceClick:index str:str];

}


//滚动监听
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    NSLog(@"offset--%f",offset.x);
    if(offset.x<=0){
        offset.x = 0;
        scrollView.contentOffset = offset;
    }
    NSUInteger index = round(offset.x / scrollView.frame.size.width);
    self.pageControl.currentPage = index;
}


-(void)sendAction{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"send_face" object:self];
    
    

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/





@end
