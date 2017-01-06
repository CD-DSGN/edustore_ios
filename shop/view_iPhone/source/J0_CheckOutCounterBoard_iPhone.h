//
//  J0_CheckOutCounterBoard_iPhone.h
//  shop
//
//  Created by guangnian dashu on 2017/1/6.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "Bee.h"
#import "model.h"
#import "BaseBoard_iPhone.h"

@interface J0_CheckOutCounterBoard_iPhone : BaseBoard_iPhone

AS_OUTLET( BeeUIScrollView, list )

@property (nonatomic, retain) ORDER * order;
@property (nonatomic, retain) NSMutableDictionary * payInfo;
@property (nonatomic, retain) NSArray * payMethod;

/**
 * 购物车-结算-提交订单，确定提交时触发该事件
 */
AS_SIGNAL( ACTION_PAY )

/**
 * 购物车-结算-提交订单，取消提交时触发该事件
 */
AS_SIGNAL( ACTION_BACK )

// 选择WAP或SDK支付
/**
 * 购物车-结算-提交订单-确认提交, 选择使用SDK进行支付
 */
AS_SIGNAL( PAY_SDK )

/**
 * 购物车-结算-提交订单-确认提交, 选择使用WAP进行支付
 */
AS_SIGNAL( PAY_WAP )

/**
 * 购物车-结算-提交订单-确认提交, 取消支付
 */
AS_SIGNAL( CANCEL )

/**
 * 购物车-结算-提交订单-确认提交-选择使用SDK进行支付,前往安装
 */
AS_SIGNAL( INSTALLATION_APP )

/**
 * 购物车-结算-提交订单-确认提交-选择使用SDK进行支付,忽略
 */
AS_SIGNAL( CANCEL_APP )

AS_MODEL( FlowModel, flowModel )
AS_MODEL( OrderModel, orderModel )
AS_MODEL( WXPayModel, wxpayModel )
AS_MODEL( ALIPayModel, alipayModel)

@end
