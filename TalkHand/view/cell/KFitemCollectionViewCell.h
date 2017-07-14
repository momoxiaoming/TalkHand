//
//  KFitemCollectionViewCell.h
//  QsQ
//
//  Created by 张小明 on 2017/6/16.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KFitemCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
-(void)setData:(NSDictionary*) data;
@end
