//
//  NewsModel.m
//  shop
//
//  Created by 田明飞 on 2017/5/9.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel


@synthesize newsArray = _newsArray;

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
    self.newsArray = nil;
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
    
    [self gotoPage:(self.newsArray.count / 10)];
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
    if ( msg.succeed )
    {
        NSNumber *code = msg.GET_OUTPUT(@"code");
        if (code.integerValue == 200) {
            PAGINATION * page = [[PAGINATION alloc] init];
            page.page = msg.GET_INPUT( @"cpage" );
            page.count = msg.GET_INPUT( @"pagesize" );
            if ( page && [page.page isEqualToNumber:@1] )
            {
                self.newsArray = msg.GET_OUTPUT( @"data" );
            }
            else
            {
                NSArray * array = msg.GET_OUTPUT(@"data");
                if ( array && array.count )
                {
                    [self.newsArray addObjectsFromArray:array];
                }
            }
            
            self.loaded = YES;
            
            BOOL  paged = [msg.GET_OUTPUT( @"total_page" ) integerValue] == [page.page integerValue];
            if ( !paged )
            {
                self.more = YES;
            }
            else
            {
                self.more = NO;
            }
            
            [self saveCache];
        }
        
    }
}
@end
