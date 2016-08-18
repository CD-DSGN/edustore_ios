//
//  ServiceUnionPay.h
//  gaibianjia
//
//  Created by PURPLEPENG on 9/11/15.
//  Copyright (c) 2015 Geek Zoo Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceUnionPayConfig.h"
#import "UPPayPlugin.h"

#pragma mark -

FOUNDATION_EXPORT NSString * const UnionPaySucceedNotification;
FOUNDATION_EXPORT NSString * const UnionPayFailedNotification;
FOUNDATION_EXPORT NSString * const UnionPayCanceledNotification;

#pragma mark -

@interface ServiceUnionPay : BeeService<UPPayPluginDelegate>

AS_SINGLETON( ServiceUnionPay )

@property (nonatomic, readonly) ServiceUnionPayConfig * config;

@property (nonatomic, copy) BeeServiceBlock				whenSucceed;
@property (nonatomic, copy) BeeServiceBlock				whenFailed;
@property (nonatomic, copy) BeeServiceBlock				whenCancel;

- (void)payInViewController:(UIViewController *)viewController;

@end
