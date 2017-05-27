//
//  I0_MomentsWriteCommentCell_iPhone.m
//  shop
//
//  Created by guangnian dashu on 2017/5/26.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "I0_MomentsWriteCommentCell_iPhone.h"

@implementation I0_MomentsWriteCommentCell_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

DEF_OUTLET( BeeUIButton, comment )

- (void)load
{
    
}

- (void)unload
{
    
}

- (void)dataDidChanged
{
    if (self.data) {
        
        MOMENTS * moments = self.data;
        self.comment.tag = moments.publish_info.news_id.integerValue;
    }
}

@end