//
//  ECMobileManager.h
//  ECMobileManager
//
//  Created by god on 14-2-13.
//  Copyright (c) 2014年 geek-zoo studio. All rights reserved.
//

#import "Bee.h"

/**
 *	ECMobile配置管理类
 */
@interface ECMobilePushUnread : BeeModel

AS_SINGLETON( ECMobilePushUnread )

AS_NOTIFICATION( UPDATING )
AS_NOTIFICATION( UPDATED )

@property (nonatomic, readonly) NSUInteger	count;

- (void)update;

@end
