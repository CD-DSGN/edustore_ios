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
#import "A1_TeacherSignupBoard_iPhone.h"

#import "AppBoard_iPhone.h"

#import "FormCell.h"

@implementation A1_TeacherSignupBoard2_iPhone

SUPPORT_RESOURCE_LOADING( YES )
SUPPORT_AUTOMATIC_LAYOUT( YES )

DEF_MODEL( UserModel, userModel )
DEF_MODEL( RegisterModel, registerModel )

- (void)load
{
	self.userModel = [UserModel modelWithObserver:self];
    self.registerModel = [RegisterModel modelWithObserver:self];
    
    self.group = [NSMutableArray array];
    self.course = [NSMutableArray array];
    
    self.provinceArray = [NSMutableArray array];
    self.cityArray = [NSArray array];
    self.townArray = [NSArray array];
    self.selectedArray = [NSArray array];
    self.pickerDic = [NSDictionary dictionary];
    
    self.selectedProvinceName = self.selectedCityName = self.selectedTownName = nil;
    self.selectedProvinceRow = self.selectedCityRow = self.selectedTownRow = 0;
    self.courseName = @"请选择课程";
    self.courseId = 0;
    
    self.isInitRegionPickerView = NO;
}

- (void)unload
{
	SAFE_RELEASE_MODEL( self.userModel );
    SAFE_RELEASE_MODEL( self.registerModel );
    
    self.group = nil;
    self.course = nil;
}

#pragma mark -

