//
//  FaceCell.m
//  QsQ
//
//  Created by 张小明 on 2017/6/29.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "FaceCell.h"

@implementation FaceCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        
        [self createView];
    }
    return self;
}

-(void)setImage:(NSString *)imgData{
    self.imgView.image=[UIImage imageNamed:imgData];


}





-(void)createView{
    self.imgView=[[UIImageView alloc]init];
//    self.imgView.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];


 

}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
