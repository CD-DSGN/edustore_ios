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

#import "G0_SettingBoard_iPhone.h"
#import "H0_BrowserBoard_iPhone.h"
#import "AppBoard_iPhone.h"

#import "G0_SettingCell_iPhone.h"
#import "ECMobilePushConfig.h"

#import "bee.services.share.sinaweibo.h"
#import "bee.services.share.tencentweibo.h"

#import "ECMobileManager.h"
#import "ECMobileAppConfig.h"

#import "UMFeedback.h"
#import "UMFeedbackViewController.h"

#pragma mark -

@interface G0_AboutUsBoard_iPhone : BaseBoard_iPhone

@end

@implementation G0_AboutUsBoard_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )



DEF_SINGLETON( G0_SettingBoard_iPhone )

#pragma mark -

- (void)load
{
    
}

- (void)unload
{
    
}

ON_CREATE_VIEWS(signal)
{
    self.navigationBarShown = YES;
    self.navigationBarTitle = __TEXT(@"setting_about_us");
    self.navigationBarLeft  = [UIImage imageNamed:@"nav_back.png"];
    
    
    [self observeNotification:UserModel.LOGIN];
    [self observeNotification:UserModel.LOGOUT];
    [self observeNotification:UserModel.KICKOUT];
    [self observeNotification:UserModel.UPDATED];
	
	[self observeNotification:ECMobilePushConfig.UPDATING];
	[self observeNotification:ECMobilePushConfig.UPDATED];

    
    
}

ON_DELETE_VIEWS(signal)
{
    
    [self unobserveAllNotifications];
}

ON_WILL_APPEAR(signal)
{
    [bee.ui.appBoard hideTabbar];

    [[ConfigModel sharedInstance] reload];

}

ON_LEFT_BUTTON_TOUCHED( signal )
{
	[self.stack popBoardAnimated:YES];
}



#pragma mark -

ON_NOTIFICATION3( UserModel, LOGIN, notification )
{
    self.RELAYOUT();
}

ON_NOTIFICATION3( UserModel, LOGOUT, notification )
{
    self.RELAYOUT();
}

ON_NOTIFICATION3( UserModel, KICKOUT, notification )
{
    self.RELAYOUT();
}

ON_NOTIFICATION3( ECMobilePushConfig, UPDATING, notification )
{
//	[self.list reloadData];
}

ON_NOTIFICATION3( ECMobilePushConfig, UPDATED, notification )
{

	
}



@end
