//  E8_IntegralBoard_iPhone.m
//  shop
//
//  Created by guangnian dashu on 16/9/19.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "E8_IntegralStudentListBoard_iPhone.h"
#import "E8_IntegralStudentCell_iPhone.h"

#import "AppBoard_iPhone.h"

#import "CommonPullLoader.h"
#import "ECMobileManager.h"

@implementation E8_IntegralStudentListBoard_iPhone

@synthesize info_id = _info_id;

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

DEF_MODEL( UserModel, userModel )
DEF_MODEL( StudentPointModel, studentPointModel)

DEF_OUTLET( BeeUIScrollView, list )

- (void)load
{
    self.userModel = [UserModel modelWithObserver:self];
    self.studentPointModel = [StudentPointModel modelWithObserver:self];
}

- (void)unload
{
    SAFE_RELEASE_MODEL( self.userModel );
    SAFE_RELEASE_MODEL( self.studentPointModel);
}

#pragma mark -

ON_CREATE_VIEWS( signal )
{
    self.navigationBarShown = YES;
    self.navigationBarTitle = __TEXT(@"student_point_list");
    
    self.navigationBarLeft  = [UIImage imageNamed:@"nav_back.png"];
    
    self.list.headerClass = [CommonPullLoader class];
    self.list.headerShown = YES;
    
    @weakify(self);
    
    self.list.whenReloading = ^
    {
        @normalize(self);
        
        self.list.total = self.studentPointModel.studentPointArray.count;
        
        for( int i = 0; i < self.studentPointModel.studentPointArray.count; i++ )
        {
            BeeUIScrollItem * item = self.list.items[i];
            item.clazz = [E8_IntegralStudentCell_iPhone class];
            item.data = [self.studentPointModel.studentPointArray safeObjectAtIndex:i];
            item.size = CGSizeAuto;
            item.rule = BeeUIScrollLayoutRule_Tile;
        }
    };
    self.list.whenHeaderRefresh = ^
    {
        @normalize(self);
        
        [self.studentPointModel firstPage];
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
    self.studentPointModel.info_id = self.info_id;
    [self.studentPointModel firstPage];
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

ON_MESSAGE3( API, getStudentPoint, msg )
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
        self.studentPointModel.studentPointArray = msg.GET_OUTPUT( @"data" );
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
