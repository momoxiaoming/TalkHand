//
//  OtherViewCell.m
//  QsQ
//
//  Created by 张小明 on 2017/6/26.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "OtherViewCell.h"

@implementation OtherViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
    
        [self createView];
    }
    return self;
}


-(void)setItemData:(NSDictionary *)dir{
    NSLog(@"item-->%@",dir);
    self.img.image=[UIImage imageNamed:dir[@"url"]];
    self.text.text=dir[@"name"];
    
}

-(void)createView{
   
    self.img=[[UIImageView alloc]init];
    
    self.img.image=[UIImage imageNamed:@"icon_stop"];
    
    self.text=[[UILabel alloc]init];
    self.text.textAlignment=NSTextAlignmentCenter;
    self.text.font=[UIFont systemFontOfSize:10];
    self.text.textColor=[UIColor colorWithHexString:@"#919191"];
    
    [self.contentView addSubview:self.img];
    [self.contentView addSubview:self.text];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(45, 45));
        
    }];
    
    
    [self.text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img.mas_bottom).offset(10);
        
        make.centerX.equalTo(self.img);
        
        make.width.equalTo(self.img);
    }];
    
 
}
@end
