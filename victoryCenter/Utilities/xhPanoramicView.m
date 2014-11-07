//
//  xhPanoramicView.m
//  xh_AccelerMonitor
//
//  Created by Xiaohe Hu on 6/2/14.
//  Copyright (c) 2014 Xiaohe Hu. All rights reserved.
//

#import "xhPanoramicView.h"
#import "UIColor+Extensions.h"
#import "CMPopTipView.h"

@interface xhPanoramicView ()<CMPopTipViewDelegate>

@property (nonatomic, strong) UIImage           *contentImage;
//@property (nonatomic, strong) UIButton          *uib_ctrl;
@property (nonatomic, strong) UIView            *uiv_indicatorContainer;
@property (nonatomic, strong) UIImageView       *uiiv_smallPano;
@property (nonatomic, strong) UIButton          *uib_smallFrame;

// Help tip view
@property (nonatomic, strong) NSMutableArray                *arr_helpText;
@property (nonatomic, strong) NSMutableArray                *visiblePopTipViews;
@property (nonatomic, strong) NSMutableArray                *arr_helpTargetViews;
@property (nonatomic, strong) UIView                        *uiv_helpContianer;
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
//        [self initControlBtns];
        [self initIndicator];
        [self prepareHlepData];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideAndUnhideHelp:) name:@"hideAndUnhideHelp" object:nil];
    return self;
}

-(void)initScrollView {
    uis_panoramic = [[UIScrollView alloc] initWithFrame:screenRect];
    uis_panoramic.backgroundColor = [UIColor vcBackGroundColor];
    uis_panoramic.contentSize = CGSizeMake(imageWidth*(768/imageHeight), 768);
    uis_panoramic.pagingEnabled = NO;
    uis_panoramic.clipsToBounds = YES;
    uis_panoramic.showsVerticalScrollIndicator = NO;
    uis_panoramic.showsHorizontalScrollIndicator = NO;
    uis_panoramic.delegate = self;
    
    UIImageView *content = [[UIImageView alloc]initWithImage:_contentImage];
    content.frame = CGRectMake(0.0, 0.0, uis_panoramic.contentSize.width, uis_panoramic.contentSize.height);
    content.contentMode = UIViewContentModeScaleToFill;
    [uis_panoramic addSubview: content];
    
    [self addSubview: uis_panoramic];
}

#pragma mark - Init Topright indicator
-(void)initIndicator
{
    _uiv_indicatorContainer = [[UIView alloc] initWithFrame:CGRectMake(888, 50.0, 91, 68)];
    [self insertSubview:_uiv_indicatorContainer aboveSubview:uis_panoramic];
    
    _uiiv_smallPano = [[UIImageView alloc] initWithImage:[self adjustImageSizeWhenCropping:_contentImage]];
    _uiiv_smallPano.frame = CGRectMake(0.0, abs(68 - _uiiv_smallPano.frame.size.height)/2, _uiiv_smallPano.frame.size.width, _uiiv_smallPano.frame.size.height);
    UIImage *frameImge = [UIImage imageNamed:@"Tilit_Icon_Off.png"];
    _uib_smallFrame = [UIButton buttonWithType:UIButtonTypeCustom];
    _uib_smallFrame.frame = CGRectMake(-18.0, (68 - frameImge.size.height)/2, frameImge.size.width, frameImge.size.height);
    [_uib_smallFrame setImage:[UIImage imageNamed:@"Tilit_Icon_Off.png"] forState:UIControlStateNormal];
    [_uib_smallFrame setImage:[UIImage imageNamed:@"Tilit_Icon_On.png"] forState:UIControlStateSelected];
    [_uib_smallFrame addTarget:self action:@selector(ctrlBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [_uiv_indicatorContainer addSubview:_uiiv_smallPano];
    [_uiv_indicatorContainer addSubview:_uib_smallFrame];
    _uiv_indicatorContainer.frame = CGRectMake(1024 - _uiiv_smallPano.frame.size.width - 30, 50.0, _uiiv_smallPano.frame.size.width, 68);
}

#pragma mark - Resize the image to fit top indicator
-(UIImage *)adjustImageSizeWhenCropping:(UIImage *)image
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    
    float ratio=40/actualHeight;
    actualWidth = actualWidth*ratio;
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, 40);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1.0);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

