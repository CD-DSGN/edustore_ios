//
//  I0_MomentsPhotoCell_iPhone.h
//  shop
//
//  Created by guangnian dashu on 2016/11/24.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "Bee.h"

@protocol momentsPhotoCellDelegate;

@interface  I0_MomentsSinglePhotoCell_iPhone: BeeUICell
@property (nonatomic, assign) id <momentsPhotoCellDelegate> delegate;
@end

@protocol momentsPhotoCellDelegate <NSObject>
- (void)momentsPhotoCell:(UIViewController *)UIViewController withMoments:(MOMENTS *)moments andtag:(NSInteger)tag;
@end
