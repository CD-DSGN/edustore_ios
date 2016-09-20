//
//  E7_FollowCell_iPhone.m
//  shop
//
//  Created by guangnian dashu on 16/9/13.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "E7_FollowCell_iPhone.h"
#import "model.h"

@implementation E7_FollowCell_iPhone

DEF_OUTLET( UILabel, teacher )
DEF_OUTLET( UILabel, course )
DEF_OUTLET( UIButton, follow )
DEF_OUTLET( UIButton, cancel_follow )
DEF_OUTLET( UIImageView, background_row )

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

- (void)load
{
}

- (void)unload
{
}

- (void)dataDidChanged
{
    if ( self.data )
    {
        Course_Info * course_info = self.data;
        self.course.data = course_info.course_name;
        self.teacher.data = course_info.teacher_name;
        self.follow.tag = course_info.course_id.intValue;
        self.cancel_follow.tag = course_info.course_id.intValue;
        if( course_info.isLastCourse == YES )
        {
            self.background_row.image = [UIImage imageNamed:@"cell_bg_footer.png"];
        }
        else
        {
            self.background_row.image = [UIImage imageNamed:@"cell_bg_content.png"];
        }
    }
}

@end
