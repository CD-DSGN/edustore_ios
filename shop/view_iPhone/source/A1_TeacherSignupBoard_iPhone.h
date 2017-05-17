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
AS_MODEL( RegisterModel, registerModel )

@property (nonatomic, retain) NSMutableArray * group;
@property (nonatomic, retain) NSString * identifyCode;
@property (nonatomic, retain) NSString * mobilePhone;
@property (nonatomic, retain) NSString * inviteCode;
@property (nonatomic, retain) NSString * password;
// 这么写是为了增加复用（checkuser、timer都有使用）
@property (nonatomic, retain) BeeUIButton * code;
// 获取验证码按钮计时
@property (nonatomic) NSInteger currentCountDown;
@property (nonatomic, assign) NSTimer * timer;
// 验证码有效性计时
@property (nonatomic) NSInteger identifyCodeValidTime;
@property (nonatomic, assign) NSTimer * identifyCodeTimer;

@end
