//
//  I1_SendMomentsBoard_iPhone.m
//  shop
//
//  Created by guangnian dashu on 2016/11/8.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "I1_SendMomentsBoard_iPhone.h"

@implementation I1_SendMomentsBoard_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

- (void)load
{
    self.textViewSendContent = [[UITextView alloc] init];
    self.textViewPlaceholder = [[UILabel alloc] init];
    self.scrollView = [[UIScrollView alloc] init];
}

- (void)unload
{
    self.textViewSendContent = nil;
    self.textViewPlaceholder = nil;
    self.scrollView = nil;
}

#pragma mark -

ON_CREATE_VIEWS( signal )
{
    self.scrollView.frame = CGRectMake(0, 70, SCREEN_WIDTH, SCREEN_HEIGHT-70);
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-68);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
    self.textViewSendContent.textColor = [UIColor blackColor];
    self.textViewSendContent.font = [UIFont fontWithName:@"Arial" size:18];
    self.textViewSendContent.returnKeyType = UIReturnKeyDefault;
    self.textViewSendContent.keyboardType = UIKeyboardTypeDefault;
    self.textViewSendContent.scrollEnabled = YES;
    self.textViewSendContent.delegate = self;
//    self.textViewSendContent.showsVerticalScrollIndicator = NO;
    self.textViewSendContent.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-70);
    
    self.textViewPlaceholder.frame = CGRectMake(5, 0, SCREEN_WIDTH, 40);
    self.textViewPlaceholder.text = __TEXT(@"moments_send");
    self.textViewPlaceholder.textColor = [UIColor grayColor];
    self.textViewPlaceholder.font = [UIFont fontWithName:@"Arial" size:18];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.textViewSendContent];
    [self.scrollView addSubview:self.textViewPlaceholder];
    
//    UIPinchGestureRecognizer * recognizer = [[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)] autorelease];
//    [self.textViewSendContent addGestureRecognizer:recognizer];
}

ON_DELETE_VIEWS( signal )
{
    
}

ON_LAYOUT_VIEWS( signal )
{
}

ON_WILL_APPEAR( signal )
{
    
}

ON_DID_APPEAR( signal )
{
}

ON_WILL_DISAPPEAR( signal )
{
}

ON_DID_DISAPPEAR( signal )
{
}


ON_SIGNAL3( I1_SendMomentsBoard_iPhone, back, signal )
{
    UIAlertController * ac = [UIAlertController alertControllerWithTitle:@"是否退出编辑？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [ac addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [ac addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        
    }]];
    
    [self presentViewController:ac animated:NO completion:nil];
}

ON_SIGNAL3( I1_SendMomentsBoard_iPhone, send, signal )
{
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    long long time = [[NSNumber numberWithDouble:now] longLongValue];
    NSString * curTime = [NSString stringWithFormat:@"%llu", time];

    NSString * content = [[NSString stringWithString:self.textViewSendContent.text] trim];
    
    if (content.length == 0)
    {
        [self presentFailureTips:__TEXT(@"moments_null")];
    }
    else
    {
        self.CANCEL_MSG( API.teacher_publish );
        self.MSG( API.teacher_publish )
        .INPUT( @"time", curTime)
        .INPUT( @"content", content);
    }
}

#pragma mark - function
    
- (void)adjustTextView:(UITextView *)textView
{
    // 获取的是距textView头部的距离，我需要的是减去滑动之后的距离
    CGFloat currentPosition;
    if (textView.selectedTextRange)
    {
        currentPosition = [textView caretRectForPosition:textView.selectedTextRange.start].origin.y;
    }
    else
    {
        currentPosition = 0;
    }
    // 多预留一些空间，以应对字体改变
    if (currentPosition > 200)
    {
        CGRect temp = CGRectMake(0, currentPosition, SCREEN_WIDTH, 60);
        CGRect textViewFrame = [self.scrollView convertRect:temp fromView:textView];
        
//        [self.scrollView scrollRectToVisible:textViewFrame animated:YES];
        [self.textViewSendContent scrollRectToVisible:textViewFrame animated:YES];
    }
}

//- (void)handlePan:(UIPanGestureRecognizer *)recognizer
//{
//    [self.textViewSendContent resignFirstResponder];
//}

#pragma mark - UITextView delegate
    
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    return YES;
}
    
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView)
    {
        [self.textViewSendContent resignFirstResponder];
    }
}
    
- (void)textViewDidChange:(UITextView *)textView
{
    NSString * content = [NSString stringWithString:self.textViewSendContent.text];
    
    if ([content isEqualToString:@""])
    {
//        [self.scrollView addSubview:self.textViewPlaceholder];
        self.textViewPlaceholder.text = __TEXT(@"moments_send");
        
    }
    else
    {
//        [self.textViewPlaceholder removeFromSuperview];
        self.textViewPlaceholder.text = @"";
    }
    
//    CGSize size = [content sizeWithFont:[self.textViewPlaceholder font] byWidth:320];
//    NSInteger lineNumber = (NSInteger)(size.height / [self.textViewPlaceholder font].lineHeight);
}
    
// 用户选中时对frame进行调整
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.textViewSendContent.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.5f); // 减去键盘高度
    // [self performSelector:@selector(adjustTextView:) withObject:textView afterDelay:0.5f];
}
    
- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.textViewSendContent.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-70);
}

#pragma mark - 教师发送汇师圈消息
ON_MESSAGE3( API, teacher_publish, msg )
{
    if ( msg.sending )
    {
        [self.textViewSendContent resignFirstResponder];
        [self presentMessageTips:__TEXT(@"moments_sending")];
    }
    else
    {
        [self dismissTips];
    }
    if ( msg.succeed )
    {
        NSString * data = msg.GET_OUTPUT(@"data");
        if ([data isEqualToString:@"1"])
        {
            [self presentSuccessTips:__TEXT(@"moments_success")];
            [self performSelector:@selector(dismissViewController) withObject:self afterDelay:1.0f];
        }
        else
        {
            [self presentFailureTips:__TEXT(@"moments_error")];
        }
    }
    if ( msg.failed )
    {
        [self presentFailureTips:__TEXT(@"moments_error")];
    }
}

- (void)dismissViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
