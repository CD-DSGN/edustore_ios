//
//  I0_MomentsBorad_iPhone.m
//  shop
//
//  Created by guangnian dashu on 2016/11/7.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "AppBoard_iPhone.h"
#import "BaseBoard_iPhone.h"
#import "ECMobileManager.h"

#import "I0_MomentsBorad_iPhone.h"
#import "I0_MomentsCommentsCell_iPhone.h"
#import "I1_SendMomentsBoard_iPhone.h"
#import "I0_MomentsCell_iPhone.h"
#import "I0_MomentsNoResultCell_iPhone.h"
#import "I0_MomentsHeaderCell_iPhone.h"
#import "I0_MomentsPhotoCell_iPhone.h"
#import "I0_MomentsWriteCommentCell_iPhone.h"
#import "I2_MomentsPhotoBoard_iPhone.h"

#import "CommonNoResultCell.h"
#import "CommonPullLoader.h"
#import "CommonFootLoader.h"
#import "I0_MomentsWriteCommentView.h"

@interface I0_MomentsBorad_iPhone () <MomentsSendDelegate>

@property (nonatomic, retain) NSMutableArray * sendMomentsDraftArray;

@end

@implementation I0_MomentsBorad_iPhone

DEF_SINGLETON( MomentsBoard )

SUPPORT_RESOURCE_LOADING( YES )
SUPPORT_AUTOMATIC_LAYOUT( YES )

DEF_MODEL( MomentModel, momentModel )
DEF_MODEL( UserModel, userModel )

DEF_OUTLET( BeeUIScrollView, list )

- (void)load
{
    self.momentModel = [MomentModel modelWithObserver:self];
    self.userModel = [UserModel modelWithObserver:self];
    
    self.sendMomentsDraftArray = [NSMutableArray array];
}

- (void)unload
{
    SAFE_RELEASE_MODEL( self.momentModel );
    SAFE_RELEASE_MODEL( self.userModel );
    
    self.sendMomentsDraftArray = nil;
}

#pragma mark -

ON_CREATE_VIEWS( signal )
{
    self.navigationBarTitle = __TEXT(@"Moments");
    [self showNavigationBarAnimated:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideTextView:) name:UIKeyboardWillHideNotification object:nil];
    
    @weakify(self);

    self.list.headerClass = [CommonPullLoader class];
    self.list.headerShown = YES;
    
    self.list.footerClass = [CommonFootLoader class];
//    self.list.footerShown = YES;
    
    self.list.lineCount = 1;
    self.list.animationDuration = 0.25f;
    
    self.list.whenReloading = ^
    {
        @normalize(self);
        
        /**汇师圈为空的情况：
         * 1.用户未登录状态；
         * 2.学生已登录，返回数据为空（学生未关注教师/教师未发送任何消息）
         * 3.教师已登录，未发布任何消息
         **/
        
        self.list.total = self.momentModel.moments.count;
        
        if ( [UserModel online] == NO )  // 未登录状态
        {
            self.list.total = 1;
            BeeUIScrollItem * item = self.list.items[0];
            item.clazz = [I0_MomentsNoResultCell_iPhone class];
            item.size = self.list.size;
            item.rule = BeeUIScrollLayoutRule_Tile;
            item.data = @0;
            
            [self handleEmpty:NO];
            [self handleLogined:YES];
        }
        else    // 已登录
        {
            [self handleLogined:YES];
            
            // 返回数据为空
            if ( self.momentModel.loaded && self.momentModel.moments.count == 0)
            {
                if ([self.userModel.user.is_teacher isEqual:@1])
                {
                    // 教师用户，还未发布任何消息
                    self.list.total = 1;
                    BeeUIScrollItem * item = self.list.items[0];
                    item.clazz = [I0_MomentsNoResultCell_iPhone class];
                    item.size = self.list.size;
                    item.rule = BeeUIScrollLayoutRule_Tile;
                    item.data = @1;
                }
                else
                {
                    if ([self.no_follow isEqualToString:@"1"])
                    {
                        // 学生用户，未关注过教师
                        self.list.total = 1;
                        BeeUIScrollItem * item = self.list.items[0];
                        item.clazz = [I0_MomentsNoResultCell_iPhone class];
                        item.size = self.list.size;
                        item.rule = BeeUIScrollLayoutRule_Tile;
                        item.data = @2;
                    }
                    else
                    {
                        // 学生用户，所关注教师没有发送过消息
                        self.list.total = 1;
                        BeeUIScrollItem * item = self.list.items[0];
                        item.clazz = [I0_MomentsNoResultCell_iPhone class];
                        item.size = self.list.size;
                        item.rule = BeeUIScrollLayoutRule_Tile;
                        item.data = @3;
                    }
                }
                [self handleEmpty:YES];
            }
            // 有返回数据：学生所关注的教师有发送消息，教师有发送消息
            else
            {
                [self handleEmpty:NO];
                
                for( int i = 0; i < self.momentModel.moments.count; i++ )
                {
                    BeeUIScrollItem * item = self.list.items[i];
                    item.clazz = [I0_MomentsCell_iPhone class];
                    item.data = [self.momentModel.moments safeObjectAtIndex:i];
                    item.size = CGSizeAuto;
                    item.rule = BeeUIScrollLayoutRule_Tile;
                }
            }
        }
        
        [self observeNotification:UserModel.LOGIN];
    };
    self.list.whenHeaderRefresh = ^
    {
        @normalize(self);
        
        [self.momentModel firstPage];
    };
    self.list.whenFooterRefresh = ^
    {
        @normalize(self);
        
        [self.momentModel nextPage];
    };
    self.list.whenReachBottom = ^
    {
        @normalize(self);
        
        [self.momentModel nextPage];
    };

}

