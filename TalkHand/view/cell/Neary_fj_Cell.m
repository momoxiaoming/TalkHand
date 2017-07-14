//
//  Neary_fj_Cell.m
//  QsQ
//
//  Created by 张小明 on 2017/3/25.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "Neary_fj_Cell.h"

@implementation Neary_fj_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setItemData:(NSDictionary *)dir{
    [self.bg_img sd_setImageWithURL:[NSURL URLWithString:[dir valueForKey:@"iconUrlInsert"]] placeholderImage:[UIImage imageNamed:@"icon_mor"]];
    
    self.title.text=[dir valueForKey:@"title"];
    self.time.text=[dir valueForKey:@"time"];
    self.msg.text=[dir valueForKey:@"content"];

}






//设置间距为10
-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 10;//这里间距为10，可以根据自己的情况调整
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1 * frame.origin.x;
    [super setFrame:frame];
}
//该方法用于创建cell
+(instancetype)tgcellWithTableView:(UITableView *)tableview{
    
    Neary_fj_Cell *cell=[tableview dequeueReusableCellWithIdentifier:@"fjcell"];
    if(cell==nil){
        //这里的名字就是xil的文件名
        cell=[[[NSBundle mainBundle] loadNibNamed:@"Neary_fj_Cell" owner:nil options:nil] firstObject];
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 3.3;
        //取消cell的选中效果
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}
@end
