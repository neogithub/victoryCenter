//
//  mapViewController.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/23/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//


/*
    items tag list:
 
    Access / Amenities's content:
    Panel's title --> 101
    Panel's option buttons' container --> 102
 */
#import "mapViewController.h"
#import "MPFoldTransition.h"
#import "MPFlipTransition.h"
#import "UIColor+Extensions.h"
#import "embDrawPath.h"
#import "embBezierPaths.h"
#import "embDirections.h"
#import "embBlockPaths.h"
#import <MapKit/MapKit.h>
#import "MapViewAnnotation.h"
#import "embMapHotspotListViewController.h"
#import "siteOverview.h"
#import "xhPopTipsView.h"

#define METERS_PER_MILE 1609.344

//static CGFloat  kTableHeight                = 280;
//static CGFloat  kExpendedHeight             = 433;//kTableHeight + 160;
static CGFloat  kPanelTitleHeight           = 46;
static BOOL     kMapCanZoom                 = YES;
static CGFloat  kMinZoom                    = 1.0;
static CGFloat  kMaxZoom                    = 2.0;
static float    panle_x                     = 733.0;
static float    panle_w                     = 227.0;
static float    kPanelBtnHeight             = 38.0;
@interface mapViewController () <UIScrollViewDelegate, UIGestureRecognizerDelegate, embDrawPathDelegate, MKMapViewDelegate, embMapHotspotListViewControllerDelegate>
{
    float                   panel_h;
    CGFloat                 kTableHeight;
    
    NSMutableArray          *arr_topBtnsArray;
    NSMutableArray          *arr_subMenuArray;
    NSMutableArray          *arr_panelBtnArray;
    NSMutableArray          *arr_switcherArray;
    NSMutableArray          *arr_overlayArray;
    NSMutableArray          *arr_indicatorColors;
    NSMutableArray          *arr_cells;
    //Hotspot data
    NSDictionary            *dict_HotSpotsRaw;
    NSMutableArray          *arr_HotSpotsRaw;
    NSMutableArray          *arr_HotSpotCategories;
    NSMutableArray          *arr_HotSpotData;
    NSMutableArray          *arr_HotSpotXY;
    NSMutableArray          *arr_HotSpotViewArray;
    
    UIView                  *uiv_cityAccPanel;
    UIView                  *uiv_cityAmePanel;
    UIView                  *uiv_neibAmePanel;
    UIView                  *uiv_neibAccPanel;
    UIView                  *uiv_siteAmePanel;
    UIView                  *uiv_siteAccPanel;
    
    UIView                  *uiv_panelIndicator;
    UIButton                *uib_bldBtn;
    
    UIView                  *uiv_distanceInfoContainer;
    
    UIView                  *uiv_siteAmenInfo;
    UIImageView             *uiiv_airPlane;
}
//Top root menu
@property (weak, nonatomic) IBOutlet UIButton           *uib_city;
@property (weak, nonatomic) IBOutlet UIButton           *uib_neighbor;
@property (weak, nonatomic) IBOutlet UIButton           *uib_site;
//Sub menu container
@property (weak, nonatomic) IBOutlet UIView             *uiv_citySubMenu;
@property (weak, nonatomic) IBOutlet UIView             *uiv_neighborhoodSubMenu;
@property (weak, nonatomic) IBOutlet UIView             *uiv_siteSubMenu;
//Sub menu buttons
@property (weak, nonatomic) IBOutlet UIButton           *uib_cityDistricts;
@property (weak, nonatomic) IBOutlet UIButton           *uib_cityAmenities;
@property (weak, nonatomic) IBOutlet UIButton           *uib_cityAccess;
@property (weak, nonatomic) IBOutlet UIButton           *uib_neighborhoodDistricts;
@property (weak, nonatomic) IBOutlet UIButton           *uib_neighboorhoodAmenities;
@property (weak, nonatomic) IBOutlet UIButton           *uib_neighborhoodAccess;
@property (weak, nonatomic) IBOutlet UIButton           *uib_siteOverview;
@property (weak, nonatomic) IBOutlet UIButton           *uib_siteAmenities;
@property (weak, nonatomic) IBOutlet UIButton           *uib_siteAccess;
//Map switch container
@property (weak, nonatomic) IBOutlet UIView             *uiv_mapSwitchContainer;
@property (weak, nonatomic) IBOutlet UIButton           *uib_normalMap;
@property (weak, nonatomic) IBOutlet UIButton           *uib_appleMap;
@property (weak, nonatomic) IBOutlet UIButton           *uib_googleMap;
//Zooming map images
@property (nonatomic, strong) UIScrollView              *uis_zooming;
@property (nonatomic, strong) UIView                    *uiv_mapContainer;
@property (nonatomic, strong) UIImageView               *uiiv_mapImg;
@property (nonatomic, strong) UIImageView               *uiiv_mapOverlay;
@property (nonatomic, strong) UIImageView               *uiiv_vcLogo;
@property (nonatomic, strong) UIImageView               *uiiv_vcLogoFlag;
@property (nonatomic, strong) UIImageView               *uiiv_tredartLogo;
@property (nonatomic, strong) UIImageView               *uiiv_dart1Logo;
@property (nonatomic, strong) UIImageView               *uiiv_dart2Logo;
@property (nonatomic, strong) UIImageView               *uiiv_treLogo;
//Draw path
@property (nonatomic, strong) embDrawPath               *embPath;
@property (nonatomic, strong) embDrawPath				*embDirectionPath;
@property (nonatomic, strong) embDrawPath				*embBlockPath;
@property (nonatomic, strong) NSMutableArray			*dirpathsArray;
@property (nonatomic, strong) NSMutableArray			*arr_pathItems;
//Map Types
@property (nonatomic, strong) MKMapView                 *mapView;
@property (nonatomic, strong) MKMapCamera				*mapCamera;
@property (nonatomic, strong) UIView                    *uiv_appleMapContainer;
//Hotspot's table view & hotspots
@property (nonatomic, strong) UIView                    *uiv_tablePanel;
@property (nonatomic, strong) UIView                    *uiv_tappedHotspot;
@property (nonatomic, strong) embMapHotspotListViewController	*vc_hotspotList;
//Site map overview
@property (nonatomic, strong) UIView                    *uiv_overviewContainer;
@property (nonatomic, strong) siteOverview              *uiv_siteOverview;
// Help tip view
@property (nonatomic, strong) xhPopTipsView                 *uiv_helpView;
@property (nonatomic, strong) NSMutableArray                *arr_helpText;
@property (nonatomic, strong) NSMutableArray                *arr_helpTargetViews;
@end

@implementation mapViewController

@synthesize mode = _mode;
@synthesize foldStyle = _foldStyle;


- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = screenRect;
    [self loadHotspotDict];
    [self prepareHlepData];
    
    [self performSelector:@selector(popLogoFlagAnimation) withObject:nil afterDelay:0.5];
}

- (void)loadHotspotDict
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"hotspots"
													 ofType:@"plist"];
    dict_HotSpotsRaw = [[NSDictionary alloc] initWithContentsOfFile:path];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTopButtons];
    [self setSubMenus];
    [self setUpMapAnimation];
    [self initZoomingScrollView];
    [self setUpSwitcherContainer];
    //Hide all submenu's container at first
    _uiv_citySubMenu.hidden = NO;
    _uiv_neighborhoodSubMenu.hidden = YES;
    _uiv_siteSubMenu.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetLocation) name:@"tapOnTitle" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideAndUnhideHelp:) name:@"hideAndUnhideHelp" object:nil];
}

- (void)resetLocation
{
    [self removeAllHotspots];
    [self removeAllPanels];
    [self tapMapTopMenu:_uib_city];
    [self removeOverlay];
    for (UIButton *tmp in [_uiv_citySubMenu subviews]) {
        tmp.selected = NO;
    }
}

#pragma mark - Set up map's flod animation
- (void)setUpMapAnimation
{
    _mode = MPTransitionModeFold;
    _foldStyle = MPFoldStyleHorizontal;
    [self isFold];
}

/* Set the map animated in fold way */
- (BOOL)isFold
{
	return [self mode] == MPTransitionModeFold;
}

- (UIView *)getMapForIndex:(NSUInteger)index
{
    //Init inside map container, this container zoomed with scroll view
    _uiv_mapContainer = [[UIView alloc] initWithFrame:screenRect];
    _uiv_mapContainer.tag = index;
    _uiv_mapContainer.backgroundColor = [UIColor whiteColor];
    _uiv_mapContainer.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    //Set up map image, according to the index change different level map
    _uiiv_mapImg = [[UIImageView alloc] initWithFrame:screenRect];
	[_uiiv_mapImg setContentMode:UIViewContentModeScaleAspectFit];
    _uiiv_mapImg.userInteractionEnabled = YES;
    _uiiv_mapImg.backgroundColor = [UIColor whiteColor];
    
    //Set up logos image
    _uiiv_vcLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grfx_victorycenter_logo.png"]];
    _uiiv_tredartLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grfx_tredart_logo.png"]];
    _uiiv_dart1Logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grfx_dartLogo.png"]];
    _uiiv_dart2Logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grfx_dartLogo.png"]];
    _uiiv_treLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grfx_treLogo.png"]];
	switch (index % 3) {
		case 0:
            [_uiiv_mapImg setImage:[UIImage imageNamed:@"City_base_map_.png"]];
            _uiiv_vcLogo.frame = CGRectMake(489.0, 385.0, _uiiv_vcLogo.frame.size.width, _uiiv_vcLogo.frame.size.height);
            _uiiv_tredartLogo.frame = CGRectMake(456.0, 308.0, _uiiv_tredartLogo.frame.size.width, _uiiv_tredartLogo.frame.size.height);
            _uiiv_dart1Logo.frame = CGRectMake(338.0, 193.0, _uiiv_dart1Logo.frame.size.width, _uiiv_dart1Logo.frame.size.height);
            _uiiv_dart2Logo.frame = CGRectMake(512.0, 446.0, _uiiv_dart2Logo.frame.size.width, _uiiv_dart2Logo.frame.size.height);
            _uiiv_treLogo.frame = CGRectMake(450.0, 460.0, _uiiv_treLogo.frame.size.width, _uiiv_treLogo.frame.size.height);
			break;
		case 1:
            [_uiiv_mapImg setImage:[UIImage imageNamed:@"Neighborhood_map.png"]];
            _uiiv_vcLogo.frame = CGRectMake(480.0, 428.0, _uiiv_vcLogo.frame.size.width, _uiiv_vcLogo.frame.size.height);
            _uiiv_tredartLogo.frame = CGRectMake(423.0, 288.0, _uiiv_tredartLogo.frame.size.width, _uiiv_tredartLogo.frame.size.height);
            _uiiv_dart2Logo.frame = CGRectMake(537.0, 566.0, _uiiv_dart2Logo.frame.size.width, _uiiv_dart2Logo.frame.size.height);
            _uiiv_treLogo.frame = CGRectMake(390.0, 610.0, _uiiv_treLogo.frame.size.width, _uiiv_treLogo.frame.size.height);
			break;
		case 2:
            [_uiiv_mapImg setImage:[UIImage imageNamed:@"Site_Base map.png"]];
            _uiiv_vcLogo.frame = CGRectZero;
            _uiiv_tredartLogo.frame = CGRectMake(205.0, 707.0, _uiiv_tredartLogo.frame.size.width, _uiiv_tredartLogo.frame.size.height);
            _uiiv_dart1Logo.frame = CGRectZero;
            _uiiv_dart2Logo.frame = CGRectZero;
            _uiiv_treLogo.frame = CGRectZero;
			break;
		default:
			break;
	}
    
    _uiiv_vcLogo.tag = 150;
    _uiiv_tredartLogo.tag = 160;
    _uiiv_dart1Logo.tag = 161;
    _uiiv_dart2Logo.tag = 162;
    _uiiv_treLogo.tag = 163;
    
    [_uiv_mapContainer addSubview:_uiiv_mapImg];
    [_uiv_mapContainer insertSubview:_uiiv_vcLogo atIndex:11];
    [_uiv_mapContainer insertSubview:_uiiv_tredartLogo atIndex:12];
    [_uiv_mapContainer insertSubview:_uiiv_dart1Logo atIndex:12];
    [_uiv_mapContainer insertSubview:_uiiv_dart2Logo atIndex:12];
    [_uiv_mapContainer insertSubview:_uiiv_treLogo atIndex:12];
    
    UITapGestureRecognizer *tapOnVClogo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnVCLogo:)];
    tapOnVClogo.numberOfTapsRequired = 1;
    _uiiv_vcLogo.userInteractionEnabled = YES;
    [_uiiv_vcLogo addGestureRecognizer: tapOnVClogo];
    
	return _uiv_mapContainer;
}

