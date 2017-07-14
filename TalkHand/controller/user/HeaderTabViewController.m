//
//  HeaderTabViewController.m
//  HJTabViewControllerDemo
//
//  Created by haijiao on 2017/3/18.
//  Copyright © 2017年 olinone. All rights reserved.
//

#import "HeaderTabViewController.h"

#import "HJTabViewControllerPlugin_HeaderScroll.h"
#import "HJTabViewControllerPlugin_TabViewBar.h"
#import "HJDefaultTabViewBar.h"
#import "UserinfoHeader.h"
#import "PotoViewController.h"
#import "VideoCollectionView.h"
#import "AFHttpSessionClient.h"
#import <AVFoundation/AVFoundation.h>
#import "CompressionImge.h"
#import "UserInfoViewController.h"
@interface HeaderTabViewController () <HJTabViewControllerDataSource, HJTabViewControllerDelagate, HJDefaultTabViewBarDelegate>
@property  VideoCollectionView * videocell;
@property  PotoViewController * potocell;
@property UserinfoHeader * headerview;
@end

@implementation HeaderTabViewController

-(void)viewWillAppear:(BOOL)animated{

 self.navigationController.navigationBar.alpha =1;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //读取数据
    NSString *own = [userDefaults objectForKey:@"id"];
    NSDictionary *  posts=[[FMDConfig sharedInstance]getUserInfoWithId:own];
    if(posts){
        [self updateData:posts];
        
    }

}
-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBar.alpha =0;
    
    
    [self getUserinfo];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//     self.navigationController.navigationBar.hidden=YES;

    self.tabDataSource = self;
    self.tabDelegate = self;
    self.view.backgroundColor=[UIColor colorWithHexString:@"#ebebeb"];
    
    
    HJDefaultTabViewBar *tabViewBar = [HJDefaultTabViewBar new];
    tabViewBar.delegate = self;
    HJTabViewControllerPlugin_TabViewBar *tabViewBarPlugin = [[HJTabViewControllerPlugin_TabViewBar alloc] initWithTabViewBar:tabViewBar delegate:nil];
    [self enablePlugin:tabViewBarPlugin];
  
    [self enablePlugin:[HJTabViewControllerPlugin_HeaderScroll new]];
    
    self.navigationController.navigationBar.alpha =0;
 
    
    [self initMenu];

    
//    
//    
    
    
    
}



-(void)getUserinfo{
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    NSMutableDictionary * parm=[[NSMutableDictionary alloc]init];
    //获取NSUserDefaults对象
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    //读取数据
    NSString *own = [userDefaults objectForKey:@"id"];

    [parm setValue:own forKey:@"ownerId"];
    [parm setValue:@"" forKey:@"otherId"];

    
    [as post:getUserinfo_url parameters:parm actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
        
        NSInteger state=[posts[@"state"]integerValue];
        
       
        if(state==1){
           
            [[FMDConfig sharedInstance] saveUserInfo:posts ];
            
          [self updateData:posts];
        }else {
            posts=[[FMDConfig sharedInstance]getUserInfoWithId:own];
        
        
        }
      
        

        
    }];



}

//更新数据
-(void)updateData:(NSDictionary* )data{
    
    [self.headerview setViewData:data];
    
    NSMutableArray * d=data[@"video"];
    
    
    if(d!=nil&&d.count!=0){
        [_videocell setVideo:d];
    }
    
    
    NSMutableArray * d2=data[@"alumn"];
    if(d2!=nil&&d2.count!=0){
        [_potocell setVideo:d2];
    }

}


