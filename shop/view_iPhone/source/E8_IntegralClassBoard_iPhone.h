//
//  E8_IntegralBoard_iPhone.h
//  shop
//
//  Created by guangnian dashu on 16/9/19.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "Bee.h"
#import "BaseBoard_iPhone.h"

#import "controller.h"
#import "model.h"
#import "TeacherClassModel.h"
#import "UIViewController+ErrorTips.h"

@interface E8_IntegralClassBoard_iPhone : BaseBoard_iPhone

AS_MODEL( UserModel, userModel )
AS_MODEL(TeacherClassModel, classModel)

AS_OUTLET( BeeUIScrollView, list )

@end
