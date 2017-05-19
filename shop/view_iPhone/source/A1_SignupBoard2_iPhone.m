//
//  A1_SignupBoard2_iPhone.m
//  shop
//
//  Created by guangnian dashu on 2017/5/19.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "A1_SignupBoard2_iPhone.h"
#import "A1_SignupCell2_iPhone.h"

#import "AppBoard_iPhone.h"

@interface A1_SignupBoard2_iPhone ()
{
    NSInteger gradeSelectedRow;
}
// picker view
@property (nonatomic, strong) UIPickerView * regionPickerView;
@property (nonatomic, strong) UIPickerView * schoolPickerView;
@property (nonatomic, strong) UIPickerView * gradePickerView;
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
// 年级相关的数据
@property (nonatomic, strong) NSMutableArray        *    gradeArray;
@property (nonatomic, strong) NSMutableArray        *    gradeIdArray;
@property (nonatomic, strong) NSString              *    selectedGradeName;
@property (nonatomic, strong) NSNumber              *    selectedGradeId;
@end

@implementation A1_SignupBoard2_iPhone

SUPPORT_RESOURCE_LOADING( YES )
SUPPORT_AUTOMATIC_LAYOUT( YES )

DEF_MODEL( UserModel, userModel )

- (void)load
{
    self.userModel = [UserModel modelWithObserver:self];
    
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
    
    self.gradeArray = [NSMutableArray array];
    self.gradeIdArray = [NSMutableArray array];
    self.selectedGradeId = @0;
    self.selectedGradeName = nil;
    gradeSelectedRow = 0;
}

- (void)unload
{
    SAFE_RELEASE_MODEL( self.userModel );
    
    self.provinceArray = nil;
    self.cityArray = nil;
    self.townArray = nil;
    self.provinceIdArray = nil;
    self.cityIdArray = nil;
    self.townIdArray = nil;
    
    self.schoolArray = nil;
    self.schoolIdArray = nil;
    
    self.gradeArray = nil;
    self.gradeIdArray = nil;
}

#pragma mark -

ON_CREATE_VIEWS( signal )
{
    self.navigationBarShown = YES;
    self.navigationBarTitle = @"学生注册";
    self.navigationBarLeft  = [UIImage imageNamed:@"nav_back.png"];
    
    @weakify(self);
    
    self.list.reuseEnable = NO;
    self.list.whenReloading = ^
    {
        @normalize(self);
        
        self.list.total = 1;
        
        BeeUIScrollItem * item = self.list.items[0];
        item.clazz = [A1_SignupCell2_iPhone class];
        item.rule  = BeeUIScrollLayoutRule_Line;
        item.size  = self.list.size;
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

#pragma mark - A1_SignupCell2_iPhone
ON_SIGNAL3( A1_SignupCell2_iPhone, chooseRegion, signal )
{
    // 1. 当已经有选择地区的时候，不再调用网络请求，只需新建一个alertVC，将pickerView加上去即可
    // 2. 当没有选择地区的时候，且返回结果是省的信息时，新建alertVC，加上pickerView；不是省的信息时，更新pickerView
    if (self.provinceArray.count != 0) {
        
        [self showRegionPickerView];
    } else {
        
        [self getRegionByParentRegionId:@1];
    }
}

ON_SIGNAL3( A1_SignupCell2_iPhone, chooseSchool, signal )
{
    [self getSchool];
}

ON_SIGNAL3( A1_SignupCell2_iPhone, signupButton, signal )
{
    [self doRegister];
}

ON_SIGNAL3( A1_SignupCell2_iPhone, chooseGrade, signal )
{
    NSString * message = @"\n\n\n\n\n\n\n\n\n";
    UIAlertController * sheet = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleActionSheet];
    // 添加确定按钮
    [sheet addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        //点击确定的逻辑处理...
        BeeUILabel * gradeLabel = [self getLabelByLabelName:@"grade"];
        gradeLabel.text = [self.gradeArray objectAtIndex:gradeSelectedRow];
        gradeLabel.textColor = [UIColor blackColor];
        self.selectedGradeName = self.gradeArray[gradeSelectedRow];
        self.selectedGradeId = self.gradeIdArray[gradeSelectedRow];
    }]];
    [sheet.view addSubview:self.gradePickerView];
    [self presentViewController:sheet animated:YES completion:nil];
}