- (void)tapOnVCLogo:(UIGestureRecognizer *)gesture
{
//    if (_uiiv_vcLogoFlag) {
//        [_uiiv_vcLogoFlag removeFromSuperview];
//        _uiiv_vcLogoFlag = nil;
//        return;
//    }
//    
//    _uiiv_vcLogoFlag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VictoryCenter_Flag.png"]];
//    CGRect logoFrame = _uiiv_vcLogo.frame;
//    _uiiv_vcLogoFlag.frame = CGRectMake(logoFrame.origin.x + logoFrame.size.width/2, logoFrame.origin.y - _uiiv_vcLogoFlag.frame.size.height, _uiiv_vcLogoFlag.frame.size.width, _uiiv_vcLogoFlag.frame.size.height);
//    _uiiv_vcLogoFlag.tag = 151;
//    
//    CGRect oldFrame = _uiiv_vcLogoFlag.frame;
//    _uiiv_vcLogoFlag.layer.anchorPoint = CGPointMake(0.0, 1.0);
//    _uiiv_vcLogoFlag.frame = oldFrame;
//    
//    [_uiv_mapContainer addSubview: _uiiv_vcLogoFlag];
    
    if (_uiiv_vcLogoFlag) {
        
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _uiiv_vcLogoFlag.transform = CGAffineTransformMakeScale(0.0, 0.0);
        } completion:^(BOOL finished){
            [_uiiv_vcLogoFlag removeFromSuperview];
            _uiiv_vcLogoFlag = nil;
            return;
        }];
        
    }
    else {
        _uiiv_vcLogoFlag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VictoryCenter_Flag.png"]];
        CGRect logoFrame = _uiiv_vcLogo.frame;
        _uiiv_vcLogoFlag.frame = CGRectMake(logoFrame.origin.x + logoFrame.size.width/2, logoFrame.origin.y - _uiiv_vcLogoFlag.frame.size.height, _uiiv_vcLogoFlag.frame.size.width, _uiiv_vcLogoFlag.frame.size.height);
        _uiiv_vcLogoFlag.tag = 151;
        
        CGRect oldFrame = _uiiv_vcLogoFlag.frame;
        _uiiv_vcLogoFlag.layer.anchorPoint = CGPointMake(0.0, 1.0);
        _uiiv_vcLogoFlag.frame = oldFrame;
        _uiiv_vcLogoFlag.transform = CGAffineTransformMakeScale(0.0, 0.0);
        [_uiv_mapContainer addSubview: _uiiv_vcLogoFlag];
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _uiiv_vcLogoFlag.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished){
            
        }];
    }
}

- (void)popLogoFlagAnimation
{
    [self performSelector:@selector(tapOnVCLogo:) withObject:nil afterDelay:0.0];
    [self performSelector:@selector(tapOnVCLogo:) withObject:nil afterDelay:2.5];
}

-(void)animationOfMaps:(int)index
{
    // Reset the zoom level of the scroll view
	[_uis_zooming setZoomScale:1.0];
    UIView *previousView = _uiv_mapContainer;
    UIView *nextView = [self getMapForIndex:index];
	BOOL forwards = nextView.tag > previousView.tag;
    
    // handle wrap around
	if (nextView.tag == 2 && previousView.tag == 0)
		forwards = YES;
	else if (nextView.tag == 0 && previousView.tag == 2)
		forwards = NO;
    
    // execute the transition
	if ([self isFold])
	{
		[MPFoldTransition transitionFromView:previousView
									  toView:nextView
									duration:[MPFoldTransition defaultDuration]
									   style:forwards? [self foldStyle]	: MPFoldStyleFlipFoldBit([self foldStyle])
							transitionAction:MPTransitionActionAddRemove
								  completion:^(BOOL finished) {
                                      if (index < 2) {        }
                                  }
		 ];
	}
}

#pragma mark - Init zooming scroll view for map
- (void) initZoomingScrollView
{
    _uis_zooming = [[UIScrollView alloc] initWithFrame:screenRect];
    if (kMapCanZoom==YES)
    {
		_uis_zooming.maximumZoomScale = kMaxZoom;
		_uis_zooming.minimumZoomScale = kMinZoom;
		_uis_zooming.clipsToBounds = YES;
		_uis_zooming.delegate = self;
		_uis_zooming.scrollEnabled = kMapCanZoom;
	}
    
    [_uis_zooming insertSubview:[self getMapForIndex:0] atIndex:0];
    [self.view insertSubview:_uis_zooming atIndex:0];
    
    // add doubletap for zooming
	UITapGestureRecognizer *tapDblRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomPlan:)];
	[tapDblRecognizer setNumberOfTapsRequired:2];
	[tapDblRecognizer setDelegate:self];
	[_uis_zooming addGestureRecognizer:tapDblRecognizer];
    _uis_zooming.contentSize = CGSizeMake(_uis_zooming.frame.size.width, _uis_zooming.frame.size.height);
}

#pragma mark zooming
-(void)zoomPlan:(UITapGestureRecognizer *)sender
{
	// 1 determine which to zoom
	UIScrollView *tmp;
	tmp = _uis_zooming;
	// if uis_mapScrollView is the sender
	if (tmp == _uis_zooming) {
		CGPoint pointInView = [sender locationInView:tmp];
		// 2
		CGFloat newZoomScale = tmp.zoomScale * kMaxZoom;
		newZoomScale = MIN(newZoomScale, tmp.maximumZoomScale);
		// 3
		CGSize scrollViewSize = tmp.bounds.size;
		CGFloat w = scrollViewSize.width / newZoomScale;
		CGFloat h = scrollViewSize.height / newZoomScale;
		CGFloat x = pointInView.x - (w / kMaxZoom);
		CGFloat y = pointInView.y - (h / kMaxZoom);
		CGRect rectToZoomTo = CGRectMake(x, y, w, h);
		// 4
		if (tmp.zoomScale >= kMaxZoom-.01) {		// sets midpoint for zooming back the other way
			[tmp setZoomScale: 1.0 animated:YES];
			
		} else if (tmp.zoomScale < kMaxZoom) {
			[tmp zoomToRect:rectToZoomTo animated:YES];
		}
	}
}

#pragma mark scroll delegates
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	// for(UIView *subview in [_uis_zooming subviews]) {
    for (UIView *dropPinView in _uiv_mapContainer.subviews) {
        if (dropPinView.tag >= 100) {
//            CGRect oldFrame = dropPinView.frame;
            // 0.5 means the anchor is centered on the x axis. 1 means the anchor is at the bottom of the view. If you comment out this line, the pin's center will stay where it is regardless of how much you zoom. I have it so that the bottom of the pin stays fixed. This should help user RomeoF.
            //[dropPinView.layer setAnchorPoint:CGPointMake(0.5, 1)];
//            [dropPinView.layer setAnchorPoint:CGPointMake(0.5, 0.5)];
//            dropPinView.frame = oldFrame;
            // When you zoom in on scrollView, it gets a larger zoom scale value.
            // You transform the pin by scaling it by the inverse of this value.
            dropPinView.transform = CGAffineTransformMakeScale(1.0/scrollView.zoomScale, 1.0/scrollView.zoomScale);
        }
    }
	// }
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return _uiv_mapContainer;
}

#pragma mark - Top 3 buttons (city, neighborhood and site) action

- (void)setTopButtons
{
    arr_topBtnsArray = [[NSMutableArray alloc] init];
    
    [self initTopBtn:_uib_city withTitle:@"CITY" andTag:0 andSelected:YES];
    [self initTopBtn:_uib_neighbor withTitle:@"NEIGHBORHOOD" andTag:1 andSelected:NO];
    [self initTopBtn:_uib_site withTitle:@"SITE" andTag:2 andSelected:NO];
}
- (void)initTopBtn:(UIButton *)theBtn withTitle:(NSString *)title andTag:(int)index andSelected:(BOOL)selected
{
    [theBtn setTitle:title forState:UIControlStateNormal];
    [theBtn setTitle:title forState:UIControlStateSelected];
    [theBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [theBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [theBtn.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14]];
    theBtn.tag = index;
    theBtn.selected = selected;
    [theBtn addTarget:self action:@selector(tapMapTopMenu:) forControlEvents:UIControlEventTouchUpInside];
    if (selected) {
        theBtn.backgroundColor = [UIColor vcDarkBlue];
    }
    else{
        theBtn.backgroundColor = [UIColor vcLightBlue];
    }
    [arr_topBtnsArray addObject: theBtn];
}

- (void)resetTopBtns
{
    for (UIButton *tmp in arr_topBtnsArray) {
        tmp.selected = NO;
        tmp.backgroundColor = [UIColor vcLightBlue];
    }
}

/*
    1. Reset all top buttons
    2. Make the tapped one (sender) selected
 */
- (void)updateTopBtns:(id)sender
{
    // Reset all top buttons
    UIButton *tappedBtn = sender;
    [self resetTopBtns];
    
    // Highlight the selected button
    tappedBtn.selected = YES;
    tappedBtn.backgroundColor = [UIColor vcDarkBlue];
}
#pragma mark Top menu action
- (void)tapMapTopMenu:(id)sender
{
    UIButton *tappedBtn = sender;
    if (tappedBtn.selected)
    {
        [self removeOverviewPanel];
        [self removeOverlay];
        [self removeAllPanels];
        [self removeHotspots];
        [self resetSubMenus];
        return;
    }
    else
    {
        // Remove all panels
        [self removeAllPanels];
        [self performSelector:@selector(removeOverlay) withObject:nil afterDelay:0.1];
        [self removeOverviewPanel];
        [self updateTopBtns:tappedBtn];
        [self animationOfMaps:(int)tappedBtn.tag];
        [self updateSubMenu:(int)tappedBtn.tag];
    }
}

- (void)updateSubMenu:(int)index
{
    [self resetSubMenus];
    [self removeOverlay];
    [self removeBldBtn];
    switch (index) {
        case 0: { //Show City's sub menu
            _uiv_citySubMenu.hidden = NO;
            _uiv_neighborhoodSubMenu.hidden = YES;
            _uiv_siteSubMenu.hidden = YES;
            _uiv_mapSwitchContainer.hidden = NO;
            [self performSelector:@selector(popLogoFlagAnimation) withObject:nil afterDelay:0.31];
            break;
        }
        case 1: { //Show Neighborhood's sub menu
            _uiv_citySubMenu.hidden = YES;
            _uiv_neighborhoodSubMenu.hidden = NO;
            _uiv_siteSubMenu.hidden = YES;
            _uiv_mapSwitchContainer.hidden = NO;
            [self performSelector:@selector(popLogoFlagAnimation) withObject:nil afterDelay:0.31];
            break;
        }
        case 2: { //Show Site's sub menu
            _uiv_citySubMenu.hidden = YES;
            _uiv_neighborhoodSubMenu.hidden = YES;
            _uiv_siteSubMenu.hidden = NO;
            _uiv_mapSwitchContainer.hidden = YES;
            [self creatBuildingBtn];
            [self performSelector:@selector(tapSubMenu:) withObject:_uib_siteAmenities afterDelay:0.4];
            
            double delayInSeconds = 0.5;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                UIButton *tmp = [arr_panelBtnArray objectAtIndex: arr_panelBtnArray.count - 1];
                [self performSelector:@selector(tapSiteAmenities:) withObject:tmp afterDelay:0.0];
            });
            break;
        }
        default:
            break;
    }
}

