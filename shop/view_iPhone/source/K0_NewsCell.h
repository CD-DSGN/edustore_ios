//
//  K0_NewsCell.h
//  shop
//
//  Created by 田明飞 on 2017/5/4.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "Bee_UICell.h"
#import "Bee.h"
@interface K0_NewsCell : BeeUICell

AS_OUTLET( BeeUIScrollView, list )

@property (nonatomic, retain) MOMENTS * moments;

@end
