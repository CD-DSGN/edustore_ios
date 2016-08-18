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

#import "A1_SignupBoard_iPhone.h"
#import "A1_SignupCell_iPhone.h"

#import "AppBoard_iPhone.h"

#import "FormCell.h"

@implementation A1_SignupBoard_iPhone

SUPPORT_RESOURCE_LOADING( YES )
SUPPORT_AUTOMATIC_LAYOUT( YES )

DEF_MODEL( UserModel, userModel )

DEF_OUTLET( BeeUIScrollItem, list )

- (void)load
{
	self.userModel = [UserModel modelWithObserver:self];
    
    self.group = [NSMutableArray array];
}

- (void)unload
{
	SAFE_RELEASE_MODEL( self.userModel );
    
    self.group = nil;
}

#pragma mark -

ON_CREATE_VIEWS( signal )
{
    self.navigationBarShown = YES;
    self.navigationBarTitle = __TEXT(@"member_signup");
    self.navigationBarLeft  = [UIImage imageNamed:@"nav_back.png"];
    [self showBarButton:BeeUINavigationBar.RIGHT
                  title:__TEXT(@"register_regist")
                  image:[UIImage imageNamed:@"nav_right.png"]];
    
    @weakify(self);

    self.list.reuseEnable = NO;
    self.list.whenReloading = ^
    {
        @normalize(self);
        
        NSArray * datas = self.group;
        
        self.list.total = datas.count;
        
        for ( int i=0; i < datas.count; i++ )
        {
            FormData * formData = [self.group safeObjectAtIndex:i];
            
            if ( i == 0 )
            {
                formData.scrollIndex = UIScrollViewIndexFirst;
            }
            else if ( i == self.list.total - 1 ) // self.commentModel.comments.count
            {
                formData.scrollIndex = UIScrollViewIndexLast;
            }
            else
            {
                formData.scrollIndex = UIScrollViewIndexDefault;
            }

            BeeUIScrollItem * item = self.list.items[i];
            item.clazz = [A1_SignupCell_iPhone class];
            item.rule  = BeeUIScrollLayoutRule_Line;
            item.size  = CGSizeAuto;
            item.data  = formData;
        }
    };
    
    [self observeNotification:BeeUIKeyboard.HIDDEN];
    [self observeNotification:BeeUIKeyboard.SHOWN];
    [self observeNotification:BeeUIKeyboard.HEIGHT_CHANGED];
}

ON_DELETE_VIEWS( signal )
{
    [self unobserveNotification:BeeUIKeyboard.HIDDEN];
    [self unobserveNotification:BeeUIKeyboard.HEIGHT_CHANGED];
    [self unobserveNotification:BeeUIKeyboard.SHOWN];
}

ON_LAYOUT_VIEWS( signal )
{
}

ON_WILL_APPEAR( signal )
{
    [self setupFields];
}

ON_DID_APPEAR( signal )
{
	[self.list reloadData];
}

ON_WILL_DISAPPEAR( signal )
{
}

ON_DID_DISAPPEAR( signal )
{
}

#pragma mark -

ON_LEFT_BUTTON_TOUCHED( signal )
{
    [self.stack popBoardAnimated:YES];
}

ON_RIGHT_BUTTON_TOUCHED( signal )
{
    [self doRegister];
}

#pragma mark - BeeUITextField

ON_SIGNAL3( BeeUITextField, RETURN, signal )
{
    NSArray * inputs = [self inputs];
    
    BeeUITextField * input = (BeeUITextField *)signal.source;
    
    NSInteger index = [inputs indexOfObject:input];
    
    if ( UIReturnKeyNext == input.returnKeyType )
    {
        BeeUITextField * next = [inputs objectAtIndex:(index + 1)];
        [next becomeFirstResponder];
    }
    else if ( UIReturnKeyDone == input.returnKeyType )
    {
        [self.view endEditing:YES];
        [self doRegister];
    }
}

#pragma mark - SignupBoard_iPhone

ON_SIGNAL3( SignupBoard_iPhone, signin, signal )
{
	[self.stack popBoardAnimated:YES];
}

