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

#import "B1_ProductListFilterCell_iPhone.h"

#pragma mark -

@implementation B1_ProductListFilterCell_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

DEF_OUTLET( BeeUIImageView, item_popular_indicator )
DEF_OUTLET( BeeUIImageView, item_expensive_indicator )
DEF_OUTLET( BeeUIImageView, item_cheap_indicator )

- (CGSize)estimateUISizeByWidth:(CGFloat)width
{
    if ( self.hidden )
    {
        return CGSizeZero;
    }
    else
    {
        return CGSizeMake( width , 44 );
    }
}

- (void)load
{
    BeeUIImageView * bg = (BeeUIImageView *)$(@".filter-bg").view;
    bg.backgroundColor = [UIImage imageNamed:@"item_grid_filter_bg.png"].patternColor;
}

- (void)unload
{
}

- (void)selectTab1
{
	$(@"#item-popular").CSS( @"color: #fff" );
	$(@"#item-cheap").CSS( @"color: #999" );
	$(@"#item-expensive").CSS( @"color: #999" );
    
    $(@"item-popular-arrow").CSS( @"image: url(item_grid_filter_down_active_arrow.png)" );
    $(@"item-cheap-arrow").CSS( @"image: url(item_grid_filter_down_arrow.png)" );
    $(@"item-expensive-arrow").CSS( @"image: url(item_grid_filter_down_arrow.png)" );
	
	self.item_popular_indicator.alpha = 1;
	self.item_cheap_indicator.alpha = 0;
	self.item_expensive_indicator.alpha = 0;
}

- (void)selectTab2
{
	$(@"#item-popular").CSS( @"color: #999" );
	$(@"#item-cheap").CSS( @"color: #fff" );
	$(@"#item-expensive").CSS( @"color: #999" );
    
    $(@"item-popular-arrow").CSS( @"image: url(item_grid_filter_down_arrow.png)" );
    $(@"item-cheap-arrow").CSS( @"image: url(item_grid_filter_down_active_arrow.png)" );
    $(@"item-expensive-arrow").CSS( @"image: url(item_grid_filter_down_arrow.png)" );

	self.item_popular_indicator.alpha = 0;
	self.item_cheap_indicator.alpha = 1;
	self.item_expensive_indicator.alpha = 0;
}

- (void)selectTab3
{
	$(@"#item-popular").CSS( @"color: #999" );
	$(@"#item-cheap").CSS( @"color: #999" );
	$(@"#item-expensive").CSS( @"color: #fff" );
    
    $(@"item-popular-arrow").CSS( @"image: url(item_grid_filter_down_arrow.png)" );
    $(@"item-cheap-arrow").CSS( @"image: url(item_grid_filter_down_arrow.png)" );
    $(@"item-expensive-arrow").CSS( @"image: url(item_grid_filter_down_active_arrow.png)" );

	self.item_popular_indicator.alpha = 0;
	self.item_cheap_indicator.alpha = 0;
	self.item_expensive_indicator.alpha = 1;
}

@end
