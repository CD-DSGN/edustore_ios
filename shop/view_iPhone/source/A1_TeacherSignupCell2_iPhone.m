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
DEF_OUTLET( BeeUITextField, realname )
DEF_OUTLET( BeeUILabel, school )
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
        
    }
}

@end
