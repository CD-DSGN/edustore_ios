//
//  I1_SendMomentsBoard_iPhone.h
//  shop
//
//  Created by guangnian dashu on 2016/11/8.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "Bee.h"
#import "BaseBoard_iPhone.h"

@interface I1_SendMomentsBoard_iPhone : BaseBoard_iPhone<UITextViewDelegate>

@property (nonatomic, retain) UIScrollView * scrollView;
@property (nonatomic, retain) UITextView * textViewSendContent;
@property (nonatomic, retain) UILabel * textViewPlaceholder;

@end
