//
//  K0_NewsCell.m
//  shop
//
//  Created by 田明飞 on 2017/5/4.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "K0_NewsCell.h"
#import "ecmobile.h"
@implementation K0_NewsCell

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

+ (CGSize)estimateUISizeByWidth:(CGFloat)width forData:(id)data
{
    // 通过查询的返回值来大致计算出高度（如何保证精确度？）
    // 暂时通过多留白的方式
    NEWS_DETAIL * news = data;
    CGSize content_size = [news.sketch sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14.0] byWidth:SCREEN_WIDTH - 75.0f];      // 正文内容的size
    CGFloat head_height = 40.0f;             // 头部高度+留白
    //CGSize size = CGSizeMake(width, content_size.height + head_height + 10 );
    CGSize size = CGSizeMake(width, [UIScreen mainScreen].bounds.size.width * 0.30 + 10);
    return size;
}

- (void)load
{
    self.tappable = YES;
    self.tapSignal = self.TAPPED;
}

- (void)unload
{
    
}

- (void)dataDidChanged
{
    if (self.data) {
        NEWS_DETAIL * news = self.data;
        
            $(@"#news-name").TEXT(news.title);
            $(@"#create-at").TEXT(news.updated_at);
            $(@"#content").TEXT(news.sketch);
            $(@"#news-type").TEXT(news.label_name);
            // 此时avatar不为空，应为一个url路径。为空时为路径前缀
            if ([news.banner.banner_url rangeOfString:@".jpg"].location != NSNotFound)
            {
                $(@"#news-image").IMAGE(news.banner.banner_url);
            }
            else
            {
                $(@"#news-image").IMAGE([UIImage imageNamed:@"profile_no_avatar_icon.png"]);
            }
        
        }
    
}

@end
