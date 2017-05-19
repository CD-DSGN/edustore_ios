//
//  TeacherClassModel.m
//  shop
//
//  Created by 田明飞 on 2017/5/19.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "TeacherClassModel.h"

@implementation TeacherClassModel

@synthesize classArray = _classArray;

- (void)load
{
}

- (void)unload
{
    [self saveCache];
}

#pragma mark -

- (void)loadCache
{
}

- (void)saveCache
{
}

- (void)clearCache
{
    self.classArray = nil;
    self.loaded = NO;
}

#pragma mark -

- (void)firstPage
{
    [self gotoPage:0];
}

- (void)lastPage
{
}

- (void)prevPage
{
}

- (void)nextPage
{
    
}

- (void)gotoPage:(NSUInteger)index
{
    
    self.CANCEL_MSG( API.getTeacherClass );
    self.MSG( API.getTeacherClass );
}

#pragma mark - MESSAGE

ON_MESSAGE3( API, getTeacherClass, msg )
{
    if ( msg.succeed )
    {
        NSNumber *code = msg.GET_OUTPUT(@"success");
        if (code.integerValue == 1) {
            
            self.classArray = msg.GET_OUTPUT( @"data" );
            
            self.loaded = YES;
            
            self.more = NO;
            
            [self saveCache];
        }
        
    }
}


@end