#pragma mark -

- (NSArray *)inputs
{
    NSMutableArray * inputs = [NSMutableArray array];
    
    for ( BeeUIScrollItem * item in self.list.items )
    {
        if ( [item.view isKindOfClass:[A1_SignupCell_iPhone class]] )
        {
            [inputs addObject:((A1_SignupCell_iPhone *)item.view).input];
        }
    }
    
    return inputs;
}

- (void)setupFields
{
    [self.group removeAllObjects];
    
    NSArray * fields = self.userModel.fields;

    FormData * username = [FormData data];
    username.tagString = @"username";
    username.placeholder = __TEXT(@"login_username");
    username.keyboardType = UIKeyboardTypeDefault;
    username.returnKeyType = UIReturnKeyNext;
    [self.group addObject:username];
    
//    FormData * email = [FormData data];
//    email.tagString = @"email";
//    email.placeholder = __TEXT(@"register_email");
//    email.keyboardType = UIKeyboardTypeEmailAddress;
//    email.returnKeyType = UIReturnKeyNext;
//    [self.group addObject:email];
    
//    UIButton * btn = [[UIButton alloc] init];
//    btn.frame = CGRectMake(0, 0, 200, 140);
//    btn.center = CGPointMake(180, 215);
//    [btn addTarget:self action:@selector(btnClick:)   forControlEvents:UIControlEventTouchUpInside];
//    [btn setTitle:@"getIdentify" forState:UIControlStateNormal];
//    [self.view addSubview:btn];

    
    FormData * password = [FormData data];
    password.tagString = @"password";
    password.placeholder = __TEXT(@"login_password");
    password.isSecure = YES;
    password.returnKeyType = UIReturnKeyNext;
    [self.group addObject:password];
    
    FormData * password2 = [FormData data];
    password2.tagString = @"password2";
    password2.placeholder = __TEXT(@"register_confirm");
    password2.isSecure = YES;
    password2.returnKeyType = UIReturnKeyNext;
    [self.group addObject:password2];
    
    FormData * mobilePhone = [FormData data];
    mobilePhone.tagString = @"mobilePhone";
    mobilePhone.placeholder = __TEXT(@"mobile_phone");
    mobilePhone.keyboardType = UIKeyboardTypeDefault;
    mobilePhone.returnKeyType = UIReturnKeyNext;
    [self.group addObject:mobilePhone];
    
    FormData * identifyCode = [FormData data];
    identifyCode.tagString = @"identifyCode";
    identifyCode.placeholder = __TEXT(@"identify_code");
    identifyCode.keyboardType = UIKeyboardTypeDefault;
    identifyCode.returnKeyType = UIReturnKeyDone;
    [self.group addObject:identifyCode];
    
//    if ( fields.count == 0 )
//    {
//        password2.returnKeyType = UIReturnKeyDone;
//    }
//    else
//    {
//        password2.returnKeyType = UIReturnKeyNext;
//    }
    
    
    
    if ( fields && 0 != fields.count  )
    {
        for ( int i=0; i < fields.count; i++ )
        {
            SIGNUP_FIELD * field = fields[i];
            
            FormData * element = [FormData data];
            element.tagString = field.id.stringValue;
            element.placeholder = field.name;
            element.data = field;
            
            if ( i == (fields.count - 1) )
            {
                element.returnKeyType = UIReturnKeyDone;
            }
            else
            {
                element.returnKeyType = UIReturnKeyNext;
            }
            
            [self.group addObject:element];
        }
    }
}

- (void)btnClick:(id) sender {
    [sender removeFromSuperview];
}

