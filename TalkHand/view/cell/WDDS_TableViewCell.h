//
//  WDDS_TableViewCell.h
//  QsQ
//
//  Created by 张小明 on 2017/4/15.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDDS_TableViewCell : UITableViewCell
+(instancetype) tgcellWithTableView:(UITableView *) tableview;
+(void)setData:(NSData*) data;

@property (weak, nonatomic) IBOutlet UILabel *msg;



@end
