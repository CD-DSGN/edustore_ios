//
//  I0_MomentsPhotoCell_iPhone.m
//  shop
//
//  Created by guangnian dashu on 2016/11/24.
//  Copyright © 2016年 geek-zoo studio. All rights reserved.
//

#import "I0_MomentsSinglePhotoCell_iPhone.h"
#import "I0_MomentsBorad_iPhone.h"
#import "I2_MomentsPhotoBoard_iPhone.h"
#import "I0_MomentsCell_iPhone.h"
#import "AppBoard_iPhone.h"
#import "SinglePhotoBrowerViewController.h"
#define IMAGEWIDTH   (SCREEN_WIDTH - 50 - 20 * 3)/3.0
#define IMAGEHEIGHT  (SCREEN_WIDTH - 50 - 20 * 3)/3.0
#define IMAGELEFT    50.0f
#define BLANKHEIGHT  10.0f

@implementation I0_MomentsSinglePhotoCell_iPhone

SUPPORT_AUTOMATIC_LAYOUT( YES )
SUPPORT_RESOURCE_LOADING( YES )

- (void)load
{
    
}

- (void)unload
{
}



- (void)dataDidChanged
{
    if (self.data)
    {
        
        MOMENTS * moments = self.data;
        NSArray * photo_array = moments.publish_info.photo_array;
        NSDictionary * photo = [photo_array objectAtIndex:0];
        
        if (![[photo objectForKey:@"thumb_height"] isEqual:[NSNull null]]) {
            NSInteger height = [[photo objectForKey:@"thumb_height"] integerValue];
            NSInteger width = [[photo objectForKey:@"thumb_width"] integerValue];
            if (height > width ) {
                CGFloat temp = 140 * height /(width * 1.0);
                NSString *tempString = [NSString stringWithFormat:@"height: %fpx", temp];
                $(@"#big_photo").CSS(tempString);
                $(@"#photo_button").CSS(tempString);
                $(@"#big_photo").CSS(@"width: 140px;");
            }else {
                CGFloat temp = 140 * width /(height * 1.0);
                NSString *tempString = [NSString stringWithFormat:@"width: %fpx", temp];
                $(@"#big_photo").CSS(tempString);
                $(@"#photo_button").CSS(tempString);
                $(@"#big_photo").CSS(@"height: 140px;");
            }
            
            $(@"#big_photo").IMAGE([photo objectForKey:@"img_thumb"]);
        }else {
            $(@"#big_photo").CSS(@"width: 140px");
            $(@"#big_photo").CSS(@"height: 140px;");
            $(@"#big_photo").IMAGE([UIImage imageNamed:@"huishi_icon_backup"]);
            
        }
        
        
        
        // 消除复用影响代价最小的想法（目前）
//        for (NSInteger i = photo_count; i < 9; i++) {
//            BeeUIImageView * imageCell = [[BeeUIImageView alloc] initWithFrame:CGRectMake((IMAGELEFT + (IMAGEWIDTH+BLANKHEIGHT)*(i%3)), ((IMAGEHEIGHT+BLANKHEIGHT)*(i/3)), SCREEN_WIDTH, IMAGEHEIGHT)];
//            if ( i%3 == 0 ) {
//                [imageCell setFrame:CGRectMake(0, ((IMAGEHEIGHT+BLANKHEIGHT)*(i/3)), SCREEN_WIDTH, IMAGEHEIGHT)];
//            }
//            [imageCell setBackgroundColor:[UIColor clearColor]];
//            [imageView addSubview:imageCell];
//        }


    }
}

ON_SIGNAL3(I0_MomentsSinglePhotoCell_iPhone, photo_button, signal)
{
    
    MOMENTS * moments = self.data;
    if ([[moments.publish_info.photo_array.firstObject objectForKey:@"img"] isMemberOfClass:[UIImage class]]) {
        return;
    }
    SinglePhotoBrowerViewController * board = [[SinglePhotoBrowerViewController alloc]init];
    board.imageArray = moments.publish_info.photo_array;
    board.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //    board.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    board.index = 0;
    [[AppBoard_iPhone sharedInstance] presentViewController:board animated:YES completion:nil];
}


