//
//  NearyCell.m
//  QsQ
//
//  Created by 张小明 on 2017/3/25.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "NearyCell.h"
@implementation NearyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setCellData:(NSObject *)obj{
    

    
    self.adress.text=[NSString stringWithFormat:@"%@",[obj valueForKey:@"address"]];;
    self.name.text=[obj valueForKey:@"name"];
    self.lv.text= [NSString stringWithFormat:@"LV %@",[obj valueForKey:@"level"]];
    self.age.text=[NSString stringWithFormat:@"%@ 岁",[obj valueForKey:@"age"]];
    [self.bgImage sd_setImageWithURL:[obj valueForKey:@"iconUrl"] placeholderImage:[UIImage imageNamed:@"icon_mor"]];
    int isvip=[[obj valueForKey:@"isVip"] intValue];
    [self.vip_img setHidden:isvip==1?true:false];
    
    int issex=[[obj valueForKey:@"sex"] intValue];
    self.sex_img.image=[UIImage imageNamed:issex==1?@"icon_body":@"icon_girl"];
    
    
   
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//该方法用于创建cell
+(instancetype)tgcellWithTableView:(UITableView *)tableview{
   
    NearyCell *cell=[tableview dequeueReusableCellWithIdentifier:@"nrcell"];
    if(cell==nil){
        //这里的名字就是xil的文件名
        cell=[[[NSBundle mainBundle] loadNibNamed:@"NearyCell" owner:nil options:nil] firstObject];
        //设置圆角
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 3.3;
        //取消cell的选中效果
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
     
        
    }
    return cell;
}

//设置间距
-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 10;//这里间距为10，可以根据自己的情况调整
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1 * frame.origin.x;
    [super setFrame:frame];
}

@end
