//
//  J0_CheckOutCounterCell_iPhone.h
//  shop
//
//  Created by guangnian dashu on 2017/1/6.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "Bee.h"
#import "BaseBoard_iPhone.h"

#import "controller.h"
#import "model.h"

#import "UIViewController+ErrorTips.h"

@interface J0_CheckOutCounterCell_iPhone : BeeUICell<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain)UITableView * pay_method;

@property (nonatomic, retain)NSArray * payMethodList;
@property (nonatomic, retain)NSMutableArray * selectIconArray;

@property (nonatomic, retain)ORDER * order;

@property (nonatomic, retain)NSString * selectPayCode;
@property (nonatomic, retain)NSString * selectPayId;
    
@property (nonatomic, retain)BeeUICell * selfCell;

AS_MODEL( OrderModel, orderModel )

AS_MODEL( WXPayModel, wxpayModel )

AS_MODEL( ALIPayModel, alipayModel )

AS_SIGNAL( PAY_SDK )

@end
