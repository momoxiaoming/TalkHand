//
//  ADCollectionViewCell.m
//  QsQ
//
//  Created by 张小明 on 2017/4/18.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "ADCollectionViewCell.h"

@implementation ADCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    
    if(self){
        self=[[[NSBundle mainBundle] loadNibNamed:@"ADCollectionViewCell" owner:nil options:nil] firstObject];
       
    }
    return self;
    
}


-(void)setData:(NSData *)data{
    self.img.layer.cornerRadius=6;
      self.bgview.layer.cornerRadius=6;
    
    
    [self.img.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.img.layer setBorderWidth:0.5];
    [self.img.layer setMasksToBounds:YES];
    
    int canclick=[[data valueForKey:@"canClick"] intValue];
     int isclick=[[data valueForKey:@"isClick"] intValue];
    
    
    
    if(isclick==1){
        [self.bgview setHidden:YES];
    }else{
        [self.bgview setHidden:false];
    }
    
//    self.img.image=[UIImage imageNamed:@"icon_banner"];
    [self.img sd_setImageWithURL:[data valueForKey:@"iconUrl"] placeholderImage:[UIImage imageNamed:@"icon_mor"]];
    
    
    
}
@end
