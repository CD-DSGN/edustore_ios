//
//  E4_GoodsReturnCell_iPhone.h
//  shop
//
//  Created by guangnian dashu on 2017/3/6.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "Bee.h"

@interface E4_GoodsReturnCell_iPhone : BeeUICell

AS_MODEL( UserModel, userModel);

AS_OUTLET( BeeUIButton, select_reason )
AS_OUTLET( BeeUIButton, return_goods )

@end
