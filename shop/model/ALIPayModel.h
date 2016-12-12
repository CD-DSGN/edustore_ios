//
//  ALIPayModel.h
//  shop
//
//  Created by guangnian dashu on 16/11/1.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - POST /get_sign

@interface REQ_SIGN_ALIPAY : BeeActiveObject
@property (nonatomic, copy) NSNumber * order_id;
@property (nonatomic, retain) SESSION * session;
@end

@interface RESP_SIGN_ALIPAY : BeeActiveObject
@property (nonatomic, retain) NSString * signString;
@end

@interface API_SIGN_ALIPAY : BeeAPI
@property (nonatomic, retain) REQ_SIGN_ALIPAY * req;
@property (nonatomic, retain) RESP_SIGN_ALIPAY * resp;
@end

// 根据订单获取签名
@interface ALIPayModel : BeeOnceViewModel

@property (nonatomic, retain) IN NSNumber *       order_id; // 商品订单号

@property (nonatomic, retain) OUT NSString * signString;

- (void)pay;

@end
