//
//  GzCell.h
//  QsQ
//
//  Created by 张小明 on 2017/6/22.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GzCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *tx_img;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIView *lv_img;
@property (weak, nonatomic) IBOutlet UIImageView *vip_img;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *lv_txt;
@property (weak, nonatomic) IBOutlet UIImageView *sex_img;
@property (weak, nonatomic) IBOutlet UIImageView *gz_img;
@property (weak, nonatomic) IBOutlet UILabel *gz_txt;
+(instancetype)tgcellWithTableView:(UITableView *)tableview;
-(void)setItemData:(NSDictionary*)itemdata type:(NSString*)fk;
@end
