//
//  I0_MomentsCell_iPhone.m
//  shop
//
//  Created by guangnian dashu on 2016/11/8.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "I0_MomentsHeaderCell_iPhone.h"
#import "I0_MomentsBorad_iPhone.h"
@implementation I0_MomentsHeaderCell_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

- (void)load
{

}

- (void)unload
{
}

- (void)dataDidChanged
{
    if (self.data)
    {
        MOMENTS * moments = self.data;
        _publish_time = moments.publish_info.publish_time;
        _publish_uid = moments.publish_info.user_id;
        if ([[UserModel sharedInstance].user.id integerValue] == [moments.publish_info.user_id integerValue]) {
            self.deleteButton.hidden = NO;
        }else {
            self.deleteButton.hidden = YES;
        }
        
        NSString * time = [self timeDescription:moments.publish_info.publish_time];

        $(@"#user-name").TEXT(moments.teacher_info.real_name);
        $(@"#create-at").TEXT(time);
        $(@"#content").TEXT(moments.publish_info.news_content);
        
        // 此时avatar不为空，应为一个url路径。为空时为路径前缀
        if ([moments.teacher_info.avatar rangeOfString:@".jpeg"].location != NSNotFound)
        {
            $(@"#user-avatar").IMAGE(moments.teacher_info.avatar);
        }
        else
        {
            $(@"#user-avatar").IMAGE([UIImage imageNamed:@"profile_no_avatar_icon.png"]);
        }
        
//        if (moments.teacher_info.avatar != nil)
//        {
//            $(@"#user-avatar").IMAGE(moments.teacher_info.avatar);
//        }
//        else
//        {
//            $(@"#user-avatar").IMAGE([UIImage imageNamed:@"profile_no_avatar_icon.png"]);
//        }
    }
}
-(UIButton *)deleteButton
{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor colorWithRed:73/255.0 green:99/255.0 blue:144/255.0 alpha:1] forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _deleteButton.frame = CGRectMake(SCREEN_WIDTH - 45, 0, 40, 30);
        [self addSubview:_deleteButton];
        [_deleteButton addTarget:self action:@selector(deleteAlert) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}
-(void)deleteAlert
{
    UIAlertController * ac = [UIAlertController alertControllerWithTitle:@"是否确认删除？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [ac addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action){
        [self deleteThisMoment];
    }]];
    [ac addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        
    }]];
    [[self findViewController:self] presentViewController:ac animated:YES completion:nil];
    
}
- (UIViewController *)findViewController:(UIView *)sourceView
{
    id target=sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}
-(void)deleteThisMoment
{
    self.CANCEL_MSG( API.moments_delete );
    self.MSG( API.moments_delete )
    .INPUT( @"publish_time", _publish_time)
    .INPUT( @"publish_uid", _publish_uid);
    
    
}

ON_MESSAGE3(API, moments_delete, msg)
{
    I0_MomentsBorad_iPhone *vc = (I0_MomentsBorad_iPhone*)[self findViewController:self];
    if ( msg.sending )
    {
        
            [vc presentMessageTips:__TEXT(@"moments_delete")];
        
    }
    else
    {
        [vc dismissTips];
        
    }
    
    if ( msg.succeed )
    {
        STATUS * status = msg.GET_OUTPUT(@"status");
        
        if ( status && status.succeed.boolValue )
        {
            [vc.momentModel firstPage];
        }
        else
        {
            [vc showErrorTips:msg];
        }
    }
    else if ( msg.failed )
    {
        [vc showErrorTips:msg];
    }
}
// 所有比较均在GMT0下进行的
- (NSString *)timeDescription:(NSString *)publish_time
{
    NSTimeInterval publish_timeInterval = [publish_time doubleValue];
    NSDate * publish_date = [NSDate dateWithTimeIntervalSince1970:publish_timeInterval];
    
    // 获取当前的date
    NSDate * cur_date = [NSDate date];
    NSDateFormatter * formatter = [[[NSDateFormatter alloc] init] autorelease];
    
    // 通过日历类判断教师发送的时间与现在时间的差值
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    if ([calendar isDateInToday:publish_date])
    {
        int delta = (int)[cur_date timeIntervalSinceDate:publish_date];
        if (delta < 60)
        {
            return @"刚刚";
        }
        else if (delta < 3600)
        {
            return [NSString stringWithFormat:@"%d分钟前",(delta/60)];
        }
            return [NSString stringWithFormat:@"%d小时前",(delta/3600)];
    }
    
    if ([calendar isDateInYesterday:publish_date])
    {
        [formatter setDateFormat:@"昨天 HH:mm"];
        return [formatter stringFromDate:publish_date];
    }
    
    NSDateComponents * coms = [calendar components:NSCalendarUnitYear fromDate:cur_date toDate:publish_date options:0];
    if (coms.year == 0)
    {
        [formatter setDateFormat:@"MM-dd HH:mm"];
        return [formatter stringFromDate:publish_date];
    }

    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [formatter stringFromDate:publish_date];
}

@end
