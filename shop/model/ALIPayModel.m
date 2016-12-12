//
//  ALIPayModel.m
//  shop
//
//  Created by guangnian dashu on 16/11/1.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "ALIPayModel.h"

@implementation REQ_SIGN_ALIPAY
@synthesize order_id = _order_id;
@synthesize session = _session;

- (BOOL)validate
{
    return YES;
}
@end

@implementation RESP_SIGN_ALIPAY
@synthesize signString = _signString;

- (BOOL)validate
{
    return YES;
}
@end

@implementation API_SIGN_ALIPAY

@synthesize req = _req;
@synthesize resp = _resp;

- (id)init
{
    self = [super init];
    if ( self )
    {
        self.req = [[[REQ_SIGN_ALIPAY alloc] init] autorelease];
        self.resp = [[[RESP_SIGN_ALIPAY alloc] init] autorelease];
    }
    return self;
}

- (void)dealloc
{
    self.req = nil;
    self.resp = nil;
    [super dealloc];
}

- (void)routine
{
    if ( self.sending )
    {
        if ( nil == self.req || NO == [self.req validate] )
        {
            self.failed = YES;
            return;
        }
        
        NSString * requestURI = [NSString stringWithFormat:@"%@/get_sign", [ServerConfig sharedInstance].url];
        NSString * requestBody = [self.req objectToString];
        
        self.HTTP_POST( requestURI ).PARAM( @"json", requestBody );
    }
    else if ( self.succeed )
    {
        NSDictionary * result = self.responseJSON;
        
        if ( result && [result isKindOfClass:[NSDictionary class]] )
        {
            self.resp.signString = [result objectAtPath:@"data.sign"];
        }
    
        if ( nil == self.resp.signString || NO == [self.resp validate] )
        {
            self.failed = YES;
            return;
        }
    }
    else if ( self.failed )
    {
        // TODO:
    }
    else if ( self.cancelled )
    {
        // TODO:
    }
}

@end

#pragma mark - ALIPayModel

@implementation ALIPayModel

- (void)pay
{
    [API_SIGN_ALIPAY cancel:self];
    
    API_SIGN_ALIPAY * api = [API_SIGN_ALIPAY apiWithResponder:self];
    
    @weakify(api);
    
    api.req.session = [UserModel sharedInstance].session;
    api.req.order_id = self.order_id;
    
    api.whenUpdate = ^
    {
        @normalize(api);
        
        if ( api.sending )
        {
            [self sendUISignal:self.RELOADING];
        }
        else
        {
            [self dismissTips];
            
            if ( api.succeed )
            {
                self.signString = api.resp.signString;
                [self sendUISignal:self.RELOADED];
            }
            else
            {
                [self sendUISignal:self.FAILED];
            }
        }
    };
    
    [api send];
}

@end
