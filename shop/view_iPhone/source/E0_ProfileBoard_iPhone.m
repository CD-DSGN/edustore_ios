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
	
#import "E0_ProfileBoard_iPhone.h"
#import "E0_ProfileHelpCell_iPhone.h"
#import "E0_ProfileCell_iPhone.h"
#import "E1_PendingPaymentBoard_iPhone.h"
#import "E2_PendingShippedBoard_iPhone.h"
#import "E3_PendingReceivedBoard_iPhone.h"
#import "E4_HistoryBoard_iPhone.h"
#import "E5_CollectionBoard_iPhone.h"
#import "E7_FollowBoard_iPhone.h"
#import "E8_IntegralBoard_iPhone.h"
#import "F0_AddressListBoard_iPhone.h"
#import "G0_SettingBoard_iPhone.h"
#import "G2_MessageBoard_iPhone.h"
#import "G1_HelpBoard_iPhone.h"

#import "AppBoard_iPhone.h"

#import "CommonPullLoader.h"
#import "ECMobileManager.h"
#import "E0_ProfileHelpBoard_iPhone.h"

#pragma mark -

DEF_UI( E0_ProfileBoard_iPhone, profile )

@implementation E0_ProfileBoard_iPhone

DEF_SINGLETON( E0_ProfileBoard_iPhone )

SUPPORT_RESOURCE_LOADING( YES );
SUPPORT_AUTOMATIC_LAYOUT( YES );

DEF_SIGNAL( PHOTO_FROM_CAMERA )
DEF_SIGNAL( PHOTO_FROM_LIBRARY )
DEF_SIGNAL( PHOTO_REMOVE )

DEF_MODEL( UserModel,			userModel );

DEF_OUTLET( BeeUIScrollView, list )

- (void)load
{
	self.userModel = [UserModel modelWithObserver:self];
}

- (void)unload
{
	SAFE_RELEASE_MODEL( self.userModel );
}

#pragma mark -

ON_CREATE_VIEWS( signal )
{
    self.navigationBarTitle = __TEXT(@"profile_personal");
    self.navigationBarShown = YES;
    
    [self showNavigationBarAnimated:NO];
    
    [self showBarButton:BeeUINavigationBar.RIGHT
                  image:[UIImage imageNamed:@"nav_right.png"]
                  image:[UIImage imageNamed:@"profile_refresh_site_icon.png"]];

    @weakify(self);
    
    self.list.headerClass = [CommonPullLoader class];
    self.list.headerShown = YES;
    
    self.list.lineCount = 1;
    self.list.animationDuration = 0.25f;
    
    self.list.whenReloading = ^
    {
        @normalize(self);
        
        self.list.total = 1;
        
        BeeUIScrollItem * item = self.list.items[0];
        item.clazz = [E0_ProfileCell_iPhone class];
        item.data = self.userModel;
        item.size = CGSizeAuto;
        item.rule = BeeUIScrollLayoutRule_Tile;
    };
    self.list.whenHeaderRefresh = ^
    {
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
    [self unobserveAllNotifications];
    
    self.list = nil;
}

ON_LAYOUT_VIEWS( signal )
{
}

ON_WILL_APPEAR( signal )
{
    self.navigationBarShown = YES;
    
    [bee.ui.appBoard showTabbar];
    
    [[CartModel sharedInstance] reload];
    
    [self updateState];
}

ON_DID_APPEAR( signal )
{
}

ON_WILL_DISAPPEAR( signal )
{
	[CartModel sharedInstance].loaded = NO;
	
    [bee.ui.appBoard hideTabbar];
}

ON_DID_DISAPPEAR( signal )
{
}

#pragma mark -

ON_LEFT_BUTTON_TOUCHED( signal )
{
}

ON_RIGHT_BUTTON_TOUCHED( signal )
{
    [self.stack pushBoard:[G0_SettingBoard_iPhone sharedInstance] animated:YES];
}

#pragma mark - E0_ProfileBoard_iPhone

ON_SIGNAL3( E0_ProfileBoard_iPhone, PHOTO_FROM_CAMERA, signal )
{
    //Take Photo with Camera
    @try
    {
        if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] )
        {
            UIImagePickerController *cameraVC = [[UIImagePickerController alloc] init];
            [cameraVC setSourceType:UIImagePickerControllerSourceTypeCamera];
            [cameraVC.navigationBar setBarStyle:UIBarStyleBlack];
            [cameraVC setDelegate:self];
            [cameraVC setAllowsEditing:YES];
//            [self presentModalViewController:cameraVC animated:YES];
            [self presentViewController:cameraVC animated:YES completion:nil];
            [cameraVC release];
        }
        else
        {
            CC(@"Camera is not available.");
        }
    }
    @catch ( NSException * exception )
    {
        CC(@"Camera is not available.");
    }
}

