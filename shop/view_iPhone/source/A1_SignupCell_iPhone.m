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

#import "A1_SignupCell_iPhone.h"
#import "FormCell.h"
#import "model.h"

#pragma mark -

@implementation A1_SignupCell_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

DEF_OUTLET( BeeUIImageView, background )
DEF_OUTLET( BeeUITextField, input )
DEF_OUTLET( BeeUIButton, getIdentifyCode )
DEF_OUTLET( BeeUITextField, username )
DEF_OUTLET( BeeUITextField, password )
DEF_OUTLET( BeeUITextField, confirmePassword )
DEF_OUTLET( BeeUITextField, mobilePhone )
DEF_OUTLET( BeeUITextField, identifyCode )
DEF_OUTLET( BeeUIButton, signupButton )

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
        if ( [registerInfo.passwordTag isEqualToString:__TEXT(@"login_password")])
        {
            self.password.secureTextEntry = YES;
        }
        if ( [registerInfo.confirmPasswordTag isEqualToString:__TEXT(@"register_confirm")])
        {
            self.confirmePassword.secureTextEntry = YES;
        }
        if ( [registerInfo.mobilePhoneTag isEqualToString:__TEXT(@"mobile_phone")])
        {
            self.mobilePhone.keyboardType = UIKeyboardTypeNamePhonePad;
        }
        if ( [registerInfo.identifyCodeTag isEqualToString:__TEXT(@"identify_code")])
        {
            self.identifyCode.keyboardType = UIKeyboardTypeNamePhonePad;
            CGFloat width = [[UIScreen mainScreen] bounds].size.width * 0.4f;
            $(@"identifyCode").CSS([NSString stringWithFormat:@"width:%fpx",width]);
            self.identifyCode.returnKeyType = UIReturnKeyDone;
        }
        // 可以这么设计，不过需要放上自己的图片
//        [self.getIdentifyCode setImage:[UIImage imageNamed:@"button_blue.png"] forState:UIControlStateNormal];
//        [self.getIdentifyCode setImage:[UIImage imageNamed:@"button_orange.png"] forState:UIControlStateFocused];
        
//        FormData * formData = self.data;
//        self.input.placeholder = formData.placeholder;
//        self.input.secureTextEntry = formData.isSecure;
//        self.input.returnKeyType = formData.returnKeyType;
//        self.input.keyboardType = formData.keyboardType;
//        
//        if ( formData.text )
//        {
//            self.input.text = formData.text;
//        }
//        
//        switch ( formData.scrollIndex )
//        {
//            case UIScrollViewIndexFirst:
//                self.background.image = [UIImage imageNamed:@"cell_bg_header.png"];
//                break;
//            case UIScrollViewIndexLast:
//                self.background.image = [UIImage imageNamed:@"cell_bg_footer.png"];
//                break;
//            case UIScrollViewIndexDefault:
//            default:
//                self.background.image = [UIImage imageNamed:@"cell_bg_content.png"];
//                break;
//        }
//        
//        if ( formData.placeholder != __TEXT(@"identify_code"))
//        {
//            self.getIdentifyCode.hidden = YES; 
//        } else {
//            $(@"input").CSS(@"width:165px");
//            $(@"input").CSS(@"input-return-key:done");
//        }
//        
    }
}

@end