#pragma mark - Set up submenus of each top button

- (void)setSubMenus
{
    [self setCitySubMenu];
    [self setNeighborhoodSubMenu];
    [self setSiteSubMenu];
    
    arr_subMenuArray = [[NSMutableArray alloc] initWithObjects:_uiv_citySubMenu, _uiv_neighborhoodSubMenu, _uiv_siteSubMenu, nil];
}

- (void)setCitySubMenu
{
    [self initSubMenuButton:_uib_cityDistricts withTitle:@"DISTRICTS" andTag:11 andSelected:NO];
    [self initSubMenuButton:_uib_cityAccess withTitle:@"ACCESS" andTag:12 andSelected:NO];
    [self initSubMenuButton:_uib_cityAmenities withTitle:@"AMENITIES" andTag:13 andSelected:NO];
}

- (void)setNeighborhoodSubMenu
{
    [self initSubMenuButton:_uib_neighborhoodDistricts withTitle:@"DISTRICTS" andTag:23 andSelected:NO];
    [self initSubMenuButton:_uib_neighboorhoodAmenities withTitle:@"AMENITIES" andTag:21 andSelected:NO];
    [self initSubMenuButton:_uib_neighborhoodAccess withTitle:@"ACCESS" andTag:22 andSelected:NO];
}

- (void)setSiteSubMenu
{
    [self initSubMenuButton:_uib_siteOverview withTitle:@"OVERVIEW" andTag:31 andSelected:NO];
    [self initSubMenuButton:_uib_siteAmenities withTitle:@"AMENITIES" andTag:32 andSelected:NO];
    [self initSubMenuButton:_uib_siteAccess withTitle:@"ACCESS" andTag:33 andSelected:NO];
}

- (void)initSubMenuButton:(UIButton*)theBtn withTitle:(NSString *)title andTag:(int)index andSelected:(BOOL)selected
{
    [theBtn setTitle:title forState:UIControlStateNormal];
    [theBtn setTitle:title forState:UIControlStateSelected];
    [theBtn setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateNormal];
    [theBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [theBtn.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14.0]];
    theBtn.backgroundColor = [UIColor vcDarkBlue];
    theBtn.tag = index;
    theBtn.selected = selected;
    [theBtn addTarget:self action:@selector(tapSubMenu:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)resetSubMenus
{
    for (UIView *tmpView in arr_subMenuArray) {
        for (UIButton *tmp in [tmpView subviews]) {
            tmp.selected = NO;
            tmp.backgroundColor = [UIColor vcDarkBlue];
            [tmp.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14.0]];
        }
    }
}

#pragma mark Sub menu's action
- (void)tapSubMenu:(id)sender
{
    UIButton *tappedBtn = sender;
    // Get the tag's ten digit to load correct sub menu
    // 1* --> City's sub menu
    // 2* --> Neighborhood's sub menu
    // 3* --> Site's sub menu
    int categoryIndx = (int)tappedBtn.tag/10;
    switch (categoryIndx) {
        case 1: { //Taped City's submenu
            [self handleCitySubMenu:tappedBtn];
            break;
        }
        case 2: { // Tapped Neighborhood's submenu
            [self handleNeibSubMenu:tappedBtn];
            break;
        }
        case 3: { // Tapped Site's submenu
            [self handleSiteSubMenu:tappedBtn];
            break;
        }
        default:
            break;
    }
    
}

#pragma mark - City Submenu

- (void)handleCitySubMenu:(id)sender
{
    UIButton *tappedBtn = sender;
    if (tappedBtn.selected) {
        [self deHiliteSubMenu:_uiv_citySubMenu];
        [self removeOverlay];
        [self removePaths];
        [self removeAllPanels];
        [self removeAllHotspots];
        return;
    }
    
    [self hiliteSubMenuTappedButton:sender inView:_uiv_citySubMenu];
    [self removeOverlay];
    [self removePaths];
    [self removeAllPanels];
    [self removeAllHotspots];
    // Get -digit to detect which button is tapped
    // *1 --> load overlay
    // *2 --> load City's Access panel
    int selectedIndex = (int)[sender tag]%10;
    if (selectedIndex == 1) { // Tapped Districts
        [self updateOverlayImage:@"Districts_overlay.png"];
    }
    if (selectedIndex == 2) { // Tapped Access
        [self updateOverlayImage:@"Access_overlay.png"];
        [self addCityAccessPanel];
    }
    if (selectedIndex == 3) { // Tapped Amenities
        [self addCityAmeniteisPanel];
    }
}
#pragma mark City Accesss panel
- (void)addCityAccessPanel
{
    uiv_cityAccPanel = [self setUpAccessPanel];
//    [self addDistanceInfo];
}

- (void)addDistanceInfo
{
    uiv_distanceInfoContainer = [[UIView alloc] initWithFrame:CGRectMake(panle_x, 6*kPanelBtnHeight + kPanelTitleHeight+15, panle_w, 85)];
    uiv_distanceInfoContainer.backgroundColor = [UIColor clearColor];
    
    UIView *uiv_toLoveField = [[UIView alloc] initWithFrame:CGRectMake(0, 0, panle_w, 40)];
    uiv_toLoveField.backgroundColor = [UIColor vcDarkBlue];
    UILabel *uil_toLoveField = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, panle_w - 20, 20)];
    uil_toLoveField.backgroundColor = [UIColor clearColor];
    uil_toLoveField.text = @"Victory Center to Love Field:";
    uil_toLoveField.textColor = [UIColor whiteColor];
    [uil_toLoveField setFont:[UIFont fontWithName:@"Raleway-Bold" size:11.0]];
    [uil_toLoveField setTextAlignment:NSTextAlignmentLeft];
    
    UILabel *uil_toLoveField1 = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 18.0, panle_w - 20, 20)];
    uil_toLoveField1.backgroundColor = [UIColor clearColor];
    uil_toLoveField1.text = @"8 miles, 13-15 minutes";
    uil_toLoveField1.textColor = [UIColor whiteColor];
    [uil_toLoveField1 setFont:[UIFont fontWithName:@"Raleway-Bold" size:11.0]];
    [uil_toLoveField1 setTextAlignment:NSTextAlignmentLeft];
    
    [uiv_toLoveField addSubview: uil_toLoveField];
    [uiv_toLoveField addSubview: uil_toLoveField1];
    
    UIView *uiv_toDall = [[UIView alloc] initWithFrame:CGRectMake(0, uiv_toLoveField.frame.size.height +  5, panle_w, 40)];
    uiv_toDall.backgroundColor = [UIColor vcDarkBlue];
    
    UILabel *uil_toDall = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, panle_w - 20, 20)];
    uil_toDall.backgroundColor = [UIColor vcDarkBlue];
    uil_toDall.text = @"Victory Center to Dall/Fort Worth";
    uil_toDall.textColor = [UIColor whiteColor];
    [uil_toDall setFont:[UIFont fontWithName:@"Raleway-Bold" size:11.0]];
    [uil_toDall setTextAlignment:NSTextAlignmentLeft];
    
    UILabel *uil_toDall1 = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 18.0, panle_w - 20, 20)];
    uil_toDall1.backgroundColor = [UIColor vcDarkBlue];
    uil_toDall1.text = @"International: 21 miles, 25-28 minutes";
    uil_toDall1.textColor = [UIColor whiteColor];
    [uil_toDall1 setFont:[UIFont fontWithName:@"Raleway-Bold" size:11.0]];
    [uil_toDall1 setTextAlignment:NSTextAlignmentLeft];
    
    [uiv_toDall addSubview: uil_toDall];
    [uiv_toDall addSubview: uil_toDall1];
    
    [uiv_distanceInfoContainer addSubview: uiv_toLoveField];
    [uiv_distanceInfoContainer addSubview: uiv_toDall];
    if (uiv_cityAccPanel) {
        [self.view insertSubview:uiv_distanceInfoContainer belowSubview:uiv_cityAccPanel];
    }
    if (uiv_neibAccPanel) {
        [self.view insertSubview:uiv_distanceInfoContainer belowSubview:uiv_neibAccPanel];
    }
    if (uiv_siteAccPanel) {
        [self.view insertSubview:uiv_distanceInfoContainer belowSubview:uiv_siteAccPanel];
    }
//    [_uiv_mapContainer addSubview: uiv_distanceInfoContainer];
    
    uiv_distanceInfoContainer.transform = CGAffineTransformMakeTranslation(0, -100);
    CGFloat duration = 0.5f;
    CGFloat damping = 0.8f;
    CGFloat velocity = 0.5f;
    // int to hold UIViewAnimationOption
    NSInteger option;
    option = UIViewAnimationCurveEaseInOut;
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:option animations:^{
        uiv_distanceInfoContainer.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){      }];
    
    UITapGestureRecognizer *tapOnAirDistance = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAirDistance:)];
    tapOnAirDistance.numberOfTapsRequired = 1;
    uiv_distanceInfoContainer.userInteractionEnabled = YES;
    [uiv_distanceInfoContainer addGestureRecognizer: tapOnAirDistance];
}

