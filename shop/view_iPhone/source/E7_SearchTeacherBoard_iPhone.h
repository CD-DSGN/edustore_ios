//
//  E7_SearchTeacherBoard_iPhone.h
//  shop
//
//  Created by guangnian dashu on 16/9/14.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "Bee.h"
#import "BaseBoard_iPhone.h"

#import "controller.h"
#import "model.h"

#import "UIViewController+ErrorTips.h"

@interface E7_SearchTeacherBoard_iPhone : BaseBoard_iPhone<UITableViewDelegate,UITableViewDataSource>

AS_OUTLET( BeeUITextField, searchInput )
AS_MODEL( UserModel, userModel )

@property (nonatomic, retain) NSNumber * course_id;
@property (nonatomic, retain)NSNumber * user_id;

@property (nonatomic, retain) NSArray * searchHistory;
@property (nonatomic, retain) NSMutableArray * userResult;
@property (nonatomic, retain) NSMutableArray * teacherId;
@property (nonatomic, retain) NSMutableArray * isFollowed;

@property (nonatomic, retain) UITableView * history;
@property (nonatomic, retain) UITableView * result;

@end