ON_SIGNAL3( E0_ProfileBoard_iPhone, PHOTO_FROM_LIBRARY, signal )
{
    //Show Photo Library
    @try
    {
        if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] )
        {
            UIImagePickerController *imgPickerVC = [[UIImagePickerController alloc] init];
            [imgPickerVC setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [imgPickerVC.navigationBar setBarStyle:UIBarStyleBlack];
            [imgPickerVC setDelegate:self];
            [imgPickerVC setAllowsEditing:YES];
            [self presentViewController:imgPickerVC animated:YES completion:nil];
//            [self presentModalViewController:imgPickerVC animated:YES];
            [imgPickerVC release];
        }
        else
        {
            CC(@"Album is not available.");
        }
    }
    @catch ( NSException * exception )
    {
        //Error
        CC(@"Album is not available.");
    }
}

ON_SIGNAL3( E0_ProfileBoard_iPhone, PHOTO_REMOVE, signal )
{
    UIView * item = ((BeeUIScrollItem *)self.list.items[0]).view;
    if ( nil == item )
        return;
    
    $(item).FIND(@"#header-avatar").DATA( [UIImage imageNamed:@"profile_no_avatar_icon.png"] );
    
    [[UserModel sharedInstance] setAvatar:nil];
    
//    [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - E0_ProfileCell_iPhone

/**
 * 个人中心-登录（未登录状态），点击事件触发时执行的操作
 */
ON_SIGNAL3( E0_ProfileCell_iPhone, signin, signal )
{
	if ( NO == [UserModel online] )
	{
		[bee.ui.appBoard showLogin];
		return;
	}	
}

/**
 * 个人中心-我的收藏，点击事件触发时执行的操作
 */
ON_SIGNAL3( E0_ProfileCell_iPhone, collection, signal )
{
    if ( NO == [UserModel online] )
    {
        [bee.ui.appBoard showLogin];
        return;
    }
    
    [self.stack pushBoard:[E5_CollectionBoard_iPhone board] animated:YES];
}

ON_SIGNAL3( E0_ProfileCell_iPhone, notification, signal )
{
    if ( NO == [UserModel online] )
    {
        [bee.ui.appBoard showLogin];
        return;
    }
    
    [self.stack pushBoard:[G2_MessageBoard_iPhone board] animated:YES];
}

/**
 * 个人中心-收货地址管理，点击事件触发时执行的操作
 */
ON_SIGNAL3( E0_ProfileCell_iPhone, manage, signal )
{
    if ( NO == [UserModel online] )
    {
        [bee.ui.appBoard showLogin];
        return;
    }
    
    [self.stack pushBoard:[F0_AddressListBoard_iPhone board] animated:YES];
}

/**
 * 个人中心-待付款，点击事件触发时执行的操作
 */
ON_SIGNAL3( E0_ProfileCell_iPhone, order_await_pay, signal )
{
    if ( NO == [UserModel online] )
    {
        [bee.ui.appBoard showLogin];
        return;
    }
    
    [self.stack pushBoard:[E1_PendingPaymentBoard_iPhone board] animated:YES];
}

/**
 * 个人中心-待发货，点击事件触发时执行的操作
 */
ON_SIGNAL3( E0_ProfileCell_iPhone, order_await_ship, signal )
{
    if ( NO == [UserModel online] )
    {
        [bee.ui.appBoard showLogin];
        return;
    }
    
    [self.stack pushBoard:[E2_PendingShippedBoard_iPhone board] animated:YES];
}

/**
 * 个人中心-待收货，点击事件触发时执行的操作
 */
ON_SIGNAL3( E0_ProfileCell_iPhone, order_shipped, signal )
{
    if ( NO == [UserModel online] )
    {
        [bee.ui.appBoard showLogin];
        return;
    }
    
    [self.stack pushBoard:[E3_PendingReceivedBoard_iPhone board] animated:YES];
}

/**
 * 个人中心-历史订单，点击事件触发时执行的操作
 */
ON_SIGNAL3( E0_ProfileCell_iPhone, order_finished, signal )
{
    if ( NO == [UserModel online] )
    {
        [bee.ui.appBoard showLogin];
        return;
    }
    
    [self.stack pushBoard:[E4_HistoryBoard_iPhone board] animated:YES];
}

/**
 * 个人中心-照相机图标，点击事件触发时执行的操作
 */
ON_SIGNAL3( E0_ProfileCell_iPhone, carema, signal )
{
    if ( NO == [UserModel online] )
    {
        [bee.ui.appBoard showLogin];
        return;
    }
    
//    if ( [UserModel sharedInstance].avatar )
//    {
//        BeeUIActionSheet * confirm = [BeeUIActionSheet spawn];
//        [confirm addDestructiveTitle:__TEXT(@"delete_photo") signal:self.PHOTO_REMOVE];
//        [confirm addCancelTitle:__TEXT(@"button_cancel")];
//        [confirm showInViewController:self];
//    }
//    else
//    {
        BeeUIActionSheet * confirm = [BeeUIActionSheet spawn];
        
        if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] )
        {
            [confirm addButtonTitle:__TEXT(@"from_camera") signal:self.PHOTO_FROM_CAMERA];
        }
        if ( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] )
        {
            [confirm addButtonTitle:__TEXT(@"from_album") signal:self.PHOTO_FROM_LIBRARY];
        }
        
        [confirm addCancelTitle:__TEXT(@"button_cancel")];
        [confirm showInViewController:self];
