//
//  ServiceUnionPay.m
//  gaibianjia
//
//  Created by PURPLEPENG on 9/11/15.
//  Copyright (c) 2015 Geek Zoo Studio. All rights reserved.
//

#import "ServiceUnionPay.h"

#pragma mark -

NSString * const UnionPaySucceedNotification = @"UnionPaySucceedNotification";
NSString * const UnionPayFailedNotification = @"UnionPayFailedNotification";
NSString * const UnionPayCanceledNotification = @"UnionCanceledNotification";

#pragma mark -

static NSString * const kUPPayModeDistrbution = @"00"; // 正式环境
static NSString * const kUPPayModeDevelopment = @"01"; // 测试环境

#pragma mark -

@implementation ServiceUnionPay

DEF_SINGLETON( ServiceUnionPay )

#pragma mark -

- (ServiceUnionPayConfig *)config
{
    return [ServiceUnionPayConfig sharedInstance];
}

#pragma mark -

- (void)payInViewController:(UIViewController *)viewController
{
    [UPPayPlugin startPay:self.config.tn
                     mode:kUPPayModeDistrbution
           viewController:viewController
                 delegate:self];
}

#pragma mark -

- (void)UPPayPluginResult:(NSString *)result
{
    if ( [result isEqualToString:@"success"] )
    {
        //支付成功
        [self notifySucceed];
    }
    else if ( [result isEqualToString:@"fail"] )
    {
        //支付失败
        [self notifyFailed];
    }
    else if( [result isEqualToString:@"cancel"] )
    {
        //取消操作
        if ( self.whenCancel )
        {
            self.whenCancel();
        }
    }
}

#pragma mark -

- (void)notifySucceed
{
    [[NSNotificationCenter defaultCenter] postNotificationName:UnionPaySucceedNotification object:nil];
    
    if ( self.whenSucceed )
    {
        self.whenSucceed();
    }
}

- (void)notifyFailed
{
    [[NSNotificationCenter defaultCenter] postNotificationName:UnionPayFailedNotification object:nil];
    
    if ( self.whenFailed )
    {
        self.whenFailed();
    }
}

- (void)notifyCanceled
{
    [[NSNotificationCenter defaultCenter] postNotificationName:UnionPayCanceledNotification object:nil];
    
    if ( self.whenCancel )
    {
        self.whenCancel();
    }
}

@end
