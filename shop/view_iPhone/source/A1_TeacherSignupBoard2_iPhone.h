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
#import "BaseBoard_iPhone.h"

#import "controller.h"
#import "model.h"

#import "UIViewController+ErrorTips.h"

@interface A1_TeacherSignupBoard2_iPhone : BaseBoard_iPhone<UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

AS_OUTLET( BeeUIScrollView, list )

AS_MODEL( UserModel, userModel )
AS_MODEL( RegisterModel, registerModel )

@property (nonatomic, retain) NSString * invite_user_id;
@property (nonatomic, retain) NSString * mobilePhone;
@property (nonatomic, retain) NSString * inviteCode;
@property (nonatomic, retain) NSString * password;

@end
