//
//  E7_FollowBoard_iPhone.m
//  shop
//
//  Created by guangnian dashu on 16/9/13.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "E7_FollowBoard_iPhone.h"
#import "E7_FollowCell_iPhone.h"
#import "E7_SearchTeacherBoard_iPhone.h"

#import "AppBoard_iPhone.h"

#import "CommonPullLoader.h"
#import "ECMobileManager.h"


// 查数据库，获取课程信息，存放于list（scrollView）中，在Cell中呈现
@implementation E7_FollowBoard_iPhone

DEF_MODEL( UserModel, userModel )

DEF_OUTLET( BeeUIScrollView, list )

- (void)load
{
    self.userModel = [UserModel modelWithObserver:self];
    self.course = [NSMutableArray array];
    self.course_id = [NSMutableArray array];
    self.teacher_name = [NSMutableArray array];
}

- (void)unload
{
    SAFE_RELEASE_MODEL( self.userModel );
    self.course = nil;
    self.course_id = nil;
    self.teacher_name = nil;
}

#pragma mark -

ON_CREATE_VIEWS( signal )
{
    self.navigationBarShown = YES;
    self.navigationBarTitle = __TEXT(@"follow");
    self.navigationBarLeft  = [UIImage imageNamed:@"nav_back.png"];
    
    @weakify(self);
    
    self.list.whenReloading = ^
    {
        @normalize(self);
        
        self.list.total = self.course.count;
        self.list.scrollEnabled = NO;
        
        for ( int i = 0; i < self.course.count; i++ )
        {
            Course_Info * course_info = [[Course_Info alloc] init];
            course_info.course_name = self.course[i];
            course_info.course_id = self.course_id[i];
            course_info.teacher_name = self.teacher_name[i];
            if ( i == (self.course.count - 1) )
            {
                course_info.isLastCourse = YES;
            }
            else
            {
                course_info.isLastCourse = NO;
            }
            
            BeeUIScrollItem * item = self.list.items[i];
            item.clazz = [E7_FollowCell_iPhone class];
            item.rule = BeeUIScrollLayoutRule_Line;
            item.size = CGSizeAuto;
            item.data = course_info;
        }
        
    };
}

ON_DELETE_VIEWS( signal )
{
    self.list = nil;
}

ON_LAYOUT_VIEWS( signal )
{
}

ON_WILL_APPEAR( signal )
{
    [self setupCourse];
    // [self setupTeacher];
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
    
}

#pragma mark - 查询课程
- (void)setupCourse
{
    [self.userModel getCourse:self.user_id];
}

#pragma mark - 初始化学生关注的教师
- (void)setupTeacher
{
    [self.userModel getTeacher:self.user_id];
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
        [self.course_id removeAllObjects];
        [self.teacher_name removeAllObjects];
        for( int i = 0; i < getCourse.course_name.count; i++ )
        {
            [self.course addObject:getCourse.course_name[i]];
            [self.course_id addObject:getCourse.course_id[i]];
            [self.teacher_name addObject:getCourse.teacher_name[i]];
        }
        [self.list reloadData];
    }
    else if ( msg.failed )
    {
        // 获取课程失败时：
    }
    else if ( msg.cancelled )
    {
    }
}

ON_MESSAGE3( API, get_teacher, msg )
{
    if( msg.sending )
    {
        
    }
    else if( msg.succeed )
    {
    }
    else if ( msg.failed )
    {
        
    }
    else if ( msg.cancelled )
    {
    }
}

ON_MESSAGE3( API, cancel_follow, msg )
{
    if( msg.sending )
    {
        // 取消关注中
        [self presentMessageTips:@"取消中"];
    }
    else if( msg.succeed )
    {
        // 取消关注后刷新
        [self setupCourse];
        
    }
    else if ( msg.failed )
    {
        
    }
    else if ( msg.cancelled )
    {
    }
}

#pragma mark - 关注、取消关注事件处理

ON_SIGNAL3( E7_FollowCell_iPhone, follow, signal )
{
    UIButton * follow = signal.source;
    // printf("%ld\n", (long)follow.tag);
    E7_SearchTeacherBoard_iPhone * board = [[[E7_SearchTeacherBoard_iPhone alloc] init] autorelease];
    board.course_id = [NSNumber numberWithInteger:follow.tag];
    board.user_id = self.user_id;
    board.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:board animated:YES completion:nil];
    // [self.stack pushBoard:board animated:YES];
}

ON_SIGNAL3(E7_FollowCell_iPhone, cancel_follow, signal )
{
    UIButton * cancel = signal.source;
    NSNumber * course_id = [NSNumber numberWithInteger:cancel.tag];
    [self.userModel cancelFollowByStudentId:self.user_id courseId:course_id];
}

@end
