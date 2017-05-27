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
}

- (void)unload
{
    SAFE_RELEASE_MODEL( self.momentModel );
    SAFE_RELEASE_MODEL( self.userModel );
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
    
    [self.momentModel firstPage];
    
    [self.list reloadData];
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
    self.commentView.hidden = NO;
    [self.commentView setCommitCommentBlock:^(){
        
    }];
}

#pragma mark -

ON_MESSAGE3( API, moments_list, msg )
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
