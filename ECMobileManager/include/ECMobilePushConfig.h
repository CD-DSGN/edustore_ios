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
@interface ECMobilePushConfig : BeeModel

AS_SINGLETON( ECMobilePushConfig )

AS_NOTIFICATION( UPDATING )
AS_NOTIFICATION( UPDATED )

@property (nonatomic, retain) NSString *	token;
@property (nonatomic, readonly) BOOL		on;
@property (nonatomic, readonly) BOOL		ready;

- (void)turnOn;
- (void)turnOff;

- (void)update;

@end