#pragma mark - Init Control Buttons
//-(void)initControlBtns {
//    _uib_ctrl = [UIButton buttonWithType:UIButtonTypeCustom];
//    _uib_ctrl.frame = CGRectMake(800.0, 60.0, 50.0, 50.0);
//    [_uib_ctrl setBackgroundColor:[UIColor clearColor]];
//    [_uib_ctrl setImage:[UIImage imageNamed:@"pano_opportunity_local_button_gesture_off.png"] forState:UIControlStateNormal];
//    [_uib_ctrl setImage:[UIImage imageNamed:@"pano_opportunity_local_button_gesture_on.png"] forState:UIControlStateSelected];
//    [_uib_ctrl addTarget:self action:@selector(ctrlBtnTapped) forControlEvents:UIControlEventTouchUpInside];
//    _uib_ctrl.selected = NO;
//    _uib_ctrl.backgroundColor = [UIColor clearColor];
//    
//    [self insertSubview:_uib_ctrl aboveSubview:uis_panoramic];
//}

-(void)ctrlBtnTapped
{
//    _uib_ctrl.selected = !_uib_ctrl.selected;
//    if (_uib_ctrl.selected) {
    _uib_smallFrame.selected = !_uib_smallFrame.selected;
    if (_uib_smallFrame.selected) {
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
//    NSLog(@"%f",acceleration.y);
    
    offset.x = offset.x+acceleration.y;

    if (offset.x < 0) {
        offset.x = 0;
    }
    if (offset.x > (uis_panoramic.contentSize.width - self.frame.size.width)) {
        offset.x = (uis_panoramic.contentSize.width - self.frame.size.width);
    }
    [uis_panoramic setContentOffset:offset];
    
   float indicatorMove =  (offset.x /uis_panoramic.contentSize.width) * _uiiv_smallPano.frame.size.width + 5.0;
    _uib_smallFrame.transform = CGAffineTransformMakeTranslation(indicatorMove, 0.0);
}
-(void)changeScrollViewOffset2:(CMRotationRate)rotation {
    CGPoint offset = uis_panoramic.contentOffset;
//    NSLog(@"%f",rotation.x);
    
    offset.x = offset.x+rotation.x;
    
    if (offset.x < 0) {
        offset.x = 0;
    }
    if (offset.x >  (uis_panoramic.contentSize.width - self.frame.size.width)) {
        offset.x =  (uis_panoramic.contentSize.width - self.frame.size.width);
    }
    
    [uis_panoramic setContentOffset:offset];
    
    float indicatorMove =  (offset.x /uis_panoramic.contentSize.width) * _uiiv_smallPano.frame.size.width + 5.0;
    _uib_smallFrame.transform = CGAffineTransformMakeTranslation(indicatorMove, 0.0);
}

#pragma mark - Scroll View Delegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = uis_panoramic.contentOffset;
    float indicatorMove =  (offset.x /uis_panoramic.contentSize.width) * _uiiv_smallPano.frame.size.width + 5.0;
    _uib_smallFrame.transform = CGAffineTransformMakeTranslation(indicatorMove, 0.0);
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

}

#pragma mark - Add Help view
- (void)hideAndUnhideHelp:(NSNotification *)pNotification
{    
    if (_uiv_helpContianer) {
        [self fadeOutPopViews:nil];
    }
    else {
        [self loadHelpView];
    }
}

- (void)prepareHlepData
{
    [_arr_helpText removeAllObjects];
    _arr_helpText = nil;
    _arr_helpText = [[NSMutableArray alloc] initWithObjects:
                     @"Tap close button to retun gallery",
                     @"Tap tilt to turn on the functionality",
                     nil];
    
    [_arr_helpTargetViews removeAllObjects];
    _arr_helpTargetViews = nil;
    UIButton *homeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 45.0, 45.0)];
    UIView *tmp1 = [[UIView alloc] initWithFrame:CGRectMake(_uiv_indicatorContainer.frame.origin.x + 20, _uiv_indicatorContainer.frame.origin.y+_uiv_indicatorContainer.frame.size.height, 1, 1)];