-(void) initMenu{
    
    
    
    self.baseView=[[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-50, SCREEN_HEIGHT-70-50, 50, 50)];
    UIImageView * imgv=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    imgv.image=[UIImage imageNamed:@"icon_xf"];
    [self.baseView addSubview:imgv];
    [self.view addSubview:self.baseView];
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentTableViewTouchInSide)];
    self.baseView.userInteractionEnabled=YES;
    [self.baseView addGestureRecognizer:tableViewGesture];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [img1 setImage:[UIImage imageNamed:@"icon_xiaj"]];
    [view1 addSubview:img1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [img2 setImage:[UIImage imageNamed:@"icon_pais"]];
    [view2 addSubview:img2];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImageView *img3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [img3 setImage:[UIImage imageNamed:@"icon_xiac"]];
    [view3 addSubview:img3];
    
    NSArray * uiview_arr=@[view1,view2,view3];
    
    [self setListener:view1 index:1];
    [self setListener:view2 index:2];
    [self setListener:view3 index:3];
    
     CGRect rect=CGRectMake(SCREEN_WIDTH-20-50, SCREEN_HEIGHT-70-50, 50, 50);
    
    
    self.sideMenu=[[UserInfoMenu alloc] initItemsAndBaseView:uiview_arr Cgrect:rect];
    [self.view addSubview:self.sideMenu];
    
    
    
    

}





-(void)setListener:(UIView *) arr index:(NSInteger) index{
   
    arr.tag=index;
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuAction:)];
//    tableViewGesture.view.tag=index;
    arr.userInteractionEnabled=YES;
    [arr addGestureRecognizer:tableViewGesture];

}

-(void)menuAction:(id)sender{
    
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    
    UIView *views = (UIView*) tap.view;
    
    NSUInteger index = views.tag;
    
    NSLog(@"菜单选项%lu",index);
    switch (index) {
        case 1:
            NSLog(@"拍照上传");
            
            [self video_action:2];
            
            
            break;
        case 2:
             NSLog(@"录像上传");
               [self video_action:1];
            break;
        case 3:
              NSLog(@"相册上传");
               [self video_action:3];
            break;
        default:
            break;
    }
}


