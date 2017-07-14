//
//  MainTabBarController.m
//  QsQ
//
//  Created by 张小明 on 2017/3/24.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "MainTabBarController.h"

#import "BaseNavigationController.h"
#import "TabModel.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"路过");
    [self setupAllChildViewControllers];
//     [self.navigationController popToRootViewControllerAnimated:YES];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifAction:) name:@"msg" object:nil];
    
    
    
}
-(void)notifAction:(id)sender{   //消息通知的处理
    NSLog(@"收到通知-->%@",sender);
    
    
    
    
    //    [self.onlineBtn setTitle:@"校长" forState:UIControlStateNormal];
    //
    //    self.label.text=@"哈哈哈哈";
    
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"name" object:nil] ;  //移除通知
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];

}
#pragma mark -初始化所有的子控制器

- (void)setupAllChildViewControllers
{
    //设置底部文字选中颜色
    self.tabBar.tintColor = [UIColor colorWithHexString:@"#2fb9c3"];
    //设置底部文字未选中颜色
    self.tabBar.unselectedItemTintColor=[UIColor colorWithHexString:@"#999999"];
    //设置底部导航栏颜色
    self.tabBar.barTintColor=[UIColor blackColor];
    
    //获取tabbar的分页数据信息,初始化所有底部控制器
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"tabbar" ofType:@"plist"];
    NSArray *dataTabbar = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    NSMutableArray *tabbarArray = [TabModel mj_objectArrayWithKeyValuesArray:dataTabbar];
    
    
    
    
    
    for (int i = 0; i<tabbarArray.count; i++) {
        
        TabModel *model = tabbarArray[i];
        NSLog(@"vctitle%@,vcname%@,selectimg%@,img%@",model.VcTitle,model.VcName,model.SelectImgName,model.ImgName);
        [self setupControllersWithClass:model.VcName title:model.VcTitle image:model.ImgName seletedImage:model.SelectImgName  NibName:nil];
    }
    
}

#pragma mark - 添加一个子控制器
/**
 *  初始化一个子控制器
 *
 *  @param class                子控制器
 *  @param image             图标
 *  @param selectedImage     选中图标
 *  @param title 标题
 */
- (void)setupControllersWithClass:(NSString*)class title:(NSString *)title image:(NSString*)image seletedImage:(NSString *)selectedImage NibName:(NSString *)name{
    UIImage *nomor_image=[UIImage imageNamed:image];
        UIImage *select_image=[UIImage imageNamed:selectedImage];
    //创建子导航控制器、Controller控制器
    UIViewController *vc = [[[NSClassFromString(class) alloc] init] initWithNibName:name bundle:nil];
    
    BaseNavigationController *na = [[BaseNavigationController alloc]initWithRootViewController:vc];
   

    vc.navigationItem.title = title;
    na.tabBarItem.title = title;
    na.tabBarItem.image = [nomor_image  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    na.tabBarItem.selectedImage = [select_image  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:na];
    
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
