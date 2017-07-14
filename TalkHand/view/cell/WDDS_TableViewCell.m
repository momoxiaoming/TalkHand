//
//  WDDS_TableViewCell.m
//  QsQ
//
//  Created by 张小明 on 2017/4/15.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "WDDS_TableViewCell.h"

@implementation WDDS_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//该方法用于创建cell
+(instancetype)tgcellWithTableView:(UITableView *)tableview{
    
    WDDS_TableViewCell *cell=[tableview dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil){
        //这里的名字就是xil的文件名
        cell=[[[NSBundle mainBundle] loadNibNamed:@"WDDS_TableViewCell" owner:nil options:nil] firstObject];
//        [cell initView];
        //设置圆角
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 3.3;
        //取消cell的选中效果
        //        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}

+(void)setData:(NSData *)data{

}

@end