-(void)video_action:(NSInteger) index{
    //触发事件：录像
    UIImagePickerController * imagepicker=[[UIImagePickerController alloc]init];
    imagepicker.delegate = self;
    //判断相机是否可用
    BOOL isCameraSupport = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if(isCameraSupport){
        //判断后置摄像头是否可用
        BOOL isRearSupport = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if(isRearSupport){
            
            
            if(index==1){
                //指定使用照相机模式,可以指定使用相册／照片库
                imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                //设置当拍照完或在相册选完照片后，是否跳到编辑模式进行图片剪裁。只有当showsCameraControls属性为true时才有效果
                imagepicker.allowsEditing = NO;
                //设置拍照时的下方的工具栏是否显示，如果需要自定义拍摄界面，则可把该工具栏隐藏
                imagepicker.showsCameraControls  = YES;
                //录像质量
                imagepicker.videoQuality = UIImagePickerControllerQualityTypeMedium;
                //录像最长时间
                imagepicker.videoMaximumDuration = 10.0f;
                //设置使用后置摄像头
                imagepicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                
                imagepicker.mediaTypes =  [[NSArray alloc] initWithObjects:(NSString*)kUTTypeMovie,nil];
                imagepicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo; //相机的模式 拍照/摄像
                
            }else if(index==2){
                //指定使用照相机模式,可以指定使用相册／照片库
                imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                //设置当拍照完或在相册选完照片后，是否跳到编辑模式进行图片剪裁。只有当showsCameraControls属性为true时才有效果
                imagepicker.allowsEditing = NO;
                //设置拍照时的下方的工具栏是否显示，如果需要自定义拍摄界面，则可把该工具栏隐藏
                imagepicker.showsCameraControls  = YES;
                imagepicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto; //相机的模式 拍照/摄像
             
            }else if(index==3){
                //设置选取的照片是否可编辑
//                imagepicker.allowsEditing = YES;
                imagepicker.mediaTypes =  [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage,nil];

                //设置相册呈现的样式
                //照片的选取样式还有以下两种
                //UIImagePickerControllerSourceTypePhotoLibrary,直接全部呈现系统相册
                //UIImagePickerControllerSourceTypeCamera//调取摄像头
                 imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            
           [self presentViewController:imagepicker animated:YES completion:nil];
        }
        
    }
    
  
    
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //通过UIImagePickerControllerMediaType判断返回的是照片还是视频
    NSString* type = [info objectForKey:UIImagePickerControllerMediaType];
    //如果返回的type等于kUTTypeImage，代表返回的是照片,并且需要判断当前相机使用的sourcetype是拍照还是相册
    if ([type isEqualToString:(NSString*)kUTTypeMovie]) {
        // 视频处理
        NSURL *sourceURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSLog(@"%@",[NSString stringWithFormat:@"%f s", [self getVideoLength:sourceURL]]);
        NSLog(@"%@", [NSString stringWithFormat:@"%.2f kb", [self getFileSize:[sourceURL path]]]);
        NSURL *newVideoUrl ; //一般.mp4
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        newVideoUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]]] ;//这个是保存在app自己的沙盒路径里，后面可以选择是否在上传后删除掉。我建议删除掉，免得占空间。
        [picker dismissViewControllerAnimated:YES completion:nil];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self convertVideoQuailtyWithInputURL:sourceURL outputURL:newVideoUrl completeHandler:nil];
    }else if([type isEqualToString:(NSString*)kUTTypeImage]){
        UIImage *  image = info[UIImagePickerControllerOriginalImage];//获取原始照片
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        CompressionImge *img=[[CompressionImge alloc]init];
//        NSData *imageData =UIImageJPEGRepresentation(image,1);//图片对象转为nsdata
//        
       NSData *data=[img resetSizeOfImageData:image maxSize:200];
        UIImage *up_img = [UIImage imageWithData: data];
        
        [self upLoadImgFile:up_img type:@"2"];
    
    }
    // 选择图片后手动销毁界面
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void) convertVideoQuailtyWithInputURL:(NSURL*)inputURL
                               outputURL:(NSURL*)outputURL
                         completeHandler:(void (^)(AVAssetExportSession*))handler
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    //  NSLog(resultPath);
    exportSession.outputURL = outputURL;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse= YES;
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
     {
         switch (exportSession.status) {
             case AVAssetExportSessionStatusCancelled:
                 NSLog(@"AVAssetExportSessionStatusCancelled");
                 break;
             case AVAssetExportSessionStatusUnknown:
                 NSLog(@"AVAssetExportSessionStatusUnknown");
                 break;
             case AVAssetExportSessionStatusWaiting:
                 NSLog(@"AVAssetExportSessionStatusWaiting");
                 break;
             case AVAssetExportSessionStatusExporting:
                 NSLog(@"AVAssetExportSessionStatusExporting");
                 break;
             case AVAssetExportSessionStatusCompleted:
                 NSLog(@"AVAssetExportSessionStatusCompleted");
                 NSLog(@"%@",[NSString stringWithFormat:@"%f s", [self getVideoLength:outputURL]]);
                 NSLog(@"%@", [NSString stringWithFormat:@"%.2f kb", [self getFileSize:[outputURL path]]]);
                 
                 [self upLoadFile:outputURL type:@"3"];
                 break;
             case AVAssetExportSessionStatusFailed:
                 NSLog(@"AVAssetExportSessionStatusFailed");
                 break;
         }
         
     }];
    
}
-(void)upLoadImgFile:(UIImage *)img type:(NSString *)type{
    
    AFHttpSessionClient * af=[AFHttpSessionClient sharedClient ];
//    NSData *video_data=[NSData dataWithContentsOfURL:url];
    NSMutableDictionary *dir=[[NSMutableDictionary alloc]init];
    [dir setObject:type forKey:@"type"];
    [af UploadImageFile:img parameters:dir path:upvideo_url actionBlock:^(NSDictionary *posts, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if([posts[@"state"] isEqualToString:@"1"]){
            Toast * t=[Toast makeText:@"图片上传成功"];
            [t showWithType:ShortTime];
            
            NSArray *url_list=posts[@"url"];
            
            NSString * video_url=[ url_list valueForKey:@"1"];
            NSLog(@"视频地址%@",video_url);
            [self showWindow:@"2" url:video_url];
        }else{
            Toast * t=[Toast makeText:@"图片上传失败"];
            [t showWithType:ShortTime];
        }
        
    }];
}
-(void)upLoadFile:(NSURL *)url type:(NSString *)type{
    
    AFHttpSessionClient * af=[AFHttpSessionClient sharedClient ];
    NSData *video_data=[NSData dataWithContentsOfURL:url];
    NSMutableDictionary *dir=[[NSMutableDictionary alloc]init];
    
    [dir setObject:type forKey:@"type"];
    [af UploadVideoFile:video_data path:upvideo_url parameters:dir actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if([posts[@"state"] isEqualToString:@"1"]){
            
            Toast * t=[Toast makeText:@"视频上传成功"];
            [t showWithType:ShortTime];
            NSArray *url_list=posts[@"url"];
            
            NSString * video_url=[ url_list valueForKey:@"1"];
            NSLog(@"视频地址%@",video_url);
            [self showWindow:@"2" url:video_url];
        
        }else{
            Toast * t=[Toast makeText:@"视频上传失败"];
            [t showWithType:ShortTime];
        }
        
    }];
}

