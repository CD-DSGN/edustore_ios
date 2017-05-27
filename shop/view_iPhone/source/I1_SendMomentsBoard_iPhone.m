//
//  I1_SendMomentsBoard_iPhone.m
//  shop
//
//  Created by guangnian dashu on 2016/11/8.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "I1_SendMomentsBoard_iPhone.h"
#import "I1_SendMomentsBoardCell_iPhone.h"
#import "PhotoBrowserViewController.h"
@implementation I1_SendMomentsBoard_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

- (void)load
{
    self.textViewSendContent = [[UITextView alloc] init];
    self.textViewPlaceholder = [[UILabel alloc] init];
    self.scrollView = [[UIScrollView alloc] init];
}

- (void)unload
{
    self.textViewSendContent = nil;
    self.textViewPlaceholder = nil;
    self.scrollView = nil;
}
-(NSMutableArray *)photoArray
{
    if (!_photoArray) {
        _photoArray = [NSMutableArray array];
        [_photoArray retain];
    }
    return _photoArray;
}

#pragma mark -

ON_CREATE_VIEWS( signal )
{
    self.scrollView.frame = CGRectMake(0, 70, SCREEN_WIDTH, SCREEN_HEIGHT-70);
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-68);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
    self.textViewSendContent.textColor = [UIColor blackColor];
    self.textViewSendContent.font = [UIFont fontWithName:@"Arial" size:18];
    self.textViewSendContent.returnKeyType = UIReturnKeyDefault;
    self.textViewSendContent.keyboardType = UIKeyboardTypeDefault;
    self.textViewSendContent.scrollEnabled = YES;
    self.textViewSendContent.delegate = self;
//    self.textViewSendContent.showsVerticalScrollIndicator = NO;
    self.textViewSendContent.frame = CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT-70) /3.0 );
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:)
                                                name:@"UITextViewTextDidChangeNotification"
                                              object:self.textViewSendContent];
    
    
    self.textViewPlaceholder.frame = CGRectMake(5, 0, SCREEN_WIDTH, 40);
    self.textViewPlaceholder.text = __TEXT(@"moments_send");
    self.textViewPlaceholder.textColor = [UIColor grayColor];
    self.textViewPlaceholder.font = [UIFont fontWithName:@"Arial" size:18];
    
    UIImageView *seperatorLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fengexian"]];
    seperatorLine.frame = CGRectMake(5, CGRectGetMaxY(self.textViewSendContent.frame), SCREEN_WIDTH - 10, 1);
    seperatorLine.contentMode = UIViewContentModeScaleAspectFit;
    seperatorLine.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    seperatorLine.layer.cornerRadius = 0.5;
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.textViewSendContent];
    [self.scrollView addSubview:self.textViewPlaceholder];
    
    [self.scrollView addSubview:self.collectionView];
    [self.scrollView addSubview:seperatorLine];
//    UIPinchGestureRecognizer * recognizer = [[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)] autorelease];
//    [self.textViewSendContent addGestureRecognizer:recognizer];
}
static NSString *photoId = @"PhotoCell";
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 50)/3.0, (SCREEN_WIDTH - 50)/3.0);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.textViewSendContent.frame), SCREEN_WIDTH, layout.itemSize.height + 20) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.contentInset = UIEdgeInsetsMake(10, 15, 10, 15);
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[I1_SendMomentsBoardCell_iPhone class] forCellWithReuseIdentifier:photoId];
    }
    return _collectionView;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoArray.count + 1 > 3? 3 : self.photoArray.count + 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    I1_SendMomentsBoardCell_iPhone *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoId forIndexPath:indexPath];
    if (_photoArray.count != 0) {
        if (_photoArray.count == 3) {
            cell.photoImageView.image = self.photoArray[indexPath.row];
        }
        else {
            cell.photoImageView.image = indexPath.row == self.photoArray.count ? [UIImage imageNamed:@"tianjiazhaopian"] : self.photoArray[indexPath.item];
        }

    }else {
        cell.photoImageView.image = [UIImage imageNamed:@"tianjiazhaopian"];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.photoArray.count != 3 && indexPath.row == self.photoArray.count) {
        UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
            picker.delegate = self;
            picker.allowsEditing = YES;//设置可编辑
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //进入照相界面
            [self presentViewController:picker animated:YES completion:nil];
        }];
        UIAlertAction *actionPhotoLibrary = [UIAlertAction actionWithTitle:@"从手机相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            TZImagePickerController *imagePickerController = [[TZImagePickerController alloc]initWithMaxImagesCount:3 - _photoArray.count delegate:self];
            imagePickerController.allowTakePicture = NO;
            [self presentViewController:imagePickerController animated:YES completion:nil];
            [imagePickerController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isOriginal) {
                [self.photoArray addObjectsFromArray:photos];
                [self.collectionView reloadData];
            }];
            
        }];
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [sheet addAction:actionCamera];
        [sheet addAction:actionPhotoLibrary];
        [sheet addAction:actionCancel];
        [self presentViewController:sheet animated:YES completion:nil];
        
    }
    else {
        PhotoBrowserViewController *photoBrowser = [[PhotoBrowserViewController alloc]init];
        [photoBrowser retain];
        photoBrowser.index = indexPath.row;
        photoBrowser.imageArray = _photoArray;
        [photoBrowser.imageArray retain];
        [photoBrowser setDeletePhoto:^(NSInteger index){
            [self.photoArray removeObjectAtIndex:index];
            [self.collectionView reloadData];
        }];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:photoBrowser] animated:NO completion:nil];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.photoArray addObject:[self fixOrientation: image]];
    
    [self.collectionView reloadData];
    [picker release];
}
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;  
    }  
    
    // And now we just create a new UIImage from the drawing context  
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);  
    UIImage *img = [UIImage imageWithCGImage:cgimg];  
    CGContextRelease(ctx);  
    CGImageRelease(cgimg);  
    return img;  
}
ON_DELETE_VIEWS( signal )
{
    
}

