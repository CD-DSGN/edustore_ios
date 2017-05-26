//
//  I0_MomentsCommentsCell_iPhone.m
//  shop
//
//  Created by guangnian dashu on 2016/11/23.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "I0_MomentsCommentsCell_iPhone.h"

@implementation I0_MomentsCommentsCell_iPhone

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
        
        NSDictionary * commentInfo = self.data;
        $(@"#username").TEXT([NSString stringWithFormat:@"%@:",commentInfo[@"show_name"]]);
        $(@"#commentContent").TEXT(commentInfo[@"comment_content"]);
    }
}

@end
