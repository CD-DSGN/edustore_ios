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

@interface A1_TeacherSignupCell2_iPhone ()
{
    NSInteger gradeAndClassLine;
}
@end

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
DEF_OUTLET( BeeUILabel, gradeOne )
DEF_OUTLET( BeeUILabel, gradeTwo )
DEF_OUTLET( BeeUILabel, gradeThree )
DEF_OUTLET( BeeUILabel, gradeFour )
DEF_OUTLET( BeeUILabel, gradeFive )
DEF_OUTLET( BeeUILabel, classOne )
DEF_OUTLET( BeeUILabel, classTwo )
DEF_OUTLET( BeeUILabel, classThree )
DEF_OUTLET( BeeUILabel, classFour )
DEF_OUTLET( BeeUILabel, classFive )


- (void)load
{
    gradeAndClassLine = 1;
}

- (void)unload
{
}

- (void)dataDidChanged
{
    if ( self.data )
    {
        TEACHER_REGISTER_INFO * teacherInfo = self.data;
        if (teacherInfo.line.integerValue > 6 || teacherInfo.line.integerValue < 0) {
            [self hideAll];
        } else {
            switch (teacherInfo.line.integerValue) {
                case 2:
                    [self hideAll];
                    [self showGradeClassLine2];
                    break;
                case 3:
                    [self hideAll];
                    [self showGradeClassLine2];
                    [self showGradeClassLine3];
                    break;
                case 4:
                    [self hideAll];
                    [self showGradeClassLine2];
                    [self showGradeClassLine3];
                    [self showGradeClassLine4];
                    break;
                case 5:
                    [self hideAll];
                    [self showGradeClassLine2];
                    [self showGradeClassLine3];
                    [self showGradeClassLine4];
                    [self showGradeClassLine5];
                    $(@"#addGradeLabel").TEXT(@"您最多可以选择5个班级");
                    break;
                default:
                    [self hideAll];
                    break;
            }
        }
        
        if (![teacherInfo.teacher_name isEqualToString: @""] && teacherInfo.teacher_name != nil) {
            $(@"#realname").TEXT(teacherInfo.teacher_name);
        }
        if (![teacherInfo.province_id isEqualToString:@""] && teacherInfo.province_id != nil) {
            $(@"#region").CSS(@"color:black");
            $(@"#region").TEXT([NSString stringWithFormat:@"%@ %@ %@", teacherInfo.province_id, teacherInfo.town_id, teacherInfo.district_id]);
        }
        if (![teacherInfo.school_id isEqualToString:@""] && teacherInfo.school_id != nil) {
            $(@"#school").CSS(@"color:black");
            $(@"#school").TEXT(teacherInfo.school_id);
            
        }
        if (![teacherInfo.course_id isEqualToString:@""] && teacherInfo.course_id != nil) {
            $(@"#course").CSS(@"color:black");
            $(@"#course").TEXT(teacherInfo.course_id);
            
        }
        if (teacherInfo.grade_array.count > 0) {
            
            if (![teacherInfo.grade_array[0] isEqualToString:@""]) {
                
                $(@"#gradeOne").CSS(@"color:black");
                $(@"#gradeOne").TEXT(teacherInfo.grade_array[0]);
            }
            if (![teacherInfo.grade_array[1] isEqualToString:@""]) {
                
                $(@"#gradeTwo").CSS(@"color:black");
                $(@"#gradeTwo").TEXT(teacherInfo.grade_array[1]);
            }
            if (![teacherInfo.grade_array[2] isEqualToString:@""]) {
                
                $(@"#gradeThree").CSS(@"color:black");
                $(@"#gradeThree").TEXT(teacherInfo.grade_array[2]);
            }
            if (![teacherInfo.grade_array[3] isEqualToString:@""]) {
                
                $(@"#gradeFour").CSS(@"color:black");
                $(@"#gradeFour").TEXT(teacherInfo.grade_array[3]);
            }
            if (![teacherInfo.grade_array[4] isEqualToString:@""]) {
                
                $(@"#gradeFive").CSS(@"color:black");
                $(@"#gradeFive").TEXT(teacherInfo.grade_array[4]);
            }
        }
        if (teacherInfo.class_array.count > 0) {
            
            if (![teacherInfo.class_array[0] isEqualToString:@"0"]) {
                
                $(@"#classOne").CSS(@"color:black");
                $(@"#classOne").TEXT(teacherInfo.class_array[0]);
            }
            if (![teacherInfo.class_array[1] isEqualToString:@"0"]) {
                
                $(@"#classTwo").CSS(@"color:black");
                $(@"#classTwo").TEXT(teacherInfo.class_array[1]);
            }
            if (![teacherInfo.class_array[2] isEqualToString:@"0"]) {
                
                $(@"#classThree").CSS(@"color:black");
                $(@"#classThree").TEXT(teacherInfo.class_array[2]);
            }
            if (![teacherInfo.class_array[3] isEqualToString:@"0"]) {
                
                $(@"#classFour").CSS(@"color:black");
                $(@"#classFour").TEXT(teacherInfo.class_array[3]);
            }
            if (![teacherInfo.class_array[4] isEqualToString:@"0"]) {
                
                $(@"#classFive").CSS(@"color:black");
                $(@"#classFive").TEXT(teacherInfo.class_array[4]);
            }
        }
    }
}

-(void)hideAll
{
    $(@"#chooseGradeTwo").HIDE();
    $(@"#chooseGradeThree").HIDE();
    $(@"#chooseGradeFour").HIDE();
    $(@"#chooseGradeFive").HIDE();
}

- (void)showGradeClassLine2
{
    $(@"#chooseGradeTwo").SHOW();
}

- (void)showGradeClassLine3
{
    $(@"#chooseGradeThree").SHOW();
}

- (void)showGradeClassLine4
{
    $(@"#chooseGradeFour").SHOW();
}

- (void)showGradeClassLine5
{
    $(@"#chooseGradeFive").SHOW();
}



@end
