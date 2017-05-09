//
//  NewsModel.m
//  shop
//
//  Created by 田明飞 on 2017/5/9.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel


@synthesize moments = _moments;

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
    self.moments = nil;
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
    if ( NO == self.more )
        return;
    
    [self gotoPage:(self.moments.count / 10)];
}

- (void)gotoPage:(NSUInteger)index
{
//    if ( NO == [UserModel online] )
//        return;
    
    PAGINATION * page = [PAGINATION object];
    page.page	= __INT( 1 + index );
    page.count	= __INT( 10 );
    
    self.CANCEL_MSG( API.getNews );
    self.MSG( API.getNews )
    .INPUT( @"cpage", page.page )
    .INPUT( @"pagesize", page.count);
}

#pragma mark - MESSAGE

ON_MESSAGE3( API, getNews, msg )
{
//    if ( msg.succeed )
//    {
        STATUS * status = msg.GET_OUTPUT( @"status" );
        if ( NO == status.succeed.boolValue )
        {
            msg.failed = YES;
            return;
        }
        
        PAGINATION * page = msg.GET_INPUT( @"pagination" );
        if ( page && [page.page isEqualToNumber:@1] )
        {
            self.moments = msg.GET_OUTPUT( @"data" );
        }
        else
        {
            NSArray * array = msg.GET_OUTPUT(@"data");
            if ( array && array.count )
            {
                [self.moments addObjectsFromArray:array];
            }
        }
        
        self.loaded = YES;
        
        PAGINATED * paged = msg.GET_OUTPUT( @"paginated" );
        if ( paged )
        {
            self.more = paged.more.boolValue;
        }
        else
        {
            self.more = NO;
        }
        
        [self saveCache];
//    }
}
@end