- (void)tapAirDistance:(UIGestureRecognizer *)gesture
{
    [_arr_pathItems removeAllObjects];
    _arr_pathItems = nil;
    _arr_pathItems = [[NSMutableArray alloc] init];
    NSMutableArray *arr_directionItems = [[NSMutableArray alloc] init];
    NSMutableArray *arr_directionItems2 = [[NSMutableArray alloc] init];
    embBezierPaths *paths; //For site map
    embDirections *dirpaths; // For city/neighborhood map
    paths = [[embBezierPaths alloc] init];
    arr_directionItems2 = paths.bezierPaths;
    dirpaths = [[embDirections alloc] init];
    arr_directionItems = dirpaths.bezierPaths;
    
    // actual drawpath function
    _embDirectionPath = [[embDrawPath alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    _embDirectionPath.delegate=self;
    //[_uiv_mapContainer insertSubview:_embDirectionPath atIndex:2];
    
    if (_uiiv_mapOverlay) {
        [_uiv_mapContainer insertSubview:_embDirectionPath aboveSubview:_uiiv_mapOverlay];
    } else {
        [_uiv_mapContainer insertSubview:_embDirectionPath belowSubview:_uiiv_vcLogo];
    }
    
    // loop # paths in a group
    int pathGrouping	= -1;
    int indexStart		= -1;
    
    if (_uiv_citySubMenu.hidden == NO) {
        pathGrouping	= 1;
        indexStart		= 12;
        _arr_pathItems = arr_directionItems;
    }
    
    if (_uiv_neighborhoodSubMenu.hidden == NO) {
        pathGrouping	= 1;
        indexStart		= 13;
        _arr_pathItems = arr_directionItems;
    }
    
    if (_uiv_siteSubMenu.hidden == NO) {
        pathGrouping	= 1;
        indexStart		= 4;
        _arr_pathItems = arr_directionItems2;
    }
    
    for (int i=0; i<pathGrouping; i++) {
        embBezierPathItem *p = _arr_pathItems[indexStart+i];
        _embDirectionPath.myPath = p.embPath;
        _embDirectionPath.animationSpeed = 1.0;
        _embDirectionPath.pathStrokeColor = p.pathColor;
        _embDirectionPath.pathLineWidth = p.pathWidth;
        _embDirectionPath.pathCapImage = [UIImage imageNamed:@"arrow.png"];
        _embDirectionPath.isTappable = NO;
        //        _embDirectionPath.pathCapImage = [UIImage imageNamed:@"arrow.png"];
        if(!_dirpathsArray){
            _dirpathsArray = [[NSMutableArray alloc] init];
            [_dirpathsArray addObject:_embDirectionPath]; // for removal later
        }
        //[_dirpathsArray addObject:_embDirectionPath]; // for removal later
        [_embDirectionPath startAnimationFromIndex:i afterDelay:p.pathDelay];
    }
}

#pragma mark City Amenities panel
- (void)addCityAmeniteisPanel
{
    uiv_cityAmePanel = [self setUpAmenitiesPanel];
    [self prepareHotspotData:@"city"];
    //Set up indicator's color array
    [arr_indicatorColors removeAllObjects];
    arr_indicatorColors = nil;
    arr_indicatorColors = [[NSMutableArray alloc] initWithObjects:[UIColor vcSiteRestaurant], [UIColor vcSiteRetail], [UIColor vcSiteResidentail], [UIColor vcSiteRecreation], nil];
}

#pragma  mark - Neighborhood Submenu

- (void)handleNeibSubMenu:(id)sender
{
    UIButton *tappedBtn = sender;
    if (tappedBtn.selected) {
        [self deHiliteSubMenu:_uiv_neighborhoodSubMenu];
        [self removeOverlay];
        [self removePaths];
        [self removeAllPanels];
        [self removeAllHotspots];
        return;
    }
    
    [self hiliteSubMenuTappedButton:sender inView:_uiv_neighborhoodSubMenu];
    [self removeOverlay];
    [self removePaths];
    [self removeAllPanels];
    [self removeAllHotspots];
    
    // Get -digit to detect which button is tapped
    // *1 --> load Neighborhood's Amenities panel
    // *2 --> load Neighborhood's Access panel
    int selectedIndex = (int)[sender tag]%10;
    if (selectedIndex == 1) { // Tapped Amenities
        [self addNeibAmenitiesPanel];
    }
    if (selectedIndex == 2) { // Tapped Access
        [self updateOverlayImage:@"Neigh_Access.png"];
        [self addNeibAccessPanel];
//        [self addDistanceInfo];
    }
    if (selectedIndex == 3) { // Tapped Districits
        [self updateOverlayImage:@"Neighborhood_Districts_Overlay.png"];
    }
}

#pragma mark Add panel for neighborhood amenities
- (void)addNeibAmenitiesPanel
{
    uiv_neibAmePanel = [self setUpAmenitiesPanel];
    [self prepareHotspotData:@"neighborhood"];
    uiv_neibAmePanel.alpha = 0.8;
    //Set up indicator's color array
    [arr_indicatorColors removeAllObjects];
    arr_indicatorColors = nil;
    arr_indicatorColors = [[NSMutableArray alloc] initWithObjects:[UIColor vcSiteRestaurant], [UIColor vcSiteRetail], [UIColor vcSiteResidentail], [UIColor vcSiteRecreation], nil];
}

#pragma mark Add panel for neighborhood access
- (void)addNeibAccessPanel
{
    uiv_neibAccPanel = [self setUpAccessPanel];
}

#pragma mark - Site Submenu
#pragma mark Site Submenu
- (void)handleSiteSubMenu:(id)sender
{
    UIButton *tappedBtn = sender;
    if (tappedBtn.selected) {
        [self deHiliteSubMenu:_uiv_siteSubMenu];
        [self removeOverlay];
        [self removePaths];
        [self removeAllPanels];
        [self removeAllHotspots];
        return;
    }
    
    [self hiliteSubMenuTappedButton:sender inView:_uiv_siteSubMenu];
    [self removeOverlay];
    [self removePaths];
    [self removeAllPanels];
    [self removeAllHotspots];
    [self removeOverviewPanel];
    // Get -digit to detect which button is tapped
    // *1 --> load Site's Overview's overlay
    // *2 --> load Site's Amenities panel
    // *3 --> load Site's Access panel
    int selectedIndex = (int)[sender tag]%10;
    if (selectedIndex == 1) { // Tapped Overview
        [self loadSiteOverview];
    }
    if (selectedIndex == 2) { // Tapped Amenities
        [self addSiteAmenitiesPanel];
        [self createBottomInfoBox];
    }
    if (selectedIndex == 3) { // Tapped Access
        [self addSiteAccessPanel];
    }
}

#pragma mark Load Over view
 - (void)loadSiteOverview
{
    if (_uiv_siteOverview) {
        [self removeOverviewPanel];
    }
    _uiv_overviewContainer = [[UIView alloc] initWithFrame:screenRect];
    _uiv_overviewContainer.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.4];
    UITapGestureRecognizer *tapOnOverview = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveOutOverview:)];
    [_uiv_overviewContainer addGestureRecognizer: tapOnOverview];
    _uiv_overviewContainer.userInteractionEnabled = YES;
    
    _uiv_siteOverview = [[siteOverview alloc] initWithFrame:CGRectMake(68.0, 170.0, 888.0, 360.0)];
//    _uiv_siteOverview = [[siteOverview alloc] initWithFrame:CGRectMake(68.0, 170.0, 888.0, 260.0)];
    _uiv_siteOverview.transform = CGAffineTransformMakeTranslation(0.0, -600);
    _uiv_siteOverview.alpha = 0.0;
    
    
    UILabel *overViewTitle = [[UILabel alloc] initWithFrame:CGRectMake((_uiv_siteOverview.frame.size.width - 200)/2, 0.0, 200.0, 50.0)];
    overViewTitle.backgroundColor = [UIColor clearColor];
    overViewTitle.text = @"OVERVIEW";
    overViewTitle.font = [UIFont fontWithName:@"Raleway-Bold" size:18.0];
    overViewTitle.textColor = [UIColor vcDarkBlue];
    overViewTitle.textAlignment = NSTextAlignmentCenter;
    [_uiv_siteOverview addSubview: overViewTitle];
    
    [_uiv_overviewContainer addSubview: _uiv_siteOverview];
    //        [self addCell];
    [self.view addSubview: _uiv_overviewContainer];
    // Animation for the overview image
    CGFloat duration = 0.8f;
    CGFloat damping = 0.5f;
    CGFloat velocity = 0.15f;
    // int to hold UIViewAnimationOption
    NSInteger option;
    option = UIViewAnimationCurveEaseInOut;
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:option animations:^{
        _uiv_siteOverview.alpha = 1.0;
        _uiv_siteOverview.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){      }];
}

- (void)moveOutOverview:(UIGestureRecognizer *)gesture
{
    [UIView animateWithDuration:0.33 animations:^{
        _uiv_siteOverview.transform = CGAffineTransformMakeTranslation(0.0, -600);
    } completion:^(BOOL finished){
        [self removeOverviewPanel];
        [self resetSubMenus];
    }];
}

#pragma mark Create cells in overview panel
- (void)addCell
{
    [arr_cells removeAllObjects];
    arr_cells = nil;
    arr_cells = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i++) {
        UIButton *uib_cell = [self createCellwithFrame:CGRectMake(41 + i*(25 + 184), 220, 184, 117) andImage:@"grfx_compass.png" andTag:i];
        [arr_cells addObject: uib_cell];
        [_uiv_siteOverview addSubview: uib_cell];
    }
}

- (UIButton *)createCellwithFrame:(CGRect)frame andImage:(NSString *)imageName andTag:(int)index
{
    UIButton *uib_cell = [UIButton buttonWithType: UIButtonTypeCustom];
    uib_cell.backgroundColor = [UIColor redColor];
    uib_cell.frame = frame;
    [uib_cell setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    uib_cell.tag = index;
    [uib_cell addTarget:self action:@selector(tapCell:) forControlEvents:UIControlEventTouchUpInside];
    return  uib_cell;
}

- (void)tapCell:(id)sender
{
    NSLog(@"The tapped cell is No.%i", (int)[sender tag]);
}

#pragma mark Add panel for site amenities
- (void)addSiteAmenitiesPanel
{
    uiv_siteAmePanel = [self createSiteAmenitiesPanel];
    [self prepareHotspotData:@"site"];
    uiv_siteAmePanel.alpha =  0.8;
    //Set up overlay's array
    [arr_overlayArray removeAllObjects];
    arr_overlayArray = nil;
    arr_overlayArray = [[NSMutableArray alloc] initWithObjects:@"grfx_recreationg_overlay.png", @"grfx_retail_overlay.png", @"grfx_residential_overlay.png", @"grfx_restaurant_overlay.png", @"grfx_site_parking.png", @"gfrx_all_overlay.png", nil];
    
    //Set up indicator's color array
    [arr_indicatorColors removeAllObjects];
    arr_indicatorColors = nil;
    arr_indicatorColors = [[NSMutableArray alloc] initWithObjects:[UIColor vcSiteRecreation], [UIColor vcSiteRetail], [UIColor vcSiteResidentail], [UIColor vcSiteRestaurant], [UIColor vcDarkBlue], [UIColor vcDarkBlue], nil];
}

#pragma mark Create Site Amenities' panel

- (UIView *)createSiteAmenitiesPanel
{
    [self updateHelpData];
    
    panel_h = 6*kPanelBtnHeight + kPanelTitleHeight;
    UIView *panel = [self createPanelWithTitle:@"AMENITIES" andHeight:panel_h];
    NSArray *arr_buttonTitles = [[NSArray alloc] initWithObjects:@"RECREATION", @"ACCOMMODATIONS", @"RESIDENTIAL", @"DINING", @"PARKING", @"VIEW ALL", nil];
    
    [self createBtnsForPanel:panel withTitleArray:arr_buttonTitles andTargetSel:@"tapSiteAmenities:" andEdgeInset:45.0 withIdicator:YES];
    [self.view insertSubview:panel belowSubview:_uiv_siteSubMenu];
    [self animateThePanel:panel];
    return panel;
}

#pragma mark Create bottom info box of site's amenities

- (void)createBottomInfoBox
{
    uiv_siteAmenInfo = [[UIView alloc] initWithFrame:CGRectMake(350.0, 700.0, 460.0, 55.0)];
    uiv_siteAmenInfo.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: uiv_siteAmenInfo];
    
    UIView *uiv_leftBar = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 10.0, 55.0)];
    uiv_leftBar.backgroundColor = [UIColor vcDarkBlue];
    [uiv_siteAmenInfo addSubview: uiv_leftBar];
    
    UILabel *uil_existing =[[UILabel alloc] initWithFrame:CGRectMake(18.0, 5.0, 260, 15)];
    uil_existing.backgroundColor = [UIColor clearColor];
    [uil_existing setText:@"E - EXISTING"];
    [uil_existing setFont:[UIFont fontWithName:@"Raleway-Bold" size:11.0]];
    [uil_existing setTextColor:[UIColor vcDarkBlue]];
    [uiv_siteAmenInfo addSubview: uil_existing];
    
    UILabel *uil_changing = [[UILabel alloc] initWithFrame:CGRectMake(18.0, 20.0, 260, 15)];
    uil_changing.backgroundColor = [UIColor clearColor];
    [uil_changing setText:@"E* - CONFIGURATION & RETAILER MAY CHANGE"];
    [uil_changing setFont:[UIFont fontWithName:@"Raleway-Bold" size:11.0]];
    [uil_changing setTextColor:[UIColor vcDarkBlue]];
    [uiv_siteAmenInfo addSubview: uil_changing];
    
    UILabel *uil_planing = [[UILabel alloc] initWithFrame:CGRectMake(18.0, 35.0, 260, 15)];
    uil_planing.backgroundColor = [UIColor clearColor];
    [uil_planing setText:@"PL - PLANNED"];
    [uil_planing setFont:[UIFont fontWithName:@"Raleway-Bold" size:11.0]];
    [uil_planing setTextColor:[UIColor vcDarkBlue]];
    [uiv_siteAmenInfo addSubview: uil_planing];
    
    UIImageView *uiiv_park = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"parking_icon.png"]];
    uiiv_park.frame = CGRectMake(290, 5.0, 15, 15);
    [uiv_siteAmenInfo addSubview: uiiv_park];
    
    UIImageView *uiiv_valet = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"valet_icon.png"]];
    uiiv_valet.frame = CGRectMake(290, 35.0, 15, 15);
    [uiv_siteAmenInfo addSubview: uiiv_valet];
    
    UILabel *uil_parking = [[UILabel alloc] initWithFrame:CGRectMake(318.0, 5.0, 100.0, 15.0)];
    uil_parking.backgroundColor = [UIColor clearColor];
    [uil_parking setText:@"PARKING"];
    [uil_parking setFont:[UIFont fontWithName:@"Raleway-Bold" size:11.0]];
    [uil_parking setTextColor:[UIColor vcDarkBlue]];
    [uiv_siteAmenInfo addSubview: uil_parking];
    
    UILabel *uil_valet = [[UILabel alloc] initWithFrame:CGRectMake(318.0, 35.0, 100.0, 15.0)];
    uil_valet.backgroundColor = [UIColor clearColor];
    [uil_valet setText:@"VALET PARKING"];
    [uil_valet setFont:[UIFont fontWithName:@"Raleway-Bold" size:11.0]];
    [uil_valet setTextColor:[UIColor vcDarkBlue]];
    [uiv_siteAmenInfo addSubview: uil_valet];
}

