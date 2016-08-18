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

#import "Bee.h"

#pragma mark -

/**
 * 商品列表-TABBAR（人气排行/最贵/最便宜）对应的cell
 */
@interface B1_ProductListFilterCell_iPhone : BeeUICell

AS_OUTLET( BeeUIImageView, item_popular_indicator )
AS_OUTLET( BeeUIImageView, item_expensive_indicator )
AS_OUTLET( BeeUIImageView, item_cheap_indicator )

- (void)selectTab1;
- (void)selectTab2;
- (void)selectTab3;

@end
