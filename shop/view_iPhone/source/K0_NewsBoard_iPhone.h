//
//  K0_NewsBoard_iPhone.h
//  shop
//
//  Created by 田明飞 on 2017/5/4.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "BaseBoard_iPhone.h"
#import "model.h"
#import "Bee.h"
#import "I0_MomentsPhotoCell_iPhone.h"

#import "UIViewController+ErrorTips.h"

@interface K0_NewsBoard_iPhone : BaseBoard_iPhone

AS_SINGLETON( NewsBoard )

AS_MODEL( NewsModel, newsModel )
AS_MODEL( UserModel, userModel )

AS_OUTLET( BeeUIScrollView, list )

@end