#pragma mark Actions for site amenities' buttons
- (void)tapSiteAmenities:(id)sender
{
    UIView *buttonContianer = [uiv_siteAmePanel viewWithTag:102];
    CGRect oriFrame = buttonContianer.frame;
    oriFrame.size.height = panel_h - kPanelTitleHeight;
    UIButton *tappedBtn = sender;
    if (tappedBtn.tag < 4) {
        if (tappedBtn.selected) {
            [self loadHotspotTable:sender];
            [UIView animateWithDuration:0.3 animations:^{
                _uiiv_mapOverlay.alpha = 0.0;
            }];
        }
        else {
            [self updateOverlayImage:[arr_overlayArray objectAtIndex:[sender tag]]];
            [self loadHotspotTable:sender];
        }
    }
    else {
        for (UIView __strong *tmp in arr_HotSpotViewArray) {
            [tmp removeFromSuperview];
            tmp = nil;
        }
        if (tappedBtn.selected) {
            [self deHighLightPanelBtn:tappedBtn];
            [UIView animateWithDuration:0.33 animations:^{
                buttonContianer.frame = oriFrame;
                [self resetButtonsAndIndicators:uiv_siteAmePanel];
                _uiiv_mapOverlay.alpha = 0.0;
            } completion:^(BOOL finished){
                [self deHighLightPanelBtn:sender];
            }];

        }
        else {
            [UIView animateWithDuration:0.33 animations:^{
                buttonContianer.frame = oriFrame;
                [self resetButtonsAndIndicators:uiv_siteAmePanel];
            } completion:^(BOOL finished){
                [self highLightPanelBtn:tappedBtn andIndicatorColor:[arr_indicatorColors objectAtIndex:tappedBtn.tag] withIndicator:YES];
                [self updateOverlayImage:[arr_overlayArray objectAtIndex:[sender tag]]];
                [_uiv_tablePanel removeFromSuperview];
                _uiv_tablePanel = nil;
            }];
        }
    }
    
    
//========Overlay Only==========
//    UIButton *tappedBtn = sender;
//    if (tappedBtn.selected) {
//        [self deHighLightPanelBtn:sender];
//        [UIView animateWithDuration:0.3 animations:^{
//            _uiiv_mapOverlay.alpha = 0.0;
//        }];
//    }
//    else {
//        [self highLightPanelBtn:sender andIndicatorColor:[arr_indicatorColors objectAtIndex:[sender tag]] withIndicator:YES];
//        [self updateOverlayImage:[arr_overlayArray objectAtIndex:[sender tag]]];
//    }
}

#pragma mark Add panel for site access
- (void)addSiteAccessPanel
{
    uiv_siteAccPanel = [self setUpAccessPanel];
}

#pragma mark Add building button and it's action

- (void)creatBuildingBtn
{
    uib_bldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    uib_bldBtn.frame = CGRectMake(500.0, 545.0, 206.0, 144.0);
    uib_bldBtn.backgroundColor = [UIColor clearColor];
    [_uiv_mapContainer addSubview: uib_bldBtn];
    [uib_bldBtn addTarget:self action:@selector(tapBldBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tapBldBtn:(id)sender
{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"Jump to Building Details"]
//                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [alert show];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"switchToBuilding" object:nil];
}

- (void)removeBldBtn
{
    if (uib_bldBtn) {
        [uib_bldBtn removeFromSuperview];
        uib_bldBtn = nil;
    }
}

#pragma mark - Create Access & Amenities panel

- (UIView *)setUpAccessPanel
{
    [self updateHelpData];
    
    panel_h = 6*kPanelBtnHeight + kPanelTitleHeight;
    UIView *panel = [self createPanelWithTitle:@"ACCESS" andHeight:panel_h];
    NSArray *arr_buttonTitles = [[NSArray alloc] initWithObjects:@"FROM DALLAS N. TOLLWAY", @"FROM WOODALL RODGERS", @"FROM KATY TRAIL", @"FROM I-35", @"FROM I-30", @"AIRPORTS", nil];
    [self createBtnsForPanel:panel withTitleArray:arr_buttonTitles andTargetSel:@"drawPathsFromBezierClass:" andEdgeInset:45.0 withIdicator:YES];
    [self.view insertSubview:panel belowSubview:_uiv_siteSubMenu];
    [self animateThePanel:panel];
    return panel;
}

- (UIView *)setUpAmenitiesPanel
{
    [self updateHelpData];
    
    panel_h = 4*kPanelBtnHeight + kPanelTitleHeight;
    UIView *panel = [self createPanelWithTitle:@"AMENITIES" andHeight:panel_h];
    NSArray *arr_buttonTitles = [[NSArray alloc] initWithObjects:@"RECREATION", @"ACCOMMODATIONS", @"RESIDENTIAL", @"DINING", nil];
    
    [self createBtnsForPanel:panel withTitleArray:arr_buttonTitles andTargetSel:@"loadHotspotTable:" andEdgeInset:45.0 withIdicator:YES];
    [self.view insertSubview:panel belowSubview:_uiv_siteSubMenu];
    [self animateThePanel:panel];
    return panel;
}
#pragma mark - Highlight & Dehightlight current tapped button of sub menu
/*
 Required Arguement:
 1. Tapped sub menu's button
 2. Button's superview --> sub menu's container
 */
- (void)hiliteSubMenuTappedButton:(id)sender inView:(UIView *)container
{
    UIButton *tappedBtn = sender;
    for (UIButton *tmp in [container subviews]) {
        tmp.selected = NO;

        [tmp.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14.0]];
    }
    tappedBtn.selected = YES;
    [tappedBtn.titleLabel setFont:[UIFont fontWithName:@"Raleway-ExtraBold" size:16.0]];
}

- (void)deHiliteSubMenu:(UIView *)container
{
    for (UIButton *tmp in [container subviews]) {
        tmp.selected = NO;
        
        [tmp.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14.0]];
    }
}

#pragma mark - update map's overlay
//Required Arguement: Overlay image file's name
- (void)updateOverlayImage:(NSString *)imageName
{
    NSString *name = [imageName substringWithRange:NSMakeRange(0, imageName.length-4)];
    NSString *extension = [imageName pathExtension];
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:extension];
    
    [UIView animateWithDuration:0.3 animations:^{
        _uiiv_mapOverlay.alpha = 0.0;
    } completion:^(BOOL finished){
        [_uiiv_mapOverlay removeFromSuperview];
        _uiiv_mapOverlay = nil;
        
        //If in Site map merge overlay with parking
        if (_uiv_siteSubMenu.hidden == NO) {
            UIImage *normalLayer = [UIImage imageWithContentsOfFile:path];
            CGSize size = screenRect.size;
            UIGraphicsBeginImageContext(size);
            
            [normalLayer drawInRect:screenRect];
            
            _uiiv_mapOverlay = [[UIImageView alloc] initWithImage:normalLayer];
            _uiiv_mapOverlay.frame = screenRect;
            _uiiv_mapOverlay.alpha = 0.0;
            [_uiv_mapContainer insertSubview:_uiiv_mapOverlay atIndex:1];
        }
        else {
            _uiiv_mapOverlay = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]];
            _uiiv_mapOverlay.frame = screenRect;
            _uiiv_mapOverlay.alpha = 0.0;
            [_uiv_mapContainer insertSubview: _uiiv_mapOverlay belowSubview:_uiiv_vcLogo];
        }
     
        [UIView animateWithDuration:0.3 animations:^{
            _uiiv_mapOverlay.alpha = 1.0;
        }];
    }];
}

#pragma mark - Create Panel
/*
 Required arguements:
 1. NSString panel's title
 2. float panel's height
 */

- (UIView *)createPanelWithTitle:(NSString *)title andHeight:(float)panelH
{
    UIView* uiv_panel = [[UIView alloc] initWithFrame:CGRectMake(panle_x, 0.0, panle_w, panelH)];
    uiv_panel.backgroundColor = [UIColor clearColor];
    
    UIButton *uib_PanelTitle = [UIButton buttonWithType:UIButtonTypeCustom];
    uib_PanelTitle.frame = CGRectMake(0.0, 0.0, panle_w, kPanelTitleHeight);
    [uib_PanelTitle setBackgroundImage:[UIImage imageNamed:@"grfx_access_nav.png"] forState:UIControlStateNormal];
    [uib_PanelTitle setTitle:title forState:UIControlStateNormal];
    [uib_PanelTitle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [uib_PanelTitle.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:16.0]];
    uib_PanelTitle.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 100);
    uib_PanelTitle.tag = 101;
    uib_PanelTitle.layer.borderWidth = 1.0;
    uib_PanelTitle.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    uib_PanelTitle.userInteractionEnabled = NO;
    [uiv_panel addSubview: uib_PanelTitle];
    return uiv_panel;
}

/*
 Highlighted selected panel buttons
 
 Required arguemnets:
 1. Tapped panel button
 2. Indicator's color
 3. With/out indicator bool value
 */

- (void)highLightPanelBtn:(id)sender andIndicatorColor:(UIColor *)color withIndicator:(BOOL)indicator
{
    for (UIButton *tmp in arr_panelBtnArray) {
        tmp.backgroundColor = [UIColor whiteColor];
        tmp.layer.borderWidth = 1.0;
        tmp.layer.borderColor = [UIColor vcButtonBorder].CGColor;
        tmp.selected = NO;
    }
    uiiv_airPlane.image = [UIImage imageNamed:@"Plane_Icon_Blue.png"];
    
    UIButton *tappedBtn = sender;
    tappedBtn.selected = YES;
    tappedBtn.backgroundColor = [UIColor vclightbluemenu];
    tappedBtn.layer.borderWidth = 1.0;
    tappedBtn.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    
    [uiv_panelIndicator removeFromSuperview];
    uiv_panelIndicator = nil;
    if (indicator) {
        CGRect frame = CGRectMake(19, tappedBtn.frame.origin.y + (tappedBtn.frame.size.height - 14)/2, 14, 14);
        uiv_panelIndicator = [[UIView alloc] initWithFrame:frame];
        uiv_panelIndicator.backgroundColor = color;
        uiv_panelIndicator.layer.borderColor = [UIColor vcDarkBlue].CGColor;
        uiv_panelIndicator.layer.borderWidth = 2.0;
        CGPoint savedCenter = uiv_panelIndicator.center;
        uiv_panelIndicator.layer.cornerRadius = 14.0 / 2.0;
        uiv_panelIndicator.center = savedCenter;
        if (tappedBtn.tag !=5) {
            [tappedBtn.superview addSubview: uiv_panelIndicator];
        }
        if (tappedBtn.tag == 5 && [tappedBtn.titleLabel.text isEqualToString:@"VIEW ALL"]) {
            [tappedBtn.superview addSubview: uiv_panelIndicator];
        }

    
    }
    if (tappedBtn.tag == 5) {
        uiiv_airPlane.image = [UIImage imageNamed:@"Plane_Icon_White.png"];
    }
}

