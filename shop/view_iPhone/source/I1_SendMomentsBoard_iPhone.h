//
//  I1_SendMomentsBoard_iPhone.h
//  shop
//
//  Created by guangnian dashu on 2016/11/8.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "Bee.h"
#import "BaseBoard_iPhone.h"
#import "TZImagePickerController.h"
@interface I1_SendMomentsBoard_iPhone : BaseBoard_iPhone<UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, TZImagePickerControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, retain) UIScrollView * scrollView;
@property (nonatomic, retain) UITextView * textViewSendContent;
@property (nonatomic, retain) UILabel * textViewPlaceholder;

@property (nonatomic,strong) NSMutableArray *photoArray;
@property (nonatomic,strong) UICollectionView *collectionView;

@end
