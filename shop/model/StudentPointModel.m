//
//  StudentPointModel.m
//  shop
//
//  Created by 田明飞 on 2017/5/19.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "StudentPointModel.h"

@implementation StudentPointModel

@synthesize studentPointArray = _studentPointArray;
@synthesize info_id = _info_id;
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
    self.studentPointArray = nil;
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
    
    NSNumber *info_id = self.info_id;
    
    self.CANCEL_MSG( API.getStudentPoint );
    self.MSG( API.getStudentPoint )
    .INPUT( @"info_id", info_id );
}

#pragma mark - MESSAGE

ON_MESSAGE3( API, getStudentPoint, msg )
{
    if ( msg.succeed )
    {
        NSNumber *code = msg.GET_OUTPUT(@"success");
        if (code.integerValue == 1) {
            
            self.studentPointArray = msg.GET_OUTPUT( @"data" );
            
            self.loaded = YES;
            
            self.more = NO;
            
            [self saveCache];
        }
        
    }
}



@end