- (void)deHighLightPanelBtn:(id)sender
{
    UIButton *tappedBtn = sender;
    tappedBtn.backgroundColor = [UIColor whiteColor];
    tappedBtn.layer.borderWidth = 1.0;
    tappedBtn.layer.borderColor = [UIColor vcButtonBorder].CGColor;
    
    [self unselectAllPanelBtns];
    if (tappedBtn.tag == 5) {
        uiiv_airPlane.image = [UIImage imageNamed:@"Plane_Icon_Blue.png"];
    }
    [uiv_panelIndicator removeFromSuperview];
    uiv_panelIndicator = nil;
}

- (void)unselectAllPanelBtns
{
    for (UIButton *tmp in arr_panelBtnArray) {
        tmp.selected = NO;
    }
}

#pragma mark Create panel's content (Buttons)
/*
 Required arguements:
 1. UIView      the panel
 2. NSArray     array of content buttons' titles
 3. NSString    name of button's target selector
 4. float       left edge inset for button's title
 5. Bool        with initial indicator or not
 */

- (void)createBtnsForPanel:(UIView *)panle withTitleArray:(NSArray *)arr_buttonTitles andTargetSel:(NSString *)methodName andEdgeInset:(float)leftEdge withIdicator:(BOOL)indicator
{
    [arr_panelBtnArray removeAllObjects];
    arr_panelBtnArray = nil;
    arr_panelBtnArray = [[NSMutableArray alloc] init];
    UIView *uiv_optionContainer = [[UIView alloc] init];
    uiv_optionContainer.backgroundColor = [UIColor whiteColor];
    uiv_optionContainer.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    uiv_optionContainer.layer.borderWidth = 1.0;
    uiv_optionContainer.frame = CGRectMake(0.0, kPanelTitleHeight, panle_w, panle.frame.size.height-kPanelTitleHeight);
    uiv_optionContainer.tag = 102;
    uiv_optionContainer.clipsToBounds = YES;
    
    SEL method = NSSelectorFromString(methodName);
    
    for (int i = 0; i < arr_buttonTitles.count; i++) {
        UIButton *uib_accOption = [UIButton buttonWithType:UIButtonTypeCustom];
        uib_accOption.frame = CGRectMake(0.0, i*kPanelBtnHeight, panle_w, kPanelBtnHeight);
        uib_accOption.backgroundColor = [UIColor whiteColor];
        uib_accOption.layer.borderWidth = 1.0;
        uib_accOption.layer.borderColor = [UIColor vcButtonBorder].CGColor;
        [uib_accOption setTitle:arr_buttonTitles[i] forState:UIControlStateNormal];
        [uib_accOption setTitleColor:[UIColor vcDarkBlue] forState:UIControlStateNormal];
        [uib_accOption.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:12.0]];
        uib_accOption.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        uib_accOption.titleEdgeInsets = UIEdgeInsetsMake(3.0, leftEdge, 0.0, 0.0);
        uib_accOption.tag = i;
        [uib_accOption addTarget:self action:method forControlEvents:UIControlEventTouchUpInside];
        [uiv_optionContainer addSubview: uib_accOption];
        UIView *uiv_Indicator;
        if (indicator) {
            CGRect frame = CGRectMake(19, uib_accOption.frame.origin.y + (uib_accOption.frame.size.height - 14)/2, 14, 14);
            uiv_Indicator = [[UIView alloc] initWithFrame:frame];
            uiv_Indicator.backgroundColor = [UIColor clearColor];
            uiv_Indicator.layer.borderColor = [UIColor vcDarkBlue].CGColor;
            uiv_Indicator.layer.borderWidth = 2.0;
            CGPoint savedCenter = uiv_Indicator.center;
            uiv_Indicator.layer.cornerRadius = 14.0 / 2.0;
            uiv_Indicator.center = savedCenter;
            uiv_Indicator.tag = 500+i;
            [uiv_optionContainer addSubview: uiv_Indicator];
        }
        
        if ([arr_buttonTitles[i]  isEqual: @"AIRPORTS"]) {
            uiiv_airPlane = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Plane_Icon_Blue.png"]];
            uiiv_airPlane.frame = CGRectMake(16.0, uib_accOption.frame.origin.y + (uib_accOption.frame.size.height - 20)/2, 20, 20);
            [uiv_optionContainer addSubview: uiiv_airPlane];
            [uiv_Indicator removeFromSuperview];
        }
        [arr_panelBtnArray addObject: uib_accOption];
    }
    [panle insertSubview: uiv_optionContainer belowSubview:[panle viewWithTag:101]];
}

#pragma mark - Animate the panel
//Drop down the menu
- (void)animateThePanel:(UIView *)panel
{
    panel.transform = CGAffineTransformMakeTranslation(0.0, - kPanelTitleHeight * 10);
    [panel viewWithTag:101].transform = CGAffineTransformMakeTranslation(0.0, - kPanelTitleHeight * 5);
    [panel viewWithTag:102].transform = CGAffineTransformMakeTranslation(0.0, - kPanelTitleHeight * 10);
    
    // Animation for the overview image
    CGFloat duration = 0.5f;
    CGFloat damping = 0.7f;
    CGFloat velocity = 0.68f;
    // int to hold UIViewAnimationOption
    NSInteger option;
    option = UIViewAnimationCurveEaseInOut;
    
    [UIView animateWithDuration:duration animations:^{
        [panel viewWithTag:101].transform = CGAffineTransformIdentity;
        [panel viewWithTag:102].transform = CGAffineTransformIdentity;
    }];
    
    [UIView animateWithDuration:duration*1.5 delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:option animations:^{
        panel.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){      }];
}

#pragma mark - Load data for hotspots and animation for panel extension
#pragma mark  Reset panel's size to load table view
- (void)loadHotspotTable:(id)sender
{
    UIButton *tappedBtn = sender;
    UIView *buttonContianer = tappedBtn.superview; //[uiv_neibAmePanel viewWithTag:102];
    UIView *thePanel = buttonContianer.superview;
    if (tappedBtn.selected) {
        CGRect frame = buttonContianer.frame;
        frame.size.height = panel_h - kPanelTitleHeight;//4*kPanelBtnHeight;
        [UIView animateWithDuration:0.33 animations:^{
            [self resetButtonsAndIndicators:thePanel];
            for (UIView *tmp in arr_HotSpotViewArray) {
                tmp.alpha = 0.0;
            }
            buttonContianer.frame = frame;
        } completion:^(BOOL finished){
            [self deHighLightPanelBtn:sender];
            return;
        }];
    }
    
    else {
        
        //Check if panel is opened:
        //Do the animation of shrink , change highlighted button and expension
        if (buttonContianer.frame.size.height > 4*kPanelBtnHeight) {
            CGRect frame = buttonContianer.frame;
            frame.size.height = panel_h - kPanelTitleHeight;//4*kPanelBtnHeight;
            [UIView animateWithDuration:0.33 animations:^{
                [self resetButtonsAndIndicators:thePanel];
                buttonContianer.frame = frame;
            } completion:^(BOOL finished){
                [self expandAmenityPanel:sender];
            }];
        }
        else {
            [self expandAmenityPanel:sender];
        }
    }
}

- (void)expandAmenityPanel:(id)sender
{
    UIButton *tappedBtn = sender;
    //Get button's contianer
    UIView *buttonContianer = tappedBtn.superview;//[uiv_neibAmePanel viewWithTag:102];
    //Get the current panel
    UIView *thePanel = buttonContianer.superview;
    
    //Add hotspots accroding to index
    [self createHotspots:(int)[sender tag]];
    
    if (arr_HotSpotXY.count >= 9) {
        kTableHeight = 280.0;
    }
    else {
        kTableHeight = 150.0;
    }
    
    //Update position of table view's position
    [_uiv_tablePanel removeFromSuperview];
    _uiv_tablePanel = nil;
    _uiv_tablePanel = [[UIView alloc] init];
    UIButton *firstBtn = [arr_panelBtnArray objectAtIndex:0];
    _uiv_tablePanel.frame = CGRectMake(0.0, kPanelBtnHeight*([sender tag] + 1), panle_w, kTableHeight+10);
    _uiv_tablePanel.backgroundColor = [UIColor vcPanelBackgroundColor];
    
    //Update table view's content data
    [self loadHotspotTableView:(int)[sender tag]];
    //Add table view under buttons' container
    
    
    [buttonContianer insertSubview:_uiv_tablePanel aboveSubview:firstBtn];
    
    //Update Amenities panel's height
    CGRect oldFrame = thePanel.frame;
    oldFrame.size.height = kTableHeight + thePanel.frame.size.height;  //kExpendedHeight;
    thePanel.frame = oldFrame;
    CGRect containerOldFrame = buttonContianer.frame;
    containerOldFrame.size.height = oldFrame.size.height-kPanelTitleHeight;
    
    CGFloat duration = 0.5f;
    CGFloat damping = 0.7f;
    CGFloat velocity = 1.0f;
    // int to hold UIViewAnimationOption
    NSInteger option;
    option = UIViewAnimationCurveEaseInOut;
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:option animations:^{
        buttonContianer.frame = containerOldFrame;
        [self rearrangeBtns:(int)[sender tag]];
        [self rearrangeIndicator:(int)[sender tag] andInContainer:buttonContianer];
        [self highLightPanelBtn:sender andIndicatorColor:[arr_indicatorColors objectAtIndex:[sender tag]] withIndicator:YES];
    } completion:^(BOOL finished){      }];
}

// Move all buttons have bigger index to bottom panel
- (void)rearrangeBtns:(int)index
{
    for (UIButton *tmp in arr_panelBtnArray) {
        if (tmp.tag > index) {
            tmp.transform = CGAffineTransformMakeTranslation(0.0, kTableHeight);
        }
    }
}
// Move indicators to correct position
- (void)rearrangeIndicator:(int)index andInContainer:(UIView *)container
{
    for (UIView *tmp in [[container viewWithTag:102] subviews]) {
        if (tmp.tag >=500) {
            if (tmp.tag-500 > index) {
                tmp.transform = CGAffineTransformMakeTranslation(0.0, kTableHeight);
            }
        }
    }
}

- (void)resetButtonsAndIndicators:(UIView *)panel
{
    panel.frame = CGRectMake(panle_x, 0.0, panle_w, panel_h);
    for (UIButton *tmp in arr_panelBtnArray) {
        tmp.transform = CGAffineTransformIdentity;
    }
    for (UIView *tmp in [[panel viewWithTag:102] subviews]) {
        if (tmp.tag >=500) {
            tmp.transform = CGAffineTransformIdentity;
        }
    }
}
#pragma mark Load Hotspot data and hotspot view
- (void) prepareHotspotData:(NSString *)section
{
    [arr_HotSpotsRaw removeAllObjects];
    arr_HotSpotsRaw = nil;
    [arr_HotSpotCategories removeAllObjects];
    arr_HotSpotCategories = nil;
    
    // Build the array from the plist
	arr_HotSpotsRaw = [[NSMutableArray alloc] init];
	arr_HotSpotsRaw = [[NSMutableArray alloc] initWithArray:[dict_HotSpotsRaw objectForKey:section]];
    
	// get all categories from array (use if needed)
	arr_HotSpotCategories = [[NSMutableArray alloc] init];
    arr_HotSpotData = [[NSMutableArray alloc] init];
	for (NSDictionary *hotspotsDict in arr_HotSpotsRaw) { // iterate through the array
		NSString *floorplan = [hotspotsDict valueForKeyPath:@"category"];
		[arr_HotSpotCategories addObject:floorplan];
        NSArray *hotspotData = [hotspotsDict valueForKeyPath:@"hotspots"];
        [arr_HotSpotData addObject: hotspotData];
	}
    
}

