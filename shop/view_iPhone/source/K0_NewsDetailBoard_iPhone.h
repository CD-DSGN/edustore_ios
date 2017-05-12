//
//  K0_NewsDetailBoard_iPhone.h
//  shop
//
//  Created by 田明飞 on 2017/5/11.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "BaseBoard_iPhone.h"

@interface K0_NewsDetailBoard_iPhone : BaseBoard_iPhone

AS_OUTLET(BeeUIWebView, webView)

@property (nonatomic,strong) NEWS_DETAIL *newsDetail;

@end
