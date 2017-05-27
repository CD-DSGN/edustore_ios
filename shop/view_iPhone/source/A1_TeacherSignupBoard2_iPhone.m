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

#import "A1_TeacherSignupBoard2_iPhone.h"
#import "A1_TeacherSignupCell2_iPhone.h"

#import "AppBoard_iPhone.h"

#import "FormCell.h"

@interface A1_TeacherSignupBoard2_iPhone ()
{
    NSInteger gradeAndClassLine;
    NSInteger gradeSelectedRow;
}
@property (nonatomic, strong) UIPickerView * regionPickerView;
@property (nonatomic, strong) UIPickerView * schoolPickerView;
@property (nonatomic, strong) UIPickerView * gradePickerView;
@property (nonatomic, strong) UIPickerView * coursePickerView;
// 地区（省市县）相关的数据
@property (strong, nonatomic) NSMutableArray        *    provinceArray;
@property (strong, nonatomic) NSMutableArray        *    cityArray;
@property (strong, nonatomic) NSMutableArray        *    townArray;
@property (strong, nonatomic) NSMutableArray        *    provinceIdArray;
@property (strong, nonatomic) NSMutableArray        *    cityIdArray;
@property (strong, nonatomic) NSMutableArray        *    townIdArray;
@property (nonatomic, strong) NSString              *    selectedProvinceName;
@property (nonatomic, strong) NSString              *    selectedCityName;
@property (nonatomic, strong) NSString              *    selectedTownName;
@property (nonatomic, strong) NSNumber              *    selectedProvinceId;
@property (nonatomic, strong) NSNumber              *    selectedCityId;
@property (nonatomic, strong) NSNumber              *    selectedTownId;
// 学校信息相关的数据
@property (nonatomic, strong) NSMutableArray        *    schoolArray;
@property (nonatomic, strong) NSMutableArray        *    schoolIdArray;
@property (nonatomic, strong) NSString              *    selectedSchoolName;
@property (nonatomic, strong) NSNumber              *    selectedSchoolId;
// 课程信息相关的数据
@property (nonatomic, strong) NSMutableArray        *    courseArray;
@property (nonatomic, strong) NSMutableArray        *    courseIdArray;
@property (nonatomic, strong) NSString              *    selectedCourseName;
@property (nonatomic, strong) NSNumber              *    selectedCourseId;
// 年级、班级数据
@property (nonatomic, strong) NSMutableArray        *    gradeArray;
@property (nonatomic, strong) NSMutableArray        *    gradeIdArray;
@property (nonatomic, strong) NSMutableArray        *    selectedGradeArray;
@property (nonatomic, strong) NSMutableArray        *    selectedGradeIdArray;
// 增加年级、班级输入时需要的信息
@property (nonatomic, strong) TEACHER_REGISTER_INFO * teacherInfo;
@end

@implementation A1_TeacherSignupBoard2_iPhone

SUPPORT_RESOURCE_LOADING( YES )
SUPPORT_AUTOMATIC_LAYOUT( YES )

DEF_MODEL( UserModel, userModel )
DEF_MODEL( RegisterModel, registerModel )

- (void)load
{
    self.userModel = [UserModel modelWithObserver:self];
    self.registerModel = [RegisterModel modelWithObserver:self];
    
    self.provinceArray = [NSMutableArray array];
    self.cityArray = [NSMutableArray array];
    self.townArray = [NSMutableArray array];
    self.provinceIdArray = [NSMutableArray array];
    self.cityIdArray = [NSMutableArray array];
    self.townIdArray = [NSMutableArray array];
    self.selectedProvinceName = self.selectedCityName = self.selectedTownName = nil;
    self.selectedProvinceId = self.selectedCityId = self.selectedTownId = @0;
    
    self.schoolArray = [NSMutableArray array];
    self.schoolIdArray = [NSMutableArray array];
    self.selectedSchoolId = @0;
    self.selectedSchoolName = nil;
    
    self.courseArray = [NSMutableArray array];
    self.courseIdArray = [NSMutableArray array];
    self.selectedCourseId = @0;
    self.selectedCourseName = nil;
    
    self.gradeArray = [NSMutableArray array];
    self.gradeIdArray = [NSMutableArray array];
    self.selectedGradeArray = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"", nil];
    self.selectedGradeIdArray = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0", nil];
    gradeSelectedRow = 0;
    
    gradeAndClassLine = 1;
    self.teacherInfo = [[TEACHER_REGISTER_INFO alloc] init];
    self.teacherInfo.line = [NSNumber numberWithInteger:gradeAndClassLine];
    self.teacherInfo.grade_array = [NSMutableArray array];
    self.teacherInfo.class_array = [NSMutableArray array];
}

- (void)unload
{
    SAFE_RELEASE_MODEL( self.userModel );
    SAFE_RELEASE_MODEL( self.registerModel );
    
    self.provinceArray = nil;
    self.cityArray = nil;
    self.townArray = nil;
    self.provinceIdArray = nil;
    self.cityIdArray = nil;
    self.townIdArray = nil;
    
    self.schoolArray = nil;
    self.schoolIdArray = nil;
    
    self.courseArray = nil;
    self.courseIdArray = nil;
    
    self.gradeArray = nil;
    self.gradeIdArray = nil;
    self.selectedGradeArray = nil;
    self.selectedGradeIdArray = nil;
    
    self.teacherInfo = nil;
}

