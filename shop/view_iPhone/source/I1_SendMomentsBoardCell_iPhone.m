//
//  I1_SendMomentsBoardCell_iPhone.m
//  shop
//
//  Created by 田明飞 on 2017/1/16.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "I1_SendMomentsBoardCell_iPhone.h"

@implementation I1_SendMomentsBoardCell_iPhone

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        _photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_photoImageView];
        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _photoImageView.layer.masksToBounds = YES;
        _photoImageView.userInteractionEnabled = YES;
    }
    return self;
}

@end
