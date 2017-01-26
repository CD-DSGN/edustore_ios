//
//  PhotoBrowserViewController.h
//  shop
//
//  Created by 田明飞 on 2017/1/17.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DeletePhoto) (NSInteger index);
@interface PhotoBrowserViewController : UIViewController

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,strong) NSArray *imageArray;

@property (nonatomic,strong) DeletePhoto deletePhoto;

@end
