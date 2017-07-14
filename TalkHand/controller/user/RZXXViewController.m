//
//  RZXXViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/4/14.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "RZXXViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

#import <AVFoundation/AVFoundation.h>
#import "AFHttpSessionClient.h"
@interface RZXXViewController ()
@property UIImageView * ct;
@property UIButton * next;
@end

@implementation RZXXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"诚信认证";
    [self createView];
    //防止导航栏遮住控件
    self.edgesForExtendedLayout = UIRectEdgeNone;
 
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self initData];
}


-(void)initData{
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    
    NSMutableDictionary * parm=[[NSMutableDictionary alloc]init];
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [parm setValue:[def objectForKey:@"id"] forKey:@"id"];
    [as post:getisVideoAttest_URL parameters:parm actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSInteger state=[posts[@"state"] integerValue];;
        
          if(state==1){
              NSInteger rz=[posts[@"legalizeVideoState"]integerValue];
        
            if(rz==0){
             
            }else if(rz==1){
                [self.next setTitle:@"已经认证完成" forState:UIControlStateNormal];
                [self.next setEnabled:YES];
                
            }else if(rz==2){
                [self.next setTitle:@"正在认证" forState:UIControlStateNormal];
                [self.next setEnabled:YES];
            
            }
            
            
        }
        
        
    }];
}



-(void)sendRzData:(NSString *)url{
    AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
    
    NSMutableDictionary * parm=[[NSMutableDictionary alloc]init];
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSString *acount=[def objectForKey:@"id"];
    
    [parm setValue:acount forKey:@"id"];
    [parm setValue:url forKey:@"url"];
    NSLog(@"请求参数-->%@",parm);
    [as post:getupdateVideoAttest_URL parameters:parm actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
        NSInteger state=[posts[@"state"] integerValue];;
        
        if(state==1){
  
            
        }
        
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.alpha=1;
    
    

}


-(void) createView{
    UIView *rect_bg=[[UIView alloc] init];
    rect_bg.backgroundColor=[UIColor whiteColor];
    rect_bg.layer.cornerRadius=6;
    
    
    
     _ct=[[UIImageView alloc] init];
    
    
    
    _ct.image=[UIImage imageNamed:@"icon_jj"];
    
    UILabel * item1=[[UILabel alloc] init];
    item1.text=NSLocalizedString(@"rzxx_str1", nil);
    item1.textColor=[UIColor colorWithHexString:@"#4d4d4d"];
    item1.font=[UIFont systemFontOfSize:14];
    
    UILabel * item2=[[UILabel alloc] init];
    item2.text=NSLocalizedString(@"rzxx_str2", nil);
    item2.textColor=[UIColor colorWithHexString:@"#666666"];
    item2.font=[UIFont systemFontOfSize:12];
    
    
     _next=[[UIButton alloc]init];
    UIImage *normal_img=[UIColor createImage:@"#2fb9c3"];
     UIImage *select_img=[UIImage imageNamed:@"#1082f4"];
    
    
    [_next setBackgroundImage:normal_img forState:UIControlStateNormal];
    [_next setBackgroundImage:select_img forState:UIControlStateSelected];
 
    _next.tintColor=[UIColor whiteColor];
//    next.backgroundColor=[UIColor colorWithHexString:@"#0abaf4"];
//    UILabel * label=[[UILabel alloc]init];
//    label.text=NSLocalizedString(@"rzxx_str3", nil);
//    next.currentTitle=@"保存";
    [_next setTitle:@"开始上传" forState:UIControlStateNormal];
    _next.layer.cornerRadius=6;
   
    _next.layer.masksToBounds = YES;
    
    
  
   
    [self.view addSubview:rect_bg];
     [self.view addSubview:_ct];
    [self.view addSubview:item1];
    [self.view addSubview:item2];
    [self.view addSubview:_next];
    
    [rect_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-30);
        make.left.equalTo(self.view).offset(30);
        make.top.equalTo(self.view).offset(70);
        make.size.mas_equalTo(CGSizeMake(0, 200));
    }];
    
    [_ct mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(rect_bg);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [item1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rect_bg.mas_bottom).offset(30);
        make.centerX.equalTo(self.view);
        
    }];
    [item2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(item1.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        
    }];
    
    [_next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-50);
       
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.size.mas_equalTo(CGSizeMake(0, 45));
    }];
    
    [_next addTarget:self action:@selector(video_action) forControlEvents:UIControlEventTouchUpInside];

}


-(void)video_action{
    //触发事件：录像
  
    UIImagePickerController * imagepicker=[[UIImagePickerController alloc]init];

    //判断相机是否可用
     BOOL isCameraSupport = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if(isCameraSupport){
        //判断后置摄像头是否可用
    BOOL isRearSupport = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if(isRearSupport){
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
            
            imagepicker.delegate = self;
            
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
               
                 [self upLoadFile:outputURL];
                 break;
             case AVAssetExportSessionStatusFailed:
                 NSLog(@"AVAssetExportSessionStatusFailed");
                 break;
         }
         
     }];
    
}

-(void)upLoadFile:(NSURL *)url{

    AFHttpSessionClient * af=[AFHttpSessionClient sharedClient ];
    NSData *video_data=[NSData dataWithContentsOfURL:url];
    NSMutableDictionary *dir=[[NSMutableDictionary alloc]init];
    [dir setObject:@"3" forKey:@"type"];
    [af UploadVideoFile:video_data path:upvideo_url parameters:dir actionBlock:^(NSDictionary *posts, NSError *error) {
        NSLog(@"%@",posts);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if([posts[@"state"] isEqualToString:@"1"]){
             Toast * t=[Toast makeText:@"上传成功"];
           [t showWithType:ShortTime];
            
            [self.ct setImage:[UIImage imageNamed:@"icon_sfz"]];
            [_next setEnabled:YES];
            NSArray *url_list=posts[@"url"];
                               
            NSString * video_url=[ url_list valueForKey:@"1"];
            NSLog(@"视频地址%@",video_url);
            [self sendRzData:video_url];
            
            
        }else{
            Toast * t=[Toast makeText:@"上传失败"];
            [t showWithType:ShortTime];
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