- (void)doRegister
{    
    NSString * userName = nil;
  	//NSString * email = nil;
    NSString * mobilePhone = nil;
    NSString * identifyCode = nil;
  	NSString * password = nil;
  	NSString * password2 = nil;
    
    NSArray * inputs = [self inputs];
    
    NSMutableArray * fields = [NSMutableArray array];

    //为我们需要的参数赋值
    for ( BeeUITextField * input in inputs )
    {
        A1_SignupCell_iPhone * cell = (A1_SignupCell_iPhone *)input.superview;

        FormData * data = cell.data;
        
        if ( [data.tagString isEqualToString:@"username"] )
        {
            userName = cell.input.text.trim;
            data.text = userName;
        }
        else if( [data.tagString isEqualToString:@"mobilePhone"] )
        {
            mobilePhone = cell.input.text.trim;
            data.text = mobilePhone;
        }
        else if( [data.tagString isEqualToString:@"identifyCode"] )
        {
            identifyCode = cell.input.text.trim;
            data.text = identifyCode;
        }
        else if( [data.tagString isEqualToString:@"password"] )
        {
            password = cell.input.text;
            data.text = password;
        }
        else if( [data.tagString isEqualToString:@"password2"] )
        {
            password2 = cell.input.text;
            data.text = password2;
        }
        else
        {
            SIGNUP_FIELD * field = (SIGNUP_FIELD *)cell.data;

            if ( field.need.boolValue && cell.input.text.length == 0 )
            {
                [self presentMessageTips:[NSString stringWithFormat:@"%@%@", __TEXT(@"please_input"), field.name]];
                return;
            }
            
            SIGNUP_FIELD_VALUE * fieldValue = [[[SIGNUP_FIELD_VALUE alloc] init] autorelease];
            fieldValue.id = field.id;
            fieldValue.value = cell.input.text;
            data.text = cell.input.text;
            [fields addObject:fieldValue];
        }
    }

	if ( 0 == userName.length || NO == [userName isChineseUserName] )
	{
		[self presentMessageTips:__TEXT(@"wrong_username")];
		return;
	}
	
	if ( userName.length < 2 )
	{
		[self presentMessageTips:__TEXT(@"username_too_short")];
		return;
	}
	
	if ( userName.length > 20 )
	{
		[self presentMessageTips:__TEXT(@"username_too_long")];
		return;
	}

	if ( 0 == mobilePhone.length || NO == [mobilePhone isMobilePhone] )
	{
		[self presentMessageTips:__TEXT(@"wrong_mobile")];
		return;
	}
    
    if ( 4 != identifyCode.length )
    {
        [self presentMessageTips:__TEXT(@"wrong_identifyCode")];
        return;
    }
	
	if ( 0 == password.length || NO == [password isPassword] )
	{
		[self presentMessageTips:__TEXT(@"wrong_password")];
		return;
	}

	if ( password.length < 6 )
	{
		[self presentMessageTips:__TEXT(@"password_too_short")];
		return;
	}

	if ( password.length > 20 )
	{
		[self presentMessageTips:__TEXT(@"password_too_long")];
		return;
	}

	if ( NO == [password isEqualToString:password2] )
	{
		[self presentMessageTips:__TEXT(@"wrong_password")];
		return;
	}

    [self.userModel signupWithUser:userName
                          password:password
                       mobilePhone:mobilePhone
                      identifyCode:identifyCode
                            fields:fields];
}

#pragma mark -

ON_NOTIFICATION3( BeeUIKeyboard, SHOWN, notification )
{
    CGFloat keyboardHeight = [BeeUIKeyboard sharedInstance].height;
    
    [self.list setBaseInsets:UIEdgeInsetsMake( 0, 0, keyboardHeight, 0)];
}

ON_NOTIFICATION3( BeeUIKeyboard, HEIGHT_CHANGED, notification )
{
    CGFloat keyboardHeight = [BeeUIKeyboard sharedInstance].height;
    
    [self.list setBaseInsets:UIEdgeInsetsMake( 0, 0, keyboardHeight, 0)];
}

ON_NOTIFICATION3( BeeUIKeyboard, HIDDEN, notification )
{
    [self.list setBaseInsets:UIEdgeInsetsZero];
}

#pragma mark -

