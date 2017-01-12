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

#import "E3_PendingReceivedCellFooter_iPhone.h"
#import "ECMobileManager.h"

#pragma mark -

@implementation E3_PendingReceivedCellFooter_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

- (void)load
{
    if (IS_SCREEN_55_INCH)
    {
        $(@"#shipping").CSS(@"width:80px;left:30px;");
        $(@"#confirm").CSS(@"width:80px");
    }
    if (IS_SCREEN_47_INCH)
    {
        $(@"#shipping").CSS(@"width:80px;left:15px;");
        $(@"#confirm").CSS(@"width:80px");
    }
    if (IS_SCREEN_4_INCH)
    {
        $(@"#shipping").CSS(@"width:70px;left:5px;");
        $(@"#confirm").CSS(@"width:70px");
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
        $(@"#cart-goods-price").TEXT( self.data );
    }
    else
    {
        $(@"#cart-goods-price").TEXT(@"0.00");
    }
	
	if ( [[ECMobileAppConfig sharedInstance] kuaidi100Key] )
	{
		$(@"#shipping").SHOW();
	}
	else
	{
		$(@"#shipping").HIDE();
	}

}

@end