#pragma mark -

ON_CREATE_VIEWS( signal )
{
    self.navigationBarShown = YES;
    self.navigationBarTitle = __TEXT(@"teacherSignup");
    self.navigationBarLeft  = [UIImage imageNamed:@"nav_back.png"];
    
    @weakify(self);
    
    self.list.reuseEnable = NO;
    self.list.whenReloading = ^
    {
        @normalize(self);
        
        self.list.total = 1;
        
        BeeUIScrollItem * item = self.list.items[0];
        item.clazz = [A1_TeacherSignupCell2_iPhone class];
        item.rule  = BeeUIScrollLayoutRule_Line;
        item.size  = self.list.size;
        item.data  = self.teacherInfo;
    };
    
    self.list.whenScrolling = ^
    {
        @normalize(self);
      
        [self.list endEditing:YES];
    };
    
    [self observeNotification:BeeUIKeyboard.HIDDEN];
    [self observeNotification:BeeUIKeyboard.SHOWN];
    [self observeNotification:BeeUIKeyboard.HEIGHT_CHANGED];
}

ON_DELETE_VIEWS( signal )
{
    [self unobserveNotification:BeeUIKeyboard.HIDDEN];
    [self unobserveNotification:BeeUIKeyboard.HEIGHT_CHANGED];
    [self unobserveNotification:BeeUIKeyboard.SHOWN];
}

ON_LAYOUT_VIEWS( signal )
{
}

ON_WILL_APPEAR( signal )
{
    [self setupFields];
}

ON_DID_APPEAR( signal )
{
    [self.list reloadData];
    [self getGrade];
}

ON_WILL_DISAPPEAR( signal )
{
}

ON_DID_DISAPPEAR( signal )
{
}

#pragma mark -

ON_LEFT_BUTTON_TOUCHED( signal )
{
    [self.stack popBoardAnimated:YES];
}

ON_RIGHT_BUTTON_TOUCHED( signal )
{
}

#pragma mark - lazy load
- (UIPickerView *)regionPickerView
{
    if (!_regionPickerView) {
        _regionPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 200)];
        _regionPickerView.delegate = self;
        _regionPickerView.dataSource = self;
    }
    return _regionPickerView;
}

- (UIPickerView *)gradePickerView
{
    if (!_gradePickerView) {
        _gradePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 200)];
        _gradePickerView.delegate = self;
        _gradePickerView.dataSource = self;
    }
    return _gradePickerView;
}

- (UIPickerView *)schoolPickerView
{
    if (!_schoolPickerView) {
        _schoolPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 200)];
        _schoolPickerView.delegate = self;
        _schoolPickerView.dataSource = self;
    }
    return _schoolPickerView;
}

- (UIPickerView *)coursePickerView
{
    if (!_coursePickerView) {
        _coursePickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 200)];
        _coursePickerView.delegate = self;
        _coursePickerView.dataSource = self;
    }
    return _coursePickerView;
}

// 如果重构页面需要修改的地方
#pragma mark - BeeUITextField

ON_SIGNAL3( BeeUITextField, RETURN, signal )
{
//    NSArray * inputs = [self inputs];
//    
//    BeeUITextField * input = (BeeUITextField *)signal.source;
//    
//    NSInteger index = [inputs indexOfObject:input];
//    
//    if ( index == 0 )
//    {
//        // 下一步为选择地区
//        [self getRegionByParentRegionId:@1];
//        BeeUITextField * next = [inputs objectAtIndex:index];
//        [next resignFirstResponder];
//    }
//    else if ( index == 1 )
//    {
//        // 下一步为选择课程
//        [self getCourse];
//        BeeUITextField * next = [inputs objectAtIndex:index];
//        [next resignFirstResponder];
//    }
//    
//    else if ( UIReturnKeyNext == input.returnKeyType )
//    {
//        BeeUITextField * next = [inputs objectAtIndex:(index + 1)];
//        [next becomeFirstResponder];
//    }
//    else if ( UIReturnKeyDone == input.returnKeyType )
//    {
//        [self.view endEditing:YES];
//        [self doRegister];
//    }
}

#pragma mark - A1_TeacherSignupCell2_iPhone
ON_SIGNAL3( A1_TeacherSignupCell2_iPhone, chooseCourses, signal )
{
    // 通过方法 getCourse 从数据库读取课程信息
    [self getCourse];
}

ON_SIGNAL3( A1_TeacherSignupCell2_iPhone, chooseRegion, signal )
{
    // 1. 当已经有选择地区的时候，不再调用网络请求，只需新建一个alertVC，将pickerView加上去即可
    // 2. 当没有选择地区的时候，且返回结果是省的信息时，新建alertVC，加上pickerView；不是省的信息时，更新pickerView
    if (self.provinceArray.count != 0) {
        
        [self showRegionPickerView];
    } else {
        
        [self getRegionByParentRegionId:@1];
    }
}

