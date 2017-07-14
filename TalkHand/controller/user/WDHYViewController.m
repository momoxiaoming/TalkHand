//
//  WDHYViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/4/25.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "WDHYViewController.h"

@interface WDHYViewController ()
@property UIWebView * web;
@end

@implementation WDHYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"超级会员";
    [self initView];
    [self initData];
    //防止导航栏遮住控件
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{


}


-(void)initData{
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.web loadRequest:request];

}

-(void)initView{
    _web=[[UIWebView alloc]init];
    
    
    [self.view addSubview:_web];
    
    
    [_web mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
