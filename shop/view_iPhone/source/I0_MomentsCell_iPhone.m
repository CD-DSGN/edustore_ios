//
//  I0_MomentsPhotoCell_iPhone.m
//  shop
//
//  Created by guangnian dashu on 2016/11/23.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "I0_MomentsCell_iPhone.h"
#import "I0_MomentsHeaderCell_iPhone.h"
#import "I0_MomentsCommentsCell_iPhone.h"
#import "I0_MomentsPhotoCell_iPhone.h"
#import "I0_MomentsWriteCommentCell_iPhone.h"

@implementation I0_MomentsCell_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

DEF_OUTLET( BeeUIScrollView, list )

// 评估UIsize
+ (CGSize)estimateUISizeByWidth:(CGFloat)width forData:(id)data
{
    // 通过查询的返回值来大致计算出高度
    MOMENTS * moments = data;
    CGSize content_size = [moments.publish_info.news_content sizeWithFont:[UIFont fontWithName:@"Helvetica" size:16.0] byWidth:SCREEN_WIDTH - 75.0f];      // 正文内容的size
    CGFloat head_height = 40.0f;             // 头部高度+留白
    CGFloat photo_height = [self.class photoHeightByCount:moments.publish_info.photo_array.count];                     // 图片高度
    CGFloat commentHeight = 20;  // 评论留白 + 放评论按钮那个框框高度
    // 计算评论栏的高度
    NSArray * commentArray = moments.publish_info.comment_array;
    commentHeight += 5 * commentArray.count;        // 每两个评论之间的gap
    for (int i = 0; i < commentArray.count; i++) {
        
        NSDictionary * commentInfo = commentArray[i];
        NSString * target_username = commentInfo[@"show_target_name"];
        NSString * show_name = commentInfo[@"show_name"];
        NSString * comment_content = commentInfo[@"comment_content"];
        NSString * content;
        if ([target_username isEqualToString:@""] || target_username == nil) {
            content = [NSString stringWithFormat:@"%@：%@",show_name, comment_content];
        } else {
            content = [NSString stringWithFormat:@"%@回复%@：%@",show_name, target_username,comment_content];
        }
        // 每一个评论内容的高度
        CGFloat singleCommentHeight = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH * 0.8f, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        commentHeight += singleCommentHeight;
    }
    commentHeight +=10;
    if (moments.publish_info.photo_array.count == 0) {
        CGSize size = CGSizeMake(width, content_size.height + head_height + photo_height  + commentHeight - 5);
        return  size;
    }
    else if(moments.publish_info.photo_array.count == 1){
        CGSize size = CGSizeMake(width, content_size.height + head_height + (SCREEN_WIDTH - 50 - 20 * 3)/3.0 * 2 + 20  + commentHeight -5);
        return  size;
    }
    else{

        CGSize size = CGSizeMake(width, content_size.height + head_height + photo_height + commentHeight -5 );

        return size;
    }
    
}

+ (CGFloat)photoHeightByCount:(NSInteger)count
{
    CGFloat photo_height = 10;
    switch (count) {
        case 1:
        case 2:
        case 3:
            photo_height = photo_height + (SCREEN_WIDTH - 50 - 20 * 3)/3.0 ;
            break;
        case 4:
        case 5:
        case 6:
            photo_height = photo_height + (SCREEN_WIDTH - 50 - 20 * 3)/3.0 * 2 + 20;
            break;
        case 7:
        case 8:
        case 9:
            photo_height = photo_height + (SCREEN_WIDTH - 50 - 20 * 3)/3.0 * 3 + 30;
            break;
        default:
            break;
    }
    return photo_height;
}

- (void)layoutDidFinish
{
    if ( self.data )
    {
        self.moments = self.data;
        
        [self.list reloadData];
    }
}

- (void)load
{
    @weakify(self);
    
    self.list.scrollEnabled = NO;
    
    self.list.lineCount = 1;
    self.list.animationDuration = 0.25f;
    
    self.list.whenReloading = ^
    {
        @normalize(self);
        
        NSInteger commentCount = self.moments.publish_info.comment_array.count;
        NSInteger photoCount = self.moments.publish_info.photo_array.count;
        photoCount = photoCount >= 1 ? 1 : 0;
        
        self.list.total = 2 + photoCount + commentCount;
        NSInteger i = 0;    // cell 的索引
        
        // 汇师圈Cell第一栏：头部信息及正文内容
        BeeUIScrollItem * headerItem = self.list.items[i];
        headerItem.clazz = [I0_MomentsHeaderCell_iPhone class];
        headerItem.data = self.moments;
        headerItem.size = CGSizeAuto;
        headerItem.rule = BeeUIScrollLayoutRule_Tile;
        i++;
        
        // 汇师圈Cell第二栏：图片信息
        if (photoCount > 0) {
            BeeUIScrollItem * photoItem = self.list.items[i];
            photoItem.clazz = [I0_MomentsPhotoCell_iPhone class];
            photoItem.data = self.moments;
            photoItem.size = CGSizeAuto;
            photoItem.rule = BeeUIScrollLayoutRule_Tile;
            i++;
        }
        
        // 汇师圈Cell第三栏，学生写评论的按钮
        BeeUIScrollItem * writeCommentItem = self.list.items[i];
        writeCommentItem.clazz = [I0_MomentsWriteCommentCell_iPhone class];
        writeCommentItem.size = CGSizeMake(SCREEN_WIDTH, 20);
        writeCommentItem.rule = BeeUIScrollLayoutRule_Tile;
        writeCommentItem.data = self.moments;
        i++;
        
        // 汇师圈Cell第四栏：评论信息
        NSInteger commentIndex = 0;
        NSArray * commentArray = self.moments.publish_info.comment_array;
        for (NSInteger j = i; j < self.list.total; j++) {
        
            // 传递评论详细信息
            NSDictionary * commentInfo = commentArray[commentIndex];
            commentIndex++;
            
            BeeUIScrollItem * commentItem = self.list.items[j];
            commentItem.clazz = [I0_MomentsCommentsCell_iPhone class];
            commentItem.data = commentInfo;
            commentItem.size = CGSizeAuto;
            commentItem.rule = BeeUIScrollLayoutRule_Tile;
            i++;
        }
    };
}

- (void)unload
{
}

- (void)dataDidChanged
{
    // 一样的，此时frame为0
    
}



@end