//    }
}

/**
 * 个人中心-关注老师（限学生），点击事件触发时执行的操作
 * 登录后可见视图，不必判断是否在线
 */
ON_SIGNAL3( E0_ProfileCell_iPhone, follow, signal )
{
    // 应该要传递一个叫学生id的参数，那么参数从哪来呢？？
    E7_FollowBoard_iPhone * board = [[E7_FollowBoard_iPhone alloc] init];
    board.user_id = self.userModel.user.id;
    [self.stack pushBoard:board animated:YES];
}

/**
 * 个人中心-查看积分（限老师），点击事件触发时执行的操作
 * 登录后可见视图，不必判断是否在线
 */
ON_SIGNAL3( E0_ProfileCell_iPhone, integral, signal )
{
    E8_IntegralBoard_iPhone * board = [[E8_IntegralBoard_iPhone alloc] init];
//    board.user_id = self.userModel.user.id;
    [self.stack pushBoard:board animated:YES];
}

#pragma mark - E0_ProfileHelpCell_iPhone

/**
 * 个人中心-帮助，点击事件触发时执行的操作
 */
ON_SIGNAL3( E0_ProfileCell_iPhone, help, signal )
{
    E0_ProfileHelpBoard_iPhone * board = [E0_ProfileHelpBoard_iPhone board];
    [self.stack pushBoard:board animated:YES];
}

#pragma mark -

ON_NOTIFICATION3( ECMobilePushUnread, UPDATING, notification )
{
}

ON_NOTIFICATION3( ECMobilePushUnread, UPDATED, notification )
{
	[self.list asyncReloadData];
}

ON_NOTIFICATION3( UserModel, LOGIN, notification )
{
	[self updateState];
}

#pragma mark - UserModel

ON_NOTIFICATION3( UserModel, LOGOUT, notification )
{
	[self updateState];
}

ON_NOTIFICATION3( UserModel, KICKOUT, notification )
{
	[self updateState];
}

ON_NOTIFICATION3( UserModel, UPDATED, notification )
{
}

#pragma mark -

- (void)updateState
{
	if ( [UserModel online] )
	{
		[[CartModel sharedInstance] reload];
		
//		if ( ![UserModel sharedInstance].loaded )
		{
			[[UserModel sharedInstance] updateProfile];
		}
		
		if ( ![UserModel sharedInstance].loaded )
        {
            [self.list showHeaderLoader:YES animated:NO];
        }
	}
	else
	{
        if ( ![UserModel sharedInstance].loaded )
        {
            [self.list showHeaderLoader:NO animated:NO];
        }
	}

	[[ECMobilePushUnread sharedInstance] update];


	[self.list reloadData];
}

#pragma mark -

ON_MESSAGE3( API, user_info, msg )
{
	if ( msg.sending )
	{
	}
	else
	{
		[self.list setHeaderLoading:NO];
		
		[self dismissTips];
	}
	
	if ( msg.succeed )
	{
		[self.list asyncReloadData];
	}
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
//    [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	UIImage * image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
//    UIImage * image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    // add nhj,将所选取图片剪裁为圆形
//    CGSize imageSize = CGSizeMake(image.size.width, image.size.height);
//    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
//    
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    CGFloat centerX = image.size.width / 2;
//    CGFloat centerY = image.size.height / 2;
//    CGContextAddArc(ctx, centerX, centerY, centerX, 0, M_PI*2, 0);
//    CGContextClip(ctx);
//    
//    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
//    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    image = newImage;
    
	if ( image )
	{
        UIView * item = ((BeeUIScrollItem *)self.list.items[0]).view;
        if ( nil == item )
            return;
        
        // add nhj, post user avatar to server
        // 将图片转换为NSData格式
        NSData * imageData = UIImageJPEGRepresentation(image, 0.3);
        if (imageData != nil)
        {
            // 将图片Base 64编码
            NSString * imageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            
            [self.userModel postAvatar:imageStr];
        }
        
        $(item).FIND(@"#header-avatar").IMAGE( image );

        [[UserModel sharedInstance] setAvatar:image];
	}
    
//    [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - post user avatar
ON_MESSAGE3( API, post_avatar, msg )
{
    if( msg.sending )
    {
        
    }
    if( msg.succeed )
    {
        
    }
    if( msg.failed )
    {
        
    }
}

@end
