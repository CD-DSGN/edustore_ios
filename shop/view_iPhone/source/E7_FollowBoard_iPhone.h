//
//  E7_FollowBoard_iPhone.h
//  shop
//
//  Created by guangnian dashu on 16/9/13.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "Bee.h"
#import "BaseBoard_iPhone.h"

#import "controller.h"
#import "model.h"

#import "UIViewController+ErrorTips.h"

@interface E7_FollowBoard_iPhone : BaseBoard_iPhone

AS_MODEL( UserModel, userModel )

AS_OUTLET( BeeUIScrollView, list )

@property (nonatomic, retain)NSMutableArray * course;
@property (nonatomic, retain)NSMutableArray * course_id;
@property (nonatomic, retain)NSMutableArray * teacher_name;

@property (nonatomic, retain)NSNumber * user_id;

@end