-(void)showWindow:(NSString *)type url:(NSString *)url{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"是否对文件进行加密" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *qx=[UIAlertAction actionWithTitle:@"不加密" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self upDateuserRes:type url:url isJM:@"0"];
    }];
    UIAlertAction *qd=[UIAlertAction actionWithTitle:@"加密" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
             [self upDateuserRes:type url:url isJM:@"1"];
    }];
    
    [alert addAction:qx];
    [alert addAction:qd];
    [self presentViewController:alert animated:YES completion:nil];
}

//文件上传后,提交上传的用户信息
-(void)upDateuserRes:(NSString *)type url:(NSString *)url isJM:(NSString *)jm{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHttpSessionClient * af=[AFHttpSessionClient sharedClient ];
    NSMutableDictionary *dir=[[NSMutableDictionary alloc]init];
    NSUserDefaults * def=[NSUserDefaults standardUserDefaults];
    
    [dir setObject:[def valueForKey:@"id" ] forKey:@"id"];
    [dir setObject:type forKey:@"type"];
    [dir setObject:url forKey:@"url"];
    [dir setObject:jm forKey:@"isDecode"];
    
    [af post:updateUserRes_url parameters:dir actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"服务器返回-->%@",posts);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSInteger state=[posts[@"state"] integerValue];
        if(state==1){
            Toast * toast=[Toast makeText:@"已加密"];
            [toast showWithType:ShortTime];
        }else{
              Toast * toast2=[Toast makeText:@"操作失败"];
              [toast2 showWithType:ShortTime];
            
        }
    }];
}


//此方法可以获取文件的大小，返回的是单位是KB。
- (CGFloat) getFileSize:(NSString *)path
{
    NSLog(@"%@",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }else{
        NSLog(@"找不到文件");
    }
    return filesize;
}
//此方法可以获取视频文件的时长。
- (CGFloat) getVideoLength:(NSURL *)URL
{
    
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:URL];
    CMTime time = [avUrl duration];
    int second = ceil(time.value/time.timescale);
    return second;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //    手动销毁界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}




