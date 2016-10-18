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

@property (nonatomic, retain) NSMutableArray * group;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * mobilePhone;
@property (nonatomic, retain) UIPickerView * selectCourse;
@property (nonatomic, retain) NSMutableArray * course;
@property (nonatomic, retain) NSString * courseName;
@property (nonatomic, retain) NSMutableArray * course_id;
// 这个courseId表明pickView中的位置，之前设计不好，与课程id冲突
@property (nonatomic) NSInteger courseId;
//@property (nonatomic, retain) NSArray * group2;
@property (nonatomic, retain) UIPickerView          *    selectRegion;
@property (strong, nonatomic) NSDictionary          *    pickerDic;
@property (strong, nonatomic) NSMutableArray        *    provinceArray;
@property (strong, nonatomic) NSArray               *    cityArray;
@property (strong, nonatomic) NSArray               *    townArray;
@property (strong, nonatomic) NSArray               *    selectedArray;
// 所选择地区字符串，传入后台查询id写数据库
@property (nonatomic, retain) NSString              *    selectedProvinceName;
@property (nonatomic, retain) NSString              *    selectedCityName;
@property (nonatomic, retain) NSString              *    selectedTownName;
// 保留当前选择地区的行数
@property (nonatomic) NSInteger                          selectedProvinceRow;
@property (nonatomic) NSInteger                          selectedCityRow;
@property (nonatomic) NSInteger                          selectedTownRow;

@property (nonatomic) BOOL isInitRegionPickerView;

@end
