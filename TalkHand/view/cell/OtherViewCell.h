//
//  OtherViewCell.h
//  QsQ
//
//  Created by 张小明 on 2017/6/26.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherViewCell : UICollectionViewCell
@property UIImageView *img;
@property UILabel *text;

-(void)setItemData:(NSDictionary*)dir;
@end
