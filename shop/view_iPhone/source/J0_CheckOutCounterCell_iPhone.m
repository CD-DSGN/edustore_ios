//
//  J0_CheckOutCounterCell_iPhone.m
//  shop
//
//  Created by guangnian dashu on 2017/1/6.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "J0_CheckOutCounterCell_iPhone.h"
#import "E2_PendingShippedBoard_iPhone.h"

#import "bee.services.alipay.h"
#import "bee.services.uppayplugin.h"
#import "bee.services.share.weixin.h"

@implementation J0_CheckOutCounterCell_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

DEF_MODEL( OrderModel, orderModel )
DEF_MODEL( WXPayModel, wxpayModel )
DEF_MODEL( ALIPayModel, alipayModel )

DEF_SIGNAL( PAY_SDK )

- (void)load
{
    self.pay_method = [[UITableView alloc] init];
    
    self.payMethodList = [[NSArray alloc] init];
    self.selectIconArray = [[NSMutableArray alloc] init];
    
    self.selfCell = [[BeeUICell alloc] init];
    
    self.orderModel = [OrderModel modelWithObserver:self];
    self.orderModel.type = ORDER_LIST_AWAIT_PAY;
    self.wxpayModel = [WXPayModel modelWithObserver:self];
    self.alipayModel = [ALIPayModel modelWithObserver:self];
}

- (void)unload
{
    self.order = nil;
    self.pay_method = nil;
    
    self.selfCell = nil;
    
    self.payMethodList = nil;
    self.selectIconArray = nil;
    
    SAFE_RELEASE_MODEL( self.orderModel );
    SAFE_RELEASE_MODEL( self.wxpayModel );
    SAFE_RELEASE_MODEL( self.alipayModel );
}

- (void)dataDidChanged
{
    if (self.data)
    {
        NSMutableDictionary * info = self.data;
        _order = [info objectForKey:@"order"];
        _payMethodList = [info objectForKey:@"flow"];
        
        $(@"#desc_content").TEXT(_order.order_info.desc);
        $(@"#amount_content").TEXT(_order.total_fee);
        
        _selfCell = self;
        
        // y值在xml里确定了
        [_pay_method setFrame:CGRectMake(0, 90, SCREEN_WIDTH, _payMethodList.count * 60.0f)];
        _pay_method.delegate = self;
        _pay_method.dataSource = self;
        [self addSubview:_pay_method];
        
        [_pay_method reloadData];
    }
}


#pragma mark - 立即支付

ON_SIGNAL3(J0_CheckOutCounterCell_iPhone, pay, signal )
{
    if ([_selectPayCode isEqualToString:@""] || _selectPayCode == nil)
    {
        [self presentFailureTips:@"请选择支付方式"];
        return;
    }
    else if ([_selectPayCode isEqualToString:@"alipay"])
    {
        NSLog(@"alipay");
        [self sendUISignal:self.PAY_SDK withObject:_order];
    }
    else if([_selectPayCode isEqualToString:@"wxpay"])
    {
        NSLog(@"wxpay");
        self.wxpayModel.order_id = _order.order_id;
        [self.wxpayModel pay];
    }
}

#pragma mark - wxpay SIGNAL

ON_SIGNAL3( WXPayModel, RELOADING, signal )
{
    [self presentMessageTips:@"加载支付信息"];
}

ON_SIGNAL3( WXPayModel, RELOADED, signal )
{
    ALIAS( bee.services.share.weixin,	wxpay );
    
    if ( wxpay.installed )
    {
        @weakify(self);
        
        wxpay.config.nonceStr = self.wxpayModel.pay_info.noncestr;
        wxpay.config.timestamp = self.wxpayModel.pay_info.timestamp;
        wxpay.config.package = self.wxpayModel.pay_info.package;
        wxpay.config.prepayId = self.wxpayModel.pay_info.prepayid;
        wxpay.config.sign = self.wxpayModel.pay_info.sign;
        wxpay.whenWaiting = ^
        {
            
        };
        
        wxpay.whenSucceed = ^
        {
            @normalize(self);
            [self.orderModel firstPage];
            [self didPaySuccess];
        };
        
        wxpay.whenCannelled = ^
        {
            @normalize(self);
            [self presentMessageTips:__TEXT(@"pay_failed")];
        };
        
        wxpay.whenFailed = ^
        {
            @normalize(self);
            [self presentMessageTips:__TEXT(@"pay_failed")];
        };
        wxpay.PAY();
    }
    else
    {
        [self presentFailureTips:@"请先安装微信客户端"];
//        BeeUIAlertView * alert = [BeeUIAlertView spawn];
//        alert.message = @"请先安装微信客户端";
//        [alert addCancelTitle:__TEXT(@"button_ignore")];
        
//        [alert showInViewController:self];
    }
}

ON_SIGNAL3( WXPayModel, FAILED, signal )
{
    [self presentMessageTips:@"微信支付失败"];
}

#pragma mark - alipay SIGNAL

ON_SIGNAL3( ALIPayModel, RELOADING, signal )
{
    [self presentMessageTips:@"拉取支付信息中..."];
}

