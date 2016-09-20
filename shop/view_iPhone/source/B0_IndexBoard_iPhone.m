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
//  Powered by BeeFramework
//

#import "B0_IndexBoard_iPhone.h"
#import "AppBoard_iPhone.h"
#import "B1_ProductListBoard_iPhone.h"
#import "B2_ProductDetailBoard_iPhone.h"
#import "H0_BrowserBoard_iPhone.h"
#import "G1_HelpBoard_iPhone.h"
#import "G2_MessageBoard_iPhone.h"

#import "CommonFootLoader.h"
#import "CommonPullLoader.h"

#import "B0_IndexNotifiBarCell_iPhone.h"
#import "B0_BannerCell_iPhone.h"
#import "B0_IndexRecommendCell_iPhone.h"
#import "B0_IndexCategoryCell_iPhone.h"

#import "ECMobileManager.h"

#pragma mark -

@implementation B0_IndexBoard_iPhone

SUPPORT_RESOURCE_LOADING( YES )
SUPPORT_AUTOMATIC_LAYOUT( YES )

DEF_MODEL( BannerModel,		bannerModel );
DEF_MODEL( CategoryModel,	categoryModel );

DEF_OUTLET( BeeUIScrollView, list )
DEF_OUTLET( B0_IndexNotifiBarCell_iPhone, notifyButton )

#pragma mark -

- (void)load
{
	self.bannerModel	= [BannerModel modelWithObserver:self];
	self.categoryModel	= [CategoryModel modelWithObserver:self];
}

- (void)unload
{
	self.bannerModel	= nil;
	self.categoryModel	= nil;
}

#pragma mark -

ON_CREATE_VIEWS( signal )
{
    self.notifyButton = [B0_IndexNotifiBarCell_iPhone cell];
//    [self showNavigationBarAnimated:NO];
//    [self setTitleString:__TEXT(@"ecmobile")];
    
    self.navigationBarShown = YES;
    self.navigationBarTitle = __TEXT(@"ecmobile");
    

    self.navigationBarRight = self.notifyButton;

//    [self showBarButton:BeeUINavigationBar.RIGHT custom:[B0_IndexNotifiBarCell_iPhone cell]];
//    $(self.rightBarButton).FIND(@"#badge-bg, #badge-count").HIDE();

    /**
     * BeeFramework中scrollView使用方式由0.4.0改为0.5.0
     * 将board中BeeUIScrollView对应的signal转换为block的实现方式
     * BeeUIScrollView的block方式写法可以从它对应的delegate方法中转换而来
     */

    @weakify(self);

    self.list.headerClass = [CommonPullLoader class];
    self.list.headerShown = YES;

    self.list.lineCount = 1;
    self.list.animationDuration = 0.25f;

    self.list.whenReloading = ^
    {
        @normalize(self);
        // scrollView item count
        self.list.total = self.bannerModel.banners.count ? 1 : 0;
        self.list.total += self.bannerModel.goods.count ? 1 : 0;
        self.list.total += self.categoryModel.categories.count;

        int offset = 0;
		
        if ( self.bannerModel.banners.count )   // 应该是轮播图片
        {
            BeeUIScrollItem * banner = self.list.items[offset];
            banner.clazz = [B0_BannerCell_iPhone class];
            banner.data = self.bannerModel.banners;             // array
            banner.size = CGSizeMake( self.list.width, 150.0f);
            // rule 水平的：width固定，垂直的：height固定
            banner.rule = BeeUIScrollLayoutRule_Line;
            banner.insets = UIEdgeInsetsMake(0, 0, 0, 0);

            offset += 1;
        }

        if ( self.bannerModel.goods.count )     // 轮播商品？？不知道
        {
            BeeUIScrollItem * recommendGoods = self.list.items[offset];
            recommendGoods.clazz = [B0_IndexRecommendCell_iPhone class];
            recommendGoods.data = self.bannerModel.goods;
            recommendGoods.size = CGSizeAuto; // TODO:
            recommendGoods.rule = BeeUIScrollLayoutRule_Line;
            recommendGoods.insets = UIEdgeInsetsMake(0, 0, 0, 0);
            
            offset += 1;
        }
        // 应该是分类推荐
        for ( int i = 0; i < self.categoryModel.categories.count; i++ )
        {
            BeeUIScrollItem * categoryItem = self.list.items[ i + offset ];
            categoryItem.clazz = [B0_IndexCategoryCell_iPhone class];
            categoryItem.data = [self.categoryModel.categories safeObjectAtIndex:i];
            categoryItem.size = CGSizeMake( self.list.width, 190.0f );
            categoryItem.rule = BeeUIScrollLayoutRule_Line;
            categoryItem.insets = UIEdgeInsetsMake(0, 0, 0, 0);
        }
        
        offset += self.categoryModel.categories.count;
    };
    // 下拉刷新
    self.list.whenHeaderRefresh = ^
    {
        [self.bannerModel reload];
        [self.categoryModel reload];

        [[CartModel sharedInstance] reload];
		
		[[ECMobilePushUnread sharedInstance] update];
    };
    
	[self observeNotification:ECMobilePushUnread.UPDATING];
	[self observeNotification:ECMobilePushUnread.UPDATED];
}