// 不用代理，使用根类的单例
- (void)openBig:(UITapGestureRecognizer *)tapRecongnizer
{
    MOMENTS * moments = self.data;
//    if (moments.publish_info.photo_array.count == 1) {
        SinglePhotoBrowerViewController * board = [[SinglePhotoBrowerViewController alloc]init];
        board.imageArray = moments.publish_info.photo_array;
        board.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        //    board.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    board.index = tapRecongnizer.view.tag;
        [[AppBoard_iPhone sharedInstance] presentViewController:board animated:YES completion:nil];
        
        
//    }
//    else {
//        I2_MomentsPhotoBoard_iPhone * board = [I2_MomentsPhotoBoard_iPhone board];
//        [board retain];
//        board.moments = self.data;
//        
//        board.pageIndex = tapRecongnizer.view.tag;
//    
//    
//        board.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        //    board.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
//        
//        [[AppBoard_iPhone sharedInstance] presentViewController:board animated:YES completion:nil];
    
        // 在当前view中的位置，但我需要的是其在window中的位置
        // CGPoint location = [tapRecongnizer locationInView:self];
//    }
}

//- (void)dataDidChanged
//{
////    现在的做法是把图片的容器写好放在这，需要就往里面填内容，不需要就隐藏，ER。。
////    穷举法，最蠢的做法。。。
//    if (self.data)
//    {
//        MOMENTS * moments = self.data;
//        NSArray * photo_array = moments.publish_info.photo_array;
//        NSInteger photo_count = photo_array.count;
//        
//        $(@"#photo_one").HIDE().IMAGE(@"");
//        $(@"#photo_two").HIDE().IMAGE(@"");
//        $(@"#photo_three").HIDE().IMAGE(@"");
//        $(@"#photo_four").HIDE().IMAGE(@"");
//        $(@"#photo_five").HIDE().IMAGE(@"");
//        $(@"#photo_six").HIDE().IMAGE(@"");
//        $(@"#photo_seven").HIDE().IMAGE(@"");
//        $(@"#photo_eight").HIDE().IMAGE(@"");
//        $(@"#photo_nine").HIDE().IMAGE(@"");
//        
//        switch (photo_count) {
//            case 1:
//                $(@"#photo_one").SHOW().IMAGE( [[photo_array objectAtIndex:0] objectForKey:@"thumb"] );
//                break;
//            case 2:
//                $(@"#photo_one").SHOW().IMAGE( [[photo_array objectAtIndex:0] objectForKey:@"thumb"] );
//                $(@"#photo_two").SHOW().IMAGE( [[photo_array objectAtIndex:1] objectForKey:@"thumb"] );
//                break;
//            case 3:
//                $(@"#photo_one").SHOW().IMAGE( [[photo_array objectAtIndex:0] objectForKey:@"thumb"] );
//                $(@"#photo_two").SHOW().IMAGE( [[photo_array objectAtIndex:1] objectForKey:@"thumb"] );
//                $(@"#photo_three").SHOW().IMAGE( [[photo_array objectAtIndex:2] objectForKey:@"thumb"] );
//                break;
//            case 4:
//                $(@"#photo_one").SHOW().IMAGE( [[photo_array objectAtIndex:0] objectForKey:@"thumb"] );
//                $(@"#photo_two").SHOW().IMAGE( [[photo_array objectAtIndex:1] objectForKey:@"thumb"] );
//                $(@"#photo_four").SHOW().IMAGE( [[photo_array objectAtIndex:2] objectForKey:@"thumb"] ).CSS(@"left: -168.2px");
//                $(@"#photo_five").SHOW().IMAGE( [[photo_array objectAtIndex:3] objectForKey:@"thumb"] );
//                break;
//            case 5:
//                $(@"#photo_one").SHOW().IMAGE( [[photo_array objectAtIndex:0] objectForKey:@"thumb"] );
//                $(@"#photo_two").SHOW().IMAGE( [[photo_array objectAtIndex:1] objectForKey:@"thumb"] );
//                $(@"#photo_three").SHOW().IMAGE( [[photo_array objectAtIndex:2] objectForKey:@"thumb"] );
//                $(@"#photo_four").SHOW().IMAGE( [[photo_array objectAtIndex:3] objectForKey:@"thumb"] );
//                $(@"#photo_five").SHOW().IMAGE( [[photo_array objectAtIndex:4] objectForKey:@"thumb"] );
//                break;
//            case 6:
//                $(@"#photo_one").SHOW().IMAGE( [[photo_array objectAtIndex:0] objectForKey:@"thumb"] );
//                $(@"#photo_two").SHOW().IMAGE( [[photo_array objectAtIndex:1] objectForKey:@"thumb"] );
//                $(@"#photo_three").SHOW().IMAGE( [[photo_array objectAtIndex:2] objectForKey:@"thumb"] );
//                $(@"#photo_four").SHOW().IMAGE( [[photo_array objectAtIndex:3] objectForKey:@"thumb"] );
//                $(@"#photo_five").SHOW().IMAGE( [[photo_array objectAtIndex:4] objectForKey:@"thumb"] );
//                $(@"#photo_six").SHOW().IMAGE( [[photo_array objectAtIndex:5] objectForKey:@"thumb"] );
//                break;
//            case 7:
//                $(@"#photo_one").SHOW().IMAGE( [[photo_array objectAtIndex:0] objectForKey:@"thumb"] );
//                $(@"#photo_two").SHOW().IMAGE( [[photo_array objectAtIndex:1] objectForKey:@"thumb"] );
//                $(@"#photo_three").SHOW().IMAGE( [[photo_array objectAtIndex:2] objectForKey:@"thumb"] );
//                $(@"#photo_four").SHOW().IMAGE( [[photo_array objectAtIndex:3] objectForKey:@"thumb"] );
//                $(@"#photo_five").SHOW().IMAGE( [[photo_array objectAtIndex:4] objectForKey:@"thumb"] );
//                $(@"#photo_six").SHOW().IMAGE( [[photo_array objectAtIndex:5] objectForKey:@"thumb"] );
//                $(@"#photo_seven").SHOW().IMAGE( [[photo_array objectAtIndex:6] objectForKey:@"thumb"] );
//                break;
//            case 8:
//                $(@"#photo_one").SHOW().IMAGE( [[photo_array objectAtIndex:0] objectForKey:@"thumb"] );
//                $(@"#photo_two").SHOW().IMAGE( [[photo_array objectAtIndex:1] objectForKey:@"thumb"] );
//                $(@"#photo_three").SHOW().IMAGE( [[photo_array objectAtIndex:2] objectForKey:@"thumb"] );
//                $(@"#photo_four").SHOW().IMAGE( [[photo_array objectAtIndex:3] objectForKey:@"thumb"] );
//                $(@"#photo_five").SHOW().IMAGE( [[photo_array objectAtIndex:4] objectForKey:@"thumb"] );
//                $(@"#photo_six").SHOW().IMAGE( [[photo_array objectAtIndex:5] objectForKey:@"thumb"] );
//                $(@"#photo_seven").SHOW().IMAGE( [[photo_array objectAtIndex:6] objectForKey:@"thumb"] );
//                $(@"#photo_eight").SHOW().IMAGE( [[photo_array objectAtIndex:7] objectForKey:@"thumb"] );
//                break;
//            case 9:
//                $(@"#photo_one").SHOW().IMAGE( [[photo_array objectAtIndex:0] objectForKey:@"thumb"] );
//                $(@"#photo_two").SHOW().IMAGE( [[photo_array objectAtIndex:1] objectForKey:@"thumb"] );
//                $(@"#photo_three").SHOW().IMAGE( [[photo_array objectAtIndex:2] objectForKey:@"thumb"] );
//                $(@"#photo_four").SHOW().IMAGE( [[photo_array objectAtIndex:3] objectForKey:@"thumb"] );
//                $(@"#photo_five").SHOW().IMAGE( [[photo_array objectAtIndex:4] objectForKey:@"thumb"] );
//                $(@"#photo_six").SHOW().IMAGE( [[photo_array objectAtIndex:5] objectForKey:@"thumb"] );
//                $(@"#photo_seven").SHOW().IMAGE( [[photo_array objectAtIndex:6] objectForKey:@"thumb"] );
//                $(@"#photo_eight").SHOW().IMAGE( [[photo_array objectAtIndex:7] objectForKey:@"thumb"] );
//                $(@"#photo_nine").SHOW().IMAGE( [[photo_array objectAtIndex:8] objectForKey:@"thumb"] );
//                break;
//            default:
//                break;
//        }
//        
//    }
//}

@end
