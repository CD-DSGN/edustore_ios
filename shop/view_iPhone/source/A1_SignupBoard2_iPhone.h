//
//  A1_SignupBoard2_iPhone.h
//  shop
//
//  Created by guangnian dashu on 2017/5/19.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "Bee.h"
#import "BaseBoard_iPhone.h"

#import "controller.h"
#import "model.h"

#import "UIViewController+ErrorTips.h"

@interface A1_SignupBoard2_iPhone : BaseBoard_iPhone<UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

AS_OUTLET( BeeUIScrollView, list )

AS_MODEL( UserModel, userModel )

@property (nonatomic, retain) NSString * nickname;
@property (nonatomic, retain) NSString * mobilePhone;
@property (nonatomic, retain) NSString * password;

@end
