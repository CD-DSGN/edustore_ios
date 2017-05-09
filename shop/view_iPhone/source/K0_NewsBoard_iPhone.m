//
//  K0_NewsBoard_iPhone.m
//  shop
//
//  Created by 田明飞 on 2017/5/4.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "K0_NewsBoard_iPhone.h"

#import "K0_NewsCell.h"
#import "AppBoard_iPhone.h"

#import "CommonNoResultCell.h"
#import "CommonPullLoader.h"
#import "CommonFootLoader.h"
@interface K0_NewsBoard_iPhone ()

@end

@implementation K0_NewsBoard_iPhone


DEF_SINGLETON( NewsBoard )

SUPPORT_RESOURCE_LOADING( YES )
SUPPORT_AUTOMATIC_LAYOUT( YES )

DEF_MODEL( NewsModel, newsModel );
DEF_MODEL( UserModel, userModel );

DEF_OUTLET( BeeUIScrollView, list )

- (void)load
{
    self.newsModel = [NewsModel modelWithObserver:self];
    self.userModel = [UserModel modelWithObserver:self];
}

- (void)unload
{
    SAFE_RELEASE_MODEL( self.newsModel );
    SAFE_RELEASE_MODEL( self.userModel );
}


ON_CREATE_VIEWS( signal )
{
    self.navigationBarTitle = __TEXT(@"news");
    [self showNavigationBarAnimated:NO];
    
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
        
//        self.list.total = self.momentModel.moments.count;
        
        if ( [UserModel online] == NO )  // 未登录状态
        {
            self.list.total = 1;
            BeeUIScrollItem * item = self.list.items[0];
            item.clazz = [K0_NewsCell class];
            item.size = self.list.size;
            item.rule = BeeUIScrollLayoutRule_Tile;
            item.data = @"用户未登录";
            
            [self handleEmpty:YES];
            [self handleLogined:NO];
        }
        else    // 已登录
        {
            [self handleLogined:YES];
            
//            // 返回数据为空
//            if ( self.momentModel.loaded && self.momentModel.moments.count == 0)
//            {
//                if ([self.userModel.user.is_teacher isEqual:@1])
//                {
//                    // 教师用户，还未发布任何消息
//                    self.list.total = 1;
//                    BeeUIScrollItem * item = self.list.items[0];
//                    item.clazz = [I0_MomentsNoResultCell_iPhone class];
//                    item.size = self.list.size;
//                    item.rule = BeeUIScrollLayoutRule_Tile;
//                    item.data = @"教师尚未发布消息";
//                }
//                else
//                {
//                    if ([self.no_follow isEqualToString:@"1"])
//                    {
//                        // 学生用户，未关注过教师
//                        self.list.total = 1;
//                        BeeUIScrollItem * item = self.list.items[0];
//                        item.clazz = [I0_MomentsNoResultCell_iPhone class];
//                        item.size = self.list.size;
//                        item.rule = BeeUIScrollLayoutRule_Tile;
//                        item.data = @"学生尚未关注任何教师";
//                    }
//                    else
//                    {
//                        // 学生用户，所关注教师没有发送过消息
//                        self.list.total = 1;
//                        BeeUIScrollItem * item = self.list.items[0];
//                        item.clazz = [I0_MomentsNoResultCell_iPhone class];
//                        item.size = self.list.size;
//                        item.rule = BeeUIScrollLayoutRule_Tile;
//                        item.data = @"学生所关注教师未发布动态";
//                    }
//                }
//                [self handleEmpty:YES];
//            }
//            // 有返回数据：学生所关注的教师有发送消息，教师有发送消息
//            else
//            {
//                [self handleEmpty:NO];
//                
//                for( int i = 0; i < self.momentModel.moments.count; i++ )
//                {
//                    BeeUIScrollItem * item = self.list.items[i];
//                    item.clazz = [I0_MomentsCell_iPhone class];
//                    item.data = [self.momentModel.moments safeObjectAtIndex:i];
//                    item.size = CGSizeAuto;
//                    item.rule = BeeUIScrollLayoutRule_Tile;
//                }
//            }
        }
    };
    self.list.whenHeaderRefresh = ^
    {
        @normalize(self);
        
        [self.newsModel firstPage];
    };
    self.list.whenFooterRefresh = ^
    {
        @normalize(self);
        
        [self.newsModel nextPage];
    };
    self.list.whenReachBottom = ^
    {
        @normalize(self);
        
        [self.newsModel nextPage];
    };
    
}

ON_DELETE_VIEWS( signal )
{
    self.list = nil;
}

ON_LAYOUT_VIEWS( signal )
{
}

ON_WILL_APPEAR( signal )
{
    [bee.ui.appBoard showTabbar];
    
    [self.newsModel firstPage];
    
    [self.list reloadData];
}

ON_DID_APPEAR( signal )
{
    // 发送按钮
//    if ([self.userModel.user.is_teacher isEqual:@1])
//    {
//        [self showBarButton:BeeUINavigationBar.RIGHT
//                      title:@"发送"
//                      image:[UIImage imageNamed:@"nav_right.png"]];
//    }
//    else
//    {
//        [self setNavigationBarRight:nil];
//    }
}

ON_WILL_DISAPPEAR( signal )
{
    
}

ON_DID_DISAPPEAR( signal )
{
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
