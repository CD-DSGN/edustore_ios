//
//  I2_MomentsPhotoBoard_iPhone.h
//  shop
//
//  Created by guangnian dashu on 2016/11/24.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "Bee.h"

@interface I2_MomentsPhotoBoard_iPhone : BeeUIBoard<UIGestureRecognizerDelegate>

AS_OUTLET( BeeUIScrollView, list )
AS_OUTLET( BeeUIPageControl, pager )

@property (nonatomic, retain) MOMENTS *				moments;
@property (nonatomic, assign) NSInteger  			pageIndex;
@property (nonatomic, assign) BOOL                  firstReloaded;

@end