-(void)annim:(UIView *) mview{
    //创建一个CGAffineTransform  transform对象
    
    CGAffineTransform  transform;
    
    //设置旋转度数
    
    transform = CGAffineTransformRotate(mview.transform,M_PI/6.0);
    
    //动画开始
    
    [UIView beginAnimations:@"rotate" context:nil ];
    
    //动画时常
    
    [UIView setAnimationDuration:0.5];
    
    //添加代理
    
    [UIView setAnimationDelegate:self];
    
    //获取transform的值
    
    [mview setTransform:transform];
    
    //关闭动画
    
    [UIView commitAnimations];
    
    
}
-(void)Closeannim:(UIView *) mview{
    //创建一个CGAffineTransform  transform对象
    
    CGAffineTransform  transform;
    
    //设置旋转度数
    
    transform = CGAffineTransformRotate(mview.transform,-M_PI/6.0);
    
    //动画开始
    
    [UIView beginAnimations:@"rotate" context:nil ];
    
    //动画时常
    
    [UIView setAnimationDuration:0.5];
    
    //添加代理
    
    [UIView setAnimationDelegate:self];
    
    //获取transform的值
    
    [mview setTransform:transform];
    
    //关闭动画
    
    [UIView commitAnimations];
    
    
}


//点击table空白处隐藏键盘
- (void)commentTableViewTouchInSide{
    if (self.sideMenu.isOpen){
        [self Closeannim:self.baseView];
        [self.sideMenu CloseMenu];
    }else{
        [self annim:self.baseView];
        [self.sideMenu OpenMenu];
    }
}
#pragma mark -

- (NSInteger)numberOfTabForTabViewBar:(HJDefaultTabViewBar *)tabViewBar {
    return [self numberOfViewControllerForTabViewController:self];
}

- (id)tabViewBar:(HJDefaultTabViewBar *)tabViewBar titleForIndex:(NSInteger)index {
    NSString * tab_name=@"";
    if (index == 0) {
        tab_name=NSLocalizedString(@"user_tab_item1_str", nil);
           }else if(index==1){
               tab_name=NSLocalizedString(@"user_tab_item2_str", @"tab2");
    }
    return tab_name;
//    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"网易云 5"];
//    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(3, 2)];
//    return attString;
}

- (void)tabViewBar:(HJDefaultTabViewBar *)tabViewBar didSelectIndex:(NSInteger)index {
    [self scrollToIndex:index animated:YES];
}

#pragma mark -

- (void)tabViewController:(HJTabViewController *)tabViewController scrollViewVerticalScroll:(CGFloat)contentPercentY {
    NSLog(@"contentPercentY-->%f",contentPercentY);
//    self.navigationController.navigationBar.alpha = contentPercentY;
}

- (NSInteger)numberOfViewControllerForTabViewController:(HJTabViewController *)tabViewController {
    return 2;
}

- (UIViewController *)tabViewController:(HJTabViewController *)tabViewController viewControllerForIndex:(NSInteger)index {
//    TableViewController *vc = [TableViewController new];
//    vc.index = index;
//    BaseViewController * vc=nil;
    NSLog(@"分页--%lu",index);
    
    if(index==1){
        _videocell=[[VideoCollectionView alloc]init];
        
        return _videocell;
    }else if(index==0){
        _potocell=[[PotoViewController alloc]init];
        //        NSMutableArray * d=[self.infodata valueForKey:@"video"];;
        //        [_videocell setVdieodata:d];
        return _potocell;
    }
    return nil;
}

- (UIView *)tabHeaderViewForTabViewController:(HJTabViewController *)tabViewController {
//    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 300)];
//    headerView.image = [UIImage imageNamed:@"1"];
//    headerView.contentMode = UIViewContentModeScaleAspectFill;
//    headerView.userInteractionEnabled = YES;
    
    self.headerview=[[UserinfoHeader alloc] init];
//    head.image=[UIImage imageNamed:@"1"];
    
    [ self.headerview setController:self];
    
    
    return self.headerview;
}

- (CGFloat)tabHeaderBottomInsetForTabViewController:(HJTabViewController *)tabViewController {
    return HJTabViewBarDefaultHeight + CGRectGetMaxY(self.navigationController.navigationBar.frame);
}

- (UIEdgeInsets)containerInsetsForTabViewController:(HJTabViewController *)tabViewController {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
