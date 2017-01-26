//
//  PhotoBrowserViewController.m
//  shop
//
//  Created by 田明飞 on 2017/1/17.
//  Copyright © 2017年 geek-zoo studio. All rights reserved.
//

#import "PhotoBrowserViewController.h"

@interface PhotoBrowserViewController ()<UIScrollViewDelegate>


@property (nonatomic,strong) NSMutableArray *imageViewArray;

@property (nonatomic,strong) UIView *backgroudView;

@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UIPageControl *pageControl;

@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation PhotoBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"%ld/%ld",_index + 1, _imageArray.count];
    [self navigationBarSetting];
    [self addSubViews];
}

-(NSMutableArray *)imageViewArray
{
    if (!_imageViewArray) {
        _imageViewArray = [NSMutableArray array];
        [_imageViewArray retain];
    }
    return _imageViewArray;
}
-(void)navigationBarSetting
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"shanchu"] style:UIBarButtonItemStylePlain target:self action:@selector(deleteImage:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(dismiss:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}
-(void)addSubViews
{
    
    _backgroudView=[[UIView alloc]initWithFrame:self.view.bounds];
    [_backgroudView retain];
    _backgroudView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:_backgroudView];
    
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_scrollView retain];
    _scrollView.backgroundColor=[UIColor blackColor];
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    UITapGestureRecognizer *cancelTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap:)];
    [_scrollView addGestureRecognizer:cancelTap];
    [_backgroudView addSubview:_scrollView];
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        visualEffectView.frame = _backgroudView.bounds;
        [_backgroudView addSubview:visualEffectView];
        [visualEffectView addSubview:_scrollView];
    }
    
    for (int i=0; i<_imageArray.count; i++) {
        UIScrollView *imageScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [imageScrollView retain];
        //设置实现缩放
        //设置代理scrollview的代理对象
        //            imageScrollView.clipsToBounds=YES;
        imageScrollView.decelerationRate = UIScrollViewDecelerationRateFast;
        imageScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageScrollView.delegate=self;
        //设置最大伸缩比例
        imageScrollView.maximumZoomScale=5.0;
        //设置最小伸缩比例
        imageScrollView.minimumZoomScale=0.1;
        imageScrollView.tag=200+i;
        imageScrollView.backgroundColor=[UIColor clearColor];
        [_scrollView addSubview:imageScrollView];
        
        //           _imageViewNew=[[REDImageView alloc]initWithFrame1:imageScrollView.bounds];
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_imageView retain];
        _imageView.userInteractionEnabled = YES;
        
        _imageView.image = _imageArray[i];
            
            //                _imageViewNew.center=CGPointMake(SCREEN_Width/2, imageScrollView.frame.size.height/2);
            if (_imageView.image.size.width>SCREEN_WIDTH&&_imageView.image.size.height/3>SCREEN_HEIGHT) {
                
                float i=_imageView.image.size.width/_imageView.image.size.height;
                if (i<0.5) {
                    UIGraphicsBeginImageContext(CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/i));  //size 为CGSize类型，即你所需要的图片尺寸
                    [_imageView.image drawInRect:CGRectMake(0, 0, CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/i).width, CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/i).height)];
                    _imageView.image = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                    
                    
                    _imageView.contentMode=UIViewContentModeScaleAspectFill;
                    _imageView.clipsToBounds=NO;
                    _imageView.frame=CGRectMake(0, 0, SCREEN_WIDTH, _imageView.image.size.height);
                }else{
                    _imageView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                    _imageView.contentMode=UIViewContentModeScaleAspectFit;
                    _imageView.clipsToBounds=NO;
                }
                
                
                
            }else if (_imageView.image.size.width/2>SCREEN_WIDTH){
                _imageView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                _imageView.contentMode=UIViewContentModeScaleAspectFit;
                _imageView.clipsToBounds=NO;
                
            }else{
                _imageView.contentMode=UIViewContentModeScaleAspectFit;
                _imageView.clipsToBounds=YES;
            }
            
            _imageView.backgroundColor=[UIColor blackColor];
            imageScrollView.contentSize=CGSizeMake(SCREEN_WIDTH, _imageView.frame.size.height);
            
            
            
            [imageScrollView addSubview:_imageView];
            [self.imageViewArray addObject:_imageView];
            
        
        _imageView.tag = i;

    }
    _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH*_imageArray.count, SCREEN_HEIGHT);
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x+_scrollView.frame.size.width*_index, 0) animated:NO];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, _scrollView.frame.size.height-30, SCREEN_WIDTH, 30)];
    [_pageControl retain];
    _pageControl.numberOfPages = _imageArray.count;
    _pageControl.tintColor = [UIColor whiteColor];
    _pageControl.currentPage=_index;
    [_backgroudView addSubview:_pageControl];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if (scrollView != _scrollView) {
        return _imageViewArray[scrollView.tag-200];
    }
    
    else {
        return nil;
    }
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    if (view.frame.size.height<SCREEN_HEIGHT) {
        ((UIImageView *)_imageViewArray[scrollView.tag-200]).center=CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    }else{
        
    }
}



-(void)cancelTap:(id)sender{
    self.navigationController.navigationBar.hidden = !self.navigationController.navigationBar.hidden;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //    if ([scrollView isEqual:_scrollView]) {
    CGFloat pageWith = _scrollView.frame.size.width;
    //根据scrolView的左右滑动,对pageCotrol的当前指示器进行切换(设置currentPage)
    int page = floor((_scrollView.contentOffset.x - pageWith/2)/pageWith)+1;
    //切换改变页码，小圆点
    _pageControl.currentPage = page;
    self.title = [NSString stringWithFormat:@"%.0f/%ld",scrollView.contentOffset.x/SCREEN_WIDTH + 1, _imageArray.count];


}

-(void)deleteImage:(UIBarButtonItem*)item
{
    _deletePhoto((NSInteger)(_scrollView.contentOffset.x/SCREEN_WIDTH));
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)dismiss:(UIBarButtonItem*)item
{
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
