//
//  CellitemClickDelete.h
//  QsQ
//
//  Created by 张小明 on 2017/6/28.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CellitemClickDelete <NSObject>


//第一个参数是点击的标记tag,第二个是表示左边cell还是右边cell,第三个参数是传递的对象值
-(void)cellClick:(NSInteger)tag isright:(NSInteger)isright object:(NSObject*)obj;


@end
