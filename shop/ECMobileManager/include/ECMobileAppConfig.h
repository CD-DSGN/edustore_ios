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
@interface ECMobileAppConfig : BeeModel

AS_SINGLETON( ECMobileAppConfig )

AS_NOTIFICATION( UPDATING )
AS_NOTIFICATION( UPDATED )
AS_NOTIFICATION( EXPIRED )

- (NSString *)weixinID;
- (NSString *)weixinKey;
- (NSString *)weixinPartnerID;

- (NSString *)sinaWeiboKey;
- (NSString *)sinaWeiboSecret;
- (NSString *)sinaWeiboCallback;

- (NSString *)tencentWeiboKey;
- (NSString *)tencentWeiboSecret;
- (NSString *)tencentWeiboCallback;

- (NSString *)alipayKey;
- (NSString *)alipayCallback;
- (NSString *)alipayPartnerID;
- (NSString *)alipaySeller;
- (NSString *)alipayPrivateKey;
- (NSString *)alipayPublicKey;

- (NSString *)iflyKey;
- (NSString *)kuaidi100Key;
- (NSString *)umengKey;

- (void)update;

@end