#pragma mark - custom function
- (void)doRegister
{
    NSString * nickname = self.nickname;
    NSString * mobilePhone = self.mobilePhone;
    NSString * password = self.password;
    NSNumber * school = self.selectedSchoolId;
    NSNumber * grade = self.selectedGradeId;
    NSNumber * studentClass = @0;
    
    // 省市不能为空，县可以为空
    if ( self.selectedTownName.length == 0 )
    {
        [self presentMessageTips:__TEXT(@"region")];
        return;
    }
    // 学校
    if ( [school isEqual:@0] )
    {
        [self presentMessageTips:@"请选择学校"];
        return;
    }
    if ( [grade isEqual:@0])
    {
        [self presentMessageTips:@"请选择年级"];
        return;
    }
    NSArray * inputs = [self inputs];
    for ( BeeUITextField * input in inputs )
    {
        if ( [input.placeholder isEqualToString:@"班级"] )
        {
            NSString * classContent = [NSString stringWithFormat:@"%@",input.text];
            classContent = [classContent stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
            if (classContent.length > 0) {
                
                [self presentFailureTips:@"班级只能填写数字"];
                return;
            }
            studentClass = [NSNumber numberWithInteger:input.text.integerValue];
        }
    }
    if ( [studentClass isEqual:@0] )
    {
        [self presentMessageTips:@"请填写班级"];
        return;
    }
    
    [self.userModel signupWithUser:mobilePhone
                          password:password
                       mobilePhone:mobilePhone
                          nickname:nickname
                          schoolId:school
                           gradeId:grade
                           classId:studentClass];
}

- (BeeUILabel *)getLabelByLabelName:(NSString *) labelName
{
    NSMutableArray * inputs = [NSMutableArray array];
    
    BeeUIScrollItem * item = self.list.items[0];
    
    if ( [item.view isKindOfClass:[A1_SignupCell2_iPhone class]])
    {
        [inputs addObject:((A1_SignupCell2_iPhone *)item.view).region];
        [inputs addObject:((A1_SignupCell2_iPhone *)item.view).school];
        [inputs addObject:((A1_SignupCell2_iPhone *)item.view).grade];
    }
    if ( [labelName isEqualToString:@"region"] )
    {
        return inputs[0];
    }
    else if ( [labelName isEqualToString:@"school"] )
    {
        return inputs[1];
    }
    else if ([labelName isEqualToString:@"grade"])
    {
        return inputs[2];
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
    }]];
    [sheet.view addSubview:self.schoolPickerView];
    [self presentViewController:sheet animated:YES completion:nil];
}

- (NSArray *)inputs
{
    NSMutableArray * inputs = [NSMutableArray array];
    
    BeeUIScrollItem * item = self.list.items[0];
    
    if ( [item.view isKindOfClass:[A1_SignupCell2_iPhone class]])
    {
        [inputs addObject:((A1_SignupCell2_iPhone *)item.view).studentClass];
    }
    return inputs;
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

#pragma mark - pickerView delegate
// pickerview 获取选中的值
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ( pickerView == self.regionPickerView )
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

#pragma mark - pickerView dataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if ( pickerView == self.regionPickerView )
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
    if ( pickerView == self.regionPickerView )
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
    if ( pickerView == self.regionPickerView )
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
    
    if (pickerView == self.regionPickerView)
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

#pragma mark - network result
// 注册结果

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

ON_MESSAGE3( API, user_signup, msg )
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

@end
