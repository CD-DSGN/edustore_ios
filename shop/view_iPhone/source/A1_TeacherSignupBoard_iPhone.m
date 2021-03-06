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

#import "A1_TeacherSignupBoard_iPhone.h"
#import "A1_TeacherSignupCell_iPhone.h"
#import "A1_TeacherSignupBoard2_iPhone.h"

#import "AppBoard_iPhone.h"

#import "FormCell.h"

@interface A1_TeacherSignupBoard_iPhone () <UIScrollViewDelegate>

@end

@implementation A1_TeacherSignupBoard_iPhone

SUPPORT_RESOURCE_LOADING( YES )
SUPPORT_AUTOMATIC_LAYOUT( YES )

DEF_MODEL( UserModel, userModel )

DEF_OUTLET( BeeUIScrollView, list)

- (void)load
{
	self.userModel = [UserModel modelWithObserver:self];
    self.registerModel = [RegisterModel modelWithObserver:self];
    
    self.group = [NSMutableArray array];
}

- (void)unload
{
	SAFE_RELEASE_MODEL( self.userModel );
    SAFE_RELEASE_MODEL( self.registerModel );
    
    self.group = nil;
}

#pragma mark -

ON_CREATE_VIEWS( signal )
{
    self.navigationBarShown = YES;
    self.navigationBarTitle = __TEXT(@"teacherSignup");
    self.navigationBarLeft  = [UIImage imageNamed:@"nav_back.png"];
//    [self showBarButton:BeeUINavigationBar.RIGHT
//                  title:__TEXT(@"next_step")
//                  image:[UIImage imageNamed:@"nav_right.png"]];
    
    @weakify(self);

    self.list.delegate = self;
    self.list.reuseEnable = NO;
    self.list.whenReloading = ^
    {
        @normalize(self);
        
        self.list.total = 1;
        
        BeeUIScrollItem * item = self.list.items[0];
        item.clazz = [A1_TeacherSignupCell_iPhone class];
        item.rule  = BeeUIScrollLayoutRule_Line;
        item.size  = CGSizeAuto;
        item.data  = self.registerModel;
        
//        NSArray * datas = self.group;
//        
//        self.list.total = datas.count;
//        
//        for ( int i=0; i < datas.count; i++ )
//        {
//            FormData * formData = [self.group safeObjectAtIndex:i];
//            
//            if ( i == 0 )
//            {
//                formData.scrollIndex = UIScrollViewIndexFirst;
//            }
//            else if ( i == self.list.total - 1 ) // self.commentModel.comments.count
//            {
//                formData.scrollIndex = UIScrollViewIndexLast;
//            }
//            else
//            {
//                formData.scrollIndex = UIScrollViewIndexDefault;
//            }
//
//            BeeUIScrollItem * item = self.list.items[i];
//            item.clazz = [A1_TeacherSignupCell_iPhone class];
//            item.rule  = BeeUIScrollLayoutRule_Line;
//            item.size  = CGSizeAuto;
//            item.data  = formData;
//        }
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
}

#pragma mark - BeeUITextField
// return keyboard
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
        [self nextStep];
    }
}

// next step button
ON_SIGNAL3( A1_TeacherSignupCell_iPhone, nextStepButton, signal )
{
    [self nextStep];
}

// get identify code
ON_SIGNAL3( A1_TeacherSignupCell_iPhone, getIdentifyCode, signal )
{
    [self getIdentifyCode];
}

#pragma mark -

- (NSArray *)inputs
{
    NSMutableArray * inputs = [NSMutableArray array];
    
    BeeUIScrollItem * item = self.list.items[0];
    
    if ( [item.view isKindOfClass:[A1_TeacherSignupCell_iPhone class]])
    {
        [inputs addObject:((A1_TeacherSignupCell_iPhone *)item.view).mobilePhone];
        [inputs addObject:((A1_TeacherSignupCell_iPhone *)item.view).identifyCode];
        [inputs addObject:((A1_TeacherSignupCell_iPhone *)item.view).password];
        [inputs addObject:((A1_TeacherSignupCell_iPhone *)item.view).confirmePassword];
        [inputs addObject:((A1_TeacherSignupCell_iPhone *) item.view).inviteCode];
    }
    
    return inputs;
}

