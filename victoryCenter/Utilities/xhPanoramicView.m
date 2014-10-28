//
//  xhPanoramicView.m
//  xh_AccelerMonitor
//
//  Created by Xiaohe Hu on 6/2/14.
//  Copyright (c) 2014 Xiaohe Hu. All rights reserved.
//

#import "xhPanoramicView.h"
@interface xhPanoramicView ()

@property (nonatomic, strong) UIImage           *contentImage;
@property (nonatomic, strong) UIButton          *uib_ctrl;
@property (nonatomic, strong) UIView            *uiv_indicatorContainer;
@property (nonatomic, strong) UIImageView       *uiiv_smallPano;
@property (nonatomic, strong) UIImageView       *uiiv_smallFrame;
@end

@implementation xhPanoramicView
@synthesize uis_panoramic;

- (id)initWithFrame:(CGRect)frame andImageName:(NSString *)imageName
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSString *fileName = [[imageName lastPathComponent] stringByDeletingPathExtension];
        NSString *fileExt = [imageName pathExtension];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileExt];
        _contentImage = [UIImage imageWithContentsOfFile:filePath];
        imageWidth = _contentImage.size.width;
        imageHeight = _contentImage.size.height;
        [self initScrollView];
        
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.accelerometerUpdateInterval = 0.0;
        self.motionManager.gyroUpdateInterval = 0.0;
        [self initControlBtns];
        [self initIndicator];
    }
    return self;
}

-(void)initScrollView {
    uis_panoramic = [[UIScrollView alloc] initWithFrame:self.bounds];
    uis_panoramic.backgroundColor = [UIColor whiteColor];
    uis_panoramic.contentSize = CGSizeMake(imageWidth, imageHeight);
    uis_panoramic.pagingEnabled = NO;
    uis_panoramic.clipsToBounds = YES;
    uis_panoramic.showsVerticalScrollIndicator = NO;
    uis_panoramic.showsHorizontalScrollIndicator = NO;
    uis_panoramic.delegate = self;
    
    UIImageView *content = [[UIImageView alloc]initWithImage:_contentImage];
    content.frame = CGRectMake(0.0, 0.0, imageWidth, uis_panoramic.frame.size.height);
    [uis_panoramic addSubview: content];
    
    [self addSubview: uis_panoramic];
}

#pragma mark - Init Topright indicator
-(void)initIndicator
{
    _uiv_indicatorContainer = [[UIView alloc] initWithFrame:CGRectMake(888, 60.0, 91, 31)];
    [self insertSubview:_uiv_indicatorContainer aboveSubview:uis_panoramic];
    
    _uiiv_smallFrame = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pano_opportunity_local_nav_frame.png"]];
    _uiiv_smallFrame.frame = CGRectMake(0.0, 0.0, _uiiv_smallFrame.frame.size.width, _uiiv_smallFrame.frame.size.height);
    _uiiv_smallPano = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pano_opportunity_local_nav_bar.png"]];
    _uiiv_smallPano.frame = CGRectMake(0.0, 7.5, _uiiv_smallPano.frame.size.width, _uiiv_smallPano.frame.size.height);
    
    [_uiv_indicatorContainer addSubview:_uiiv_smallPano];
    [_uiv_indicatorContainer addSubview:_uiiv_smallFrame];
}

#pragma mark - Init Control Buttons
-(void)initControlBtns {
    _uib_ctrl = [UIButton buttonWithType:UIButtonTypeCustom];
    _uib_ctrl.frame = CGRectMake(800.0, 60.0, 50.0, 50.0);
    [_uib_ctrl setBackgroundColor:[UIColor clearColor]];
    [_uib_ctrl setImage:[UIImage imageNamed:@"pano_opportunity_local_button_gesture_off.png"] forState:UIControlStateNormal];
    [_uib_ctrl setImage:[UIImage imageNamed:@"pano_opportunity_local_button_gesture_on.png"] forState:UIControlStateSelected];
    [_uib_ctrl addTarget:self action:@selector(ctrlBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    _uib_ctrl.selected = NO;
    _uib_ctrl.backgroundColor = [UIColor clearColor];
    
    [self insertSubview:_uib_ctrl aboveSubview:uis_panoramic];
}

-(void)ctrlBtnTapped
{
    _uib_ctrl.selected = !_uib_ctrl.selected;
    if (_uib_ctrl.selected) {
        [self startMotionManager];
    }
    else {
        [self stopMotionManager];
    }
}
#pragma mark - Motion Manger Controller
-(void)startMotionManager {
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        [self changeScrollViewOffset1:accelerometerData.acceleration];
        if (error) {
            NSLog(@"%@",error);
        }
    }];
    
    [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMGyroData *gyrodata, NSError *error){
        [self changeScrollViewOffset2:gyrodata.rotationRate];
    }];
    
}
-(void)stopMotionManager {
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        nil;
        if (error) {
            NSLog(@"%@",error);
        }
    }];
    
    [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMGyroData *gyrodata, NSError *error){
        nil;
    }];
    
    [self.motionManager stopAccelerometerUpdates];
    [self.motionManager stopAccelerometerUpdates];
    
}

-(void)changeScrollViewOffset1:(CMAcceleration)acceleration {
    CGPoint offset = uis_panoramic.contentOffset;
    NSLog(@"%f",acceleration.y);
    
    offset.x = offset.x+acceleration.y*5;
    
    if (offset.x < 0) {
        offset.x = 0;
    }
    if (offset.x > (imageWidth - self.frame.size.width)) {
        offset.x = (imageWidth - self.frame.size.width);
    }
    [uis_panoramic setContentOffset:offset];
    
   float indicatorMove =  (offset.x /self.uis_panoramic.contentSize.width * 65);
    _uiiv_smallFrame.transform = CGAffineTransformMakeTranslation(indicatorMove, 0.0);
}
-(void)changeScrollViewOffset2:(CMRotationRate)rotation {
    CGPoint offset = uis_panoramic.contentOffset;
    NSLog(@"%f",rotation.x);
    
    offset.x = offset.x+rotation.x*5;
    
    if (offset.x < 0) {
        offset.x = 0;
    }
    if (offset.x >  (imageWidth - self.frame.size.width)) {
        offset.x =  (imageWidth - self.frame.size.width);
    }
    
    [uis_panoramic setContentOffset:offset];
    
    float indicatorMove =  (offset.x /self.uis_panoramic.contentSize.width * 65);
    _uiiv_smallFrame.transform = CGAffineTransformMakeTranslation(indicatorMove, 0.0);
}

#pragma mark - Scroll View Delegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = uis_panoramic.contentOffset;
    float indicatorMove =  (offset.x /self.uis_panoramic.contentSize.width * 65);
    _uiiv_smallFrame.transform = CGAffineTransformMakeTranslation(indicatorMove, 0.0);
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
