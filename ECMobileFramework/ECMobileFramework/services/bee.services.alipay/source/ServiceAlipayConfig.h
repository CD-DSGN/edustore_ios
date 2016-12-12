//
//  ServiceAlipayConfig.h
//  gaibianjia
//
//  Created by PURPLEPENG on 9/11/15.
//  Copyright (c) 2015 Geek Zoo Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceAlipayConfig : NSObject

AS_SINGLETON( ServiceAlipayConfig )

@property (nonatomic, strong) NSString * partner;
@property (nonatomic, strong) NSString * seller;
@property (nonatomic, strong) NSString * privateKey;
@property (nonatomic, strong) NSString * publicKey;
@property (nonatomic, strong) NSString * notifyURL;
@property (nonatomic, strong) NSString * tradeNO;
@property (nonatomic, strong) NSString * productName;
@property (nonatomic, strong) NSString * productDescription;
@property (nonatomic, strong) NSString * amount;
// TODO:
@property (nonatomic, strong) NSString * wapCallBackURL;

@property (nonatomic, strong) NSString * signString;

@end
