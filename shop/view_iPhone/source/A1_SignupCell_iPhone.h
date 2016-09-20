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

#import "Bee.h"

#pragma mark -

@interface A1_SignupCell_iPhone : BeeUICell

AS_OUTLET( BeeUIImageView, background )
AS_OUTLET( BeeUITextField, input )
AS_OUTLET( BeeUIButton, getIdentifyCode )
AS_OUTLET( BeeUITextField, username )
AS_OUTLET( BeeUITextField, password )
AS_OUTLET( BeeUITextField, confirmePassword )
AS_OUTLET( BeeUITextField, mobilePhone )
AS_OUTLET( BeeUITextField, identifyCode )
@end
