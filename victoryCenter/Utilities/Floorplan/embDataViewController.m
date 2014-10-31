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
	int                             iTotalButtons;
	UIView                          *uiv_testFitButtonHolder;
    NSMutableArray                  *arr_testFitBtnArray;
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
@property (nonatomic, strong) NSMutableArray                *arr_hotspotImg;

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
	
    self.view.backgroundColor = [UIColor vcBackGroundColor];
    [self loadDataAndView];
    
    [self loadTestFitBtns];
}

#pragma mark - LAYOUT FLOOR PLAN DATA
-(void)loadDataAndView
{
	_uii_Plan = [UIImage imageNamed:_floorplan[0]];
	if (!_zoomingScroll) {
        CGRect theFrame = self.view.bounds;
        theFrame.origin.x = 35;
        theFrame.origin.y = 64;
        theFrame.size.width = 900;
        theFrame.size.height = 682;
		_zoomingScroll = [[ebZoomingScrollView alloc] initWithFrame:theFrame image:nil shouldZoom:YES];
        [self.view addSubview:_zoomingScroll];
        _zoomingScroll.backgroundColor = [UIColor clearColor];
		_zoomingScroll.delegate=self;
	}
	
	// plan info data
	NSString *planName = _dict[@"floorplaninfo"][0][@"floorinfo"][0];
    [self loadInImge:planName];
    
    // load plan's hotspot
    NSArray *arr_hotspots = _dict[@"floorplaninfo"][0][@"hotspots"];
    if (arr_hotspots.count) {
        [self loadHospots:arr_hotspots];
    }
    
    //Added Road Names Labels
    UILabel *uil_victoryAve = [[UILabel alloc] initWithFrame:CGRectMake(830,260, 130, 30)];
    [uil_victoryAve setText:@"VICTORY AVE"];
    uil_victoryAve.backgroundColor = [UIColor vcBackGroundColor];
    [uil_victoryAve setFont:[UIFont fontWithName:@"Raleway-Medium" size:12]];
    [uil_victoryAve setTextColor:[UIColor vcLightBlue]];
    [uil_victoryAve setContentMode:UIViewContentModeCenter];
    CGSize size = [uil_victoryAve.text sizeWithAttributes:
                   @{NSFontAttributeName:
                         [UIFont fontWithName:@"Raleway-Medium" size:13]}];
    uil_victoryAve.frame = CGRectMake(uil_victoryAve.frame.origin.x, uil_victoryAve.frame.origin.y, size.width, size.height);
    [self.view addSubview: uil_victoryAve];
    CGRect oldFrame = uil_victoryAve.frame;
    uil_victoryAve.layer.anchorPoint = CGPointMake(0.0, 0.0);
    uil_victoryAve.frame = oldFrame;
    uil_victoryAve.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    UILabel *uil_highMarketSt = [[UILabel alloc] initWithFrame:CGRectMake(700.0, 200, 130, 30)];
    [uil_highMarketSt setText:@"HIGH MARKET ST"];
    uil_highMarketSt.backgroundColor = [UIColor vcBackGroundColor];
    [uil_highMarketSt setFont:[UIFont fontWithName:@"Raleway-Medium" size:12]];
    [uil_highMarketSt setTextColor:[UIColor vcLightBlue]];
    [uil_highMarketSt setContentMode:UIViewContentModeCenter];
    CGSize size1 = [uil_highMarketSt.text sizeWithAttributes:
                   @{NSFontAttributeName:
                         [UIFont fontWithName:@"Raleway-Medium" size:12]}];
    uil_highMarketSt.frame = CGRectMake(uil_highMarketSt.frame.origin.x, uil_highMarketSt.frame.origin.y, size1.width, size1.height);
    [self.view addSubview: uil_highMarketSt];
//    CGRect oldFrame = uil_highMarketSt.frame;
//    uil_highMarketSt.layer.anchorPoint = CGPointMake(1.0, 1.0);
//    uil_highMarketSt.frame = oldFrame;
//    uil_highMarketSt.transform = CGAffineTransformMakeRotation(-M_PI_2);
    
    //Added compass image
    UIImageView *uiiv_compass = [[UIImageView alloc] initWithFrame:CGRectMake(940, 670, 31, 41)];
    [uiiv_compass setImage:[UIImage imageNamed:@"grfx_compass.png"]];
    [self.view addSubview: uiiv_compass];
}

