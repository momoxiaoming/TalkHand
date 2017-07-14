//
//  PotoCollectionViewCell.m
//  QsQ
//
//  Created by 张小明 on 2017/3/27.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "PotoCollectionViewCell.h"
#import "ImageUtil.h"
@implementation PotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];

    if(self){
        self=[[[NSBundle mainBundle] loadNibNamed:@"PotoCollectionViewCell" owner:nil options:nil] firstObject];
//        self.bgImg.layer.masksToBounds = YES;
//        self.bgImg.layer.cornerRadius = 5;
    }
    return self;

}


-(void)setInfoData:(NSObject *)obj{
    
    NSInteger isv=[[obj valueForKey:@"isVisible"] integerValue];
     NSString * url=[NSString stringWithFormat:@"%@",[obj valueForKey:@"url"]];
     self.bgImg.image=[UIImage imageNamed:@"icon_mor"];
    if(url!=nil){
        if(isv==1){
            [self.bgImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon_mor"]];
        }else{
           
        
        
           
            [self.bgImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon_mor"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                self.bgImg.image=[ImageUtil boxblurImage:image withBlurNumber:1];
            }];
                
               
         
            
            
            
            
          
        }
    }else{
        [self.bgImg setImage:[UIImage imageNamed:@"icon_mor"]];;
    }
   
    
    
    
    

}


@end
