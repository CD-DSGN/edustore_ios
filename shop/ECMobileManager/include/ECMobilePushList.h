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
@interface ECMobilePushList : BeeModel

AS_SINGLETON( ECMobilePushList )

AS_NOTIFICATION( UPDATING )
AS_NOTIFICATION( UPDATED )

@property (nonatomic, readonly) BOOL		loaded;
@property (nonatomic, readonly) BOOL		more;
@property (nonatomic, readonly) NSUInteger	total;
@property (nonatomic, readonly) NSArray *	messages;

- (void)firstPage;
- (void)nextPage;

@end