ON_DELETE_VIEWS( signal )
{
    self.list = nil;
    
	[self unobserveNotification:ECMobilePushUnread.UPDATING];
	[self unobserveNotification:ECMobilePushUnread.UPDATED];
}

ON_LAYOUT_VIEWS( signal )
{
}

ON_WILL_APPEAR( signal )
{
	[self.list reloadData];

	[bee.ui.appBoard showTabbar];

//		[[CartModel sharedInstance] reload];

	[[ECMobilePushUnread sharedInstance] update];
}

ON_DID_APPEAR( signal )
{
	if ( NO == self.bannerModel.loaded )
	{
		[self.bannerModel reload];
	}

	if ( NO == self.categoryModel.loaded )
    {
        [self.categoryModel reload];
    }
    
//    [self.list reloadData];
}

ON_WILL_DISAPPEAR( signal )
{
	[CartModel sharedInstance].loaded = NO;
}

ON_DID_DISAPPEAR( signal )
{
}

ON_LOAD_DATAS( signal )
{
    [self.bannerModel loadCache];
    [self.categoryModel loadCache];
}

#pragma mark -

ON_LEFT_BUTTON_TOUCHED( signal )
{
}

ON_RIGHT_BUTTON_TOUCHED( signal )
{
    [self.stack pushBoard:[G2_MessageBoard_iPhone board] animated:YES];
}

#pragma mark - B0_BannerPhotoCell_iPhone

/**
 * 首页-banner，点击事件触发时执行的操作
 */
ON_SIGNAL3( B0_BannerPhotoCell_iPhone, mask, signal )
{
    BANNER * banner = signal.sourceCell.data;
    
	if ( banner )
	{
        // 首页轮播图片带有不同的信息，跳转至不同的页面
        // 其中的action由本地的xml文件中写入
        if ( [banner.action isEqualToString:BANNER_ACTION_GOODS] )
        {
            B2_ProductDetailBoard_iPhone * board = [B2_ProductDetailBoard_iPhone board];
            board.goodsModel.goods_id = banner.action_id;
            [self.stack pushBoard:board animated:YES];
        }
        else if ( [banner.action isEqualToString:BANNER_ACTION_BRAND] )
        {
            B1_ProductListBoard_iPhone * board = [B1_ProductListBoard_iPhone board];
            board.searchByHotModel.filter.brand_id = banner.action_id;
            board.searchByCheapestModel.filter.brand_id = banner.action_id;
            board.searchByExpensiveModel.filter.brand_id = banner.action_id;
            [self.stack pushBoard:board animated:YES];
        }
        else if ( [banner.action isEqualToString:BANNER_ACTION_CATEGORY] )
        {
            B1_ProductListBoard_iPhone * board = [B1_ProductListBoard_iPhone board];
			board.category = banner.description;
            board.searchByHotModel.filter.category_id = banner.action_id;
            board.searchByCheapestModel.filter.category_id = banner.action_id;
            board.searchByExpensiveModel.filter.category_id = banner.action_id;
            [self.stack pushBoard:board animated:YES];
        }
        else
        {
            H0_BrowserBoard_iPhone * board = [[[H0_BrowserBoard_iPhone alloc] init] autorelease];
            board.defaultTitle = banner.description.length ? banner.description : __TEXT(@"new_activity");
            board.urlString = banner.url;
            [self.stack pushBoard:board animated:YES];
        }
	}
}

#pragma mark - B0_IndexCategoryCell_iPhone

/**
 * 首页-分类商品-分类，点击事件触发时执行的操作
 */
