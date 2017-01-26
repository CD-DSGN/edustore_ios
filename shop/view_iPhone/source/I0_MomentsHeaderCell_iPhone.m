//
//  I0_MomentsCell_iPhone.m
//  shop
//
//  Created by guangnian dashu on 2016/11/8.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "I0_MomentsHeaderCell_iPhone.h"

@implementation I0_MomentsHeaderCell_iPhone

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
        MOMENTS * moments = self.data;
        
        NSString * time = [self timeDescription:moments.publish_info.publish_time];

        $(@"#user-name").TEXT(moments.teacher_info.real_name);
        $(@"#create-at").TEXT(time);
        $(@"#content").TEXT(moments.publish_info.news_content);
        
        // 此时avatar不为空，应为一个url路径。为空时为路径前缀
        if ([moments.teacher_info.avatar rangeOfString:@".jpeg"].location != NSNotFound)
        {
            $(@"#user-avatar").IMAGE(moments.teacher_info.avatar);
        }
        else
        {
            $(@"#user-avatar").IMAGE([UIImage imageNamed:@"profile_no_avatar_icon.png"]);
        }
        
//        if (moments.teacher_info.avatar != nil)
//        {
//            $(@"#user-avatar").IMAGE(moments.teacher_info.avatar);
//        }
//        else
//        {
//            $(@"#user-avatar").IMAGE([UIImage imageNamed:@"profile_no_avatar_icon.png"]);
//        }
    }
}

// 所有比较均在GMT0下进行的
- (NSString *)timeDescription:(NSString *)publish_time
{
    NSTimeInterval publish_timeInterval = [publish_time doubleValue];
    NSDate * publish_date = [NSDate dateWithTimeIntervalSince1970:publish_timeInterval];
    
    // 获取当前的date
    NSDate * cur_date = [NSDate date];
    NSDateFormatter * formatter = [[[NSDateFormatter alloc] init] autorelease];
    
    // 通过日历类判断教师发送的时间与现在时间的差值
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    if ([calendar isDateInToday:publish_date])
    {
        int delta = (int)[cur_date timeIntervalSinceDate:publish_date];
        if (delta < 60)
        {
            return @"刚刚";
        }
        else if (delta < 3600)
        {
            return [NSString stringWithFormat:@"%d分钟前",(delta/60)];
        }
            return [NSString stringWithFormat:@"%d小时前",(delta/3600)];
    }
    
    if ([calendar isDateInYesterday:publish_date])
    {
        [formatter setDateFormat:@"昨天 HH:mm"];
        return [formatter stringFromDate:publish_date];
    }
    
    NSDateComponents * coms = [calendar components:NSCalendarUnitYear fromDate:cur_date toDate:publish_date options:0];
    if (coms.year == 0)
    {
        [formatter setDateFormat:@"MM-dd HH:mm"];
        return [formatter stringFromDate:publish_date];
    }

    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [formatter stringFromDate:publish_date];
}

@end
