//
//  RegisterModel.h
//  shop
//
//  Created by guangnian dashu on 16/8/30.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//
//  Add by nahuanjie

#import "Bee.h"
#import "ecmobile.h"

#pragma mark -

@interface RegisterModel : BeeOnceViewModel

@property (nonatomic, retain) NSString *    usernameTag;
@property (nonatomic, retain) NSString *    passwordTag;
@property (nonatomic, retain) NSString *    confirmPasswordTag;
@property (nonatomic, retain) NSString *    mobilePhoneTag;
@property (nonatomic, retain) NSString *    identifyCodeTag;
@property (nonatomic, retain) NSString *    realnameTag;
@property (nonatomic, retain) NSString *    regionTag;
@property (nonatomic, retain) NSString *    schoolTag;
@property (nonatomic, retain) NSString *    courseTag;
@property (nonatomic, retain) NSString *    inviteTag;

@end
