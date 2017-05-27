//
//  I0_MomentsWriteCommentView.m
//  shop
//
//  Created by 田明飞 on 2017/5/26.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "I0_MomentsWriteCommentView.h"

@implementation I0_MomentsWriteCommentView

-(instancetype)init
{
    if ([super init]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5];
        
        _backView = [[UIView alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT , SCREEN_WIDTH - 60, SCREEN_HEIGHT * 0.3)];
        [self addSubview:_backView];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 2;
        
        _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 25, _backView.frame.size.width - 60, 20)];
        _placeholderLabel.textColor = [UIColor lightGrayColor];
        [_backView addSubview:_placeholderLabel];
        _placeholderLabel.font = [UIFont systemFontOfSize:14];
        
        _textView = [[UITextView alloc]init];
        _textView.frame = CGRectMake(30, 20, _backView.frame.size.width - 60, _backView.frame.size.height - 60);
        [_backView addSubview:_textView];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.layer.borderColor = [UIColor colorWithRed:250/255.0 green:104/255.0 blue:51/255.0 alpha:1].CGColor;
        _textView.layer.borderWidth = 0.5;
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.layer.cornerRadius = 5;
        _textView.delegate = self;
        
        _commitComentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitComentButton.frame = CGRectMake(_backView.frame.size.width - 60, _backView.frame.size.height - 5 - 30, 50, 30);
        [_commitComentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitComentButton setTitle:@"提交" forState:UIControlStateNormal];
        [_commitComentButton setBackgroundColor:[UIColor colorWithRed:250/255.0 green:104/255.0 blue:51/255.0 alpha:1]];
        _commitComentButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_backView addSubview:_commitComentButton];
        _commitComentButton.layer.cornerRadius = 3;
        [_commitComentButton addTarget:self action:@selector(commitComment:) forControlEvents:UIControlEventTouchUpInside];
        
        [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(changeFrame:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideTextView:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

-(void)changeFrame:(NSNotification*)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _backView.frame = CGRectMake(_backView.frame.origin.x, SCREEN_HEIGHT - height - _backView.frame.size.height - 100, _backView.frame.size.width, _backView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)hideTextView:(NSNotification*)notification
{
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _backView.frame = CGRectMake(30, SCREEN_HEIGHT , SCREEN_WIDTH - 60, SCREEN_HEIGHT * 0.3);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


-(void)commitComment:(UIButton*)button
{
    _commitCommentBlock();
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _placeholderLabel.hidden = NO;
    }else
    {
        _placeholderLabel.hidden = YES;
    }
}
@end
