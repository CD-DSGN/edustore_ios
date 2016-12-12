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

@implementation I0_MomentsCell_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

DEF_OUTLET( BeeUIScrollView, list )

// 评估UIsize
+ (CGSize)estimateUISizeByWidth:(CGFloat)width forData:(id)data
{
    // 通过查询的返回值来大致计算出高度（如何保证精确度？）
    // 暂时通过多留白的方式
    MOMENTS * moments = data;
    CGSize content_size = [moments.publish_info.news_content sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14.0] byWidth:260];      // 正文内容的size
    CGFloat head_height = 57;                                   // 头部高度+留白
    CGFloat photo_height = [self.class photoHeightByCount:moments.publish_info.photo_array.count];                     // 图片高度
    CGSize size = CGSizeMake(width, content_size.height + head_height + photo_height);
    return size;
}

+ (CGFloat)photoHeightByCount:(NSInteger)count
{
    CGFloat photo_height = 0;
    switch (count) {
        case 1:
        case 2:
        case 3:
            photo_height = 65;
            break;
        case 4:
        case 5:
        case 6:
            photo_height = 65 * 2;
            break;
        case 7:
        case 8:
        case 9:
            photo_height = 65 * 3;
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
        
        self.list.total = 2;
        
        // 汇师圈Cell第一栏：头部信息及正文内容
        BeeUIScrollItem * headerItem = self.list.items[0];
        headerItem.clazz = [I0_MomentsHeaderCell_iPhone class];
        headerItem.data = self.moments;
        headerItem.size = CGSizeAuto;
        headerItem.rule = BeeUIScrollLayoutRule_Tile;
        
        // 汇师圈Cell第二栏：图片信息
        BeeUIScrollItem * photoItem = self.list.items[1];
        photoItem.clazz = [I0_MomentsPhotoCell_iPhone class];
        photoItem.data = self.moments;
        photoItem.size = CGSizeAuto;
        photoItem.rule = BeeUIScrollLayoutRule_Tile;
        
        
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
