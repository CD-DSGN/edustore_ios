//
//  StudentPointModel.h
//  shop
//
//  Created by 田明飞 on 2017/5/19.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "Bee_PagingViewModel.h"
#import "ecmobile.h"
@interface StudentPointModel : BeePagingViewModel

@property (nonatomic, retain) NSMutableArray * studentPointArray;

@property (nonatomic, retain) NSNumber * info_id;

@end