//Load & update hotspot table list
- (void)loadHotspotTableView:(int)index
{
    [_vc_hotspotList.view removeFromSuperview];
    _vc_hotspotList.view = nil;
    [_vc_hotspotList removeFromParentViewController];
    _vc_hotspotList = nil;
    
    _vc_hotspotList = [[embMapHotspotListViewController alloc] initWithNibName:nil bundle:nil];
	_vc_hotspotList.delegate = self;
    _vc_hotspotList.view.backgroundColor = [UIColor clearColor];
    _vc_hotspotList.view.tag = index;
    
    _vc_hotspotList.incomingData = arr_HotSpotsRaw;
    _vc_hotspotList.category = arr_HotSpotCategories[index];
    _vc_hotspotList.numColor = arr_indicatorColors[index]; //Color for index label
    
    CGRect frame = CGRectMake(0.0, 7.0, panle_w, kTableHeight - 10);
    _vc_hotspotList.view.frame = frame;
    
    [_uiv_tablePanel addSubview: _vc_hotspotList.view];
    [_vc_hotspotList didMoveToParentViewController:self];
}

- (void)createHotspots:(int)index
{
    for (UIView *tmp in arr_HotSpotViewArray) {
        [UIView animateWithDuration:0.2 animations:^{
            tmp.alpha = 0.0;
        } completion:^(BOOL finished){
            [tmp removeFromSuperview];
        }];
    }
    [arr_HotSpotViewArray removeAllObjects];
    arr_HotSpotViewArray = nil;
    [arr_HotSpotXY removeAllObjects];
    arr_HotSpotXY = nil;
    arr_HotSpotViewArray = [[NSMutableArray alloc] init];
    arr_HotSpotXY = [[NSMutableArray alloc] init];
    
    //Get hotspots' x and y value and add to array
    for (NSDictionary *itemData in arr_HotSpotData[index]) {
        [arr_HotSpotXY addObject: [itemData objectForKey:@"xy"]];
    }
    
    for (int i =0; i < arr_HotSpotXY.count; i++) {
        UIView *hotspotView = [[UIView alloc] init];
        hotspotView.backgroundColor = [UIColor whiteColor];
        CGPoint centerPoint = CGPointFromString([NSString stringWithFormat:@"{%@}", arr_HotSpotXY[i]]);
        hotspotView.center = centerPoint;
        UIColor *borderColor = [arr_indicatorColors objectAtIndex:index];
        [self setHotspotRoundedView:hotspotView toDiameter:30 num:i+1 andColor:borderColor];
        hotspotView.layer.borderWidth = 3.0;
        hotspotView.layer.borderColor = borderColor.CGColor;
        hotspotView.tag=i + 100*(index+1);
        [arr_HotSpotViewArray addObject: hotspotView];
        [_uiv_mapContainer insertSubview:hotspotView belowSubview:_uiiv_vcLogo];
    }
    
}

- (void)setHotspotRoundedView:(UIView *)roundedView toDiameter:(float)newSize num:(int)i andColor:(UIColor *)textColor
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
    
    UILabel *numLabel = [[UILabel alloc] initWithFrame:roundedView.bounds];
    numLabel.font = [UIFont boldSystemFontOfSize:12.0];
    numLabel.backgroundColor = [UIColor clearColor];
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    numLabel.textColor = textColor;
	numLabel.text = [NSString stringWithFormat:@"%i",i%100];
    numLabel.font = [UIFont systemFontOfSize:16];
	[roundedView addSubview:numLabel];
    
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hotspotTapped:)];
	[tapG setNumberOfTapsRequired:1];
	[tapG setDelegate:self];
	[roundedView addGestureRecognizer:tapG];
    roundedView.userInteractionEnabled = YES;
}

- (void)hotspotTapped:(UIGestureRecognizer *)gesture
{
    int index = (int)gesture.view.tag;
    NSIndexPath *myIP;
    // index%100 is the index of the hotspot in array
    myIP = [NSIndexPath indexPathForRow: index%100 inSection:0];
    [_vc_hotspotList rowToSelect:myIP];
    [self hiliteHotSpot: index];
}

- (void)hiliteHotSpot:(int)index
{
    // index%100 is the index of the hotspot in array
    // index/100 is the index of amentites' section
    
    UIColor *theColor = [arr_indicatorColors objectAtIndex:index/100-1];
    
    if (_uiv_tappedHotspot) {
        _uiv_tappedHotspot.backgroundColor = [UIColor whiteColor];
        _uiv_tappedHotspot.layer.borderWidth = 3.0;
        _uiv_tappedHotspot.layer.borderColor = theColor.CGColor;
        for (UILabel *tmp in [_uiv_tappedHotspot subviews]) {
            tmp.textColor = theColor;
        }
    }
    
    _uiv_tappedHotspot = [arr_HotSpotViewArray objectAtIndex:index%100];
    [_uiv_tappedHotspot removeFromSuperview];
    [_uiv_mapContainer insertSubview:_uiv_tappedHotspot belowSubview:_uiiv_vcLogo];
    _uiv_tappedHotspot.backgroundColor = theColor;
    _uiv_tappedHotspot.layer.borderWidth = 3.0;
    _uiv_tappedHotspot.layer.borderColor = [UIColor whiteColor].CGColor;
    for (UILabel *tmp in [_uiv_tappedHotspot subviews]) {
        tmp.textColor = [UIColor whiteColor];
    }
}

- (void)removeAllHotspots
{
    for (UIView __strong *tmp in arr_HotSpotViewArray) {
        [tmp removeFromSuperview];
        tmp = nil;
    }
}
#pragma mark Delegate method of embMapHotspotListViewController
// Delegate method of class embMapHotspotListViewController
- (void)childViewController:(embMapHotspotListViewController*)viewController
               didChooseRow:(NSInteger)rowIndex
{
    //Get current amenities' section index
    int index = (int)_vc_hotspotList.view.tag;
    [self hiliteHotSpot:(int)rowIndex+(index+1)*100];
}

#pragma mark - Draw Path
-(void)drawPathsFromBezierClass:(id)sender
{
//    UIAlertView *alert =
//    [[UIAlertView alloc] initWithTitle: @""
//                               message: @"Proper derection coming soon."
//                              delegate: self
//                     cancelButtonTitle: @"OK"
//                     otherButtonTitles: nil];
//    alert.tag = 1;
//    [alert show];

    
    // clean up
	[self removePaths];
    if (uiv_distanceInfoContainer) {
        [self removeDistanceLabels];
    }
    
    UIButton *tappedBtn = sender;
    if (tappedBtn.selected) {
        [self deHighLightPanelBtn:sender];
        for (UIButton *tmp in arr_panelBtnArray) {
            tmp.selected = NO;
        }
        return;
    }
    
    [self highLightPanelBtn:sender andIndicatorColor:[UIColor vcPathColor] withIndicator:YES];
    
    if (tappedBtn.tag == 5) {
        [self addDistanceInfo];
        return;
    }
    
    [_arr_pathItems removeAllObjects];
    _arr_pathItems = nil;
	_arr_pathItems = [[NSMutableArray alloc] init];
    NSMutableArray *arr_directionItems = [[NSMutableArray alloc] init];
    NSMutableArray *arr_directionItems2 = [[NSMutableArray alloc] init];
	embBezierPaths *paths; //For site map
	embDirections *dirpaths; // For city/neighborhood map
    paths = [[embBezierPaths alloc] init];
    arr_directionItems2 = paths.bezierPaths;
    dirpaths = [[embDirections alloc] init];
    arr_directionItems = dirpaths.bezierPaths;
	
	// actual drawpath function
	_embDirectionPath = [[embDrawPath alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
	_embDirectionPath.delegate=self;
	//[_uiv_mapContainer insertSubview:_embDirectionPath atIndex:2];
	
	if (_uiiv_mapOverlay) {
		[_uiv_mapContainer insertSubview:_embDirectionPath aboveSubview:_uiiv_mapOverlay];
	} else {
		[_uiv_mapContainer insertSubview:_embDirectionPath belowSubview:_uiiv_vcLogo];
	}
    
	// loop # paths in a group
	int pathGrouping	= -1;
	int indexStart		= -1;
    
    if (_uiv_citySubMenu.hidden == NO) {
        switch ([sender tag]) {
			case 0:
				pathGrouping	= 1;
				indexStart		= 0;
				break;
				
			case 1:
				pathGrouping	= 1;
				indexStart		= 1;
				break;
				
			case 2:
				pathGrouping	= 1;
				indexStart		= 2;
				break;
				
			case 3:
				pathGrouping	= 2;
				indexStart		= 3;
				break;
				
			case 4:
				pathGrouping	= 1;
				indexStart		= 5;
				break;
			default:
				break;
		}
        _arr_pathItems = arr_directionItems;
    }

    if (_uiv_neighborhoodSubMenu.hidden == NO) {
        switch ([sender tag]) {
			case 0:
				pathGrouping	= 1;
				indexStart		= 6;
				break;
				
			case 1:
				pathGrouping	= 1;
				indexStart		= 7;
				break;
				
			case 2:
				pathGrouping	= 1;
				indexStart		= 8;
				break;
				
			case 3:
				pathGrouping	= 2;
				indexStart		= 9;
				break;
				
			case 4:
				pathGrouping	= 1;
				indexStart		= 11;
				break;
			default:
				break;
		}
        _arr_pathItems = arr_directionItems;
    }

    if (_uiv_siteSubMenu.hidden == NO) {
        switch ([sender tag]) {
			case 0:
				pathGrouping	= 1;
				indexStart		= 0;
				break;
				
			case 1:
				pathGrouping	= 1;
				indexStart		= 1;
				break;
				
			case 2:
				pathGrouping	= 1;
				indexStart		= 0;
				break;
				
			case 3:
				pathGrouping	= 2;
				indexStart		= 2;
				break;
				
			case 4:
				pathGrouping	= 1;
				indexStart		= 3;
				break;
			default:
				break;
		}
        _arr_pathItems = arr_directionItems2;
    }

	for (int i=0; i<pathGrouping; i++) {
		embBezierPathItem *p = _arr_pathItems[indexStart+i];
		_embDirectionPath.myPath = p.embPath;
		_embDirectionPath.animationSpeed = 1.0;
		_embDirectionPath.pathStrokeColor = p.pathColor;
		_embDirectionPath.pathLineWidth = p.pathWidth;
		_embDirectionPath.pathCapImage = [UIImage imageNamed:@"arrow.png"];
		_embDirectionPath.isTappable = NO;
        //        _embDirectionPath.pathCapImage = [UIImage imageNamed:@"arrow.png"];
		if(!_dirpathsArray){
			_dirpathsArray = [[NSMutableArray alloc] init];
			[_dirpathsArray addObject:_embDirectionPath]; // for removal later
		}
		//[_dirpathsArray addObject:_embDirectionPath]; // for removal later
		[_embDirectionPath startAnimationFromIndex:i afterDelay:p.pathDelay];
	}
}

-(void)removePaths
{
	NSInteger i = 0;
	for(embDrawPath *pathView in _dirpathsArray) {
		if([pathView isKindOfClass:[embDrawPath class]]) {
			UIViewAnimationOptions options = UIViewAnimationOptionAllowUserInteraction;
			[UIView animateWithDuration:.2 delay:((0.05 * i) + 0.2) options:options
							 animations:^{
								 pathView.alpha = 0.0;
							 }
							 completion:^(BOOL finished){
								 [pathView embDrawPathShouldRemove];
							 }];
			i += 1;
		}
	}
	[_embDirectionPath removeFromSuperview];
	_embDirectionPath=nil;
}

#pragma mark - Create map switcher container and buttons
- (void)setUpSwitcherContainer
{
    arr_switcherArray = [[NSMutableArray alloc] init];
    [self initSwitcherButton:_uib_normalMap andTitle:@"MAP" andTag:41 andSelected:YES];
    [self initSwitcherButton:_uib_appleMap andTitle:@"APPLE MAP" andTag:42 andSelected:NO];
    [self initSwitcherButton:_uib_googleMap andTitle:@"GOOGLE EARTH" andTag:43 andSelected:NO];
}

- (void)initSwitcherButton:(UIButton *)theBtn andTitle:(NSString *)title andTag:(int)index andSelected:(BOOL)selected
{
    [theBtn setTitle:title forState:UIControlStateNormal];
    [theBtn setTitle:title forState:UIControlStateSelected];
    [theBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [theBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [theBtn.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14]];
    theBtn.tag = index;
    theBtn.selected = selected;
    [theBtn setContentEdgeInsets:UIEdgeInsetsMake(3, 0, 0, 0)];
    [theBtn addTarget:self action:@selector(tapMapSwitcher:) forControlEvents:UIControlEventTouchUpInside];
    if (selected) {
        theBtn.backgroundColor = [UIColor vcDarkBlue];
    }
    else{
        theBtn.backgroundColor = [UIColor vcLightBlue];
    }
    [arr_switcherArray addObject: theBtn];
}
#pragma mark Actions of map switcher
- (void)tapMapSwitcher:(id)sender
{
    UIButton *tappedBtn = sender;
    if (tappedBtn.selected) {
        return;
    }
    
    for (UIButton *tmp in arr_switcherArray) {
        tmp.selected = NO;
        tmp.backgroundColor = [UIColor vcLightBlueAlpha];
    }
    tappedBtn.selected = YES;
    tappedBtn.backgroundColor = [UIColor vcDarkBlue];
    
    int index = (int)tappedBtn.tag;
    switch (index) {
        case 41: {
            [self removeAppleMap];
            break;
        }
        case 42: {
            [self initAppleMap];
            break;
        }
        case 43: {
            [self loadGoogleEarth];
            break;
        }
        default:
            break;
    }
}

- (void)initAppleMap
{
    [self removeAppleMap];
    _uiv_appleMapContainer = [[UIView alloc] initWithFrame:screenRect];
    _mapView = [[MKMapView alloc] initWithFrame:screenRect];
    _mapView.delegate = self;
    _mapView.mapType = MKMapTypeStandard;
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 32.7888204;
    zoomLocation.longitude= -96.8118198;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    // 3
    [_mapView setRegion:viewRegion animated:NO];
    [_uiv_appleMapContainer addSubview: _mapView];
    [self.view insertSubview:_uiv_appleMapContainer belowSubview:_uiv_mapSwitchContainer];
    MapViewAnnotation *newAnnotation = [[MapViewAnnotation alloc] initWithTitle:@"Victory Center" andCoordinate:zoomLocation];
    [self.mapView addAnnotation:newAnnotation];
}

- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{
	MKAnnotationView *annotationView = [views objectAtIndex:0];
	id <MKAnnotation> mp = [annotationView annotation];
    MKCoordinateRegion region;
	if (!_uiv_citySubMenu.hidden) {
        region = MKCoordinateRegionMakeWithDistance([mp coordinate], 8500, 8500);
    }
    if (!_uiv_neighborhoodSubMenu.hidden) {
        region = MKCoordinateRegionMakeWithDistance([mp coordinate], 3000, 3000);
    }
	[mv setRegion:region animated:YES];
	[mv selectAnnotation:mp animated:YES];
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    _mapView.centerCoordinate =
	userLocation.location.coordinate;
}

- (void)removeAppleMap
{
    [_uiv_appleMapContainer removeFromSuperview];
    _uiv_appleMapContainer = nil;
    [_mapView removeFromSuperview];
    _mapView = nil;
}

- (void)loadGoogleEarth
{
    NSURL *urlApp = [NSURL URLWithString:@"comgoogleearth://"];
	BOOL canOpenApp = [[UIApplication sharedApplication] canOpenURL:urlApp];
	printf("\n canOpenGoogleEarth:%i \n",canOpenApp);
	
	if (canOpenApp) {
        
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle: @""
								   message: @"Tap OK to switch from Victory Center to Google Earth."
								  delegate: self
						 cancelButtonTitle: @"Cancel"
						 otherButtonTitles: @"OK",nil];
        alert.tag = 1;
		[alert show];
	} else {
		UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle: @"Sorry!"
								   message: @"You need Google Earth installed."
								  delegate: self
						 cancelButtonTitle: @"Cancel"
						 otherButtonTitles: @"Install",nil];
        alert.tag = 2;
		[alert show];
	}
}

- (void) alertView: (UIAlertView *)alertView clickedButtonAtIndex: (NSInteger) buttonIndex {
    if (alertView.tag == 1) {
        if (buttonIndex==1) {
            NSURL *urlApp = [NSURL URLWithString:@"comgoogleearth://"];
            [[UIApplication sharedApplication] canOpenURL:urlApp];
            NSString *stringURL = @"comgoogleearth://";
            NSURL *url = [NSURL URLWithString:stringURL];
            [[UIApplication sharedApplication] openURL:url];
        }
        if (buttonIndex == 0) {
            [self tapMapSwitcher:_uib_normalMap];
        }
    }
    else {
        if (buttonIndex==1) {
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"https://itunes.apple.com/us/app/google-earth/id293622097?mt=8"]];
        }
        if (buttonIndex == 0) {
            [self tapMapSwitcher:_uib_normalMap];
        }
    }
}