//    UIView *tmp2 = [[UIView alloc] initWithFrame:frame];
    _arr_helpTargetViews = [[NSMutableArray alloc] initWithObjects:homeBtn, tmp1, nil];
}

- (void)dismissAllPopTipViews
{
    [_uiv_helpContianer removeFromSuperview];
    _uiv_helpContianer = nil;
    for (CMPopTipView *popTipView in self.visiblePopTipViews) {
        [popTipView dismissAnimated:YES];
        [self.visiblePopTipViews removeObject:popTipView];
    }
}

- (void)loadHelpView
{
	[self dismissAllPopTipViews];
    _uiv_helpContianer = [[UIView alloc] initWithFrame:screenRect];
    _uiv_helpContianer.alpha = 0.0;
    for (int i = 0; i < _arr_helpText.count; i++) {
        NSString *contentMessage = nil;
        contentMessage = _arr_helpText[i];
        UIColor *backgroundColor = [UIColor vcHelpBackgroundColor];
        UIColor *textColor = [UIColor whiteColor];
        
        CMPopTipView *popTipView;
        popTipView = [[CMPopTipView alloc] initWithMessage:contentMessage];
        popTipView.delegate = self;
        
        /* Some options to try.
         */
        //popTipView.disableTapToDismiss = YES;
        //popTipView.preferredPointDirection = PointDirectionUp;
        //popTipView.hasGradientBackground = NO;
        //popTipView.cornerRadius = 2.0;
        //popTipView.sidePadding = 30.0f;
        //popTipView.topMargin = 20.0f;
        //popTipView.pointerSize = 50.0f;
        popTipView.hasShadow = NO;
        popTipView.borderColor = [UIColor clearColor];
        if (backgroundColor && ![backgroundColor isEqual:[NSNull null]]) {
            popTipView.backgroundColor = backgroundColor;
        }
        if (textColor && ![textColor isEqual:[NSNull null]]) {
            popTipView.textColor = textColor;
        }
        
        popTipView.animation = arc4random() % 2;
        popTipView.has3DStyle = NO;
        
        popTipView.dismissTapAnywhere = NO;
        //        [popTipView autoDismissAnimated:NO atTimeInterval:3.0];
        [popTipView presentPointingAtView:_arr_helpTargetViews[i] inView:_uiv_helpContianer animated:YES];
        
        [self.visiblePopTipViews addObject:popTipView];
    }
    [self addSubview: _uiv_helpContianer];
    UITapGestureRecognizer *tapOnHelp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fadeOutPopViews:)];
    tapOnHelp.numberOfTapsRequired = 1;
    _uiv_helpContianer.userInteractionEnabled = YES;
    [_uiv_helpContianer addGestureRecognizer: tapOnHelp];
    [UIView animateWithDuration:0.33 animations:^{
        _uiv_helpContianer.alpha = 1.0;
    }];
}

- (void)fadeOutPopViews:(UIGestureRecognizer *)gesture
{
    [UIView animateWithDuration:0.33 animations:^{
        _uiv_helpContianer.alpha = 0.0;
    } completion:^(BOOL finished){
        [self dismissAllPopTipViews];
    }];
}

#pragma mark - CMPopTipViewDelegate methods

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
	[self.visiblePopTipViews removeObject:popTipView];
}
#pragma mark - Cleaning memory
- (void) removeFromSuperview
{
    [self stopMotionManager];
    [uis_panoramic removeFromSuperview];
    uis_panoramic = nil;
    [_arr_helpTargetViews removeAllObjects];
    _arr_helpTargetViews = nil;
    [_arr_helpText removeAllObjects];
    _arr_helpText = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideAndUnhideHelp" object:nil];       
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
