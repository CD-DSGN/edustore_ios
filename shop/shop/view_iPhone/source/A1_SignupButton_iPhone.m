//
//  A1_SignupButton_iPhone.m
//  shop
//
//  Created by guangnian dashu on 16/8/17.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "A1_SignupButton_iPhone.h"

@implementation A1_SignupButton_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

- (void)dataDidChanged
{
    _button.title = self.data;
}

@end