ON_DELETE_VIEWS( signal )
{
    self.list = nil;
    
    [self unobserveAllNotifications];
}

ON_LAYOUT_VIEWS( signal )
{
}

ON_WILL_APPEAR( signal )
{
    [bee.ui.appBoard showTabbar];
    
    [self.list reloadData];
    
    // 通过一个字段表示是否存在未发送成功的字段
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.momentModel firstPage];
}

ON_DID_APPEAR( signal )
{
    // 发送按钮
    if ([self.userModel.user.is_teacher isEqual:@1])
    {
        [self showBarButton:BeeUINavigationBar.RIGHT
                      title:@"发送"
                      image:[UIImage imageNamed:@"nav_right.png"]];
    }
    else
    {
        [self setNavigationBarRight:nil];
    }
}

ON_WILL_DISAPPEAR( signal )
{
    
}

ON_DID_DISAPPEAR( signal )
{
}

#pragma mark -

ON_LEFT_BUTTON_TOUCHED( signal )
{
}

ON_RIGHT_BUTTON_TOUCHED( signal )
{
    // 教师发送消息页面
    I1_SendMomentsBoard_iPhone * board = [[[I1_SendMomentsBoard_iPhone alloc] init] autorelease];
    board.delegate = self;
    board.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [[AppBoard_iPhone sharedInstance] presentViewController:board animated:YES completion:nil];
//    [self presentViewController:board animated:YES completion:nil];
}

#pragma mark - custom function

- (void)handleLogined:(BOOL)logined
{
    self.list.headerShown = logined;
    [self.list setScrollEnabled:logined];
}

- (void)handleEmpty:(BOOL)isEmpty
{
    if ( isEmpty )
    {
        $(self.list.headerLoader).FIND(@"#background").HIDE();
    }
    else
    {
        $(self.list.headerLoader).FIND(@"#background").SHOW();
    }
}

- (void)deleteMomentsCache
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * momentsCacheArray = [NSArray arrayWithArray:[defaults objectForKey:@"momentsCache"]];
    [defaults removeObjectForKey:@"momentsCache"];
    
    // 将本地数据源中未发送成功的数据删除
    for (int i = 0; i < momentsCacheArray.count; i++) {
        
        // 插入往前插的，删除也是从前删的
        [self.momentModel.moments removeObjectAtIndex:i];
    }
    [self.list reloadData];
}

