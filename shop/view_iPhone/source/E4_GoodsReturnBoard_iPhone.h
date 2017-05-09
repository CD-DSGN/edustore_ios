//
//  E4_GoodsReturn_iPhone.h
//  shop
//
//  Created by 田明飞 on 2017/3/6.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "Bee.h"
#import "model.h"
#import "BaseBoard_iPhone.h"

@interface E4_GoodsReturnBoard_iPhone : BaseBoard_iPhone

AS_OUTLET( BeeUIScrollView, list )

@property (nonatomic, strong) ORDER_GOODS * goods;

@end
