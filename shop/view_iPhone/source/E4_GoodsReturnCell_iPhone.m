//
//  E4_GoodsReturnCell_iPhone.m
//  shop
//
//  Created by guangnian dashu on 2017/3/6.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "E4_GoodsReturnCell_iPhone.h"

@interface E4_GoodsReturnCell_iPhone ()<UITextViewDelegate,  UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) ORDER_GOODS * goods;
@property (nonatomic, strong) UITextView * returnDescription;
@property (nonatomic, strong) UILabel * returnDescriptionPlacehodler;
@property (nonatomic, strong) UIPickerView * reasonPickerView;
@property (nonatomic, strong) UIToolbar * pickerViewToolbar;
@property (nonatomic, strong) NSArray * reasonArray;
@property (nonatomic, strong) NSString * refund_reason;
@property (nonatomic, strong) NSString * refund_desc;

@end

@implementation E4_GoodsReturnCell_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

DEF_MODEL( UserModel, userModel);

DEF_OUTLET( BeeUIButton, select_reason )
DEF_OUTLET( BeeUIButton, return_goods )

- (void)load
{
    [self initData];
    [self initTextView];
    
    self.userModel = [UserModel modelWithObserver:self];
}

- (void)unload
{
    SAFE_RELEASE_MODEL( self.userModel );
}

- (void)dataDidChanged
{
    if (self.data)
    {
        _goods = self.data;
        
        $(@"#goods_img").IMAGE(_goods.img.thumbURL);
        $(@"#goods_name").TEXT(_goods.name);
        $(@"#goods_price").TEXT( _goods.formated_shop_price );
        $(@"#goods_count").TEXT( [NSString stringWithFormat:@"X %@", _goods.goods_number] );
    }
}

- (void)initTextView
{
    _returnDescription = [[UITextView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.03f, 165, SCREEN_WIDTH * 0.94f, 100)];
    _returnDescription.delegate = self;
    _returnDescription.font = [UIFont systemFontOfSize:14];
    _returnDescription.returnKeyType = UIReturnKeyDone;
    [self addSubview:_returnDescription];
    
    _returnDescriptionPlacehodler = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.03f + 5, 175, 200, 15)];
    _returnDescriptionPlacehodler.text = @"请填入退款说明";
    _returnDescriptionPlacehodler.font = [UIFont systemFontOfSize:14];
    _returnDescriptionPlacehodler.textColor = [UIColor darkGrayColor];
    [self addSubview:_returnDescriptionPlacehodler];
}

- (void)initData
{
    self.CANCEL_MSG( API.returnReason );
    self.MSG( API.returnReason );
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    NSString * description = textView.text;
    if (description.length == 0) {
        _returnDescriptionPlacehodler.text = @"请填入退款说明";
    } else {
        _returnDescriptionPlacehodler.text = @"";
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - button action
ON_SIGNAL3(E4_GoodsReturnCell_iPhone, select_reason, signal)
{
    [UIView animateWithDuration:0.5f animations:^{
        _pickerViewToolbar.frame = CGRectMake(0, SCREEN_HEIGHT - 230, SCREEN_WIDTH, 30);
        _reasonPickerView.frame = CGRectMake(0, SCREEN_HEIGHT - 200, SCREEN_WIDTH, 150);
    }];
}

- (void)initPickerView
{
    _reasonPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 30, SCREEN_WIDTH, 150)];
    _reasonPickerView.showsSelectionIndicator=YES;
    _reasonPickerView.delegate = self;
    _reasonPickerView.dataSource = self;
    [self addSubview:_reasonPickerView];
    
    _pickerViewToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 30)];
    _pickerViewToolbar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem * cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelButtonHandle:)];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonHandle:)];
    [cancelButton setTintColor:[UIColor colorWithRed:90.f/255.f green:90.f/255.f blue:90.f/255.f alpha:0.8]];
    [doneButton setTintColor:[UIColor colorWithRed:90.f/255.f green:90.f/255.f blue:90.f/255.f alpha:0.8]];
    UIBarButtonItem * flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem * fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    NSArray * itemArray = @[fixedSpace, cancelButton,
                            flexibleSpace, doneButton,
                            fixedSpace];
    [_pickerViewToolbar setItems:itemArray];
    [self addSubview:_pickerViewToolbar];
}

- (void)cancelButtonHandle:(UIButton *)btn
{
    [UIView animateWithDuration:0.5f animations:^{
        _pickerViewToolbar.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 30);
        _reasonPickerView.frame = CGRectMake(0, SCREEN_HEIGHT - 30, SCREEN_WIDTH, 150);
    }];
}

- (void)doneButtonHandle:(UIButton *)btn
{
    [UIView animateWithDuration:0.5f animations:^{
        _pickerViewToolbar.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 30);
        _reasonPickerView.frame = CGRectMake(0, SCREEN_HEIGHT - 30, SCREEN_WIDTH, 150);
    } completion:^(BOOL finished) {
        if (finished == YES) {
            NSInteger row = [_reasonPickerView selectedRowInComponent:0];
            NSString * reason = [_reasonArray objectAtIndex:row];
            
            $(@"#select_reason").TEXT(reason);
        }
    }];
}

ON_SIGNAL3(E4_GoodsReturnCell_iPhone, return_goods, signal)
{
    _refund_desc = _returnDescription.text;
    _refund_reason = self.select_reason.title;
    
    if ([_refund_reason isEqualToString:@"请选择原因"])
    {
        [self presentFailureTips:@"请选择退款原因"];
        return;
    }
    if ([_refund_desc isEqualToString:@""] || _refund_desc == nil)
    {
        [self presentFailureTips:@"请填入退款说明"];
        return;
    }

    self.CANCEL_MSG( API.returnGoods );
    self
    .MSG( API.returnGoods )
    .INPUT( @"session", self.userModel.session )
    .INPUT( @"rec_id", _goods.rec_id)
    .INPUT( @"refund_reason", _refund_reason)
    .INPUT( @"refund_desc", _refund_desc);
    
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _reasonArray.count;
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_reasonArray objectAtIndex:row];
}

ON_MESSAGE3(API, returnReason, msg )
{
    if(msg.sending)
    {
    }
    if (msg.succeed)
    {
        _reasonArray = msg.GET_OUTPUT(@"reasonArray");
        [self initPickerView];
    }
    if (msg.failed || msg.cancelled)
    {
        
    }
}

ON_MESSAGE3(API, returnGoods, msg)
{
    if (msg.sending)
    {
        [self presentLoadingTips:@"退款申请中..."];
    }
    else
    {
        
    }
    if (msg.succeed)
    {
        [self presentSuccessTips:@"退款申请成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)),    dispatch_get_main_queue(), ^{
            UIViewController * parent = [self findViewController:self];
            [parent.stack popBoardAnimated:YES];
        });
    }
    if (msg.failed)
    {
        [self presentFailureTips:@"退款申请提交失败，请重试"];
    }
    if (msg.cancelled)
    {
        [self presentFailureTips:@"退款申请提交失败，请重试"];
    }
}

- (UIViewController *)findViewController:(UIView *)sourceView
{
    id target = sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

@end
