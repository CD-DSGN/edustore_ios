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

#import "AppDelegate.h"
#import "AppBoard_iPad.h"
#import "AppBoard_iPhone.h"

#import "controller.h"
#import "model.h"
#import "ecmobile.h"
#import "MobClick.h"
#import "ECMobileManager.h"

#import "bee.services.alipay.h"
#import "bee.services.location.h"
#import "bee.services.share.weixin.h"
#import "bee.services.share.sinaweibo.h"
#import "bee.services.share.tencentweibo.h"
#import "bee.services.wizard.h"
#import "bee.services.siri.h"
#import "bee.services.push.h"
#import "bee.services.uppayplugin.h"

@implementation AppDelegate

#pragma mark -

- (void)load
{
	// [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[AppBoard_iPhone sharedInstance] prefersStatusBarHidden];
    [[AppBoard_iPhone sharedInstance] prefersStatusBarStyle];
    
	bee.ui.config.ASR = YES;		// Signal自动路由
	bee.ui.config.iOS6Mode = YES;	// iOS6.0界面布局

	[[BeeUITemplateManager sharedInstance] preloadResources];
	[[BeeUITemplateManager sharedInstance] preloadPackages];

	[ArticleGroupModel	sharedInstance];
	[BannerModel		sharedInstance];
	[CartModel			sharedInstance];
	[CategoryModel		sharedInstance];
	[ConfigModel		sharedInstance];
	[UserModel			sharedInstance];

    // 配置ECSHOP
    // [ServerConfig sharedInstance].url = @"http://shop.ecmobile.cn/ecmobile/?url=";
//     [ServerConfig sharedInstance].url = @"http://60.205.92.85/ecmobile/?url=";
    [ServerConfig sharedInstance].url = @"http://nhj.s1.natapp.cc/edustore/ecmobile-ios/?url=";
    // [ServerConfig sharedInstance].url = @"http://localhost/edustore/ecmobile/?url=";
    
    // 配置管理后台
//    [ECMobileManager sharedInstance].appID	= @"52653a425feb4754";
//    [ECMobileManager sharedInstance].appKey	= @"00d4f7310e493c3e92026f71a825c253";
    [ECMobileManager sharedInstance].appID	= @"99357ad345fc1d73";
    [ECMobileManager sharedInstance].appKey	= @"0512f4115e873d99f579b900fb6c8dc4";
    
	// 配置闪屏
    bee.services.wizard.config.showBackground  = YES;
    bee.services.wizard.config.showPageControl = YES;
    bee.services.wizard.config.backgroundImage = [UIImage imageNamed:@"tuitional_bg.jpg"];
    bee.services.wizard.config.pageDotSize   = CGSizeMake( 11.0f, 11.0f );
    bee.services.wizard.config.pageDotLast   = [UIImage imageNamed:@"tuitional-carousel-btn-last.png"];
    bee.services.wizard.config.pageDotNormal = [UIImage imageNamed:@"tuitional-carousel-active-btn.png"];
	bee.services.wizard.config.pageDotHighlighted = [UIImage imageNamed:@"tuitional-carousel-btn.png"];

	bee.services.wizard.config.splashes[0] = @"wizard_1.xml";
	bee.services.wizard.config.splashes[1] = @"wizard_2.xml";
	bee.services.wizard.config.splashes[2] = @"wizard_3.xml";
	bee.services.wizard.config.splashes[3] = @"wizard_4.xml";
	bee.services.wizard.config.splashes[4] = @"wizard_5.xml";
    
	// 配置提示框
	{
		[BeeUITipsCenter setDefaultContainerView:self.window];
		[BeeUITipsCenter setDefaultBubble:[UIImage imageNamed:@"alertBox.png"]];
		[BeeUITipsCenter setDefaultMessageIcon:[UIImage imageNamed:@"icon.png"]];
		[BeeUITipsCenter setDefaultSuccessIcon:[UIImage imageNamed:@"icon.png"]];
		[BeeUITipsCenter setDefaultFailureIcon:[UIImage imageNamed:@"icon.png"]];
	}

	// 配置导航条
	{
		[BeeUINavigationBar setTitleColor:[UIColor whiteColor]];
        [BeeUINavigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"]];
    }
	
	[self observeNotification:ECMobileAppConfig.UPDATING];
	[self observeNotification:ECMobileAppConfig.UPDATED];
	
	[self updateConfig];
	
	self.window.rootViewController = [AppBoard_iPhone sharedInstance];
	
	[MobClick appLaunched];
    
}

- (void)unload
{
	[self unobserveAllNotifications];

	[MobClick appTerminated];
}

#pragma mark -

ON_NOTIFICATION3( ECMobileAppConfig, UPDATING, notification )
{
}

ON_NOTIFICATION3( ECMobileAppConfig, UPDATED, notification )
{
	[self updateConfig];
}

#pragma mark -

- (void)updateConfig
{
	ALIAS( bee.services.share.weixin,		weixin );
	ALIAS( bee.services.share.tencentweibo,	tweibo );
	ALIAS( bee.services.share.sinaweibo,	sweibo );
	ALIAS( bee.services.alipay,				alipay );
	ALIAS( bee.services.siri,				siri );
	ALIAS( bee.services.location,			lbs );

	// 配置微信
    //weixin.config.appId          = [[ECMobileAppConfig sharedInstance] weixinID];
    //weixin.config.appKey         = [[ECMobileAppConfig sharedInstance] weixinKey];
    //weixin.config.partnerId      = [[ECMobileAppConfig sharedInstance] weixinPartnerID];
    //weixin.config.payUrl         = @"http://shop.ecmobile.cn/ecmobile/payment/wxpay/beforepay.php";
    weixin.config.appId          = @"wxac39735575af3099";
    weixin.config.appKey         = @"gao35162016lichenzhangliu2016ohy";
    weixin.config.partnerId      = @"1403289802";
    weixin.config.payUrl         = @"http://nhj.s1.natapp.cc/edustore/ecmobile-ios/payment/wxpay/beforepay.php";
    

	// 配置新浪
    sweibo.config.appKey         = [[ECMobileAppConfig sharedInstance] sinaWeiboKey];
    sweibo.config.appSecret      = [[ECMobileAppConfig sharedInstance] sinaWeiboSecret];
    sweibo.config.redirectURI    = [[ECMobileAppConfig sharedInstance] sinaWeiboCallback];

	// 配置腾讯
    tweibo.config.appKey         = [[ECMobileAppConfig sharedInstance] tencentWeiboKey];
    tweibo.config.appSecret      = [[ECMobileAppConfig sharedInstance] tencentWeiboSecret];
    tweibo.config.redirectURI    = [[ECMobileAppConfig sharedInstance] tencentWeiboCallback];

	// 配置支付宝
//    alipay.config.partner        = [[ECMobileAppConfig sharedInstance] alipayPartnerID];
//    alipay.config.seller         = [[ECMobileAppConfig sharedInstance] alipaySeller];
//    alipay.config.privateKey     = [[ECMobileAppConfig sharedInstance] alipayPrivateKey];
//    alipay.config.publicKey      = [[ECMobileAppConfig sharedInstance] alipayPublicKey];
//    alipay.config.notifyURL      = [[ECMobileAppConfig sharedInstance] alipayCallback];
//    alipay.config.wapCallBackURL = @"http://shop.ecmobile.cn/ecmobile/payment/app_callback.php?err=";
    alipay.config.partner        = @"2088911655683743";
    alipay.config.seller         = @"2088911655683743";
    alipay.config.privateKey     = @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBANBMvQSwwr8KfGv5JTBBFxengfb4R7sDY1C9aIZbtlE0NqpuRvpbrEYcHhGhO7pOQ9rfI64Jb+gdAJwCuzd69BpcmvbCp6O78X7SwgXtV9+IC97QwLxtkDhIrHeTyzXiSudpbiRf46KS1U3gFierBpBWNmp3EUTz3MW8LM3gfxc1AgMBAAECgYARq/D9TOG4w3L61hBJn7wNzbBA+59aRldOqkML4wv8p6lbnC95Xf2nlQsYA83FaI5pKzUjtrk/v/YlRjYL5up+isk4kvQhSo7x6ipsRk195v9uxJy6bmIUYp531YkFL5LIQkaihu5jqstHK6EV8VF+iNyuhT1XFJ1TYQwW5mnvAQJBAPZM+jLHJIHwnVnDUu9ab7FORrW8l4mIJk9owJmNLw+ZPQFC922K/0DmzMcJMdsMG/+qgoqQdUA/99kQUgtA4Z0CQQDYgKncRrOXjWH5WQP+pTVu/Wu3xTN7Nrj8csAAdv6xLRGt1jwpMAAWrTd6pnzia+ldB1R/S5IZEqzPnQnmJgR5AkBCyHiG0Cx79ywTLL0OHW1vnBPcLzi/l+UbXwHqILgD+L7r2qaQU0IG7Q3VYg7coBnvZuJig+zm8PFZL+2vE3aZAkBZjGY1kRzJS5ZBj1sCoYzHWpSKT0uq5AiBimj2CEHyQKT2VQ1PL+Zper3ewiwXbvD4JIcDm9tS+ZF20gp9Ii5pAkB2TW96cGyrPuwQdUzfMY8fP1HjqmPUVc2jmfjicgNWcNOok8/85dQCSQdepwDraszxcjfb86y8s7rnvyfUVXNd";
    alipay.config.publicKey      = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB";
    alipay.config.notifyURL      = @"http://nhj.s1.natapp.cc/edustore/ecmobile-ios/payment/alipay/sdk/notify_url.php";
    alipay.config.wapCallBackURL = @"http://nhj.s1.natapp.cc/edustore/ecmobile-ios/payment/app_callback.php?err=";

	// 配置语音识别
    siri.config.showUI           = NO;
    siri.config.appID            = [[ECMobileAppConfig sharedInstance] iflyKey];

	// 配置友盟
	[MobClick setAppVersion:[BeeSystemInfo appShortVersion]];
	[MobClick setCrashReportEnabled:YES];
	[MobClick setLatitude:lbs.location.coordinate.latitude longitude:lbs.location.coordinate.longitude];
	[MobClick setLocation:lbs.location];
	[MobClick startWithAppkey:[[ECMobileAppConfig sharedInstance] umengKey] reportPolicy:BATCH channelId:nil];
}

@end