-(void)loadInImge:(NSString *)imageName
{
    [UIView animateWithDuration:0.0 animations:^{
        _zoomingScroll.blurView.alpha = 0.0;
    } completion:^(BOOL finished){
        _zoomingScroll.blurView.image = [UIImage imageNamed:imageName];
        [UIView animateWithDuration:0.3 animations:^{
            _zoomingScroll.blurView.alpha = 1.0;
        }];
    }];
}

#pragma mark - Load hotspots & hotspot delegate method
- (void)loadHospots:(NSArray *)arr_hotspots
{
    [_arr_hotspots removeAllObjects];
    _arr_hotspots = nil;
    [_arr_hotspotImg removeAllObjects];
    _arr_hotspotImg = nil;
    _arr_hotspotImg = [[NSMutableArray alloc] init];
    for (int i = 0; i < arr_hotspots.count; i++) {
        NSDictionary *dict_hs = arr_hotspots[i];
        
        CGPoint centerPoint = CGPointFromString([NSString stringWithFormat:@"{%@}", [dict_hs objectForKey:@"xy"]]);
        NSString *imageName = [dict_hs objectForKey:@"fileName"];
        neoHotspotsView *myHotspot = [[neoHotspotsView alloc] initWithFrame:CGRectMake(centerPoint.x, centerPoint.y, 48, 48)];
        
        NSString *str_bgName = [[NSString alloc] initWithString:[dict_hs objectForKey:@"background"]];
        myHotspot.hotspotBgName = str_bgName;
        
        myHotspot.delegate = self;
        myHotspot.tagOfHs = i;
        [_zoomingScroll.blurView addSubview: myHotspot];
        [_arr_hotspots addObject: myHotspot];
        [_arr_hotspotImg addObject:imageName];
    }
}

- (void)neoHotspotsView:(neoHotspotsView *)hotspot didSelectItemAtIndex:(NSInteger)index
{
//    NSLog(@"Tapped hotspot is %i", (int)index);
    NSDictionary* dict = [NSDictionary dictionaryWithObject:_arr_hotspotImg[index] forKey:@"imageName"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadPanoImage"
                                                        object:self
                                                      userInfo:dict];
}

#pragma mark - Load Test fit buttons

- (void)loadTestFitBtns
{
    uiv_testFitButtonHolder = [[UIView alloc] initWithFrame:CGRectMake(280.0, 710.0, 470.0, 40.0)];
    NSArray *arr_btnTitles = [[NSArray alloc] initWithObjects:@"CORE & SHELL", @"OPEN PLAN", @"OFFICE PLAN", nil];
    CGFloat btnWidth = 156;
    [arr_testFitBtnArray removeAllObjects];
    arr_testFitBtnArray = nil;
    arr_testFitBtnArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < arr_btnTitles.count; i++) {
        UIButton *uib_testfit = [UIButton buttonWithType:UIButtonTypeCustom];
        uib_testfit.frame = CGRectMake((156+1)*i, 0.0, btnWidth, 40);
        [uib_testfit setBackgroundColor:[UIColor vcLightBlue]];
        [uib_testfit setTitle:arr_btnTitles[i] forState:UIControlStateNormal];
        [uib_testfit setTitle:arr_btnTitles[i] forState:UIControlStateSelected];
        [uib_testfit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [uib_testfit setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [uib_testfit.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14.0]];
        uib_testfit.tag = i;
        
        if (i == 0) {
            uib_testfit.backgroundColor = [UIColor vcDarkBlue];
        }
        
        [uib_testfit addTarget: self action:@selector(tapTestFit:) forControlEvents:UIControlEventTouchUpInside];
        [arr_testFitBtnArray addObject: uib_testfit];
        [uiv_testFitButtonHolder addSubview: uib_testfit];
    }
    [self.view addSubview: uiv_testFitButtonHolder];
}

- (void)tapTestFit:(id)sender
{
    for (UIButton *tmp in arr_testFitBtnArray) {
        tmp.backgroundColor = [UIColor vcLightBlue];
    }
    UIButton *tappedBtn = sender;
    tappedBtn.backgroundColor = [UIColor vcDarkBlue];
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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