ON_CREATE_VIEWS( signal )
{
    self.selectCourse.tag = 1;
    self.navigationBarShown = YES;
    self.navigationBarTitle = __TEXT(@"teacherSignup");
    self.navigationBarLeft  = [UIImage imageNamed:@"nav_back.png"];
    [self showBarButton:BeeUINavigationBar.RIGHT
                  title:__TEXT(@"register_regist")
                  image:[UIImage imageNamed:@"nav_right.png"]];
    
    @weakify(self);

    self.list.reuseEnable = NO;
    self.list.whenReloading = ^
    {
        @normalize(self);
        
        self.list.total = 1;
        
        BeeUIScrollItem * item = self.list.items[0];
        item.clazz = [A1_TeacherSignupCell2_iPhone class];
        item.rule  = BeeUIScrollLayoutRule_Line;
        item.size  = CGSizeAuto;
        item.data  = self.registerModel;
        
//        NSArray * datas = self.group;
//        
//        self.list.total = datas.count;
//        
//        for ( int i=0; i < datas.count; i++ )
//        {
//            FormData * formData = [self.group safeObjectAtIndex:i];
//            
//            if ( i == 0 )
//            {
//                formData.scrollIndex = UIScrollViewIndexFirst;
//            }
//            else if ( i == self.list.total - 1 ) // self.commentModel.comments.count
//            {
//                formData.scrollIndex = UIScrollViewIndexLast;
//            }
//            else
//            {
//                formData.scrollIndex = UIScrollViewIndexDefault;
//            }
//
//            BeeUIScrollItem * item = self.list.items[i];
//            item.clazz = [A1_TeacherSignupCell2_iPhone class];
//            item.rule  = BeeUIScrollLayoutRule_Line;
//            item.size  = CGSizeAuto;
//            item.data  = formData;
//        }
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
    [self doRegister];
}

// 如果重构页面需要修改的地方
#pragma mark - BeeUITextField

ON_SIGNAL3( BeeUITextField, RETURN, signal )
{
    NSArray * inputs = [self inputs];
    
    BeeUITextField * input = (BeeUITextField *)signal.source;
    
    NSInteger index = [inputs indexOfObject:input];
    
    if ( index == 0 )
    {
        // 下一步为选择地区
        [self getRegion];
        BeeUITextField * next = [inputs objectAtIndex:index];
        [next resignFirstResponder];
    }
    else if ( index == 1 )
    {
        // 下一步为选择课程
        [self getCourse];
        BeeUITextField * next = [inputs objectAtIndex:index];
        [next resignFirstResponder];
    }
    
    else if ( UIReturnKeyNext == input.returnKeyType )
    {
        BeeUITextField * next = [inputs objectAtIndex:(index + 1)];
        [next becomeFirstResponder];
    }
    else if ( UIReturnKeyDone == input.returnKeyType )
    {
        [self.view endEditing:YES];
        [self doRegister];
    }
}

#pragma mark - SignupBoard_iPhone

ON_SIGNAL3( SignupBoard_iPhone, signin, signal )
{
	[self.stack popBoardAnimated:YES];
}

//UIActionSheet ios 8.3 之后被弃用
//使用新的 UIAlertController 重写
ON_SIGNAL3( A1_TeacherSignupCell2_iPhone, chooseCourses, signal )
{
    // 通过方法 getCourse 从数据库读取课程信息
    [self getCourse];
}

ON_SIGNAL3( A1_TeacherSignupCell2_iPhone, chooseRegion, signal )
{
    // 省市县三级联动选择地址
    [self getRegion];
}

// 查询数据库中存在的课程
- (void)getCourse
{
    [self.userModel getCourse];
}

// 加载省市县的信息（后面还有一些使用）
- (void)getRegion
{
    // 如果没有被初始化过(初始化的是array)
    if ( !self.isInitRegionPickerView )
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"region" ofType:@"plist"];
        self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
        // 从字典中读取出的顺序与数据库中的不同，需处理
        NSArray * province = [NSArray arrayWithObjects:@"北京",@"安徽",@"福建",@"甘肃",@"广东",@"广西",@"贵州",@"海南",@"河北",@"河南",@"黑龙江",@"湖北",@"湖南",@"吉林",@"江苏",@"江西",@"辽宁",@"内蒙古",@"宁夏",@"青海",@"山东",@"山西",@"陕西",@"上海",@"四川",@"天津",@"西藏",@"新疆",@"云南",@"浙江",@"重庆",@"香港",@"澳门",@"台湾", nil];
        for ( int i = 0; i < province.count; i++ )
        {
            [self.provinceArray addObject:[province objectAtIndex:i]];
        }
        self.selectedArray = [self.pickerDic objectForKey:@"北京"];
        //    self.provinceArray = [self.pickerDic allKeys];
        //    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
        
        if (self.selectedArray.count > 0) {
            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
        }
        
        if (self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
        }
        self.selectedProvinceName = [self.provinceArray objectAtIndex:0];
        self.selectedCityName = [self.cityArray objectAtIndex:0];
        self.selectedTownName = [self.townArray objectAtIndex:0];
        [self initPickerView:self.selectRegion];
        [self initAlertControllerWithPickerView:self.selectRegion];
        self.isInitRegionPickerView = YES;
    }
    else
    {
        [self initPickerView:self.selectRegion];
        [self initAlertControllerWithPickerView:self.selectRegion];
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
        [inputs addObject:((A1_TeacherSignupCell2_iPhone *)item.view).school];
        [inputs addObject:((A1_TeacherSignupCell2_iPhone *)item.view).password];
        [inputs addObject:((A1_TeacherSignupCell2_iPhone *)item.view).confirmePassword];
    }
    return inputs;
}

