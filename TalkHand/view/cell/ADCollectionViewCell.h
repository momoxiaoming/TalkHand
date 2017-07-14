//
//  ADCollectionViewCell.h
//  QsQ
//
//  Created by 张小明 on 2017/4/18.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIView *bgview;

-(void)setData:(NSData*) data;
@end
