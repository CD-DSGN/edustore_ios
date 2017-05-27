//
//  I0_MomentsWriteCommentView.h
//  shop
//
//  Created by 田明飞 on 2017/5/26.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CommitCommentBlock)() ;

@interface I0_MomentsWriteCommentView : UIView

@property (nonatomic,strong) UITextView *textView;

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIButton *commitComentButton;

@property (nonatomic, copy) CommitCommentBlock commitCommentBlock;

@end


