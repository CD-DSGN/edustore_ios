//
//                       __
//                      /\ \   _
//    ____    ____   ___\ \ \_/ \           _____    ___     ___
//   / _  \  / __ \ / __ \ \    <     __   /\__  \  / __ \  / __ \
//  /\ \_\ \/\  __//\  __/\ \ \\ \   /\_\  \/_/  / /\ \_\ \/\ \_\ \
//  \ \____ \ \____\ \____\\ \_\\_\  \/_/   /\____\\ \____/\ \____/
//   \/____\ \/____/\/____/ \/_//_/         \/____/ \/___/  \/___/
//     /\____/
//     \/___/
//
//	Powered by BeeFramework
//

#import "E1_PendingPaymentCellFooter_iPhone.h"

#pragma mark -

@implementation E1_PendingPaymentCellFooter_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

- (void)load
{
    // 页面适配调整
    if (IS_SCREEN_55_INCH)
    {
        $(@"#pay").CSS(@"width:80px");
        $(@"#cancel").CSS(@"width:80px;left:30px;");
    }
    if (IS_SCREEN_47_INCH)
    {
        $(@"#pay").CSS(@"width:80px");
        $(@"#cancel").CSS(@"width:80px;left:15px");
    }
    if (IS_SCREEN_4_INCH)
    {
        $(@"#pay").CSS(@"width:70px");
        $(@"#cancel").CSS(@"width:70px;left:5px");
    }
}

- (void)unload
{
}

- (void)dataDidChanged
{
    $(@"#cart-goods-desc").TEXT( __TEXT(@"balance_rental") );
    
    if ( self.data )
    {
		ORDER * order = self.data;
		
        $(@"#cart-goods-price").TEXT( order.total_fee );
		
		if ( [order.order_info.pay_code isEqualToString:@"cod"] )
		{
			$(@"#pay").HIDE();
		}
		else
		{
			$(@"#pay").SHOW();
		}
    }
    else
    {
        $(@"#cart-goods-price").TEXT(@"0.00");
    }
}

@end
