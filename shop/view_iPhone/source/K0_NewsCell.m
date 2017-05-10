//
//  K0_NewsCell.m
//  shop
//
//  Created by 田明飞 on 2017/5/4.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "K0_NewsCell.h"
#import "ecmobile.h"
@implementation K0_NewsCell

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
    if (self.data) {
        NEWS_DETAIL * news = self.data;
        //    _publish_time = moments.publish_info.publish_time;
        //    _publish_uid = moments.publish_info.user_id;
        //    if ([[UserModel sharedInstance].user.id integerValue] == [moments.publish_info.user_id integerValue]) {
        //        self.deleteButton.hidden = NO;
        //    }else {
        //        self.deleteButton.hidden = YES;
        //    }
        //
        //    NSString * time = [self timeDescription:moments.publish_info.publish_time];
        //
        //    $(@"#user-name").TEXT(moments.teacher_info.real_name);
        //    $(@"#create-at").TEXT(time);
        //    $(@"#content").TEXT(moments.publish_info.news_content);
        //
        //    // 此时avatar不为空，应为一个url路径。为空时为路径前缀
        //    if ([moments.teacher_info.avatar rangeOfString:@".jpeg"].location != NSNotFound)
        //    {
        //        $(@"#user-avatar").IMAGE(moments.teacher_info.avatar);
        //    }
        //    else
        //    {
        //        $(@"#user-avatar").IMAGE([UIImage imageNamed:@"profile_no_avatar_icon.png"]);
        //    }
        //
        //    //        if (moments.teacher_info.avatar != nil)
        //    //        {
        //    //            $(@"#user-avatar").IMAGE(moments.teacher_info.avatar);
        //    //        }
        //    //        else
        //    //        {
        //    //            $(@"#user-avatar").IMAGE([UIImage imageNamed:@"profile_no_avatar_icon.png"]);
        //    //        }
        //}
    }
    
}

@end
