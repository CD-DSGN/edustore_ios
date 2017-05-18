//  E8_IntegralBoard_iPhone.m
//  shop
//
//  Created by guangnian dashu on 16/9/19.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "E8_IntegralBoard_iPhone.h"
#import "E8_IntegralCell_iPhone.h"

#import "AppBoard_iPhone.h"

#import "CommonPullLoader.h"
#import "ECMobileManager.h"

@implementation E8_IntegralBoard_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

DEF_MODEL( UserModel, userModel )

DEF_OUTLET( BeeUIScrollView, list )

- (void)load
{
    self.userModel = [UserModel modelWithObserver:self];
    
    self.data = [[TEACHER_INTEGRAL alloc] init];
}

- (void)unload
{
    SAFE_RELEASE_MODEL( self.userModel );
    
    self.data = nil;
}

#pragma mark -

ON_CREATE_VIEWS( signal )
{
    self.navigationBarShown = YES;
    self.navigationBarTitle = __TEXT(@"integral");
    
    self.navigationBarLeft  = [UIImage imageNamed:@"nav_back.png"];
    
    self.list.headerClass = [CommonPullLoader class];
    self.list.headerShown = YES;
    
    @weakify(self);
    
    self.list.whenReloading = ^
    {
        @normalize(self);
        
        // 为积分页面要展示的内容赋值
        // 如果要多行内容显示，那么传参要传对应的对象，因为页面不循环输出， 都是显示的直接写出来
        self.list.total = 1;
        
        BeeUIScrollItem * item = self.list.items[0];
        item.clazz = [E8_IntegralCell_iPhone class];
        item.rule = BeeUIScrollLayoutRuleHorizontal;
        item.size = CGSizeAuto;
        item.data = self.data;
    };
    self.list.whenHeaderRefresh = ^
    {
        @normalize(self);
        
        [self searchIntegral];
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
    [bee.ui.appBoard hideTabbar];
    [self searchIntegral];
}

ON_DID_APPEAR( signal )
{
    [self.list reloadData];
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
    [self.stack popBoardAnimated:YES];
}

ON_RIGHT_BUTTON_TOUCHED( signal )
{
    
}

- (void)searchIntegral
{
    [self.userModel searchIntegral];
}

ON_MESSAGE3( API, get_integral, msg )
{
    if( msg.sending )
    {
        [self presentMessageTips:@"获取积分中"];
    }
    else
    {
        [self.list setHeaderLoading:NO];
    }
    if( msg.succeed )
    {
        TEACHER_INTEGRAL * data = msg.GET_OUTPUT( @"data" );
        self.data = data;
        [self.list asyncReloadData];
    }
    if( msg.failed )
    {
        
    }
    if( msg.cancelled )
    {
        
    }
}



@end