ON_SIGNAL3( A1_TeacherSignupCell2_iPhone, chooseSchool, signal )
{
    [self getSchool];
}

ON_SIGNAL3( A1_TeacherSignupCell2_iPhone, signupButton_wrapper, signal )
{
    [self doRegister];
}

ON_SIGNAL3( A1_TeacherSignupCell2_iPhone, chooseGradeOne, signal )
{
    NSString * message = @"\n\n\n\n\n\n\n\n\n";
    UIAlertController * sheet = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleActionSheet];
    // 添加确定按钮
    [sheet addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        //点击确定的逻辑处理...
        BeeUILabel * gradeLabel = [self getLabelByLabelName:@"gradeOne"];
        gradeLabel.text = [self.gradeArray objectAtIndex:gradeSelectedRow];
        gradeLabel.textColor = [UIColor blackColor];
        self.selectedGradeArray[0] = self.gradeArray[gradeSelectedRow];
        self.selectedGradeIdArray[0] = self.gradeIdArray[gradeSelectedRow];
        if ([gradeLabel.text isEqualToString:@"请选择年级"]) {
            
            gradeLabel.textColor = [UIColor colorWithRed:211.f/255 green:211.f/255 blue:211.f/255 alpha:1];
        }
    }]];
    [sheet.view addSubview:self.gradePickerView];
    [self presentViewController:sheet animated:YES completion:nil];
}

ON_SIGNAL3( A1_TeacherSignupCell2_iPhone, chooseGradeTwo, signal )
{
    NSString * message = @"\n\n\n\n\n\n\n\n\n";
    UIAlertController * sheet = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleActionSheet];
    // 添加确定按钮
    [sheet addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        //点击确定的逻辑处理...
        BeeUILabel * gradeLabel = [self getLabelByLabelName:@"gradeTwo"];
        gradeLabel.text = [self.gradeArray objectAtIndex:gradeSelectedRow];
        gradeLabel.textColor = [UIColor blackColor];
        self.selectedGradeArray[1] = self.gradeArray[gradeSelectedRow];
        self.selectedGradeIdArray[1] = self.gradeIdArray[gradeSelectedRow];
        if ([gradeLabel.text isEqualToString:@"请选择年级"]) {
            
            gradeLabel.textColor = [UIColor colorWithRed:211.f/255 green:211.f/255 blue:211.f/255 alpha:1];
        }
    }]];
    [sheet.view addSubview:self.gradePickerView];
    [self presentViewController:sheet animated:YES completion:nil];
}

ON_SIGNAL3( A1_TeacherSignupCell2_iPhone, chooseGradeThree, signal )
{
    NSString * message = @"\n\n\n\n\n\n\n\n\n";
    UIAlertController * sheet = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleActionSheet];
    // 添加确定按钮
    [sheet addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        //点击确定的逻辑处理...
        BeeUILabel * gradeLabel = [self getLabelByLabelName:@"gradeThree"];
        gradeLabel.text = [self.gradeArray objectAtIndex:gradeSelectedRow];
        gradeLabel.textColor = [UIColor blackColor];
        self.selectedGradeArray[2] = self.gradeArray[gradeSelectedRow];
        self.selectedGradeIdArray[2] = self.gradeIdArray[gradeSelectedRow];
        if ([gradeLabel.text isEqualToString:@"请选择年级"]) {
            
            gradeLabel.textColor = [UIColor colorWithRed:211.f/255 green:211.f/255 blue:211.f/255 alpha:1];
        }
    }]];
    [sheet.view addSubview:self.gradePickerView];
    [self presentViewController:sheet animated:YES completion:nil];
}

ON_SIGNAL3( A1_TeacherSignupCell2_iPhone, chooseGradeFour, signal )
{
    NSString * message = @"\n\n\n\n\n\n\n\n\n";
    UIAlertController * sheet = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleActionSheet];
    // 添加确定按钮
    [sheet addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        //点击确定的逻辑处理...
        BeeUILabel * gradeLabel = [self getLabelByLabelName:@"gradeFour"];
        gradeLabel.text = [self.gradeArray objectAtIndex:gradeSelectedRow];
        gradeLabel.textColor = [UIColor blackColor];
        self.selectedGradeArray[3] = self.gradeArray[gradeSelectedRow];
        self.selectedGradeIdArray[3] = self.gradeIdArray[gradeSelectedRow];
        if ([gradeLabel.text isEqualToString:@"请选择年级"]) {
            
            gradeLabel.textColor = [UIColor colorWithRed:211.f/255 green:211.f/255 blue:211.f/255 alpha:1];
        }
    }]];
    [sheet.view addSubview:self.gradePickerView];
    [self presentViewController:sheet animated:YES completion:nil];
}

