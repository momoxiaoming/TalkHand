//
//  NearyCell.h
//  QsQ
//
//  Created by 张小明 on 2017/3/25.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UIButton *talk_btn;
@property (weak, nonatomic) IBOutlet UIButton *Gz_btn;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *lv;

@property (weak, nonatomic) IBOutlet UIImageView *vip_img;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *adress;
+(instancetype) tgcellWithTableView:(UITableView *) tableview;

@property (weak, nonatomic) IBOutlet UIImageView *sex_img;
-(void)setCellData:(NSObject*) obj;


@end
