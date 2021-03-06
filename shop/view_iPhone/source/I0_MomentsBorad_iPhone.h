//
//  I0_MomentsBorad_iPhone.h
//  shop
//
//  Created by guangnian dashu on 2016/11/7.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "Bee.h"
#import "model.h"
#import "BaseBoard_iPhone.h"
#import "I0_MomentsPhotoCell_iPhone.h"

#import "UIViewController+ErrorTips.h"
#import "I0_MomentsWriteCommentView.h"

@interface I0_MomentsBorad_iPhone : BaseBoard_iPhone

AS_SINGLETON( MomentsBoard )

AS_MODEL( MomentModel, momentModel )
AS_MODEL( UserModel, userModel )

AS_OUTLET( BeeUIScrollView, list )

@property (nonatomic, retain)NSString * no_follow;

@property (nonatomic,strong) I0_MomentsWriteCommentView *commentView;

@end
