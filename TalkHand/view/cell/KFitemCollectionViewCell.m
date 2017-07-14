//
//  KFitemCollectionViewCell.m
//  QsQ
//
//  Created by 张小明 on 2017/6/16.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "KFitemCollectionViewCell.h"

@implementation KFitemCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    
    if(self){
        self=[[[NSBundle mainBundle] loadNibNamed:@"KFitemCollectionViewCell" owner:nil options:nil] firstObject];
        
    }
    return self;
    
}
-(void)setData:(NSDictionary *)data{
    [self.img sd_setImageWithURL:[NSURL URLWithString:[data valueForKey:@"iconUrl"]] placeholderImage:[UIImage imageNamed:@"icon_mor"]];

}
@end
