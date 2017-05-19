//
//  E8_IntegralCell_iPhone.m
//  shop
//
//  Created by guangnian dashu on 16/9/19.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "E8_IntegralStudentCell_iPhone.h"
#import "model.h"

#define srceenWidth [[UIScreen mainScreen] bounds].size.width

@implementation E8_IntegralStudentCell_iPhone

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

+ (CGSize)estimateUISizeByWidth:(CGFloat)width forData:(id)data
{
    CGSize size = CGSizeMake(width, 70);
    return size;
}

- (void)dataDidChanged
{
    if ( self.data )
    {
        STUDENT_POINT * studentPoint = self.data;
        
        $(@"#student_num").TEXT(@"");
        $(@"#student_name").TEXT(studentPoint.student_name);
        $(@"#student_point").TEXT(studentPoint.student_points);
        
        // 此时avatar不为空，应为一个url路径。为空时为路径前缀
        if ([studentPoint.avatar rangeOfString:@".jpg"].location != NSNotFound)
        {
            $(@"#student_avatar").IMAGE(studentPoint.avatar);
        }
        else
        {
            $(@"#student_avatar").IMAGE([UIImage imageNamed:@"profile_no_avatar_icon.png"]);
        }


    }
}



@end
