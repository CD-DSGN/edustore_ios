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

#import "A1_TeacherSignupCell2_iPhone.h"
#import "FormCell.h"
#import "model.h"

#pragma mark -

@implementation A1_TeacherSignupCell2_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

DEF_OUTLET( BeeUIImageView, background )
DEF_OUTLET( BeeUITextField, input )
DEF_OUTLET( BeeUIButton, chooseCourses )
DEF_OUTLET( BeeUIButton, chooseRegion )
DEF_OUTLET( BeeUITextField, password )
DEF_OUTLET( BeeUITextField, confirmePassword )
DEF_OUTLET( BeeUITextField, realname )
DEF_OUTLET( BeeUITextField, school )
DEF_OUTLET( BeeUILabel, region )
DEF_OUTLET( BeeUILabel, course )


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
            self.confirmePassword.returnKeyType = UIReturnKeyDone;
        }
    }
    
//    if ( self.data )
//    {
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
//        // 做一些视图上的修改，以后如果对BEE有更深入了解，可能修改做法
//        if ( formData.placeholder != __TEXT(@"course"))
//        {
//            self.chooseCourses.hidden = YES;
//            self.course.hidden = YES;
//            self.button_bkg.hidden = YES;
//        }
//        else
//        {
//            self.input.hidden = YES;
//            self.input.enabled = NO;
//        }
//        if ( formData.placeholder != __TEXT(@"region"))
//        {
//            self.chooseRegion.hidden = YES;
//            self.region.hidden =  YES;
//            self.button_bkg.hidden = YES;
//        }
//        else
//        {
//            self.input.hidden = YES;
//            self.input.enabled = NO;
//        }
//    }
}

@end