- (void)reSendMomentByCache
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * momentsArray = [NSArray arrayWithArray:[defaults objectForKey:@"momentsCache"]];
    // 有数据时才重新发送
    if (momentsArray != nil || momentsArray.count != 0) {
        
        for (int i = 0; i < momentsArray.count; i++) {
            
            NSDictionary * momentDict = [momentsArray objectAtIndex:i];
            NSString * curTime = [momentDict objectForKey:@"curTime"];
            NSString * content = [momentDict objectForKey:@"content"];
            NSArray * photoArray = [NSArray arrayWithArray:[momentDict objectForKey:@"photoArray"]];
            
            // 通过网络接口重新发送汇师圈
            self.CANCEL_MSG( API.teacher_publish );
            self.MSG( API.teacher_publish )
            .INPUT( @"time", curTime)
            .INPUT( @"content", content)
            .INPUT( @"publish_images", photoArray);
        }
    }
}

#pragma mark - momentsSendDelegate
- (void)MomentDidSendWithContent:(NSString *)content andCurTime:(NSString *)curTime andPhotoArray:(NSArray *)photoArray AndBase64PhotoArray:(NSArray *)base64PhotoArray
{
    // 教师信息
    MOMENTS_TEACHER * teacherInfo = [[MOMENTS_TEACHER alloc] init];
    teacherInfo.real_name = self.userModel.user.teacher_name;
    teacherInfo.course_name = self.userModel.user.course_name;
    teacherInfo.avatar = self.userModel.user.avatar;
    // 发布内容信息
    MOMENTS_PUBLISH * publishInfo = [[MOMENTS_PUBLISH alloc] init];
    publishInfo.user_id = [NSString stringWithFormat:@"%@",self.userModel.user.id];
    publishInfo.publish_time = curTime;
    publishInfo.news_content = content;
    // 处理传递的图片数组，转为一个字典数组
    NSMutableArray * mutablePhotoArray = [NSMutableArray array];
    for (int i = 0; i < photoArray.count; i++) {
        
        NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:photoArray[i], @"img", photoArray[i], @"img_thumb", nil];
        [mutablePhotoArray addObject:dict];
    }
    publishInfo.photo_array = [NSArray arrayWithArray:mutablePhotoArray];
    publishInfo.news_id = @0;
    publishInfo.comment_array = nil;
    // 复合起来，重新加载数据
    MOMENTS * newMoments = [[MOMENTS alloc] init];
    newMoments.teacher_info = teacherInfo;
    newMoments.publish_info = publishInfo;
    
    [self.momentModel.moments insertObject:newMoments atIndex:0];
    [self.list reloadData];
    [self.list setContentOffset:CGPointMake(0, 0) animated:YES];
    
    // 将用户需要发送的信息存在本地
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * momentsCacheArray = [NSMutableArray array];
    [momentsCacheArray addObjectsFromArray:[defaults objectForKey:@"momentsCache"]];
    NSDictionary * momentInfo = [[NSDictionary alloc] initWithObjectsAndKeys:content, @"content", curTime, @"curTime", base64PhotoArray, @"photoArray", nil];
    [momentsCacheArray addObject:momentInfo];
    [defaults setObject:momentsCacheArray forKey:@"momentsCache"];
    
    // 通过网络接口发送汇师圈
    self.CANCEL_MSG( API.teacher_publish );
    self.MSG( API.teacher_publish )
    .INPUT( @"time", curTime)
    .INPUT( @"content", content)
    .INPUT( @"publish_images", base64PhotoArray);

}

#pragma mark -
ON_SIGNAL3(I0_MomentsNoResultCell_iPhone, signInButton, signal)
{
//    NSLog(@"hahah");
    [bee.ui.appBoard showLogin];
}

// 点击评论，对汇师圈的评论事件
ON_SIGNAL3(I0_MomentsWriteCommentCell_iPhone, comment, signal)
{
    BeeUIButton * commentLabel = signal.source;
    NSLog(@"tag:%ld", (long)commentLabel.tag);
    if (commentLabel.tag == 0) {
        
        return;
    } else {
        
        self.commentView.hidden = NO;
        [self.commentView setCommitCommentBlock:^(){
            self.CANCEL_MSG( API.moments_comment );
            self.MSG( API.moments_comment )
            .INPUT( @"news_id", @(commentLabel.tag))
            .INPUT( @"comment_content", self.commentView.textView.text)
            .INPUT( @"target_comment_id", @"");
        }];
    }
}