ON_MESSAGE3( API, user_signup, msg )
{
	if ( msg.sending )
	{
		[self presentLoadingTips:__TEXT(@"signing_up")];
	}
	else
	{
		[self dismissTips];
	}

	if ( msg.succeed )
	{
		STATUS * status = msg.GET_OUTPUT(@"data_status");
		
		if ( status && status.succeed.boolValue )
		{
			if ( self.userModel.firstUse )
			{
				[bee.ui.appBoard presentSuccessTips:__TEXT(@"welcome")];
			}
			else
			{
				[bee.ui.appBoard presentSuccessTips:__TEXT(@"welcome_back")];
			}

			[bee.ui.appBoard hideLogin];
		}
		else
		{
			[self showErrorTips:msg];
		}
	}
	else if ( msg.failed )
	{
		[self showErrorTips:msg];
	}
}

ON_SIGNAL3( A1_SignupCell_iPhone, getIdentifyCode, signal)
{
    [self getIdentifyCode];
}

ON_MESSAGE3( API, getIdentifyCode, msg)
{
    if( msg.sending )
    {
       //短信发送中，按钮框变样
    }
    if( msg.succeed )
    {
        //短信发送成功，倒计时重新获取
        self.currentCountDown = 60;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    }
    else if( msg.failed )
    {
        
    }
}

- (void)countDown: (NSTimer *) theTimer
{
//    NSMutableArray * inputs = [NSMutableArray array];
//    
//    for ( BeeUIScrollItem * item in self.list.items )
//    {
//        if ( [item.view isKindOfClass:[A1_SignupCell_iPhone class]] )
//        {
//            [inputs addObject:((A1_SignupCell_iPhone *)item.view).getIdentifyCode];
//        }
//    }
//    
//    for ( BeeUIButton * identifyCodeButton in inputs )
//    {
//        A1_SignupCell_iPhone * cell = (A1_SignupCell_iPhone *)identifyCodeButton.superview;
//        cell.getIdentifyCode.image = [UIImage imageNamed:@"button_narrow_blue.png"];
// 
//    }
    if( self.currentCountDown > 0 )
    {
        NSMutableArray * inputs = [NSMutableArray array];
        
        for ( BeeUIScrollItem * item in self.list.items )
        {
            if ( [item.view isKindOfClass:[A1_SignupCell_iPhone class]] )
            {
                [inputs addObject:((A1_SignupCell_iPhone *)item.view).getIdentifyCode];
            }
        }
        
        for ( BeeUIButton * identifyCodeButton in inputs )
        {
            A1_SignupCell_iPhone * cell = (A1_SignupCell_iPhone *)identifyCodeButton.superview;
            cell.getIdentifyCode.image = [UIImage imageNamed:@"button_narrow_blue.png"];
            [cell.getIdentifyCode setTitle:[NSString stringWithFormat:@"%ld秒后重新获取",(long)self.currentCountDown]];
        }
        self.currentCountDown -= 1;
    }else {
        [self removeTimer];
    }
}

- (void)removeTimer
{
    self.currentCountDown = 0;
    [self.timer invalidate];
    self.timer = nil;
}

- (void)getIdentifyCodeButton
{
        NSMutableArray * inputs = [NSMutableArray array];
    
        for ( BeeUIScrollItem * item in self.list.items )
        {
            if ( [item.view isKindOfClass:[A1_SignupCell_iPhone class]] )
            {
                [inputs addObject:((A1_SignupCell_iPhone *)item.view).getIdentifyCode];
            }
        }
    
        for ( BeeUIButton * identifyCodeButton in inputs )
        {
            A1_SignupCell_iPhone * cell = (A1_SignupCell_iPhone *)identifyCodeButton.superview;
            if(cell.tagString isEqualToString:@"验证码")
            {
                
            }
        }
}

- (void)getIdentifyCode
{
    NSString * mobilePhone = nil;
    NSArray * inputs = [self inputs];
    
    for ( BeeUITextField * input in inputs )
    {
        A1_SignupCell_iPhone * cell = (A1_SignupCell_iPhone *)input.superview;
        
        FormData * data = cell.data;
        
        if ( [data.tagString isEqualToString:@"mobilePhone"] )
        {
            mobilePhone = cell.input.text.trim;
        }
    }
    
    self.MSG( API.getIdentifyCode )
        .INPUT( @"mobilePhone", mobilePhone);
}

@end