- (void)setupFields
{
//    self.registerModel.usernameTag = __TEXT(@"login_username");
    self.registerModel.passwordTag = __TEXT(@"login_password");
    self.registerModel.confirmPasswordTag = __TEXT(@"register_confirm");
//    self.registerModel.mobilePhoneTag = __TEXT(@"mobile_phone");
//    self.registerModel.identifyCodeTag = __TEXT(@"identify_code");
    self.registerModel.realnameTag = __TEXT(@"login_realname");
    self.registerModel.regionTag = __TEXT(@"region");
    self.registerModel.schoolTag = __TEXT(@"school");
    self.registerModel.courseTag = __TEXT(@"course");
    
//    [self.group removeAllObjects];
//    NSArray * fields = self.userModel.fields;
//
//    FormData * realname = [FormData data];
//    realname.tagString = @"realname";
//    realname.placeholder = __TEXT(@"login_realname");
//    realname.keyboardType = UIKeyboardTypeDefault;
//    realname.returnKeyType = UIReturnKeyNext;
//    [self.group addObject:realname];
//    
//    FormData * region = [FormData data];
//    region.tagString = @"region";
//    region.placeholder = __TEXT(@"region");
//    region.keyboardType = UIKeyboardTypeEmailAddress;
//    region.returnKeyType = UIReturnKeyNext;
//    [self.group addObject:region];
//    
//    FormData * school = [FormData data];
//    school.tagString = @"school";
//    school.placeholder = __TEXT(@"school");
//    school.keyboardType = UIKeyboardTypeEmailAddress;
//    school.returnKeyType = UIReturnKeyNext;
//    [self.group addObject:school];
//    
//    FormData * course = [FormData data];
//    course.tagString = @"course";
//    course.placeholder = __TEXT(@"course");
//    course.keyboardType = UIKeyboardTypeEmailAddress;
//    course.returnKeyType = UIReturnKeyNext;
//    [self.group addObject:course];
//    
//    FormData * password = [FormData data];
//    password.tagString = @"password";
//    password.placeholder = __TEXT(@"login_password");
//    password.isSecure = YES;
//    password.returnKeyType = UIReturnKeyNext;
//    [self.group addObject:password];
//    
//    FormData * password2 = [FormData data];
//    password2.tagString = @"password2";
//    password2.placeholder = __TEXT(@"register_confirm");
//    password2.isSecure = YES;
//    
//    if ( fields.count == 0 )
//    {
//        password2.returnKeyType = UIReturnKeyDone;
//    }
//    else
//    {
//        password2.returnKeyType = UIReturnKeyNext;
//    }
//    
//    [self.group addObject:password2];
    
//    if ( fields && 0 != fields.count  )
//    {
//        for ( int i=0; i < fields.count; i++ )
//        {
//            SIGNUP_FIELD * field = fields[i];
//            
//            FormData * element = [FormData data];
//            element.tagString = field.id.stringValue;
//            element.placeholder = field.name;
//            element.data = field;
//            
//            if ( i == (fields.count - 1) )
//            {
//                element.returnKeyType = UIReturnKeyDone;
//            }
//            else
//            {
//                element.returnKeyType = UIReturnKeyNext;
//            }
//            
//            [self.group addObject:element];
//        }
//    }
}