ON_SIGNAL3( A1_TeacherSignupCell2_iPhone, chooseGradeFive, signal )
{
    NSString * message = @"\n\n\n\n\n\n\n\n\n";
    UIAlertController * sheet = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleActionSheet];
    // 添加确定按钮
    [sheet addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        //点击确定的逻辑处理...
        BeeUILabel * gradeLabel = [self getLabelByLabelName:@"gradeFive"];
        gradeLabel.text = [self.gradeArray objectAtIndex:gradeSelectedRow];
        gradeLabel.textColor = [UIColor blackColor];
        self.selectedGradeArray[4] = self.gradeArray[gradeSelectedRow];
        self.selectedGradeIdArray[4] = self.gradeIdArray[gradeSelectedRow];
        if ([gradeLabel.text isEqualToString:@"请选择年级"]) {
            
            gradeLabel.textColor = [UIColor colorWithRed:211.f/255 green:211.f/255 blue:211.f/255 alpha:1];
        }
    }]];
    [sheet.view addSubview:self.gradePickerView];
    [self presentViewController:sheet animated:YES completion:nil];
}

ON_SIGNAL3( A1_TeacherSignupCell2_iPhone, gradeClassAdd, signal )
{
    gradeAndClassLine++;
    if (gradeAndClassLine > 5) {
        [self presentFailureTips:@"您最多可以选择5个班级"];
    } else {
        NSArray * inputs = [self inputs];
        for ( BeeUITextField * input in inputs )
        {
            if ( [input.placeholder isEqualToString:__TEXT(@"login_realname")] )
            {
                _teacherInfo.teacher_name = input.text;
            }
        }
        _teacherInfo.province_id = self.selectedProvinceName;
        _teacherInfo.town_id = self.selectedCityName;
        _teacherInfo.district_id = self.selectedTownName;
        _teacherInfo.course_id = self.selectedCourseName;
        _teacherInfo.school_id = self.selectedSchoolName;
        
        _teacherInfo.line = [NSNumber numberWithInteger:gradeAndClassLine];
        
        _teacherInfo.grade_array = self.selectedGradeArray;
        _teacherInfo.class_array = [NSMutableArray arrayWithArray:[self getClassInfo]];
        
        [self.list reloadData];
    }
}
    
#pragma mark -

- (NSArray *)inputs
{
    NSMutableArray * inputs = [NSMutableArray array];
    
    BeeUIScrollItem * item = self.list.items[0];
    
    if ( [item.view isKindOfClass:[A1_TeacherSignupCell2_iPhone class]])
    {
        [inputs addObject:((A1_TeacherSignupCell2_iPhone *)item.view).realname];
    }
    return inputs;
}

- (NSArray *)getClassInfo
{
    NSMutableArray * classInfo = [NSMutableArray array];
    
    NSMutableArray * inputs = [NSMutableArray array];
    
    BeeUIScrollItem * item = self.list.items[0];
    
    if ( [item.view isKindOfClass:[A1_TeacherSignupCell2_iPhone class]])
    {
        [inputs addObject:((A1_TeacherSignupCell2_iPhone *)item.view).classOne];
        [inputs addObject:((A1_TeacherSignupCell2_iPhone *)item.view).classTwo];
        [inputs addObject:((A1_TeacherSignupCell2_iPhone *)item.view).classThree];
        [inputs addObject:((A1_TeacherSignupCell2_iPhone *)item.view).classFour];
        [inputs addObject:((A1_TeacherSignupCell2_iPhone *)item.view).classFive];
    }
    
    for (int i = 0; i < 5; i++) {
        
        BeeUILabel * label = inputs[i];
        if (label.text.length <= 0) {
            classInfo[i] = @"0";
        } else {
            classInfo[i] = label.text;
        }
    }
    
    return classInfo;
}

- (void)setupFields
{
    self.registerModel.realnameTag = __TEXT(@"login_realname");
    self.registerModel.regionTag = __TEXT(@"region");
    self.registerModel.schoolTag = __TEXT(@"school");
    self.registerModel.courseTag = __TEXT(@"course");
}

