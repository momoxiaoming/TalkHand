//
//  MsgTableViewCell.m
//  QsQ
//
//  Created by 张小明 on 2017/4/1.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "MsgTableViewCell.h"
#import "FMDConfig.h"
#import "AFHttpSessionClient.h"
@implementation MsgTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
    
}
-(void)setItemData:(MsgListEntity *)dir{
    
    NSString *otherid=[dir valueForKey:@"otherid"];
    NSString *list_time=[dir valueForKey:@"list_time"];
    NSInteger readnum=[[dir valueForKey:@"readnum"]integerValue] ;
//    NSString *owerid=[dir valueForKey:@"owerid"];
    BaseMsg * list_msg=[dir valueForKey:@"list_msg"];
    
    NSDictionary *userinfo=  [[FMDConfig sharedInstance]getUserInfoWithId:otherid];
    
    if(userinfo!=NULL){
        [self.tx_img sd_setImageWithURL:[NSURL URLWithString:userinfo[@"iconUrl"]] placeholderImage:[UIImage imageNamed:@"icon_mor"]];
        self.name.text=userinfo[@"name"];
    }else
     [self getUserinfo:otherid];

  
  
//   self.tx_img
    NSInteger msgtype=[[list_msg valueForKey:@"msg_info_type"] integerValue];
    
    if(msgtype==[textMsg integerValue]){ //文本消息
        self.msg.text=[list_msg valueForKey:@"msg_content"];
    }else if(msgtype==[aduioMsg integerValue]){
       self.msg.text=@"[语音消息]";
    
    }else if(msgtype==[videoMsg integerValue]){
        self.msg.text=@"[视频消息]";
        
    }else if(msgtype==[picterMsg integerValue]){
        self.msg.text=@"[图片消息]";
        
    }

    
    if(readnum!=0){
        [self.numView setHidden:NO];

        self.msg_num.text=[NSString stringWithFormat:@"%lu",readnum];
        
    }else{
        
        [self.numView setHidden:YES];
    }
    
    
    
    
    self.time.text=[self getFormatTime:list_time];;
    
    
    
 
    


}


-(NSString *)getFormatTime:(NSString *)list_time{
    
    
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970];
    
    //当前时间,秒数
    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
    
    //保存的时间,秒数
    long long save_time=[list_time longLongValue];
    
    long long min=(theTime-save_time)/60;
    long long hours=(theTime-save_time)/60/60;
    long long day=(theTime-save_time)/60/60/24;
    if(min==0){
     return @"刚刚";
    }
    
    if(min<60){
        return [NSString stringWithFormat:@"%llu分钟前",min];
        
    }else if(hours<=24){
       return [NSString stringWithFormat:@"%llu小时前",hours];
    
    }else if(day<=30){
       return [NSString stringWithFormat:@"%llu天前",day];
    
    }else{
    return @"一个月前";
    }
    
    

}

-(void)getUserinfo:(NSString*)userid{
   
    
        AFHttpSessionClient * as=[AFHttpSessionClient sharedClient];
        
        NSMutableDictionary * parm=[[NSMutableDictionary alloc]init];
        
        [parm setValue:@"" forKey:@"ownerId"];
        [parm setValue:userid forKey:@"otherId"];
        
        
        [as post:getUserinfo_url parameters:parm actionBlock:^(NSDictionary *posts, NSError *error) {
            
            NSLog(@"%@",posts);
         
            
            NSInteger state=[posts[@"state"] integerValue];;
            if(state==1){
                //首先保存这个用户信息
                [[FMDConfig sharedInstance]saveUserInfo:posts];
                
                
                
        
            }else{
                posts=[[FMDConfig sharedInstance]getUserInfoWithId:userid];
            }
            
               [self.tx_img sd_setImageWithURL:[NSURL URLWithString:posts[@"iconUrl"]] placeholderImage:[UIImage imageNamed:@"icon_mor"]];
            self.name.text=posts[@"name"];
        }];
    


}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//该方法用于创建cell
+(instancetype)tgcellWithTableView:(UITableView *)tableview{
    
    MsgTableViewCell *cell=[tableview dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil){
        //这里的名字就是xil的文件名
        cell=[[[NSBundle mainBundle] loadNibNamed:@"MsgTableViewCell" owner:nil options:nil] firstObject];
        [cell initView];
        //设置圆角
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 3.3;
        //取消cell的选中效果
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}



-(void) initView{
    self.msg.numberOfLines=1;
    self.msg.adjustsFontSizeToFitWidth = YES;
    //设置字数大于一行的时候,自动使用省略号
    self.msg.lineBreakMode = UILineBreakModeTailTruncation;
    
    self.name.numberOfLines=1;
    self.name.adjustsFontSizeToFitWidth = YES;
    //设置字数大于一行的时候,自动使用省略号
    self.name.lineBreakMode = UILineBreakModeTailTruncation;
    
}
@end