ON_SIGNAL3( ALIPayModel, RELOADED, signal )
{
    ALIAS( bee.services.alipay,	alipay );
    
    @weakify(self);
    
    alipay.config.signString = self.alipayModel.signString;
    
    alipay.whenWaiting = ^
    {
    };
    alipay.whenSucceed = ^
    {
        @normalize(self);
        [self.orderModel firstPage];
        [self didPaySuccess];
    };
    alipay.whenFailed = ^
    {
        [self presentMessageTips:__TEXT(@"pay_failed")];
    };
    alipay.PAY();
}

ON_SIGNAL3( ALIPayModel, FAILED, signal )
{
    [self presentMessageTips:@"支付出问题啦，请重试"];
}

ON_SIGNAL3( J0_CheckOutCounterCell_iPhone, PAY_SDK, signal )
{
    ORDER * order = (ORDER *)signal.object;
    
    ALIAS( bee.services.alipay,	alipay );
    
    alipay.config.tradeNO		= order.order_sn;
    alipay.config.productName	= order.order_info.subject;
    alipay.config.productDescription	= order.order_info.desc;
    alipay.config.amount	= order.order_info.order_amount;
    
    self.alipayModel.order_id = order.order_id;
    [self.alipayModel pay];
}

#pragma mark - function

- (void)selectPayMethod:(NSIndexPath *)indexPath
{
    for (int i = 0; i < _selectIconArray.count; i++)
    {
        UIImageView * selectIcon = [_selectIconArray objectAtIndex:i];
        if (indexPath.row == i)
        {
            [selectIcon setImage:[UIImage imageNamed:@"pay_select.png"]];
            PAYMENT_INFO * payment_info = [_payMethodList objectAtIndex:i];
            _selectPayId = payment_info.pay_id;
            _selectPayCode = payment_info.pay_code;
        }
        else
        {
            [selectIcon setImage:[UIImage imageNamed:@"pay_unselect.png"]];
        }
        selectIcon = nil;
    }
}

- (void)didPaySuccess
{
    
    [self updateOrderInfo];
//    [bee.ui.tabbar selectUser];
//    [bee.ui.router open:AppBoard_iPhone.TAB_USER animated:NO];
//    [bee.ui.profile.stack pushBoard:[E2_PendingShippedBoard_iPhone board] animated:NO];
    
//    [self.viewController.stack popToRootViewControllerAnimated:NO];
//    [self.stack popToRootViewControllerAnimated:NO];
    
//    UIViewController * parent = [self findViewController:_selfCell];
//    [parent.stack popToRootViewControllerAnimated:NO];
//    [self.window presentSuccessTips:__TEXT( @"pay_succeed" )];
}

- (UIViewController *)findViewController:(UIView *)sourceView
{
    id target = sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

- (void)updateOrderInfo
{
    self.CANCEL_MSG( API.writePayId );
    self
    .MSG( API.writePayId )
    .INPUT( @"pay_code", _selectPayCode )
    .INPUT( @"order_sn", _order.order_sn);
}

#pragma mark - update order info

ON_MESSAGE3( API, writePayId, msg)
{
    if (msg.sending)
    {}
    if (msg.succeed)
    {
        UIViewController * parent = [self findViewController:_selfCell];
        [parent.stack popToRootViewControllerAnimated:NO];
        [self.window presentSuccessTips:__TEXT( @"pay_succeed" )];
    }
    if (msg.failed)
    {
        UIViewController * parent = [self findViewController:_selfCell];
        [parent.stack popToRootViewControllerAnimated:NO];
        [self.window presentSuccessTips:__TEXT( @"pay_succeed" )];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _payMethodList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 就几种支付方式，不会出现复用的情况
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView * payIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 30, 30)];
    UILabel * payName = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, 100, 20)];
    UILabel * payDesc = [[UILabel alloc] initWithFrame:CGRectMake(65, 25, SCREEN_WIDTH * 0.5f, 30)];
    
    [payName setFont:[UIFont systemFontOfSize:18]];
    [payName setTextColor:[UIColor blackColor]];
    
    [payDesc setFont:[UIFont systemFontOfSize:12]];
    [payDesc setTextColor:[UIColor lightGrayColor]];
    
    PAYMENT_INFO * payment_info = [_payMethodList objectAtIndex:indexPath.row];
    if ([payment_info.pay_code isEqualToString:@"alipay"])
    {
        [payIcon setImage:[UIImage imageNamed:@"zhifubao_pay.png"]];
        [payName setText:@"支付宝"];
        [payDesc setText:@"数亿用户都在用，安全可托付"];
    }
    else if ([payment_info.pay_code isEqualToString:@"wxpay"])
    {
        [payIcon setImage:[UIImage imageNamed:@"weixin_pay.png"]];
        [payName setText:@"微信支付"];
        [payDesc setText:@"亿万用户的选择，更快更安全"];
    }
    
    UIImageView * selectIcon = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.8f, 15, 30, 30)];
    [selectIcon setImage:[UIImage imageNamed:@"pay_unselect.png"]];
    
    [_selectIconArray addObject:selectIcon];
    
    [cell addSubview:payIcon];
    [cell addSubview:payName];
    [cell addSubview:payDesc];
    [cell addSubview:selectIcon];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectPayMethod:indexPath];
}

@end