- (void)doRegister
{
    NSString * mobilePhone = nil;
    NSString * password = nil;
    NSString * invite_user_id = nil;
    NSString * realname = nil;
    NSNumber * school = @0;
    NSNumber * course = @0;
    NSString * isTeacher = @"1";
    NSString * country = @"1";
    NSString * grade = @"";
    NSString * class = @"";
    NSArray * classArray = [self getClassInfo];
    
//    NSString * inviteCode = nil;
//    inviteCode = self.inviteCode;
    
    NSArray * inputs = [self inputs];
    
    NSMutableArray * fields = [NSMutableArray array];
    
    // 为注册需要的参数赋值
    password = self.password;
    mobilePhone = self.mobilePhone;
    course = self.selectedCourseId;
    school = self.selectedSchoolId;
    
    invite_user_id = self.invite_user_id;
    if (invite_user_id == nil) {
        invite_user_id = @"0";
    }
    
    for ( BeeUITextField * input in inputs )
    {
        if ( [input.placeholder isEqualToString:__TEXT(@"login_realname")] )
        {
            realname = input.text;
        }
    }
    if ( 0 == realname.length )
    {
        [self presentMessageTips:__TEXT(@"null_realname")];
        return;
    }
    // 省市不能为空，县可以为空
    if ( self.selectedTownName.length == 0 )
    {
        [self presentMessageTips:__TEXT(@"region")];
        return;
    }
    if ( [school isEqual:@0] )
    {
        [self presentMessageTips:__TEXT(@"null_school")];
        return;
    }
    if ( [course isEqual:@0] )
    {
        [self presentMessageTips:__TEXT(@"wrong_course")];
        return;
    }
    // 年级和班级只能同时存在或同时为空
    NSInteger gradeCount = 0;
    for (int i = 0; i < 5; i++) {
        
        NSString * classId = [NSString stringWithFormat:@"%@", classArray[i]];
        NSString * gradeId = [NSString stringWithFormat:@"%@", self.selectedGradeIdArray[i]];
        // 班级只能是纯数字
        NSString * classIsNum = classId;
        classIsNum = [classIsNum stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
        if (classIsNum.length > 0) {
            
            [self presentFailureTips:@"班级只能填写数字"];
            return;
        }
        if ([classId isEqualToString:@"0"]) {
            // 班级为0，年级不为0
            if (![gradeId isEqualToString:@"0"]) {
                
                [self presentFailureTips:@"您必须同时填写年级和班级"];
                return;
            }
        } else {
            
            // 班级不为0，年级为0
            if ([gradeId isEqualToString:@"0"]) {
                
                [self presentFailureTips:@"您必须同时填写年级和班级"];
                return;
            } else {
                gradeCount++;
            }
        }
    }
    
    if (gradeCount > 0) {
        grade = [self.selectedGradeIdArray componentsJoinedByString:@"@"];
        class = [classArray componentsJoinedByString:@"@"];
    } else {
        [self presentFailureTips:@"您必须至少填写一个年级和班级"];
        return;
    }
    
    
    [self.userModel signupWithUser:mobilePhone
                      inviteUserId:invite_user_id
                          password:password
                       mobilePhone:mobilePhone
                            fields:fields
                          realname:realname
                            school:school
                            course:course
                         isTeacher:isTeacher
                           country:country
                        provinceId:self.selectedProvinceId
                            cityId:self.selectedCityId
                            townId:self.selectedTownId
                             grade:grade
                             class:class];
}

#pragma mark -

ON_NOTIFICATION3( BeeUIKeyboard, SHOWN, notification )
{
    CGFloat keyboardHeight = [BeeUIKeyboard sharedInstance].height;
    
    [self.list setBaseInsets:UIEdgeInsetsMake( 0, 0, keyboardHeight, 0)];
}

ON_NOTIFICATION3( BeeUIKeyboard, HEIGHT_CHANGED, notification )
{
    CGFloat keyboardHeight = [BeeUIKeyboard sharedInstance].height;
    
    [self.list setBaseInsets:UIEdgeInsetsMake( 0, 0, keyboardHeight, 0)];
}

ON_NOTIFICATION3( BeeUIKeyboard, HIDDEN, notification )
{
    [self.list setBaseInsets:UIEdgeInsetsZero];
}

#pragma mark - pickerView dataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if ( pickerView == self.coursePickerView )
    {
        return 1;
    }
    else if ( pickerView == self.regionPickerView )
    {
        return 3;
    }
    else if ( pickerView == self.schoolPickerView )
    {
        return 1;
    }
    else if ( pickerView == self.gradePickerView )
    {
        return 1;
    }
    return 0;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ( pickerView == self.coursePickerView )
    {
        return [self.courseArray count];
    }
    else if ( pickerView == self.regionPickerView )
    {
        if ( component == 0 )
        {
            return [self.provinceArray count];
        }
        else if ( component == 1 )
        {
            return [self.cityArray count];
        }
        else
        {
            return [self.townArray count];
        }
    }
    else if ( pickerView == self.schoolPickerView )
    {
        return [self.schoolArray count];
    }
    else if ( pickerView == self.gradePickerView )
    {
        return [self.gradeArray count];
    }
    return 0;
}

// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if ( pickerView == self.coursePickerView )
    {
        return  self.view.frame.size.width - 20;
    }
    else if ( pickerView == self.regionPickerView )
    {
        if ( component == 0 )
        {
            return  self.view.frame.size.width/3-20;
        }
        else if ( component == 1 )
        {
            return  self.view.frame.size.width/3-15;
        }
        else if ( component == 2 )
        {
            return  self.view.frame.size.width/3+10;
        }
    }
    else if ( pickerView == self.schoolPickerView )
    {
        return self.view.frame.size.width - 20;
    }
    else if ( pickerView == self.gradePickerView )
    {
        return self.view.frame.size.width - 20;
    }
    return 0;
}
// PickerView 每一行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}
// 初始化 PickerView 的每一行，可以自定义返回样式
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    if( !view ) {
        view = [[UIView alloc] init];
    }
    
    if ( pickerView == self.coursePickerView )
    {
        UILabel * text = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 10, 30)];
        text.textAlignment = NSTextAlignmentCenter;
        text.text = [self.courseArray objectAtIndex:row];
        [view addSubview:text];
    }
    else if (pickerView == self.regionPickerView)
    {
        UILabel * text = [[UILabel alloc] init];
        if ( component == 0 )
        {
            text.frame = CGRectMake(0, 0, self.frame.size.width/3-20, 30);
            text.text = [self.provinceArray objectAtIndex:row];
        }
        else if ( component == 1)
        {
            text.frame = CGRectMake(0, 0, self.frame.size.width/3-15, 30);
            text.text = [self.cityArray objectAtIndex:row];
        }
        else
        {
            text.frame = CGRectMake(0, 0, self.frame.size.width/3+10, 30);
            text.text = [self.townArray objectAtIndex:row];
        }
        text.textAlignment = UITextAlignmentCenter;
//        text.adjustsFontSizeToFitWidth = YES;
        [view addSubview:text];
    }
    else if ( pickerView == self.schoolPickerView )
    {
        UILabel * text = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 10, 30)];
        text.textAlignment = NSTextAlignmentCenter;
        text.text = [self.schoolArray objectAtIndex:row];
        [view addSubview:text];
    }
    else if ( pickerView == self.gradePickerView )
    {
        UILabel * text = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 10, 30)];
        text.textAlignment = NSTextAlignmentCenter;
        text.text = [self.gradeArray objectAtIndex:row];
        [view addSubview:text];
    }
    return view;
}

#pragma mark - pickerView delegate
// pickerview 获取选中的值
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ( pickerView == self.coursePickerView )
    {
        self.selectedCourseName = [self.courseArray objectAtIndex:row];
        self.selectedCourseId = [self.courseIdArray objectAtIndex:row];
    }
    else if ( pickerView == self.regionPickerView )
    {
        if ( component == 0 )
        {
            self.selectedProvinceName = [self.provinceArray objectAtIndex:row];
            self.selectedProvinceId = [self.provinceIdArray objectAtIndex:row];
            [self getRegionByParentRegionId:self.selectedProvinceId];
        }
        else if ( component == 1 )
        {
            self.selectedCityName = [self.cityArray objectAtIndex:row];
            self.selectedCityId = [self.cityIdArray objectAtIndex:row];
            [self getRegionByParentRegionId:self.selectedCityId];
        }
        else if ( component == 2 )
        {
            self.selectedTownName = [self.townArray objectAtIndex:row];
            self.selectedTownId = [self.townIdArray objectAtIndex:row];
        }
    }
    else if ( pickerView == self.schoolPickerView )
    {
        self.selectedSchoolName = [self.schoolArray objectAtIndex:row];
        self.selectedSchoolId = [self.schoolIdArray objectAtIndex:row];
    }
    else if ( pickerView == self.gradePickerView )
    {
        gradeSelectedRow = row;
    }
}

#pragma mark - custom function
// 获取选择课程 按钮 之上的 label
- (BeeUILabel *)getLabelByLabelName:(NSString *) labelName
{
    NSMutableArray * inputs = [NSMutableArray array];
    
    BeeUIScrollItem * item = self.list.items[0];
    
    if ( [item.view isKindOfClass:[A1_TeacherSignupCell2_iPhone class]])
    {
        [inputs addObject:((A1_TeacherSignupCell2_iPhone *)item.view).region];
        [inputs addObject:((A1_TeacherSignupCell2_iPhone *)item.view).course];
        [inputs addObject:((A1_TeacherSignupCell2_iPhone *)item.view).school];
        [inputs addObject:((A1_TeacherSignupCell2_iPhone *)item.view).gradeOne];
        [inputs addObject:((A1_TeacherSignupCell2_iPhone *)item.view).gradeTwo];
        [inputs addObject:((A1_TeacherSignupCell2_iPhone *)item.view).gradeThree];
        [inputs addObject:((A1_TeacherSignupCell2_iPhone *)item.view).gradeFour];
        [inputs addObject:((A1_TeacherSignupCell2_iPhone *)item.view).gradeFive];
    }
    if ( [labelName isEqualToString:@"region"] )
    {
        return inputs[0];
    }
    else if ( [labelName isEqualToString:@"course"] )
    {
        return inputs[1];
    }
    else if ([labelName isEqualToString:@"school"])
    {
        return inputs[2];
    }
    else if ([labelName isEqualToString:@"gradeOne"])
    {
        return inputs[3];
    }
    else if ([labelName isEqualToString:@"gradeTwo"])
    {
        return inputs[4];
    }
    else if ([labelName isEqualToString:@"gradeThree"])
    {
        return inputs[5];
    }
    else if ([labelName isEqualToString:@"gradeFour"])
    {
        return inputs[6];
    }
    else if ([labelName isEqualToString:@"gradeFive"])
    {
        return inputs[7];
    }
    return nil;
}

// 通过父级id查询地区
- (void)getRegionByParentRegionId:(NSNumber *)regionId
{
    self.CANCEL_MSG(API.get_region);
    self.MSG(API.get_region)
    .INPUT(@"parent_id", regionId);
}

