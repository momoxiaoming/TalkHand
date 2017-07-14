//
//  GzCell.m
//  QsQ
//
//  Created by 张小明 on 2017/6/22.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "GzCell.h"

@implementation GzCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItemData:(NSDictionary *)itemdata type:(NSString *)fk{
    self.itemData=itemdata;
    if([fk isEqualToString:@"fk"]){
        self.name.text=itemdata[@"name"];
        [self.tx_img sd_setImageWithURL:[NSURL URLWithString:itemdata[@"iconUrl"]] placeholderImage:[UIImage imageNamed:@"icon_mor"]];
        self.lv_txt.text=[NSString stringWithFormat:@"LV %@",itemdata[@"level"]];
        
        NSInteger isv=[itemdata[@"isVip"] integerValue];;
        if(isv){
            [self.vip_img setHidden:NO];
        }else{
            [self.vip_img setHidden:YES];
        }
        
        self.age.text=[NSString stringWithFormat:@"%@岁",itemdata[@"age"]];
        
        [self.gz_img setHighlighted:YES];
        [self.gz_txt setHighlighted:YES];
        
        NSInteger sexindex=[itemdata[@"sex"]integerValue];
        //    _lv_view.backgroundColor=[UIColor colorWithHe
        if(sexindex==2){
            self.sex_img.image=[UIImage imageNamed:@"icon_girl"];
            self.lv_img.backgroundColor=[UIColor colorWithHexString:@"#0AAFFF"];
        }else{
            self.sex_img.image=[UIImage imageNamed:@"icon_boy"];
            self.lv_img.backgroundColor=[UIColor colorWithHexString:@"#ff80ab"];
        }

    }else {
        self.name.text=itemdata[@"name"];
        [self.tx_img sd_setImageWithURL:[NSURL URLWithString:itemdata[@"iconUrl"]] placeholderImage:[UIImage imageNamed:@"icon_mor"]];
        self.lv_txt.text=[NSString stringWithFormat:@"LV %@",itemdata[@"level"]];
        
        NSInteger isv=[itemdata[@"isVip"] integerValue];;
        if(isv){
            [self.vip_img setHidden:NO];
        }else{
            [self.vip_img setHidden:YES];
        }
        
        self.age.text=[NSString stringWithFormat:@"%@岁",itemdata[@"age"]];
        
        NSInteger isat=[itemdata[@"isAtten"] integerValue];;
        if(isat==1){
            self.gz_txt.text=@"相互关注";
            
        }else{
            self.gz_txt.text=@"已关注";
        }
        
        NSInteger sexindex=[itemdata[@"sex"]integerValue];
        //    _lv_view.backgroundColor=[UIColor colorWithHe
        if(sexindex==2){
            self.sex_img.image=[UIImage imageNamed:@"icon_girl"];
            self.lv_img.backgroundColor=[UIColor colorWithHexString:@"#0AAFFF"];
        }else{
            self.sex_img.image=[UIImage imageNamed:@"icon_boy"];
            self.lv_img.backgroundColor=[UIColor colorWithHexString:@"#ff80ab"];
        }

    }
    
    
    
    [self setListener:self.gz_img index:1];
    [self setListener:self.tx_img index:2];
   
    
    
    
}


-(void)setListener:(UIView *) arr index:(NSInteger) index{
    
    arr.tag=index;   //设置传递的参数
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuAction:)];
    //    tableViewGesture.view.tag=index;
    arr.userInteractionEnabled=YES;
    [arr addGestureRecognizer:tableViewGesture];
    
}


-(void)menuAction:(id)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    
    UIView *views = (UIView*) tap.view;
    
    NSUInteger index = views.tag;   //获取上面view设置的tag
     [_gzdelete cellClick:index isright:0 object:self.itemData];
}


//该方法用于创建cell
+(instancetype)tgcellWithTableView:(UITableView *)tableview{
    
    GzCell *cell=[tableview dequeueReusableCellWithIdentifier:@"nrcell"];
    if(cell==nil){
        //这里的名字就是xil的文件名
        cell=[[[NSBundle mainBundle] loadNibNamed:@"GzCell" owner:nil options:nil] firstObject];
        //设置圆角
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 3.3;
        //取消cell的选中效果
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        
    }
    return cell;
}



@end
