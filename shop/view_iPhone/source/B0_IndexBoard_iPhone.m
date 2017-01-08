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
#import "D0_SearchBoard_iPhone.h"
#import "E8_IntegralBoard_iPhone.h"
#import "E7_FollowBoard_iPhone.h"
#import "D0_SearchInput_iPhone.h"

#import "CommonFootLoader.h"
#import "CommonPullLoader.h"

#import "B0_IndexNotifiBarCell_iPhone.h"
#import "B0_BannerCell_iPhone.h"
#import "B0_IndexRecommendCell_iPhone.h"
#import "B0_IndexCategoryCell_iPhone.h"
#import "B0_IndexButtonCell_iPhone.h"
#import "B1_ProductListSearchBackgroundCell_iPhone.h"

#import "ECMobileManager.h"

#pragma mark -

@interface B0_IndexBoard_iPhone()
{
    D0_SearchInput_iPhone * _titleSearch;
    B1_ProductListSearchBackgroundCell_iPhone * _searchBackground;
}
@end

@implementation B0_IndexBoard_iPhone

SUPPORT_RESOURCE_LOADING( YES )
SUPPORT_AUTOMATIC_LAYOUT( YES )

DEF_MODEL( BannerModel,		bannerModel );
DEF_MODEL( CategoryModel,	categoryModel );
DEF_MODEL( UserModel, userModel);

DEF_OUTLET( BeeUIScrollView, list )
DEF_OUTLET( B0_IndexNotifiBarCell_iPhone, notifyButton )

#pragma mark -

- (void)load
{
	self.bannerModel	= [BannerModel modelWithObserver:self];
	self.categoryModel	= [CategoryModel modelWithObserver:self];
    self.userModel = [UserModel modelWithObserver:self];
}

- (void)unload
{
	self.bannerModel	= nil;
	self.categoryModel	= nil;
    
    SAFE_RELEASE_MODEL( self.userModel );
}

#pragma mark -

