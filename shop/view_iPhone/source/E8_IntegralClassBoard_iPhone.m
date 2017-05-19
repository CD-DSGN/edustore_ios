//  E8_IntegralBoard_iPhone.m
//  shop
//
//  Created by guangnian dashu on 16/9/19.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "E8_IntegralClassBoard_iPhone.h"
#import "E8_IntegralClassCell_iPhone.h"

#import "AppBoard_iPhone.h"

#import "CommonPullLoader.h"
#import "ECMobileManager.h"
#import "TeacherClassModel.h"
@implementation E8_IntegralClassBoard_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

DEF_MODEL( UserModel, userModel )
DEF_MODEL( TeacherClassModel, classModel)

DEF_OUTLET( BeeUIScrollView, list )

- (void)load
{
    self.userModel = [UserModel modelWithObserver:self];
    self.classModel = [TeacherClassModel modelWithObserver:self];
}

- (void)unload
{
    SAFE_RELEASE_MODEL( self.userModel );
    SAFE_RELEASE_MODEL( self.classModel);
}

#pragma mark -

ON_CREATE_VIEWS( signal )
{
    self.navigationBarShown = YES;
    self.navigationBarTitle = __TEXT(@"class_list");
    
    self.navigationBarLeft  = [UIImage imageNamed:@"nav_back.png"];
    
    self.list.headerClass = [CommonPullLoader class];
    self.list.headerShown = YES;
    
    @weakify(self);
    
    self.list.whenReloading = ^
    {
        @normalize(self);
        
        self.list.total = self.classModel.classArray.count;
        
        for( int i = 0; i < self.classModel.classArray.count; i++ )
        {
            BeeUIScrollItem * item = self.list.items[i];
            item.clazz = [E8_IntegralClassCell_iPhone class];
            item.data = [self.classModel.classArray safeObjectAtIndex:i];
            item.size = CGSizeAuto;
            item.rule = BeeUIScrollLayoutRule_Tile;
        }
    };
    self.list.whenHeaderRefresh = ^
    {
        @normalize(self);
        
        [self.classModel firstPage];
    };
//    self.list.whenFooterRefresh = ^
//    {
//        @normalize(self);
//        
//        [self.classModel nextPage];
//    };
//    self.list.whenReachBottom = ^
//    {
//        @normalize(self);
//        
//        [self.classModel nextPage];
//    };
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

ON_MESSAGE3( API, getTeacherClass, msg )
{
    if( msg.sending )
    {
        [self presentMessageTips:@"获取班级列表中"];
    }
    else
    {
        [self.list setHeaderLoading:NO];
    }
    if( msg.succeed )
    {
        self.classModel.classArray = msg.GET_OUTPUT( @"data" );
        [self.list asyncReloadData];
    }
    if( msg.failed )
    {
        
    }
    if( msg.cancelled )
    {
        
    }
}

ON_SIGNAL2( E8_IntegralCell_iPhone, signal )
{
    NSLog(@"checkClassList");
//    K0_NewsDetailBoard_iPhone * board = [K0_NewsDetailBoard_iPhone board];
//    [self.stack pushBoard:board animated:YES];
}


@end
