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

#import "I0_MomentsNoResultCell_iPhone.h"
#import "K0_NewsDetailBoard_iPhone.h"
@interface K0_NewsBoard_iPhone ()

@end

@interface K0_NewsBoard_iPhone ()

@property (nonatomic, assign) BOOL isFirstLoad;

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
    
    self.isFirstLoad = YES;
}

- (void)unload
{
    SAFE_RELEASE_MODEL( self.newsModel );
    SAFE_RELEASE_MODEL( self.userModel );
}


ON_CREATE_VIEWS( signal )
{
    self.navigationBarTitle = __TEXT(@"news");
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"huishi_logo"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 59, 44);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView: button];
    

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
        
        self.list.total = self.newsModel.newsArray.count;
        
        for( int i = 0; i < self.newsModel.newsArray.count; i++ )
        {
            BeeUIScrollItem * item = self.list.items[i];
            item.clazz = [K0_NewsCell class];
            item.data = [self.newsModel.newsArray safeObjectAtIndex:i];
            item.size = CGSizeAuto;
            item.rule = BeeUIScrollLayoutRule_Tile;
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
    if (self.isFirstLoad) {
        
        [self.newsModel firstPage];
        
        //[self.list reloadData];
        
        self.isFirstLoad = NO;
    }
    
    [bee.ui.appBoard showTabbar];
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

ON_MESSAGE3( API, getNews, msg )
{
    if ( msg.sending )
    {
        if ( NO == self.newsModel.loaded )
        {
            [self presentMessageTips:__TEXT(@"news_loading")];
        }
        
        if ( self.newsModel.newsArray.count )
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
        NSNumber * code = msg.GET_OUTPUT(@"code");
        
        if ( [code integerValue] == 200 )
        {
            self.list.footerShown = YES;
            [self.list setFooterMore:self.newsModel.more];
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


ON_SIGNAL2( K0_NewsCell, signal )
{
    NEWS_DETAIL * news = signal.sourceCell.data;
    if ( news )
    {
        K0_NewsDetailBoard_iPhone * board = [K0_NewsDetailBoard_iPhone board];
        board.newsDetail= news;
        board.hidesBottomBarWhenPushed = YES;
        [self.stack pushBoard:board animated:YES];
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