#pragma mark - Add Help view
- (void)hideAndUnhideHelp:(NSNotification *)pNotification
{
    if (_uiv_helpView.onScreen) {
        [UIView animateWithDuration:0.33 animations:^{
            _uiv_helpView.alpha = 0.0;
        } completion:^(BOOL finsihed){
            [_uiv_helpView removeFromSuperview];
            _uiv_helpView = nil;
        }];
    }
    else {
        [self loadHelpViews];
    }
}

- (void)prepareHlepData
{
    [_arr_helpText removeAllObjects];
    _arr_helpText = nil;
    _arr_helpText = [[NSMutableArray alloc] initWithObjects:
                     @"Tap to load main menu",
                     @"Tap section titles to change sections. Tap subtitles to change that sections content",
                     @"Tap to change map's type",
                     @"Tap to zoom in and out map",
                     nil];
    
    [_arr_helpTargetViews removeAllObjects];
    _arr_helpTargetViews = nil;
    // Home Button
    UIButton *homeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 45.0, 45.0)];
    // Top menu Button
    UIView *tmp1 = [[UIView alloc] initWithFrame:CGRectMake(523.0, 0.0, 130.0, 34.0)];
    // Bottom map's type buttons
    UIView *tmp3 = [[UIView alloc] initWithFrame:CGRectMake(515.0, 715.0, 1.0, 1.0)];
    // Pinch to zoom
    UIView *tmp4 = [[UIView alloc] initWithFrame:CGRectMake(500.0, 420.0, 1.0, 1.0)];
    _arr_helpTargetViews = [[NSMutableArray alloc] initWithObjects:homeBtn, tmp1, tmp3, tmp4, nil];
}

- (void)updateHelpData
{
    [_arr_helpText removeAllObjects];
    _arr_helpText = nil;
    _arr_helpText = [[NSMutableArray alloc] initWithObjects:
                     @"Tap to load main menu",
                     @"Tap section titles to change sections. Tap subtitles to change that sections content",
                     @"Tap to change map's type",
                     @"Tap to zoom in and out map",
                     @"Tap to load more info",
                     nil];
    
    [_arr_helpTargetViews removeAllObjects];
    _arr_helpTargetViews = nil;
    // Home Button
    UIButton *homeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 45.0, 45.0)];
    // Top menu Button
    UIView *tmp1 = [[UIView alloc] initWithFrame:CGRectMake(523.0, 0.0, 130.0, 34.0)];
    // Bottom map's type buttons
    UIView *tmp3 = [[UIView alloc] initWithFrame:CGRectMake(515.0, 715.0, 1.0, 1.0)];
    // Pinch to zoom
    UIView *tmp4 = [[UIView alloc] initWithFrame:CGRectMake(500.0, 420.0, 1.0, 1.0)];
    // Pinch to zoom
    UIView *tmp5 = [[UIView alloc] initWithFrame:CGRectMake(800.0, 220.0, 1.0, 1.0)];
    _arr_helpTargetViews = [[NSMutableArray alloc] initWithObjects:homeBtn, tmp1, tmp3, tmp4, tmp5, nil];
}

- (void)loadHelpViews
{
    if (_uiv_helpView) {
        [_uiv_helpView removeFromSuperview];
        _uiv_helpView = nil;
    }
    _uiv_helpView = [[xhPopTipsView alloc] initWithFrame:screenRect andText:_arr_helpText andViews:_arr_helpTargetViews];
    [self.view addSubview: _uiv_helpView];
}




#pragma mark - Remove items and release memory

- (void)removeDistanceLabels
{
    [UIView animateWithDuration:0.2 animations:^{
        uiv_distanceInfoContainer.transform = CGAffineTransformMakeTranslation(0.0, -100);
    } completion:^(BOOL finished){
        [uiv_distanceInfoContainer removeFromSuperview];
        uiv_distanceInfoContainer = nil;
    }];
}

- (void)removeOverviewPanel
{
    [_uiv_overviewContainer removeFromSuperview];
    _uiv_overviewContainer = nil;
}

- (void)removeOverlay
{
    [_uiiv_mapOverlay removeFromSuperview];
    _uiiv_mapOverlay = nil;
}

- (void)removeAllPanels
{
    [self prepareHlepData];
    
    [uiv_cityAccPanel removeFromSuperview];
    uiv_cityAccPanel = nil;
    
    [uiv_neibAccPanel removeFromSuperview];
    uiv_neibAccPanel = nil;
    
    [uiv_siteAccPanel removeFromSuperview];
    uiv_siteAccPanel = nil;
    
    [uiv_cityAmePanel removeFromSuperview];
    uiv_cityAmePanel = nil;
    
    [uiv_neibAmePanel removeFromSuperview];
    uiv_neibAmePanel = nil;
    
    [uiv_siteAmePanel removeFromSuperview];
    uiv_siteAmePanel = nil;
    
    [uiv_distanceInfoContainer removeFromSuperview];
    uiv_distanceInfoContainer = nil;
    
    [uiv_siteAmenInfo removeFromSuperview];
    uiv_siteAmenInfo = nil;
}

- (void)removeHotspots
{
    [arr_HotSpotsRaw removeAllObjects];
    arr_HotSpotsRaw = nil;
    
    [arr_HotSpotCategories removeAllObjects];
    arr_HotSpotCategories = nil;
    
    [arr_HotSpotData removeAllObjects];
    arr_HotSpotData = nil;
    
    [arr_HotSpotXY removeAllObjects];
    arr_HotSpotXY = nil;
    
    for (UIView __strong *tmp in arr_HotSpotViewArray) {
        [tmp removeFromSuperview];
        tmp = nil;
    }
    [arr_HotSpotViewArray removeAllObjects];
    arr_HotSpotViewArray = nil;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self removeAllPanels];
    
    [self removeAppleMap];
    
    [self removePaths];
    
    [self removeHotspots];
    
    [self removeOverlay];
    
    [_uib_city removeFromSuperview];
    _uib_city = nil;
    
    [_uib_neighbor removeFromSuperview];
    _uib_neighbor = nil;
    
    [_uib_site removeFromSuperview];
    _uib_site = nil;
    
    
    [_uiv_mapContainer removeFromSuperview];
    _uiv_mapContainer = nil;
    
    [_uis_zooming removeFromSuperview];
    _uis_zooming = nil;
    
    for (UIView __strong *tmp in arr_topBtnsArray) {
        [tmp removeFromSuperview];
        tmp = nil;
    }
    [arr_indicatorColors removeAllObjects];
    arr_indicatorColors = nil;
    
    for (UIView __strong *tmp in arr_subMenuArray) {
        [tmp removeFromSuperview];
        tmp = nil;
    }
    [arr_subMenuArray removeAllObjects];
    arr_subMenuArray = nil;
    
    for (UIView __strong *tmp in arr_panelBtnArray) {
        [tmp removeFromSuperview];
        tmp = nil;
    }
    [arr_panelBtnArray removeAllObjects];
    arr_panelBtnArray = nil;
    
    [arr_overlayArray removeAllObjects];
    arr_overlayArray = nil;
    
    [arr_indicatorColors removeAllObjects];
    arr_indicatorColors = nil;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