// 点击评论，对评论进行回复
ON_SIGNAL3( I0_MomentsCommentsCell_iPhone, comment_cell, signal )
{
    NSDictionary * commentInfo = signal.sourceCell.data;
    NSNumber * news_id = commentInfo[@"news_id"];
    NSNumber * target_comment_id = commentInfo[@"comment_id"];
    NSLog(@"news_id:%@,target_comment_id:%@",news_id,target_comment_id);
    self.commentView.hidden = NO;
    self.commentView.placeholderLabel.text = [NSString stringWithFormat:@"回复%@: ", commentInfo[@"show_name"]];
    [self.commentView setCommitCommentBlock:^(){
        self.CANCEL_MSG( API.moments_comment );
        self.MSG( API.moments_comment )
        .INPUT( @"news_id", news_id)
        .INPUT( @"comment_content", self.commentView.textView.text)
        .INPUT( @"target_comment_id", target_comment_id);
    }];
}

#pragma mark - network result

ON_MESSAGE3(API, user_signin, msg) {
    if (msg.succeed) {
        if ([self.userModel.user.is_teacher isEqual:@1])
        {
            [self showBarButton:BeeUINavigationBar.RIGHT
                          title:@"发送"
                          image:[UIImage imageNamed:@"nav_right.png"]];
        }
        else
        {
            [self setNavigationBarRight:nil];
        }
    }
}

ON_MESSAGE3(API, moments_comment, msg)
{
    if ( msg.sending )
    {
        if ( NO == self.momentModel.loaded )
        {
            //			[self presentLoadingTips:__TEXT(@"tips_loading")];
            [self presentMessageTips:__TEXT(@"moments_loading")];
        }
        
        if ( self.momentModel.moments.count )
        {
            [self.list setFooterLoading:YES];
        }
        else
        {
            [self.list setFooterLoading:NO];
        }
    }
    else
    {
        [self dismissTips];
        
        [self.list setHeaderLoading:NO];
        [self.list setFooterLoading:NO];
    }
    
    if ( msg.succeed )
    {
        STATUS * status = msg.GET_OUTPUT(@"status");
        
        if ( status && status.succeed.boolValue )
        {
            [self presentSuccessTips:@"评论成功"];
            
            [self.commentView.textView resignFirstResponder];
            // 标注nhj：这个地方之后就改成只修改数据源，不请求网络接口了吧
//            NSNumber * news_id = msg.GET_INPUT(@"news_id");
//            NSMutableArray * momentsArray = self.momentModel.moments;
//            for (int i = 0; i < momentsArray.count; i++) {
//                
//                MOMENTS * moments = [momentsArray objectAtIndex:i];
//                MOMENTS_PUBLISH * publish_info = moments.publish_info;
//                NSNumber * newsId = publish_info.news_id;
//                
//                // 取到了数据源的news_id
//                if (newsId != nil && ![newsId isEqual:@0]) {
//                    
//                    NSMutableArray * commentArray = [NSMutableArray arrayWithArray:publish_info.comment_array];
//                    
//                }
//            }
            [self.list reloadData];
        }
        else
        {
            [self showErrorTips:msg];
        }
    }
    else if ( msg.failed )
    {
        [self showErrorTips:msg];
    }
}

ON_MESSAGE3( API, moments_list, msg )
{
    if ( msg.sending )
    {
        if ( NO == self.momentModel.loaded )
        {
//            			[self presentLoadingTips:__TEXT(@"tips_loading")];
            [self presentMessageTips:__TEXT(@"moments_loading")];
        }
        
        if ( self.momentModel.moments.count )
        {
            [self.list setFooterLoading:YES];
        }
        else
        {
            [self.list setFooterLoading:NO];
        }
    }
    else
    {
        [self dismissTips];
        
        [self.list setHeaderLoading:NO];
        [self.list setFooterLoading:NO];
    }
    
    if ( msg.succeed )
    {
        STATUS * status = msg.GET_OUTPUT(@"status");
        self.no_follow = msg.GET_OUTPUT(@"no_follow");
        
        if ( status && status.succeed.boolValue )
        {
            self.list.footerShown = YES;
            [self.list setFooterMore:self.momentModel.more];
            [self.list reloadData];
        }
        else
        {
            [self showErrorTips:msg];
        }
    }
    else if ( msg.failed )
    {
        [self showErrorTips:msg];
    }
}

