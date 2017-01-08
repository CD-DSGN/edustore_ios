//
//  B0_IndexButtonCell_iPhone.m
//  shop
//
//  Created by guangnian dashu on 2016/11/10.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "B0_IndexButtonCell_iPhone.h"

@implementation B0_IndexButtonCell_iPhone

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
    if (self.data)
    {
        UserModel * userModel = self.data;
        
        if (![UserModel online])
        {
            $(@"#follow_col").SHOW();
            $(@"integral_col").HIDE();
        }
        else
        {
            if ( userModel.user.is_teacher.intValue == 0 )     // 学生账户
            {
                $(@"#follow_col").SHOW();
                $(@"#integral_col").HIDE();
            }
            else if ( userModel.user.is_teacher.intValue == 1 )     // 教师账户
            {
                $(@"#follow_col").HIDE();
                $(@"#integral_col").SHOW();
            }
        }
    }
}

@end