// 查询数据库中存在的课程
- (void)getCourse
{
    if (![self.selectedCourseId isEqual:@0] || self.selectedCourseId == nil) {
        
        [self showCoursePickerView];
    } else  {
        
        [self.userModel get_course];
    }
}

// 查询数据库中的年级信息
- (void)getGrade
{
    self.CANCEL_MSG(API.getGrade);
    self.MSG(API.getGrade);
}

// 查询数据库中的学校信息
- (void)getSchool
{
    if ([self.selectedTownId isEqual:@0] || self.selectedTownId == nil) {
        
        [self presentFailureTips:@"请先选择所在地区"];
    } else {
        
        self.CANCEL_MSG(API.getSchool);
        self.MSG(API.getSchool)
        .INPUT(@"school_region", self.selectedTownId);
    }
}

- (void)showRegionPickerView
{
    NSString * message = @"\n\n\n\n\n\n\n\n\n";
    UIAlertController * sheet = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleActionSheet];
    // 添加确定按钮
    [sheet addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        //点击确定的逻辑处理...
        BeeUILabel * region = [self getLabelByLabelName:@"region"];
        region.text = [NSString stringWithFormat:@"%@ %@ %@",self.selectedProvinceName, self.selectedCityName, self.selectedTownName];
        region.textColor = [UIColor blackColor];
        // 每次选择地区之后，将所选择的学校的信息置空
        BeeUILabel * school = [self getLabelByLabelName:@"school"];
        school.text = @"学校";
        school.textColor = [UIColor colorWithRed:198.f/255 green:198.f/255 blue:198.f/255 alpha:1];
        self.selectedSchoolName = @"";
        self.selectedSchoolId = @0;
    }]];
    [sheet.view addSubview:self.regionPickerView];
    [self presentViewController:sheet animated:YES completion:nil];
}

- (void)showCoursePickerView
{
    // 新建一个 UIAlertController, \n 为其预留出高度
    NSString * message = @"\n\n\n\n\n\n\n\n\n\n";
    UIAlertController * sheet = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleActionSheet];
    // 添加确定按钮
    [sheet addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        //点击确定的逻辑处理...
        BeeUILabel * course = [self getLabelByLabelName:@"course"];
        course.textColor = [UIColor blackColor];
        course.text = self.selectedCourseName;
        if ([course.text isEqualToString:@"请选择课程"]) {
            
            course.textColor = [UIColor colorWithRed:211.f/255 green:211.f/255 blue:211.f/255 alpha:1];
        }
    }]];
    [sheet.view addSubview:self.coursePickerView];
    [self presentViewController:sheet animated:YES completion:nil];
}

- (void)showSchoolPickerView
{
    // 新建一个alertVC放上去
    NSString * message = @"\n\n\n\n\n\n\n\n\n";
    UIAlertController * sheet = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleActionSheet];
    // 添加确定按钮
    [sheet addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        //点击确定的逻辑处理...
        BeeUILabel * school = [self getLabelByLabelName:@"school"];
        
        NSString * regionText = [NSString stringWithFormat:@"%@",self.selectedSchoolName];
        school.text = regionText;
        school.textColor = [UIColor blackColor];
        if ([school.text isEqualToString:@"请选择学校"]) {
            
            school.textColor = [UIColor colorWithRed:211.f/255 green:211.f/255 blue:211.f/255 alpha:1];
        }
    }]];
    [sheet.view addSubview:self.schoolPickerView];
    [self presentViewController:sheet animated:YES completion:nil];
}


#pragma mark - network result

ON_MESSAGE3( API, teacher_signup, msg )
{
    if ( msg.sending )
    {
        [self presentLoadingTips:__TEXT(@"signing_up")];
    }
    else
    {
        [self dismissTips];
    }
    
    if ( msg.succeed )
    {
        STATUS * status = msg.GET_OUTPUT(@"data_status");
        
        if ( status && status.succeed.boolValue )
        {
            if ( self.userModel.firstUse )
            {
                [bee.ui.appBoard presentSuccessTips:__TEXT(@"welcome")];
            }
            else
            {
                [bee.ui.appBoard presentSuccessTips:__TEXT(@"welcome_back")];
            }
            
            [bee.ui.appBoard hideLogin];
        }
        else
        {
            if ([status.error_code integerValue] == 800) {
                switch ([status.error_desc integerValue]){
                    case 1:
                        [self presentFailureTips:@"您当前课程的第一项班级信息已经被注册"];
                        break;
                    case 2:
                        [self presentFailureTips:@"您当前课程的第二项班级信息已经被注册"];
                        break;
                    case 3:
                        [self presentFailureTips:@"您当前课程的第三项班级信息已经被注册"];
                        break;
                    case 4:
                        [self presentFailureTips:@"您当前课程的第四项班级信息已经被注册"];
                        break;
                    case 5:
                        [self presentFailureTips:@"您当前课程的第五项班级信息已经被注册"];
                        break;
                }
            }else {
                
            }
            [self showErrorTips:msg];
        }
    }
    else if ( msg.failed )
    {
        [self showErrorTips:msg];
    }
}

