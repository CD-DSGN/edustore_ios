//
//  E8_IntegralCell_iPhone.m
//  shop
//
//  Created by guangnian dashu on 16/9/19.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "E8_IntegralCell_iPhone.h"
#import "model.h"

@implementation E8_IntegralCell_iPhone

DEF_OUTLET( BeeUITextField, label )
DEF_OUTLET( BeeUITextField, label2 )

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
        //self.label2.active = YES;
        //self.label2.maxLength = 70;
        NSString * temp = @"您的积分为：";
        temp = [temp stringByAppendingString:self.data];
        self.label.data = temp;
        // self.label2.data = @"label2 的积分内容显示 label2 的积分内容显示label2 的积分内容显示label2 的积分内容显示label2 的积分内容显示";
    }
}

@end
