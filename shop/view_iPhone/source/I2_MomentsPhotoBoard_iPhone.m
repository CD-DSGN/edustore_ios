//
//  I2_MomentsPhotoBoard_iPhone.m
//  shop
//
//  Created by guangnian dashu on 2016/11/24.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "AppBoard_iPhone.h"
#import "I2_MomentsPhotoBoard_iPhone.h"
#import "I2_MomentsPhotoSlideCell_iPhone.h"

#import <UIKit/UIGestureRecognizerSubclass.h>

@interface I2_MomentsPhotoBoard_iPhone()
@property (nonatomic,strong) UITapGestureRecognizer *doubleTap;
@property (nonatomic,strong) UITapGestureRecognizer *singleTap;
@end

@implementation I2_MomentsPhotoBoard_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

DEF_OUTLET( BeeUIScrollView, list )
DEF_OUTLET( BeeUIPageControl, pager )

ON_CREATE_VIEWS( signal )
{
    self.navigationBarShown = NO;
    self.navigationBarShown = YES;
    self.navigationBarLeft  = [UIImage imageNamed:@"nav_back.png"];
    
    self.view.backgroundColor = [UIColor blackColor];
    
//    _doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
//    _doubleTap.numberOfTapsRequired = 2;
//    _doubleTap.numberOfTouchesRequired  =1;
//    
//    _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//    _singleTap.numberOfTapsRequired = 1;
//    _singleTap.numberOfTouchesRequired = 1;
//    _singleTap.delaysTouchesBegan = YES;
//    //只能有一个手势存在
//    [_singleTap requireGestureRecognizerToFail:self.doubleTap];
//    
//    [self.list addGestureRecognizer:self.doubleTap];
//    [self.list addGestureRecognizer:self.singleTap];
    
    @weakify(self);
    
    self.list.animationDuration = 0.25f;
    
    self.list.whenReloading = ^
    {
        @normalize(self);
        
        self.list.total = self.moments.publish_info.photo_array.count;
        
        for ( BeeUIScrollItem * item in self.list.items )
        {
            item.clazz = [I2_MomentsPhotoSlideCell_iPhone class];
            item.size = self.list.size;
            item.data = [self.moments.publish_info.photo_array safeObjectAtIndex:item.index];
            item.rule = BeeUIScrollLayoutRule_Tile;
        }
        
        self.pager.numberOfPages = self.list.total;
        self.pager.currentPage = self.pageIndex;
    };
    self.list.whenReloaded = ^
    {
        @normalize(self);
        
        if (self.firstReloaded)
        {
            self.pager.currentPage = self.pageIndex;
            self.list.pageIndex = self.pageIndex;
            self.firstReloaded = NO;
        }
        else
        {
            self.pager.currentPage = self.list.pageIndex;
        }
        self.pager.numberOfPages = self.list.total;
    };
    self.list.whenStop = ^
    {
        @normalize(self);;
        
        self.pager.numberOfPages = self.list.total;
        self.pager.currentPage = self.list.pageIndex;
    };
}

ON_DELETE_VIEWS( signal )
{
    self.list = nil;
    
    self.pager = nil;
    self.singleTap = nil;
    self.doubleTap = nil;
}

ON_LAYOUT_VIEWS( signal )
{
}

ON_WILL_APPEAR( signal )
{
    
}

ON_DID_APPEAR( signal )
{
    self.firstReloaded = YES;
    [self.list reloadData];
}

ON_WILL_DISAPPEAR( signal )
{
}

ON_DID_DISAPPEAR( signal )
{
}

ON_LEFT_BUTTON_TOUCHED( signal )
{
}


ON_SIGNAL2( BeeUIZoomView, signal )
{
    if ([signal is:BeeUIZoomView.SINGLE_TAPPED])
    {
//        NSLog(@"single tap");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if ([signal is:BeeUIZoomView.DOUBLE_TAPPED])
    {
//        NSLog(@"double tap");
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