- (void)doRegister
{    
    NSString * userName = nil;
//  	NSString * email = nil;
    NSString * mobilePhone = nil;
    NSString * realname = nil;
    NSString * school = nil;
    NSString * course = @"0";
  	NSString * password = nil;
  	NSString * password2 = nil;
    NSString * isTeacher = @"1";
    
    NSArray * inputs = [self inputs];
    
    NSMutableArray * fields = [NSMutableArray array];
    
    // 为注册需要的参数赋值
    userName = self.username;
    mobilePhone = self.mobilePhone;
    course = [[NSString alloc] initWithFormat:@"%ld",(long)self.courseId];
    
    for ( BeeUITextField * input in inputs )
    {
        if ( [input.placeholder isEqualToString:__TEXT(@"login_realname")] )
        {
            realname = input.text;
        }
        else if( [input.placeholder isEqualToString:__TEXT(@"login_password")] )
        {
            password = input.text;
        }
        else if( [input.placeholder isEqualToString:__TEXT(@"register_confirm")] )
        {
            password2 = input.text;
        }
        else if( [input.placeholder isEqualToString:__TEXT(@"school")] )
        {
            school = input.text;
        }
    }
//    for ( BeeUITextField * input in inputs )
//    {
//        A1_TeacherSignupCell2_iPhone * cell = (A1_TeacherSignupCell2_iPhone *)input.superview;
//
//        FormData * data = cell.data;
//        
//        if ( [data.tagString isEqualToString:@"realname"] )
//        {
//            realname = cell.input.text.trim;
//            data.text = realname;
//        }
//        else if ( [data.tagString isEqualToString:@"region"] )
//        {
//
//        }
//        else if( [data.tagString isEqualToString:@"school"] )
//        {
//            school = cell.input.text.trim;
//            data.text = school;
//        }
//        else if( [data.tagString isEqualToString:@"password"] )
//        {
//            password = cell.input.text;
//            data.text = password;
//        }
//        else if( [data.tagString isEqualToString:@"password2"] )
//        {
//            password2 = cell.input.text;
//            data.text = password2;
//        }
//        else if( [data.tagString isEqualToString:@"course"] )
//        {
//            NSString * string = [[NSString alloc] initWithFormat:@"%ld",(long)self.courseId ];
//            course = string;
//        }
//        else
//        {
//            SIGNUP_FIELD * field = (SIGNUP_FIELD *)cell.data;
//
//            if ( field.need.boolValue && cell.input.text.length == 0 )
//            {
//                [self presentMessageTips:[NSString stringWithFormat:@"%@%@", __TEXT(@"please_input"), field.name]];
//                return;
//            }
//            
//            SIGNUP_FIELD_VALUE * fieldValue = [[[SIGNUP_FIELD_VALUE alloc] init] autorelease];
//            fieldValue.id = field.id;
//            fieldValue.value = cell.input.text;
//            data.text = cell.input.text;
//            [fields addObject:fieldValue];

//        }

    // 上一步已做过判断
//	if ( 0 == userName.length || NO == [userName isChineseUserName] )
//	{
//		[self presentMessageTips:__TEXT(@"wrong_username")];
//		return;
//	}
//	
//	if ( userName.length < 2 )
//	{
//		[self presentMessageTips:__TEXT(@"username_too_short")];
//		return;
//	}
//	
//	if ( userName.length > 20 )
//	{
//		[self presentMessageTips:__TEXT(@"username_too_long")];
//		return;
//	}

//	if ( 0 == email.length || NO == [email isEmail] )
//	{
//		[self presentMessageTips:__TEXT(@"wrong_email")];
//		return;
//	}
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
    if ( 0 == school.length )
    {
        [self presentMessageTips:__TEXT(@"null_school")];
        return;
    }
    if ( [course isEqualToString:@"0"] )
    {
        [self presentMessageTips:__TEXT(@"wrong_course")];
        return;
    }
	if ( 0 == password.length || NO == [password isPassword] )
	{
		[self presentMessageTips:__TEXT(@"wrong_password")];
		return;
	}

	if ( password.length < 6 )
	{
		[self presentMessageTips:__TEXT(@"password_too_short")];
		return;
	}

	if ( password.length > 20 )
	{
		[self presentMessageTips:__TEXT(@"password_too_long")];
		return;
	}

	if ( NO == [password isEqualToString:password2] )
	{
		[self presentMessageTips:__TEXT(@"wrong_password")];
		return;
	}

	[self.userModel signupWithUser:userName
						  password:password
                       mobilePhone:mobilePhone
                            fields:fields
                          realname:realname
                            school:school
                            course:course
                         isTeacher:isTeacher
                      provinceName:self.selectedProvinceName
                          cityName:self.selectedCityName
                          townName:self.selectedTownName
    ];
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

#pragma mark -

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
            [self showErrorTips:msg];
        }
    }
    else if ( msg.failed )
    {
        [self showErrorTips:msg];
    }
}