ON_LAYOUT_VIEWS( signal )
{
}

ON_WILL_APPEAR( signal )
{
    
}

ON_DID_APPEAR( signal )
{
}

ON_WILL_DISAPPEAR( signal )
{
}

ON_DID_DISAPPEAR( signal )
{
}


ON_SIGNAL3( I1_SendMomentsBoard_iPhone, back, signal )
{
    UIAlertController * ac = [UIAlertController alertControllerWithTitle:@"是否退出编辑？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [ac addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [ac addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        
    }]];
    
    [self presentViewController:ac animated:NO completion:nil];
}

ON_SIGNAL3( I1_SendMomentsBoard_iPhone, send, signal )
{
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    long long time = [[NSNumber numberWithDouble:now] longLongValue];
    NSString * curTime = [NSString stringWithFormat:@"%llu", time];

    NSString * content = [[NSString stringWithString:self.textViewSendContent.text] trim];
    NSMutableArray *imageArray = [NSMutableArray array];
    
    for (int i = 0; i < _photoArray.count; i ++) {
        UIImage *image = _photoArray[i];
        NSData * imageData = UIImageJPEGRepresentation(image, 0.1);
        if (imageData != nil)
        {
            // 将图片Base 64编码
            NSString * imageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            [imageStr retain];
            [imageArray addObject:imageStr];
        }
    }
    if (content.length == 0)
    {
        [self presentFailureTips:__TEXT(@"moments_null")];
    }
    else
    {
        self.CANCEL_MSG( API.teacher_publish );
        self.MSG( API.teacher_publish )
        .INPUT( @"time", curTime)
        .INPUT( @"content", content)
        .INPUT( @"publish_images", imageArray);

    }
}

#pragma mark - function
    
- (void)adjustTextView:(UITextView *)textView
{
    // 获取的是距textView头部的距离，我需要的是减去滑动之后的距离
    CGFloat currentPosition;
    if (textView.selectedTextRange)
    {
        currentPosition = [textView caretRectForPosition:textView.selectedTextRange.start].origin.y;
    }
    else
    {
        currentPosition = 0;
    }
    // 多预留一些空间，以应对字体改变
    if (currentPosition > 200)
    {
        CGRect temp = CGRectMake(0, currentPosition, SCREEN_WIDTH, 60);
        CGRect textViewFrame = [self.scrollView convertRect:temp fromView:textView];
        
//        [self.scrollView scrollRectToVisible:textViewFrame animated:YES];
        [self.textViewSendContent scrollRectToVisible:textViewFrame animated:YES];
    }
}

//- (void)handlePan:(UIPanGestureRecognizer *)recognizer
//{
//    [self.textViewSendContent resignFirstResponder];
//}

#pragma mark - UITextView delegate
    
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    return YES;
}
    
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView)
    {
        [self.textViewSendContent resignFirstResponder];
    }
}
    
- (void)textViewDidChange:(UITextView *)textView
{
    NSString * content = [NSString stringWithString:self.textViewSendContent.text];
    
    if ([content isEqualToString:@""])
    {
//        [self.scrollView addSubview:self.textViewPlaceholder];
        self.textViewPlaceholder.text = __TEXT(@"moments_send");
        
    }
    else
    {
//        [self.textViewPlaceholder removeFromSuperview];
        self.textViewPlaceholder.text = @"";
    }
    
//    CGSize size = [content sizeWithFont:[self.textViewPlaceholder font] byWidth:320];
//    NSInteger lineNumber = (NSInteger)(size.height / [self.textViewPlaceholder font].lineHeight);
}
    
// 用户选中时对frame进行调整
//- (void)textViewDidBeginEditing:(UITextView *)textView
//{
//    self.textViewSendContent.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.5f); // 减去键盘高度
//    // [self performSelector:@selector(adjustTextView:) withObject:textView afterDelay:0.5f];
//}

//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//    self.textViewSendContent.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-70);
//}

/**
 限制文本输入框字数
 */
-(void)textViewEditChanged:(NSNotification *)obj{
    UITextView *textView = (UITextView *)obj.object;
    
    NSString *toBeString = textView.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > 500) {
                textView.text = [toBeString substringToIndex:500];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > 500) {
            textView.text = [toBeString substringToIndex:500];
        }
    }
}

#pragma mark - 教师发送汇师圈消息
ON_MESSAGE3( API, teacher_publish, msg )
{
    if ( msg.sending )
    {
        [self.textViewSendContent resignFirstResponder];
        [self presentMessageTips:__TEXT(@"moments_sending")];
    }
    else
    {
        [self dismissTips];
    }
    if ( msg.succeed )
    {
        NSString * data = msg.GET_OUTPUT(@"data");
        if ([data isEqualToString:@"1"])
        {
            [self presentSuccessTips:__TEXT(@"moments_success")];
            [self performSelector:@selector(dismissViewController) withObject:self afterDelay:1.0f];
        }
        else
        {
            [self presentFailureTips:__TEXT(@"moments_error")];
        }
    }
    if ( msg.failed )
    {
        [self presentFailureTips:__TEXT(@"moments_error")];
    }
}

- (void)dismissViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
