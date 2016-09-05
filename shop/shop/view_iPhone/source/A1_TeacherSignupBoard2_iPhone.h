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

@property (nonatomic, retain) NSMutableArray * group;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * mobilePhone;
@property (nonatomic, retain) UIPickerView * selectCourse;
@property (nonatomic, retain) NSMutableArray * course;
@property (nonatomic, retain) NSString * courseName;
// courseId 与数据库中的id相同，也表示course在pickerview中的位置
@property (nonatomic) NSInteger courseId;
//@property (nonatomic, retain) NSArray * group2;
@property (nonatomic, retain) UIPickerView * selectRegion;
@property (nonatomic, retain) NSMutableArray * province;
@property (nonatomic, retain) NSMutableArray * city;
@property (nonatomic, retain) NSMutableArray * town;
@property (nonatomic, retain) NSMutableArray * provinceId;
@property (nonatomic, retain) NSMutableArray * cityId;
@property (nonatomic, retain) NSMutableArray * townId;
@property (nonatomic) BOOL initPickerView;

@end