- (void)setupFields
{
    self.registerModel.mobilePhoneTag = __TEXT(@"mobile_phone");
    self.registerModel.identifyCodeTag = __TEXT(@"identify_code");
    self.registerModel.passwordTag = __TEXT(@"login_password");
    self.registerModel.confirmPasswordTag = __TEXT(@"register_confirm");
    self.registerModel.inviteTag = @"inviteCode";
}

- (void)nextStep
{
    NSString * mobilePhone = nil;
    NSString * identifyCode = nil;
    NSString * inviteCode = nil;
    NSString * password = nil;
    NSString * password2 = nil;
    
    NSArray * inputs = [self inputs];
    
    // 为需要的参数赋值
    for ( BeeUITextField * input in inputs )
    {
        
        if ( [input.placeholder isEqualToString:__TEXT(@"login_inviteCode")])
        {
            inviteCode = input.text;
        }
        if ( [input.placeholder isEqualToString:__TEXT(@"mobile_phone")] )
        {
            mobilePhone = input.text;
        }
        if ( [input.placeholder isEqualToString:__TEXT(@"identify_code")] )
        {
            identifyCode = input.text;
        }
        if( [input.placeholder isEqualToString:__TEXT(@"login_password")] )
        {
            password = input.text;
        }
        if( [input.placeholder isEqualToString:__TEXT(@"register_confirm")] )
        {
            password2 = input.text;
        }
    }
    
    //为我们需要的参数赋值
//    for ( BeeUITextField * input in inputs )
//    {
//        A1_TeacherSignupCell_iPhone * cell = (A1_TeacherSignupCell_iPhone *)input.superview;
//        
//        FormData * data = cell.data;
//        
//        if ( [data.tagString isEqualToString:@"username"] )
//        {
//            userName = cell.input.text.trim;
//            data.text = userName;
//        }
//        else if( [data.tagString isEqualToString:@"mobilePhone"] )
//        {
//            mobilePhone = cell.input.text.trim;
//            data.text = mobilePhone;
//        }
//        else if( [data.tagString isEqualToString:@"identifyCode"] )
//        {
//            identifyCode = cell.input.text.trim;
//            data.text = identifyCode;
//        }
//    }
    
//    if ( 0 == userName.length || NO == [userName isChineseUserName] )
//    {
//        [self presentMessageTips:__TEXT(@"wrong_username")];
//        return;
//    }
    
//    if ( userName.length < 2 )
//    {
//        [self presentMessageTips:__TEXT(@"username_too_short")];
//        return;
//    }
//    
//    if ( userName.length > 20 )
//    {
//        [self presentMessageTips:__TEXT(@"username_too_long")];
//        return;
//    }
    
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
    
    if ( ![self.identifyCode isEqualToString:identifyCode] )
    {
        [self presentMessageTips:@"验证码不正确"];
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
    
    self.password = password;
    self.mobilePhone = mobilePhone;
    self.inviteCode = inviteCode;
    [self.userModel checkUser:mobilePhone andInviteCode:inviteCode];
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

#pragma mark - scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.list endEditing:YES];
}

#pragma mark - custom function
- (void)countDown: (NSTimer *) theTimer
{
    self.code = [self getIdentifyCodeButton];
    //计数器大于0时计数，且按钮不可用
    if( self.currentCountDown >= 0 )
    {
        [self.code setEnabled:NO];
        [self.code setSelected:YES];
        [self.code setTitle:[NSString stringWithFormat:@"%ld秒后重新获取",(long)self.currentCountDown]];
        self.currentCountDown--;
    }else {     //计数器小于0时，清空计数器并恢复按钮状态
        [self removeTimer];
        [self.code setEnabled:YES];
        [self.code setImage:nil];
        [self.code setTitle:@"获取验证码"];
    }
}

- (void)identifyCodeCountDown: (NSTimer *) theTimer
{
    if ( self.identifyCodeValidTime >= 0 ) {
        self.identifyCodeValidTime--;
    } else {
        self.identifyCode = nil;
        [self clearIdentifyCodeTimer];
    }
}

- (void)removeTimer
{
    self.currentCountDown = 0;
    [self.timer invalidate];
    self.timer = nil;
}

- (void)clearIdentifyCodeTimer
{
    self.identifyCodeValidTime = 0;
    [self.identifyCodeTimer invalidate];
    self.identifyCodeTimer = nil;
}

- (BeeUIButton *)getIdentifyCodeButton
{
    BeeUIScrollItem * item = self.list.items[0];
    if ( [item.view isKindOfClass:[A1_TeacherSignupCell_iPhone class]])
    {
        return ((A1_TeacherSignupCell_iPhone *)item.view).getIdentifyCode;
    }
    return nil;
}

- (void)getIdentifyCode
{
    NSString * mobilePhone = nil;
    NSArray * inputs = [self inputs];
    
    for ( BeeUITextField * input in inputs )
    {
        if ( [input.placeholder isEqualToString:__TEXT(@"mobile_phone")] )
        {
            mobilePhone = input.text;
            break;
        }
    }
    self.MSG( API.getIdentifyCode )
    .INPUT( @"mobilePhone", mobilePhone);
}

#pragma mark - network resutl
ON_MESSAGE3( API, checkUser, msg )
{
    if( msg.sending )
    {
        
    }
    else if( msg.succeed )
    {
        CHECK_USER_INFO * info = msg.GET_OUTPUT( @"info" );
        
        // 所填邀请码不存在
        if (info.invite_error != nil)
        {
            [self presentFailureTips:__TEXT(@"invite_error")];
        }
        else
        {
            A1_TeacherSignupBoard2_iPhone * detail = [[A1_TeacherSignupBoard2_iPhone alloc] init];
            // 传参
            detail.inviteCode = self.inviteCode;
            detail.mobilePhone = self.mobilePhone;
            detail.invite_user_id = info.invite_user_id;
            detail.password = self.password;
            // 清除计时器状态
            [self removeTimer];
            [self.code setEnabled:YES];
            [self.code setImage:nil];
            [self.code setTitle:@"获取验证码"];
            
            [self.stack pushBoard:detail animated:true];
        }
    }
    else if( msg.failed )
    {
        //用户名不可使用
//        [self showErrorTips:msg];
        [self presentFailureTips:@"电话号码已被注册"];
    }
    else if( msg.cancelled )
    {
    }
}

ON_MESSAGE3( API, getIdentifyCode, msg)
{
    if( msg.sending )
    {
        //短信发送中，进行电话的错误判断
        [self presentMessageTips:__TEXT(@"identifyCode_getting")];
    }
    else
    {
        [self dismissTips];
    }
    if( msg.succeed )
    {
        [self presentSuccessTips:__TEXT(@"identifyCode_success")];
        //短信发送成功，倒计时重新获取
        self.currentCountDown = 60;
        self.identifyCodeValidTime = 300;
        //开启两个计时器
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
        self.identifyCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(identifyCodeCountDown:) userInfo:nil repeats:YES];
        
        identifyCode * identifyCode = msg.GET_OUTPUT(@"data");
        self.identifyCode = identifyCode.identifyCode;
    }
    else if( msg.failed )
    {
        STATUS * status = msg.GET_OUTPUT(@"status");
        int error_code = [(status.error_code) intValue];
        if ( error_code == 1 )
        {
            [self presentMessageTips:@"电话已被注册"];
        }
        else if (error_code == 2 )
        {
            [self presentMessageTips:@"电话格式不正确"];
        }
        else
        {
            [self presentMessageTips:@"错误，请重新获取验证码"];
        }
    }
}


@end
