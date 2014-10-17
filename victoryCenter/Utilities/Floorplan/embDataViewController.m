//
//  embDataViewController.m
//  Example
//
//  Created by Evan Buxton on 11/23/13.
//  Copyright (c) 2013 neoscape. All rights reserved.
//

#import "embDataViewController.h"
#import "ebZoomingScrollView.h"
#import "neoHotspotsView.h"
#import "UIColor+Extensions.h"
//#import "motionImageViewController.h"

@interface embDataViewController () <neoHotspotsViewDelegate> {
	int iTotalButtons;
	UIView *uiv_testFitButtonHOlder;
    UIView *uiv_testFitSubMenuContainer;
}

@property (nonatomic, strong) neoHotspotsView				*myHotspots;
@property (nonatomic, strong) NSMutableArray				*arr_hotspots;
@property (nonatomic, strong) NSMutableArray				*arr_testFitBtnsName;
@property (nonatomic, strong) NSMutableArray                *arr_testFitBtns;
@property (nonatomic, strong) NSMutableArray                *arr_testFitImgs;
@property (nonatomic, strong) ebZoomingScrollView			*zoomingScroll;
@property (nonatomic, strong) UIImage						*uii_Plan;
@property (nonatomic, strong) UIView						*uiv_PlanDataContainer;
@property (nonatomic, strong) UIImage						*uii_PlanData;
@property (nonatomic, strong) UIImageView					*uiiv_PlanData;

@property (nonatomic, strong) NSMutableArray				*arr_floorplans;
@property (nonatomic, strong) NSDictionary					*dict;
@property (nonatomic, strong) NSMutableArray				*floorplan;
@property (nonatomic, strong) UIButton						*uib_ShellBtn;
@property (nonatomic, strong) NSMutableArray                *arr_testFitSubMenu;
@property (nonatomic, strong) NSMutableArray                *arr_testFitTenant;

@end

@implementation embDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = screenRect;
	// Do any additional setup after loading the view, typically from a nib.
	_arr_hotspots = [[NSMutableArray alloc] init];
    _arr_testFitBtns = [[NSMutableArray alloc] init];
	// floor plans
	_arr_floorplans = [[NSMutableArray alloc] init];
	_dict = self.dataObject;
	_floorplan = [_dict valueForKeyPath:@"floorplaninfo.floorplan"];
	[_arr_floorplans addObject:[_floorplan objectAtIndex:0]];
	
    UIImageView *uiiv_bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grfx_floorPlan_bg.jpg"]];
    [self.view insertSubview:uiiv_bgImage atIndex:0];
    self.view.backgroundColor = [UIColor vcBackGroundColor];
//	[self shellButton];
    [self loadDataAndView];
}

#pragma mark - LAYOUT FLOOR PLAN DATA
-(void)loadDataAndView
{
	_uii_Plan = [UIImage imageNamed:_floorplan[0]];
	if (!_zoomingScroll) {
		// NSLog(@"running");
        CGRect theFrame = self.view.bounds;
        theFrame.origin.x = 40;
        theFrame.origin.y = 64;
        theFrame.size.width = 944;
        theFrame.size.height = 682;
		_zoomingScroll = [[ebZoomingScrollView alloc] initWithFrame:theFrame image:nil shouldZoom:YES];
//		[self.view insertSubview:_zoomingScroll atIndex:1];
        [self.view addSubview:_zoomingScroll];
        _zoomingScroll.backgroundColor = [UIColor clearColor];
		_zoomingScroll.delegate=self;
	}
	
	// plan info data
	NSString *planName = _dict[@"floorplaninfo"][0][@"floorinfo"][0];
    [self loadInImge:planName];
    
    //Added Road Names Labels
    UILabel *uil_victoryAve = [[UILabel alloc] initWithFrame:CGRectMake(150, 90, 130, 30)];
    [uil_victoryAve setText:@"VICTORY AVE"];
    uil_victoryAve.backgroundColor = [UIColor vcBackGroundColor];
    [uil_victoryAve setFont:[UIFont fontWithName:@"Raleway-Medium" size:13]];
    [uil_victoryAve setTextColor:[UIColor vcLightBlue]];
    [uil_victoryAve setContentMode:UIViewContentModeCenter];
    CGSize size = [uil_victoryAve.text sizeWithAttributes:
                   @{NSFontAttributeName:
                         [UIFont fontWithName:@"Raleway-Medium" size:13]}];
    uil_victoryAve.frame = CGRectMake(uil_victoryAve.frame.origin.x, uil_victoryAve.frame.origin.y, size.width, size.height);
    [self.view addSubview: uil_victoryAve];
    
    UILabel *uil_highMarketSt = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 130, 130, 30)];
    [uil_highMarketSt setText:@"HIGH MARKET ST"];
    uil_highMarketSt.backgroundColor = [UIColor vcBackGroundColor];
    [uil_highMarketSt setFont:[UIFont fontWithName:@"Raleway-Medium" size:13]];
    [uil_highMarketSt setTextColor:[UIColor vcLightBlue]];
    [uil_highMarketSt setContentMode:UIViewContentModeCenter];
    CGSize size1 = [uil_highMarketSt.text sizeWithAttributes:
                   @{NSFontAttributeName:
                         [UIFont fontWithName:@"Raleway-Medium" size:13]}];
    uil_highMarketSt.frame = CGRectMake(uil_highMarketSt.frame.origin.x, uil_highMarketSt.frame.origin.y, size1.width, size1.height);
    [self.view addSubview: uil_highMarketSt];
    CGRect oldFrame = uil_highMarketSt.frame;
    uil_highMarketSt.layer.anchorPoint = CGPointMake(1.0, 1.0);
    uil_highMarketSt.frame = oldFrame;
    uil_highMarketSt.transform = CGAffineTransformMakeRotation(-M_PI_2);
    
    //Added compass image
    UIImageView *uiiv_compass = [[UIImageView alloc] initWithFrame:CGRectMake(940, 670, 34, 34)];
    [uiiv_compass setImage:[UIImage imageNamed:@"grfx_compass.png"]];
    [self.view addSubview: uiiv_compass];
}

-(void)loadInImge:(NSString *)imageName
{
    [UIView animateWithDuration:0.33 animations:^{
        _zoomingScroll.blurView.alpha = 0.0;
    } completion:^(BOOL finished){
        _zoomingScroll.blurView.image = [UIImage imageNamed:imageName];
        [UIView animateWithDuration:0.33 animations:^{
            _zoomingScroll.blurView.alpha = 1.0;
        }];
    }];
    
}

#pragma mark - BOILERPLATE
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	self.view.frame = screenRect;
	// otherwise plan stays zoomed in
	// when you scroll to new page
	[_zoomingScroll resetScroll];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_zoomingScroll removeFromSuperview];
    _zoomingScroll = nil;
    
    _dict = nil;
    
    [_floorplan removeAllObjects];
    _floorplan = nil;
    
    [_arr_floorplans removeAllObjects];
    _arr_floorplans = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
