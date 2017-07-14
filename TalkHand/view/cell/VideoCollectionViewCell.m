//
//  VideoCollectionViewCell.m
//  QsQ
//
//  Created by 张小明 on 2017/3/30.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "VideoCollectionViewCell.h"
#import "ImageUtil.h"
@implementation VideoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    
    if(self){
        self=[[[NSBundle mainBundle] loadNibNamed:@"VideoCollectionViewCell" owner:nil options:nil] firstObject];
        //        self.bgImg.layer.masksToBounds = YES;
        //        self.bgImg.layer.cornerRadius = 5;
    }
    return self;
    
}
-(void)setinfoData:(NSObject *)obj{
    NSString * video_url=[NSString stringWithFormat:@"%@",[obj valueForKey:@"url"]];
 
   
    //创建任务队列,一般是串行队列
    dispatch_queue_t queue=dispatch_queue_create("thunm_img_thread", NULL);
   
    dispatch_async(queue, ^{
          UIImage * img=[ImageUtil thumbnailImageForVideo:[NSURL URLWithString:video_url] atTime:1000];
        self.bgImage.backgroundColor=[UIColor blackColor];
        self.bgImage.image=img;
    });
    
    
}


@end
