//
//  I0_MomentsNoResultCell_iPhone.m
//  shop
//
//  Created by guangnian dashu on 2016/11/16.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "I0_MomentsNoResultCell_iPhone.h"

@implementation I0_MomentsNoResultCell_iPhone

SUPPORT_RESOURCE_LOADING( YES )
SUPPORT_AUTOMATIC_LAYOUT( YES )

- (void)load
{
}

- (void)unload
{
}

- (void)dataDidChanged
{
    // data: 0表未登录，1表示教师尚未发布消息，2表示学生尚未关注任何教师，3表示学生所关注教师未发布动态
    if (self.data)
    {
        NSNumber * status = self.data;
        switch (status.integerValue) {
            case 0:
                [self showLogOut];
                break;
            case 1:
                [self showLogIn];
                $(@"#errorText").TEXT(@"教师尚未发布消息");
                break;
            case 2:
                [self showLogIn];
                $(@"#errorText").TEXT(@"学生尚未关注任何教师");
                break;
            case 3:
                [self showLogIn];
                $(@"#errorText").TEXT(@"学生所关注教师未发布动态");
                break;
            default:
                break;
        }
    }
}

- (void)showLogOut
{
    $(@"logInBg").HIDE();
    $(@"errorText").HIDE();
    $(@"logOutBg").SHOW();
    $(@"logOutLabelOne").SHOW();
    $(@"logOutLabelTwo").SHOW();
    $(@"signInButton").SHOW();
}

- (void)showLogIn
{
    $(@"logInBg").SHOW();
    $(@"errorText").SHOW();
    $(@"logOutBg").HIDE();
    $(@"logOutLabelOne").HIDE();
    $(@"logOutLabelTwo").HIDE();
    $(@"signInButton").HIDE();
}

@end
