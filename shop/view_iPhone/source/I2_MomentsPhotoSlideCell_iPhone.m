//
//  I2_MomentsPhotoSlideCell_iPhone.m
//  shop
//
//  Created by guangnian dashu on 2016/11/24.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "I2_MomentsPhotoSlideCell_iPhone.h"

@implementation I2_MomentsPhotoSlideCell_iPhone

SUPPORT_RESOURCE_LOADING( YES );
SUPPORT_AUTOMATIC_LAYOUT( YES );

- (void)layoutDidFinish
{
    _photo.frame = self.bounds;
    _zoomView.frame = self.bounds;
    [_zoomView setContentSize:self.bounds.size];
    [_zoomView layoutContent];
}

- (void)load
{
    _photo = [[BeeUIImageView alloc] init];
    _photo.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    _photo.contentMode = UIViewContentModeScaleAspectFit;
    
    
    _zoomView = [[BeeUIZoomView alloc] init];
    _zoomView.backgroundColor = [UIColor blackColor];
    [_zoomView setContent:_photo animated:NO];
    [self addSubview:_zoomView];
}

- (void)unload
{
    SAFE_RELEASE_SUBVIEW( _photo );
    SAFE_RELEASE_SUBVIEW( _zoomView );
}

- (void)dataDidChanged
{
//    PHOTO * photo = self.data;
    NSDictionary * photo = self.data;
    if ( photo )
    {
        [_photo GET:[photo objectForKey:@"img"]
           useCache:YES
        placeHolder:[UIImage imageNamed:@"placeholder_image.png"]];
    }
}

@end
