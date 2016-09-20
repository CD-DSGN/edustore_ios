//
//  ServiceAlipay.h
//  gaibianjia
//
//  Created by PURPLEPENG on 9/11/15.
//  Copyright (c) 2015 Geek Zoo Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceAlipayConfig.h"

@interface ServiceAlipay : BeeService

@property (nonatomic, readonly) ServiceAlipayConfig * config;

@property (nonatomic, copy) BeeServiceBlock				whenWaiting;
@property (nonatomic, copy) BeeServiceBlock				whenSucceed;
@property (nonatomic, copy) BeeServiceBlock				whenFailed;

@property (nonatomic, readonly) BeeServiceBlock			PAY;

AS_NOTIFICATION( WAITING )
AS_NOTIFICATION( SUCCEED )
AS_NOTIFICATION( FAILED )

@end
