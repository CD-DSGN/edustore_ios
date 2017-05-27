//
//  I0_MomentsCommentsCell_iPhone.m
//  shop
//
//  Created by guangnian dashu on 2016/11/23.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "I0_MomentsCommentsCell_iPhone.h"

@interface I0_MomentsCommentsCell_iPhone ()
@end

@implementation I0_MomentsCommentsCell_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

DEF_OUTLET( BeeUILable, username )

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
        NSString * target_username = commentInfo[@"target_username"];
        NSString * show_name = commentInfo[@"show_name"];
        NSString * content = commentInfo[@"comment_content"];
        // 通过range改颜色
        NSMutableAttributedString * comment;
        NSRange showNameRange = NSMakeRange(0, show_name.length);
        NSRange targetNameRange = NSMakeRange(show_name.length+2, target_username.length);
        
        if ([target_username isEqualToString:@""]) {
            
            comment = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@：%@",show_name, content]];
            [comment addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:73.f/255 green:99.f/255 blue:144.f/255 alpha:1] range:showNameRange];
        } else {
            
            comment = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@回复%@：%@",show_name, target_username,content]];
            [comment addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:73.f/255 green:99.f/255 blue:144.f/255 alpha:1] range:showNameRange];
            [comment addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:73.f/255 green:99.f/255 blue:144.f/255 alpha:1] range:targetNameRange];
        }
        
        self.username.attributedText = comment;
    }
}

@end
