//
//  E7_FollowCell_iPhone.h
//  shop
//
//  Created by guangnian dashu on 16/9/13.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "Bee.h"

@interface E7_FollowCell_iPhone : BeeUICell

AS_OUTLET( UILabel, teacher )
AS_OUTLET( UILabel, course )
AS_OUTLET( UIButton, follow )
AS_OUTLET( UIButton, cancel_follow )
AS_OUTLET( UIImageView, background_row )

@end
