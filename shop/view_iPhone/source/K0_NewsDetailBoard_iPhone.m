//
//  K0_NewsDetailBoard_iPhone.m
//  shop
//
//  Created by 田明飞 on 2017/5/11.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "K0_NewsDetailBoard_iPhone.h"
#import "Bee.h"
#import "BaseBoard_iPhone.h"
#import "AppBoard_iPhone.h"
@interface K0_NewsDetailBoard_iPhone ()

@end

@implementation K0_NewsDetailBoard_iPhone

SUPPORT_RESOURCE_LOADING( YES )
SUPPORT_AUTOMATIC_LAYOUT( YES )



DEF_OUTLET( BeeUIWebView , webView )

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self addWebView];
}

-(void)addWebView
{
    
}

- (void)load
{
}

- (void)unload
{

}

#pragma mark -

ON_CREATE_VIEWS( signal )
{
    self.navigationBarTitle = _newsDetail.title;
    [self showNavigationBarAnimated:NO];
    [self showBarButton:BeeUINavigationBar.LEFT image:[UIImage imageNamed:@"nav_back.png"]];
    @weakify(self);
    
    [self.webView setUrl:_newsDetail.url];
    
    
}

ON_DELETE_VIEWS( signal )
{
    self.webView = nil;
}

ON_LAYOUT_VIEWS( signal )
{
}

ON_WILL_APPEAR( signal )
{
    [bee.ui.appBoard hideTabbar];
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

ON_LEFT_BUTTON_TOUCHED( signal )
{
    [self.stack popBoardAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
