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

#import "B2_ProductDetailTabCell_iPhone.h"

#pragma mark -

@implementation B2_ProductDetailTabCell_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

- (void)load
{
	$(@"#badge-bg").HIDE();
	$(@"#badge").HIDE();
    
    // 最原始、最笨的方法调整页面
    if (IS_SCREEN_55_INCH)
    {
        $(@"#favorite").CSS(@"left: 15px;");
        $(@"#add").CSS(@"left:22px;");
        $(@"#buy").CSS(@"left:22px;");
        $(@"#badge-wrapper").CSS(@"left:54px");
    }
    if (IS_SCREEN_47_INCH)
    {
        $(@"#favorite").CSS(@"left: 15px;");
        $(@"#add").CSS(@"left:20px;");
        $(@"#buy").CSS(@"left:20px;");
    }
    if (IS_SCREEN_4_INCH)
    {
        $(@"#favorite").CSS(@"left: 10px;");
        $(@"#add").CSS(@"left:15px;");
        $(@"#buy").CSS(@"left:15px;");
        $(@"#badge-wrapper").CSS(@"left:45px");
    }
}

- (void)unload
{
}

- (void)dataDidChanged
{
	NSNumber * count = self.data;
	
	if ( count && count.intValue > 0 )
	{
		$(@"#badge-bg").SHOW();
		$(@"#badge").SHOW().DATA( count );
	}
	else
	{
		$(@"#badge-bg").HIDE();
		$(@"#badge").HIDE();
	}
}

@end
