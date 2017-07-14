//
//  Neary_fj_Cell.h
//  QsQ
//
//  Created by 张小明 on 2017/3/25.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Neary_fj_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bg_img;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *msg;
@property (weak, nonatomic) IBOutlet UILabel *time;
+(instancetype) tgcellWithTableView:(UITableView *) tableview;
-(void)setItemData:(NSDictionary *)dir;
@end
