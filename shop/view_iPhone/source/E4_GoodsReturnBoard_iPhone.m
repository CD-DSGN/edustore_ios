//
//  E4_GoodsReturn_iPhone.m
//  shop
//
//  Created by 田明飞 on 2017/3/6.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "E4_GoodsReturnBoard_iPhone.h"
#import "E4_GoodsReturnCell_iPhone.h"

@interface E4_GoodsReturnBoard_iPhone ()

@end

@implementation E4_GoodsReturnBoard_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

DEF_OUTLET( BeeUIScrollView, list )

- (void)load
{
    
}

- (void)unload
{
    
}

ON_CREATE_VIEWS( signal )
{
    self.navigationBarTitle = @"申请退货";
    
    [self showNavigationBarAnimated:NO];
    [self showBarButton:BeeUINavigationBar.LEFT image:[UIImage imageNamed:@"nav_back.png"]];
    
    @weakify(self);
    
    self.list.lineCount = 1;
    self.list.animationDuration = 0.25f;
    
    self.list.whenReloading = ^
    {
        @normalize(self);
        self.list.total = 1;
        BeeUIScrollItem * item = self.list.items[0];
        item.clazz = [E4_GoodsReturnCell_iPhone class];
        item.size = self.list.size;
        item.data = self.goods;
        item.rule = BeeUIScrollLayoutRule_Tile;
    };
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
    [self.list asyncReloadData];
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

@end
