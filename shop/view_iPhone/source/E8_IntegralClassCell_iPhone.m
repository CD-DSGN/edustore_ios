//
//  E8_IntegralCell_iPhone.m
//  shop
//
//  Created by guangnian dashu on 16/9/19.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "E8_IntegralClassCell_iPhone.h"
#import "model.h"

#define srceenWidth [[UIScreen mainScreen] bounds].size.width

@implementation E8_IntegralClassCell_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

- (void)load
{
    self.tappable = YES;
    self.tapSignal = self.TAPPED;
}

- (void)unload
{
}

- (void)dataDidChanged
{
    if ( self.data )
    {
        TEACHER_INTEGRAL * integral = self.data;
        
        // 取值
        NSString * invite_code = integral.invite_code;
        NSString * pay_points = integral.pay_points;
        NSString * points_from_affiliate = integral.points_from_affiliate;
        NSString * points_from_subscription = integral.points_from_subscription;
//        NSString * rank_points = integral.rank_points;
        NSString * subscription_student_num = integral.subscription_student_num;
        NSString * recommanded_teacher_num = integral.recommanded_teacher_num;
        NSString * teacher_integral = integral.teacher_integral;
        
        if (pay_points == nil) {
            pay_points = @"0";
        }
        if (teacher_integral == nil) {
            teacher_integral = @"0";
        }
        if (invite_code == nil) {
            invite_code = @"获取错误";
        }
        if (points_from_subscription == nil) {
            points_from_subscription = @"0";
        }
        if (points_from_affiliate == nil) {
            points_from_affiliate = @"0";
        }
        if (subscription_student_num == nil) {
            subscription_student_num = @"0";
        }
        if (recommanded_teacher_num == nil) {
            recommanded_teacher_num = @"0";
        }
        
        // 定位
        CGFloat pay_points_width = [pay_points sizeWithFont:[UIFont systemFontOfSize:15.0f] byHeight:15.0f].width;
        CGFloat teacher_integral_width = [teacher_integral sizeWithFont:[UIFont systemFontOfSize:15.0f] byHeight:40.0f].width;
        CGFloat invite_code_width = [invite_code sizeWithFont:[UIFont systemFontOfSize:15.0f] byHeight:40.0f].width;
        CGFloat subscription_points_width = [points_from_subscription sizeWithFont:[UIFont systemFontOfSize:13.0f] byHeight:33.0f].width;
        CGFloat affiliate_points_width = [points_from_affiliate sizeWithFont:[UIFont systemFontOfSize:13.0f] byHeight:33.0f].width;
        
        CGFloat pay_points_left = 0.85f * srceenWidth - pay_points_width;
        CGFloat teacher_integral_left = 0.85f * srceenWidth - teacher_integral_width;
        CGFloat invite_code_left = 0.85f * srceenWidth - invite_code_width;
        CGFloat subscription_points_left = 0.85f * srceenWidth - subscription_points_width;
        CGFloat affiliate_points_left = 0.85f * srceenWidth - affiliate_points_width;
        
        // 赋值
        $(@"#pay_points").TEXT(pay_points).CSS([NSString stringWithFormat:@"left:%fpx",pay_points_left]);
        $(@"#hui_points").TEXT(teacher_integral).CSS([NSString stringWithFormat:@"left:%fpx",teacher_integral_left]);
        $(@"#invite_code").TEXT(invite_code).CSS([NSString stringWithFormat:@"left:%fpx",invite_code_left]);
        $(@"#subscription_points").TEXT(points_from_subscription).CSS([NSString stringWithFormat:@"left:%fpx",subscription_points_left]);
        $(@"#affiliate_points").TEXT(points_from_affiliate).CSS([NSString stringWithFormat:@"left:%fpx",affiliate_points_left]);

    }
}

@end