ON_MESSAGE3( API, get_course, msg )
{
    if( msg.sending )
    {
        // 获取课程中，可以不显示东西
    }
    else if( msg.succeed )
    {
        Course * getCourse = msg.GET_OUTPUT(@"data");
        [self.course removeAllObjects];
        [self.course addObject:@"请选择课程"];
        [self.course arrayByAddingObject:getCourse.course_name];
        for( int i = 0; i < getCourse.course_name.count; i++ )
        {
            [self.course addObject:getCourse.course_name[i]];
        }
        // 新建一个 UIPickerView
        self.selectCourse = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
        self.selectCourse.delegate = self;
        self.selectCourse.dataSource = self;
        
        [self.selectCourse reloadAllComponents];
        
        // 新建一个 UIAlertController, \n 为其预留出高度
        NSString * message = @"\n\n\n\n\n\n\n\n\n\n";
        UIAlertController * sheet = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleActionSheet];
        // 添加确定按钮
        [sheet addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            //点击确定的逻辑处理...
            BeeUILabel * course = [self getLabelByLabelName:@"course"];
            if( self.courseId == 0 ) {
                //用户未选择课程,字体为浅灰色
                course.textColor = [UIColor lightGrayColor];
            } else {
                course.textColor = [UIColor blackColor];
            }
            course.text = self.courseName;
            
        }]];
        // 保存上一次选择的行
        [self.selectCourse selectRow:self.courseId inComponent:0 animated:NO];
        [sheet.view addSubview:self.selectCourse];
        // 将 sheet 显示出来
            [self presentViewController:sheet animated:YES completion:nil];
        }
        else if ( msg.failed )
        {
            // 获取课程失败时：
        }
        else if ( msg.cancelled )
        {
        }
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if ( pickerView == self.selectCourse )
    {
        return 1;
    }
    else if ( pickerView == self.selectRegion )
    {
        return 3;
    }
    return 0;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ( pickerView == self.selectCourse )
    {
        return [self.course count];
    }
    else if ( pickerView == self.selectRegion )
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
    return 0;
}

// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if ( pickerView == self.selectCourse )
    {
        return  self.view.frame.size.width;
    }
    else if ( pickerView == self.selectRegion )
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
    
    if ( pickerView == self.selectCourse )
    {
        UILabel * text = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        text.textAlignment = NSTextAlignmentCenter;
        text.text = [self.course objectAtIndex:row];
        [view addSubview:text];
    }
    else
    {
        UILabel * text = [[UILabel alloc] init];
        if ( component == 0 )
        {
            text.frame = CGRectMake(0, 0, self.frame.size.width/3-20, 30);
            text.text = [self pickerView:pickerView titleForRow:row forComponent:component];
        }
        else if ( component == 1)
        {
            text.frame = CGRectMake(0, 0, self.frame.size.width/3-15, 30);
            text.text = [self pickerView:pickerView titleForRow:row forComponent:component];
        }
        else
        {
            text.frame = CGRectMake(0, 0, self.frame.size.width/3+10, 30);
            text.text = [self pickerView:pickerView titleForRow:row forComponent:component];
        }
        text.textAlignment = UITextAlignmentCenter;
        // text.adjustsFontSizeToFitWidth = YES;
        [view addSubview:text];
    }
    return view;
}
// pickerview 获取选中的值
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ( pickerView == self.selectCourse )
    {
        self.courseName = self.course[row];
        self.courseId = row;
    }
    else if ( pickerView == self.selectRegion )
    {
        // 地区数据从本地获取，省市县的id僵硬,写数据库的时候查询算了
        if ( component == 0 )
        {
            self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
            if ( self.selectedArray.count > 0 )
            {
                self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
            }
            else
            {
                self.cityArray = nil;
            }
            if ( self.cityArray.count > 0 )
            {
                self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
            }
            else
            {
                self.townArray = nil;
            }
            self.selectedProvinceRow = row;
            self.selectedTownRow = self.selectedCityRow = 0;
            [self.selectRegion selectRow:self.selectedCityRow inComponent:1 animated:NO];
            [self.selectRegion selectRow:self.selectedTownRow inComponent:2 animated:NO];
            [self.selectRegion reloadComponent:1];
            
            self.selectedProvinceName = [self.provinceArray objectAtIndex:row];
        }
        else if ( component == 1 )
        {
            if ( self.selectedArray.count > 0 )
            {
                self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:row]];
            }
            else
            {
                self.townArray = nil;
            }
            self.selectedCityRow = row;
            self.selectedTownRow = 0;
            [self.selectRegion selectRow:self.selectedTownRow inComponent:2 animated:NO];
        }
        else if ( component == 2 )
        {
            self.selectedTownRow = row;
        }
        [self.selectRegion reloadComponent:2];
    }
    
}
// 每一行的返回内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ( pickerView == self.selectCourse )
    {
        NSString * str = [self.course objectAtIndex:row];
        return str;
    }
    else if ( pickerView == self.selectRegion )
    {
        if ( component == 0 )
        {
            return [self.provinceArray objectAtIndex:row];
        }
        else if ( component == 1 )
        {
            return [self.cityArray objectAtIndex:row];
        }
        else
        {
            return [self.townArray objectAtIndex:row];
        }
    }
    return nil;
}

