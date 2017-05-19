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

+ (CGSize)estimateUISizeByWidth:(CGFloat)width forData:(id)data
{
    CGSize size = CGSizeMake(width, 50);
    return size;
}

- (void)dataDidChanged
{
    if ( self.data )
    {
        TEACHER_CLASS * teacherClass = self.data;
        NSString *name = [NSString stringWithFormat:@"%@%@%@班", teacherClass.school_name, teacherClass.grade, teacherClass.class_no];
        
        $(@"#class_name").TEXT(name);


    }
}



@end
