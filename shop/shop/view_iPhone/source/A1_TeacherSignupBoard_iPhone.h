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

@interface A1_TeacherSignupBoard_iPhone : BaseBoard_iPhone

AS_OUTLET( BeeUIScrollView, list )

AS_MODEL( UserModel, userModel )

@property (nonatomic, retain) NSMutableArray * group;
@property (nonatomic) NSInteger currentCountDown;
@property (nonatomic, assign) NSTimer * timer;
@property (nonatomic, retain) NSString * identifyCode;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * mobilePhone;
@property (nonatomic, retain) BeeUIButton * code;
//@property (nonatomic, retain) NSArray * group2;

@end
