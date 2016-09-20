//
//  ECMobileManager.h
//  ECMobileManager
//
//  Created by god on 14-2-13.
//  Copyright (c) 2014年 geek-zoo studio. All rights reserved.
//

#import "Bee.h"
#import "ECMobileAppConfig.h"
#import "ECMobilePushConfig.h"
#import "ECMobilePushList.h"
#import "ECMobilePushUnread.h"

/**
 *	ECMobile配置管理类，主要用于与管理后台通讯，获取APP配置
 *	@param appID	APP ID，请与代理商联系获取
 *	@param appID	APP Key，请与代理商联系获取
 *	@param token	用于推送的TOKEN（不需要填写）
 */
@interface ECMobileManager : NSObject

AS_SINGLETON( ECMobileManager )

@property (nonatomic, retain) NSString *				appID;
@property (nonatomic, retain) NSString *				appKey;

@property (nonatomic, readonly) ECMobileAppConfig *		appConfig;
@property (nonatomic, readonly) ECMobilePushConfig *	pushConfig;
@property (nonatomic, readonly) ECMobilePushList *		pushList;
@property (nonatomic, readonly) ECMobilePushUnread *	pushUnread;

@end