ON_MESSAGE3( API, course, msg )
{
    if( msg.sending )
    {
        // 获取课程中，可以不显示东西
    }
    else if( msg.succeed )
    {
        Course * getCourse = msg.GET_OUTPUT(@"data");
        [self.courseArray removeAllObjects];
        [self.courseIdArray removeAllObjects];
        [self.courseArray addObject:@"请选择课程"];
        [self.courseIdArray addObject:@0];
        self.selectedCourseName = @"请选择课程";
        for( int i = 0; i < getCourse.course_name.count; i++ )
        {
            [self.courseArray addObject:getCourse.course_name[i]];
            [self.courseIdArray addObject:getCourse.course_id[i]];
        }
        
        [self showCoursePickerView];
    }
    else if ( msg.failed )
    {
        // 获取课程失败时：
    }
    else if ( msg.cancelled )
    {
    }
}

ON_MESSAGE3( API, getGrade, msg )
{
    if (msg.sending) {
        
    } else if (msg.succeed) {
        
        [self.gradeArray removeAllObjects];
        [self.gradeIdArray removeAllObjects];
        [self.gradeArray addObject:@"请选择年级"];
        [self.gradeIdArray addObject:@0];
        NSArray * gradeArray = msg.GET_OUTPUT(@"data");
        for (int i = 0; i < gradeArray.count; i++) {
            
            Register_grade * registerGrade = gradeArray[i];
            [self.gradeArray addObject:registerGrade.grade_name];
            [self.gradeIdArray addObject:registerGrade.grade_id];
        }
        
    } else if (msg.cancelled) {
        
    } else if (msg.failed) {
        
    }
}

ON_MESSAGE3( API, getSchool, msg )
{
    if (msg.sending) {
        
    } else if (msg.succeed) {
        
        NSArray * schoolArray = msg.GET_OUTPUT(@"data");
        
        if (schoolArray.count > 0) {
            
            [self.schoolArray removeAllObjects];
            [self.schoolIdArray removeAllObjects];
            [self.schoolArray addObject:@"请选择学校"];
            [self.schoolIdArray addObject:@0];
            self.selectedSchoolName = @"请选择学校";
            for (int i = 0; i < schoolArray.count; i++) {
                
                Register_school * schoolInfo = [schoolArray objectAtIndex:i];
                [self.schoolArray addObject:schoolInfo.school_name];
                [self.schoolIdArray addObject:schoolInfo.school_id];
            }
            
            [self showSchoolPickerView];
        } else {
            [self presentFailureTips:@"您所选择地区暂无学校"];
        }
    } else if (msg.cancelled) {
        
    } else if (msg.failed) {
        
    }
}

// type: 0：country；1：province；2：city；3：town
ON_MESSAGE3( API, get_region, msg )
{
    if (msg.sending) {
        
    } else if (msg.succeed) {
        
        NSArray * regionArray = msg.GET_OUTPUT(@"data");
        NSNumber * regionType = msg.GET_OUTPUT(@"region_type");
        switch (regionType.integerValue) {
            case 1:
                [self.provinceArray removeAllObjects];
                [self.provinceIdArray removeAllObjects];
                break;
            case 2:
                [self.cityArray removeAllObjects];
                [self.cityIdArray removeAllObjects];
                break;
            case 3:
                [self.townArray removeAllObjects];
                [self.townIdArray removeAllObjects];
                break;
            default:
                break;
        }
        for (int i = 0; i < regionArray.count; i++) {
            
            REGION * region = [regionArray objectAtIndex:i];
            switch (region.type.integerValue) {
                case 1:
                    [self.provinceArray addObject:region.name];
                    [self.provinceIdArray addObject:region.id];
                    break;
                case 2:
                    [self.cityArray addObject:region.name];
                    [self.cityIdArray addObject:region.id];
                    break;
                case 3:
                    [self.townArray addObject:region.name];
                    [self.townIdArray addObject:region.id];
                    break;
                default:
                    break;
            }
        }
        // 得到省的信息时，新建alertVC，否则，更新上面重置过的pickerView的数据
        if ([regionType isEqual:@1]) {
            
            [self showRegionPickerView];
            
            [self.regionPickerView reloadAllComponents];
            [self.regionPickerView selectRow:0 inComponent:0 animated:NO];
            [self pickerView:self.regionPickerView didSelectRow:0 inComponent:0];
            [self.regionPickerView reloadComponent:0];
        } else if ([regionType isEqual:@2]) {
            
            [self.regionPickerView selectRow:0 inComponent:1 animated:NO];
            [self.regionPickerView reloadComponent:1];
            [self pickerView:self.regionPickerView didSelectRow:0 inComponent:1];
        } else if ([regionType isEqual:@3]) {
            
            [self.regionPickerView selectRow:0 inComponent:2 animated:NO];
            [self.regionPickerView reloadComponent:2];
            [self pickerView:self.regionPickerView didSelectRow:0 inComponent:2];
        }
    } else if (msg.cancelled) {
        
    } else if (msg.failed) {
        
    }
}

@end