ON_MESSAGE3( API, teacher_publish, msg )
{
    if ( msg.sending )
    {
        
    }
    else
    {
        
    }
    if ( msg.succeed )
    {
        NSString * data = msg.GET_OUTPUT(@"data");
        NSString * curTime = msg.GET_INPUT(@"time");
        if ([data isEqualToString:@"1"])
        {
            [self presentSuccessTips:__TEXT(@"moments_success")];
            [self.momentModel firstPage];
            
            // 发送成功，将当前在缓存中的那一条汇师圈删除了
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            NSMutableArray * momentsCacheArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"momentsCache"]];
            if (momentsCacheArray != nil && momentsCacheArray.count != 0) {
                
                for (int i = 0; i < momentsCacheArray.count; i++) {
                    
                    NSDictionary * momentDict = [momentsCacheArray objectAtIndex:i];
                    NSString * time = [momentDict objectForKey:@"curTime"];
                    if ([time isEqualToString:curTime]) {
                        
                        [momentsCacheArray removeObjectAtIndex:i];
                    }
                }
                
                [defaults setObject:momentsCacheArray forKey:@"momentsCache"];
            }
        }
        else
        {
//            [self presentFailureTips:__TEXT(@"moments_error")];
            // 失败alert提示
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            NSArray * momentsCacheArray = [defaults objectForKey:@"momentsCache"];
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您有%ld条未发送成功的汇师圈，是否重新发送？", (long)momentsCacheArray.count] preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                // 删除NSUserDefaults
                [self deleteMomentsCache];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"发送" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                // 走一个通知重新发送汇师圈
                [self reSendMomentByCache];
                
            }]];
            [[AppBoard_iPhone sharedInstance] presentViewController:alert animated:YES completion:nil];
        }
    }
    if ( msg.failed )
    {
//        [self presentFailureTips:__TEXT(@"moments_error")];
        
        // 失败alert提示
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSArray * momentsCacheArray = [defaults objectForKey:@"momentsCache"];
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您有%ld条未发送成功的汇师圈，是否重新发送？", (long)momentsCacheArray.count] preferredStyle:UIAlertControllerStyleAlert];
        
        @weakify(self);
    
        [alert addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            @normalize(self);
            // 删除NSUserDefaults
            [self deleteMomentsCache];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"发送" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            @normalize(self);
            [self reSendMomentByCache];
        }]];
        [[AppBoard_iPhone sharedInstance] presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - notification
ON_NOTIFICATION3( UserModel, LOGIN, notification )
{
    [self updateState];
    
    [self.momentModel firstPage];
}
    
- (void)updateState
{
    if ( [UserModel online] )
    {
        [[CartModel sharedInstance] reload];
        {
            [[UserModel sharedInstance] updateProfile];
        }
            
        if ( ![UserModel sharedInstance].loaded )
        {
            [self.list showHeaderLoader:YES animated:NO];
        }
    }
    else
    {
        if ( ![UserModel sharedInstance].loaded )
        {
            [self.list showHeaderLoader:NO animated:NO];
        }
    }
    
    [[ECMobilePushUnread sharedInstance] update];
        
        
    [self.list reloadData];
}

-(I0_MomentsWriteCommentView *)commentView
{
    if (!_commentView) {
        _commentView = [[I0_MomentsWriteCommentView alloc]init];
        [self.view addSubview:_commentView];
        [_commentView.textView becomeFirstResponder];
        
    }
    return _commentView;
}

-(void)hideTextView:(NSNotification*)noti
{
    self.commentView = nil;
}

@end
