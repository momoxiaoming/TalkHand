//
//  TabModel.h
//  QsQ
//
//  Created by 张小明 on 2017/3/25.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TabModel : NSObject
// VC名字
@property(nonatomic,copy)NSString *VcName;
// 标题名
@property(nonatomic,copy)NSString *VcTitle;
// 图片
@property(nonatomic,copy)NSString *ImgName;

@property(nonatomic,copy)NSString *SelectImgName;

@end
