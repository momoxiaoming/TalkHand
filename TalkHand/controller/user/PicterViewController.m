//
//  PicterViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/6/9.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "PicterViewController.h"

@interface PicterViewController ()

@end

@implementation PicterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView  * bgview=[[UIImageView alloc] initWithFrame:self.view.bounds];
//    bgview.contentMode =UIViewContentModeCenter;
    [bgview sd_setImageWithURL:[NSURL URLWithString:self.url]];
    
//    UIPress * press=[[UIPress alloc]init];
//    [bgview sd_setImageWithURL:[NSURL URLWithString:self.url] placeholderImage:[UIImage imageNamed:@"icon_mor"] options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        NSLog(@"%lu",receivedSize);
//        
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        bgview.image=image;
//    }];
    
    self.view.backgroundColor=[UIColor blackColor];
    
    [self.view addSubview:bgview];
    
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