ON_SIGNAL3( B0_IndexCategoryCell_iPhone, CATEGORY_TOUCHED, signal )
{
    CATEGORY * category = signal.sourceCell.data;
    
    if ( category )
    {
        B1_ProductListBoard_iPhone * board = [B1_ProductListBoard_iPhone board];
        board.category = category.name;
        board.searchByHotModel.filter.category_id = category.id;
        board.searchByCheapestModel.filter.category_id = category.id;
        board.searchByExpensiveModel.filter.category_id = category.id;
        [self.stack pushBoard:board animated:YES];
    }
}

/**
 * 首页-分类商品-商品1，点击事件触发时执行的操作
 */
ON_SIGNAL3( B0_IndexCategoryCell_iPhone, GOODS1_TOUCHED, signal )
{
    CATEGORY * category = signal.sourceCell.data;
    
    if ( category )
    {
        SIMPLE_GOODS * goods = [category.goods safeObjectAtIndex:1];
        
        if ( goods )
        {
            B2_ProductDetailBoard_iPhone * board = [B2_ProductDetailBoard_iPhone board];
            board.goodsModel.goods_id = goods.id;
            [self.stack pushBoard:board animated:YES];
        }
    }
}

/**
 * 首页-分类商品-商品2，点击事件触发时执行的操作
 */
ON_SIGNAL3( B0_IndexCategoryCell_iPhone, GOODS2_TOUCHED, signal )
{
    CATEGORY * category = signal.sourceCell.data;
    
    if ( category )
    {
        SIMPLE_GOODS * goods = [category.goods safeObjectAtIndex:2];
        
        if ( goods )
        {
            B2_ProductDetailBoard_iPhone * board = [B2_ProductDetailBoard_iPhone board];
            board.goodsModel.goods_id = goods.id;
            [self.stack pushBoard:board animated:YES];
        }
    }
}

#pragma mark - B0_IndexRecommendGoodsCell_iPhone

/**
 * 首页-推荐商品，点击事件触发时执行的操作
 */
ON_SIGNAL3( B0_IndexRecommendGoodsCell_iPhone, mask, signal )
{
    SIMPLE_GOODS * goods = signal.sourceCell.data;
	if ( goods )
	{
	    B2_ProductDetailBoard_iPhone * board = [B2_ProductDetailBoard_iPhone board];
		board.goodsModel.goods_id = goods.id;
		[self.stack pushBoard:board animated:YES];
	}
}

#pragma mark - B0_IndexNotifiBarCell_iPhone

/**
 * 首页-通知按钮，点击事件触发时执行的操作
 */
ON_SIGNAL3( B0_IndexNotifiBarCell_iPhone, notify, signal )
{
    if ( [signal is:BeeUIButton.TOUCH_UP_INSIDE ] )
    {
        [self.stack pushBoard:[G2_MessageBoard_iPhone board] animated:YES];
    }
}

#pragma mark -

ON_NOTIFICATION3( ECMobilePushUnread, UPDATING, notification )
{
	self.notifyButton.data = @([ECMobilePushUnread sharedInstance].count);
}

ON_NOTIFICATION3( ECMobilePushUnread, UPDATED, notification )
{
	self.notifyButton.data = @([ECMobilePushUnread sharedInstance].count);
	
	[UIApplication sharedApplication].applicationIconBadgeNumber = [ECMobilePushUnread sharedInstance].count;
}

#pragma mark -

ON_MESSAGE3( API, home_data, msg )
{
	if ( msg.sending )
	{
//		if ( NO == self.bannerModel.loaded && 0 == self.bannerModel.banners.count )
//		{
//			[self presentLoadingTips:__TEXT(@"tips_loading")];
//		}
	}
	else
	{
		[self.list setHeaderLoading:NO];

		[self dismissTips];
		
		if ( msg.succeed )
		{
			[self.list asyncReloadData];
		}
		else if ( msg.failed )
		{
			[self showErrorTips:msg];
		}
	}
}

ON_MESSAGE3( API, home_category, msg )
{
	if ( msg.sending )
	{
//		if ( NO == self.categoryModel.loaded && 0 == self.categoryModel.categories.count )
//		{
//			[self presentLoadingTips:__TEXT(@"tips_loading")];
//		}
	}
	else
	{
		[self.list setHeaderLoading:NO];

		[self dismissTips];
		
		if ( msg.succeed )
		{
			[self.list asyncReloadData];
		}
		else if ( msg.failed )
		{
			[self showErrorTips:msg];
		}
	}
}

@end