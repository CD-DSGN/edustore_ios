//
//  J0_CheckOutCounterBoard_iPhone.m
//  shop
//
//  Created by guangnian dashu on 2017/1/6.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "J0_CheckOutCounterBoard_iPhone.h"
#import "J0_CheckOutCounterCell_iPhone.h"

@implementation J0_CheckOutCounterBoard_iPhone

DEF_SIGNAL( ACTION_PAY )
DEF_SIGNAL( ACTION_BACK )
DEF_SIGNAL( PAY_SDK )
DEF_SIGNAL( PAY_WAP )
DEF_SIGNAL( CANCEL )
DEF_SIGNAL( INSTALLATION_APP )
DEF_SIGNAL( CANCEL_APP )

DEF_MODEL( FlowModel, flowModel )
DEF_MODEL( OrderModel, orderModel )
DEF_MODEL( WXPayModel, wxpayModel )
DEF_MODEL( ALIPayModel, alipayModel )

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

DEF_OUTLET( BeeUIScrollView, list )

- (void)load
{
    self.flowModel = [FlowModel modelWithObserver:self];
    self.wxpayModel = [WXPayModel modelWithObserver:self];
    self.orderModel = [OrderModel modelWithObserver:self];
    self.alipayModel = [ALIPayModel modelWithObserver:self];
    self.orderModel.type = ORDER_LIST_AWAIT_PAY;
    
    self.payInfo = [[NSMutableDictionary alloc] init];
    self.payMethod = [[NSArray alloc] init];
}

- (void)unload
{
    SAFE_RELEASE_MODEL( self.flowModel );
    SAFE_RELEASE_MODEL( self.orderModel );
    SAFE_RELEASE_MODEL( self.wxpayModel );
    SAFE_RELEASE_MODEL( self.alipayModel );
    
    self.payInfo = nil;
    self.payMethod = nil;
}

ON_CREATE_VIEWS( signal )
{
    self.navigationBarShown = YES;
    self.navigationBarTitle = __TEXT(@"checkOutCounter");
    self.navigationBarLeft  = [UIImage imageNamed:@"nav_back.png"];
    
    @weakify(self);
    
    self.list.animationDuration = 0.25f;
    
    self.list.whenReloading = ^
    {
        @normalize(self);
        
        self.list.total = 1;
        
        BeeUIScrollItem * item = self.list.items[0];
        item.clazz = [J0_CheckOutCounterCell_iPhone class];
        item.size = self.list.size;
        item.rule = BeeUIScrollLayoutRule_Tile;
        item.data = self.payInfo;
    };
}

ON_DELETE_VIEWS( signal )
{
    self.list = nil;
}

ON_LAYOUT_VIEWS( signal )
{
}

ON_WILL_APPEAR( signal )
{
    [self searchPayment];
}

ON_DID_APPEAR( signal )
{
}

ON_WILL_DISAPPEAR( signal )
{
}

ON_DID_DISAPPEAR( signal )
{
}

ON_LEFT_BUTTON_TOUCHED( signal )
{
    [self.stack popBoardAnimated:YES];
}

- (void)searchPayment
{
    self.CANCEL_MSG( API.search_payment );
    self.MSG( API.search_payment );
}

ON_MESSAGE3( API, search_payment, msg )
{
    if ( msg.sending )
    {
    }
    else if ( msg.succeed )
    {
        NSArray * data = msg.GET_OUTPUT( @"data" );
        
        [_payInfo setObject:_order forKey:@"order"];
        [_payInfo setObject:data forKey:@"flow"];
        
        [self.list reloadData];
    }
    else if ( msg.failed )
    {
        // 获取失败应该是要显示一个错误页面，并让其刷新
        [self presentFailureTips:@"网络错误，请刷新"];
        [self.stack popBoardAnimated:YES];
    }
    else if (msg.cancelled )
    {
    }
}

@end