ON_CREATE_VIEWS( signal )
{
//    self.notifyButton = [B0_IndexNotifiBarCell_iPhone cell];
//    [self showNavigationBarAnimated:NO];
//    [self setTitleString:__TEXT(@"ecmobile")];
    
    self.navigationBarShown = YES;
//    self.navigationBarTitle = __TEXT(@"ecmobile");
    

//    self.navigationBarRight = self.notifyButton;

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
        self.list.total += 1;       // add nhj, 多加一排按钮在轮播图片之下
        
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
        
        // 轮播图片之下的一排按钮
        {
            BeeUIScrollItem * item = self.list.items[offset];
            item.clazz = [B0_IndexButtonCell_iPhone class];
            item.data = self.userModel;        // 可能会传值判断教师？学生？
            item.size = CGSizeMake( self.list.width, 55);
            item.rule = BeeUIScrollLayoutRule_Line;
            item.insets = UIEdgeInsetsMake(0, 0, 0, 0);
            
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
        
        [[UserModel sharedInstance] updateProfile];

        [[CartModel sharedInstance] reload];
		
		[[ECMobilePushUnread sharedInstance] update];
    };
    
    [self observeNotification:UserModel.LOGIN];
    [self observeNotification:UserModel.LOGOUT];
    [self observeNotification:UserModel.KICKOUT];
    [self observeNotification:UserModel.UPDATED];
    
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
//	[self.list reloadData];

	[bee.ui.appBoard showTabbar];

    [[CartModel sharedInstance] reload];
//	[[ECMobilePushUnread sharedInstance] update];
    
    if (_titleSearch == nil)
    {
        _searchBackground = [[B1_ProductListSearchBackgroundCell_iPhone alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self.view insertSubview:_searchBackground atIndex:self.view.subviews.count];
        
        _titleSearch = [[D0_SearchInput_iPhone alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44.0f)];
        self.navigationBarTitle = _titleSearch;
    }
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
    
    [self.list reloadData];
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
    [self.stack pushBoard:[D0_SearchBoard_iPhone board] animated:YES];
//    [self.stack pushBoard:[G2_MessageBoard_iPhone board] animated:YES];
}

#pragma mark - BeeUITextField, search

ON_SIGNAL2( BeeUITextField, signal )
{
    BeeUITextField * textField = (BeeUITextField *)signal.source;
    
    if ([signal is:BeeUITextField.RETURN])
    {
        // do search
        [self doSearch:textField.text];
        [textField endEditing:YES];
        _searchBackground.hidden = YES;
    }
    
    if ([signal is:BeeUITextField.WILL_ACTIVE])
    {
        _searchBackground.hidden = NO;
    }
    
    if ([signal is:BeeUITextField.WILL_DEACTIVE])
    {
        _searchBackground.hidden = YES;
    }
}

#pragma mark - B0_BannerPhotoCell_iPhone

// modify nhj,屏蔽点击轮播图的跳转
/**
 * 首页-banner，点击事件触发时执行的操作
 */
//ON_SIGNAL3( B0_BannerPhotoCell_iPhone, mask, signal )
//{
//    BANNER * banner = signal.sourceCell.data;
//    
//	if ( banner )
//	{
//        // 首页轮播图片带有不同的信息，跳转至不同的页面
//        // 其中的action由本地的xml文件中写入
//        if ( [banner.action isEqualToString:BANNER_ACTION_GOODS] )
//        {
//            B2_ProductDetailBoard_iPhone * board = [B2_ProductDetailBoard_iPhone board];
//            board.goodsModel.goods_id = banner.action_id;
//            [self.stack pushBoard:board animated:YES];
//        }
//        else if ( [banner.action isEqualToString:BANNER_ACTION_BRAND] )
//        {
//            B1_ProductListBoard_iPhone * board = [B1_ProductListBoard_iPhone board];
//            board.searchByHotModel.filter.brand_id = banner.action_id;
//            board.searchByCheapestModel.filter.brand_id = banner.action_id;
//            board.searchByExpensiveModel.filter.brand_id = banner.action_id;
//            [self.stack pushBoard:board animated:YES];
//        }
//        else if ( [banner.action isEqualToString:BANNER_ACTION_CATEGORY] )
//        {
//            B1_ProductListBoard_iPhone * board = [B1_ProductListBoard_iPhone board];
//			board.category = banner.description;
//            board.searchByHotModel.filter.category_id = banner.action_id;
//            board.searchByCheapestModel.filter.category_id = banner.action_id;
//            board.searchByExpensiveModel.filter.category_id = banner.action_id;
//            [self.stack pushBoard:board animated:YES];
//        }
//        else
//        {
//            H0_BrowserBoard_iPhone * board = [[[H0_BrowserBoard_iPhone alloc] init] autorelease];
//            board.defaultTitle = banner.description.length ? banner.description : __TEXT(@"new_activity");
//            board.urlString = banner.url;
//            [self.stack pushBoard:board animated:YES];
//        }
//	}
//}

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

#pragma mark - B-_IndexButtonCell_iPhone

/**
 * 首页-全部商品按钮，点击事件触发时执行的操作
 */
ON_SIGNAL3( B0_IndexButtonCell_iPhone, all_goods_col, signal )
{
    [self.stack pushBoard:[D0_SearchBoard_iPhone board] animated:YES];
}

/**
 * 首页-教师积分按钮，点击事件触发时执行的操作
 */
ON_SIGNAL3( B0_IndexButtonCell_iPhone, integral_col, signal )
{
    E8_IntegralBoard_iPhone * board = [[E8_IntegralBoard_iPhone alloc] init];
//    board.user_id = self.userModel.user.id;
    [self.stack pushBoard:board animated:YES];
}
/**
 
 * 首页-关注教师按钮，点击事件触发时执行的操作
 */
ON_SIGNAL3( B0_IndexButtonCell_iPhone, follow_col, signal )
{
    E7_FollowBoard_iPhone * board = [[E7_FollowBoard_iPhone alloc] init];
    board.user_id = self.userModel.user.id;
    [self.stack pushBoard:board animated:YES];
}

/**
 * 首页-通知按钮，点击事件触发时执行的操作
 */
ON_SIGNAL3( B0_IndexButtonCell_iPhone, notify_col, signal )
{
    [self.stack pushBoard:[G2_MessageBoard_iPhone board] animated:YES];
}

/**
 * 首页-联系客服，点击事件触发时执行的操作
 */
ON_SIGNAL3( B0_IndexButtonCell_iPhone, connect_col, signal )
{
//    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"18380207432"];
//    UIWebView * callWebview = [[UIWebView alloc] init];
//    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//    [self.view addSubview:callWebview];
//    [callWebview release];
//    [str release];
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"18380207432"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
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

#pragma mark - search product by keyword

- (void)doSearch:(NSString *)keyword
{
    if ( keyword.length )
    {
        B1_ProductListBoard_iPhone * board = [[[B1_ProductListBoard_iPhone alloc] init] autorelease];
        board.searchByHotModel.filter.keywords = keyword;
        board.searchByCheapestModel.filter.keywords = keyword;
        board.searchByExpensiveModel.filter.keywords = keyword;
        [self.stack pushBoard:board animated:YES];
    }
    else
    {
        [self presentFailureTips:@"请输入搜索内容"];
    }
}

@end
