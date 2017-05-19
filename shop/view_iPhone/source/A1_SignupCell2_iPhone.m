//
//  A1_SignupCell2_iPhone.m
//  shop
//
//  Created by guangnian dashu on 2017/5/19.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "A1_SignupCell2_iPhone.h"
#import "model.h"

@implementation A1_SignupCell2_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

DEF_OUTLET( BeeUITextField, studentClass )
DEF_OUTLET( BeeUILabel, school )
DEF_OUTLET( BeeUILabel, region )
DEF_OUTLET( BeeUILabel, grade )

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
        
    }
}

@end