// 获取选择课程 按钮 之上的 label
- (BeeUILabel *)getLabelByLabelName:(NSString *) labelName
{
    NSMutableArray * inputs = [NSMutableArray array];
    
    BeeUIScrollItem * item = self.list.items[0];
    
    if ( [item.view isKindOfClass:[A1_TeacherSignupCell2_iPhone class]])
    {
        [inputs addObject:((A1_TeacherSignupCell2_iPhone *)item.view).region];
        [inputs addObject:((A1_TeacherSignupCell2_iPhone *)item.view).course];
    }
    if ( [labelName isEqualToString:@"region"] )
    {
        return inputs[0];
    }
    else if ( [labelName isEqualToString:@"course"] )
    {
        return inputs[1];
    }
    return nil;
}

// 初始化pickerview，以备复用
- (void)initPickerView:(UIPickerView *) pickerView
{
    if ( pickerView == self.selectRegion )
    {
        self.selectRegion = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
        self.selectRegion.delegate = self;
        self.selectRegion.dataSource = self;
        [self.selectRegion selectRow:self.selectedProvinceRow inComponent:0 animated:NO];
        [self.selectRegion selectRow:self.selectedCityRow inComponent:1 animated:NO];
        [self.selectRegion selectRow:self.selectedTownRow inComponent:2 animated:NO];
        [self.selectRegion reloadAllComponents];
    }
    else if ( pickerView == self.selectCourse )
    {
        
    }
}
// 初始化alertController，以备复用
- (void)initAlertControllerWithPickerView:(UIPickerView *) pickerView
{
    if ( pickerView == self.selectRegion )
    {
        NSString * message = @"\n\n\n\n\n\n\n\n\n";
        UIAlertController * sheet = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleActionSheet];
        // 添加确定按钮
        [sheet addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            //点击确定的逻辑处理...
            BeeUILabel * region = [self getLabelByLabelName:@"region"];
            
            NSString * temp = [self.provinceArray objectAtIndex:self.selectedProvinceRow];
            temp = [temp stringByAppendingString:@" "];
            temp = [temp stringByAppendingString:[self.cityArray objectAtIndex:self.selectedCityRow]];
            temp = [temp stringByAppendingString:@" "];
            temp = [temp stringByAppendingString:[self.townArray objectAtIndex:self.selectedTownRow]];
            region.text = temp;
            //  因为没有取消按钮，所以每次必会选择出一个地址，可以之后修改
            region.textColor = [UIColor blackColor];
            
            // 赋值，为了传参
            self.selectedProvinceName = [self.provinceArray objectAtIndex:self.selectedProvinceRow];
            self.selectedCityName = [self.cityArray objectAtIndex:self.selectedCityRow];
            self.selectedTownName = [self.townArray objectAtIndex:self.selectedTownRow];
        }]];
        [sheet.view addSubview:pickerView];
        // 将 sheet 显示出来
        [self presentViewController:sheet animated:YES completion:nil];
      //  self.initPickerView = YES;
    }
    
}

@end
