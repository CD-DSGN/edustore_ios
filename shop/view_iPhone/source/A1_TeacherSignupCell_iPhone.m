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

#import "A1_TeacherSignupCell_iPhone.h"
#import "FormCell.h"
#import "model.h"

#pragma mark -

@implementation A1_TeacherSignupCell_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

DEF_OUTLET( BeeUIImageView, background )
DEF_OUTLET( BeeUITextField, input )
DEF_OUTLET( BeeUIButton, getIdentifyCode )
DEF_OUTLET( BeeUITextField, inviteCode )
DEF_OUTLET( BeeUITextField, mobilePhone )
DEF_OUTLET( BeeUITextField, identifyCode )
DEF_OUTLET( BeeUITextField, password )
DEF_OUTLET( BeeUITextField, confirmePassword )

- (void)load
{
}

- (void)unload
{
}

- (void)dataDidChanged
{
    if ( self.data )
    {
        RegisterModel * registerInfo = self.data;
        
        if ( [registerInfo.mobilePhoneTag isEqualToString:__TEXT(@"mobile_phone")])
        {
            self.mobilePhone.keyboardType = UIKeyboardTypeNamePhonePad;
        }
        if ( [registerInfo.identifyCodeTag isEqualToString:__TEXT(@"identify_code")])
        {
            self.identifyCode.keyboardType = UIKeyboardTypeNamePhonePad;
            CGFloat width = [[UIScreen mainScreen] bounds].size.width * 0.4f;
            $(@"identifyCode").CSS([NSString stringWithFormat:@"width:%fpx",width]);
        }
        if ( [registerInfo.passwordTag isEqualToString:__TEXT(@"login_password")])
        {
            self.password.secureTextEntry = YES;
        }
        if ( [registerInfo.confirmPasswordTag isEqualToString:__TEXT(@"register_confirm")])
        {
            self.confirmePassword.secureTextEntry = YES;
        }
        if ([registerInfo.inviteTag isEqualToString:@"inviteCode"])
        {
            self.inviteCode.returnKeyType = UIReturnKeyDone;
        }
    }
}

@end
