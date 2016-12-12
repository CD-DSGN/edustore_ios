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
    if (self.data)
    {
        NSString * result = self.data;
        $(@"#text").TEXT(result);
    }
}

@end
