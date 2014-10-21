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

#define METERS_PER_MILE 1609.344

static CGFloat  kTableHeight                = 273;
static CGFloat  kExpendedHeight             = 433;//kTableHeight + 160;
static CGFloat  kNeiAmenPanelHeight         = 114.0;
static CGFloat  kPanelTitleHeight           = 46;
static BOOL     kMapCanZoom                 = YES;
static CGFloat  kMinZoom                    = 1.0;
static CGFloat  kMaxZoom                    = 2.0;
static float    panle_x                     = 733.0;
static float    panle_w                     = 227.0;
@interface mapViewController () <UIScrollViewDelegate, UIGestureRecognizerDelegate, embDrawPathDelegate, MKMapViewDelegate, embMapHotspotListViewControllerDelegate>
{
    NSMutableArray          *arr_topBtnsArray;
    NSMutableArray          *arr_subMenuArray;
    NSMutableArray          *arr_panelBtnArray;
    NSMutableArray          *arr_switcherArray;
    NSMutableArray          *arr_overlayArray;
    NSMutableArray          *arr_indicatorColors;
    //Hotspot data
    NSMutableArray          *arr_HotSpotsRaw;
    NSMutableArray          *arr_HotSpotCategories;
    NSMutableArray          *arr_HotSpotData;
    NSMutableArray          *arr_HotSpotXY;
    NSMutableArray          *arr_HotSpotViewArray;
    
    UIView                  *uiv_cityAccPanel;
    UIView                  *uiv_neibAmePanel;
    UIView                  *uiv_neibAccPanel;
    UIView                  *uiv_siteAmePanel;
    UIView                  *uiv_siteAccPanel;
    
    UIView                  *uiv_panelIndicator;
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
@property (weak, nonatomic) IBOutlet UIButton           *uib_cityAccess;
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
@end

@implementation mapViewController

@synthesize mode = _mode;
@synthesize foldStyle = _foldStyle;


- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = screenRect;;
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
	switch (index % 3) {
		case 0:
            [_uiiv_mapImg setImage:[UIImage imageNamed:@"City_base_map_.png"]];
			break;
		case 1:
            [_uiiv_mapImg setImage:[UIImage imageNamed:@"Neighborhood_map.png"]];
			break;
		case 2:
            [_uiiv_mapImg setImage:[UIImage imageNamed:@"Site_Base map.png"]];
			break;
		default:
			break;
	}
    
    [_uiv_mapContainer addSubview:_uiiv_mapImg];
	return _uiv_mapContainer;
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
								  completion:^(BOOL finished) {   }
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
    for (UIView *dropPinView in _uiiv_mapImg.subviews) {
        if (dropPinView.tag < 1000) {
            CGRect oldFrame = dropPinView.frame;
            // 0.5 means the anchor is centered on the x axis. 1 means the anchor is at the bottom of the view. If you comment out this line, the pin's center will stay where it is regardless of how much you zoom. I have it so that the bottom of the pin stays fixed. This should help user RomeoF.
            //[dropPinView.layer setAnchorPoint:CGPointMake(0.5, 1)];
            [dropPinView.layer setAnchorPoint:CGPointMake(0.5, 0.5)];
            dropPinView.frame = oldFrame;
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
        return;
    }
    else
    {
        // Remove all panels
        [self removeAllPanels];
        [self updateTopBtns:tappedBtn];
        [self animationOfMaps:(int)tappedBtn.tag];
        [self updateSubMenu:(int)tappedBtn.tag];
    }
}

- (void)updateSubMenu:(int)index
{
    [self resetSubMenus];
    [_uiiv_mapOverlay removeFromSuperview];
    _uiiv_mapOverlay = nil;
    switch (index) {
        case 0: { //Show City's sub menu
            _uiv_citySubMenu.hidden = NO;
            _uiv_neighborhoodSubMenu.hidden = YES;
            _uiv_siteSubMenu.hidden = YES;
            _uiv_mapSwitchContainer.hidden = NO;
            break;
        }
        case 1: { //Show Neighborhood's sub menu
            _uiv_citySubMenu.hidden = YES;
            _uiv_neighborhoodSubMenu.hidden = NO;
            _uiv_siteSubMenu.hidden = YES;
            _uiv_mapSwitchContainer.hidden = NO;
            break;
        }
        case 2: { //Show Site's sub menu
            _uiv_citySubMenu.hidden = YES;
            _uiv_neighborhoodSubMenu.hidden = YES;
            _uiv_siteSubMenu.hidden = NO;
            _uiv_mapSwitchContainer.hidden = YES;
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
}

- (void)setNeighborhoodSubMenu
{
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
    [theBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
    [self hiliteSubMenuTappedButton:sender inView:_uiv_citySubMenu];
    [_uiiv_mapOverlay removeFromSuperview];
    _uiiv_mapOverlay = nil;
    [self removePaths];
    [self removeAllPanels];
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
}

- (void)addCityAccessPanel
{
    float panel_h = 236.0;
    uiv_cityAccPanel = [self createPanelWithTitle:@"ACCESS" andHeight:panel_h];
    NSArray *arr_buttonTitles = [[NSArray alloc] initWithObjects:@"FROM DALLAS N. TOLLWAY", @"FROM WOODALL RODGERS", @"FROM KATY TRAIL", @"FROM I-35", @"FROM I-30", nil];
    [self createBtnsForPanel:uiv_cityAccPanel withTitleArray:arr_buttonTitles andTargetSel:@"drawPathsFromBezierClass:" andEdgeInset:45.0 withIdicator:YES];
    [self.view insertSubview:uiv_cityAccPanel belowSubview:_uiv_siteSubMenu];
    [self animateThePanel:uiv_cityAccPanel];
}

#pragma  mark - Neighborhood Submenu

- (void)handleNeibSubMenu:(id)sender
{
    [self hiliteSubMenuTappedButton:sender inView:_uiv_neighborhoodSubMenu];
    [_uiiv_mapOverlay removeFromSuperview];
    _uiiv_mapOverlay = nil;
    [self removePaths];
    [self removeAllPanels];
    
    for (UIView __strong *tmp in arr_HotSpotViewArray) {
        [tmp removeFromSuperview];
        tmp = nil;
    }
    
    // Get -digit to detect which button is tapped
    // *1 --> load Neighborhood's Amenities panel
    // *2 --> load Neighborhood's Access panel
    int selectedIndex = (int)[sender tag]%10;
    if (selectedIndex == 1) { // Tapped Amenities
        [self addNeibAmenitiesPanel];
    }
    if (selectedIndex == 2) { // Tapped Access
        [self addNeibAccessPanel];
    }
}

#pragma mark Add panel for neighborhood amenities
- (void)addNeibAmenitiesPanel
{
    float panel_h = 160.0;
    uiv_neibAmePanel = [self createPanelWithTitle:@"AMENITIES" andHeight:panel_h];
    NSArray *arr_buttonTitles = [[NSArray alloc] initWithObjects:@"RECREATION", @"ACCOMMODATION", @"RESIDENTIAL", nil];
    [self createBtnsForPanel:uiv_neibAmePanel withTitleArray:arr_buttonTitles andTargetSel:@"loadHotspotTable:" andEdgeInset:45.0 withIdicator:YES];
    [self.view insertSubview:uiv_neibAmePanel belowSubview:_uiv_siteSubMenu];
    [self animateThePanel:uiv_neibAmePanel];
    [self prepareHotspotData];
    //Set up indicator's color array
    [arr_indicatorColors removeAllObjects];
    arr_indicatorColors = nil;
    arr_indicatorColors = [[NSMutableArray alloc] initWithObjects:[UIColor vcSiteRestaurant], [UIColor vcSiteRetail], [UIColor vcSiteResidentail], [UIColor vcSiteRecreation], nil];
}
#pragma mark Reset panel's size to load table view
- (void)loadHotspotTable:(id)sender
{
    UIView *buttonContianer = [uiv_neibAmePanel viewWithTag:102];
    UIButton *tappedBtn = sender;
    if (tappedBtn.selected) {
        CGRect frame = buttonContianer.frame;
        frame.size.height = kNeiAmenPanelHeight;
        [UIView animateWithDuration:0.33 animations:^{
            [self resetButtonsAndIndicators];
            buttonContianer.frame = frame;
        } completion:^(BOOL finished){
            [self deHighLightPanelBtn:sender];
            for (UIButton *tmp in arr_panelBtnArray) {
                tmp.selected = NO;
            }
            return;
        }];

    }
    
    else {
        for (UIButton *tmp in arr_panelBtnArray) {
            tmp.selected = NO;
        }
        tappedBtn.selected = YES;
        
        
        //Check if panel is opened:
        //Do the animation of shrink , change highlighted button and expension
        if (buttonContianer.frame.size.height > kNeiAmenPanelHeight) {
            CGRect frame = buttonContianer.frame;
            frame.size.height = kNeiAmenPanelHeight;
            [UIView animateWithDuration:0.33 animations:^{
                [self resetButtonsAndIndicators];
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
    //Get button's contianer by tag 102
    UIView *buttonContianer = [uiv_neibAmePanel viewWithTag:102];
    
    //Update position of table view's position
    [_uiv_tablePanel removeFromSuperview];
    _uiv_tablePanel = nil;
    _uiv_tablePanel = [[UIView alloc] init];
    UIButton *firstBtn = [arr_panelBtnArray objectAtIndex:0];
    _uiv_tablePanel.frame = CGRectMake(0.0, 38.0*([sender tag] + 1), panle_w, kTableHeight+10);
    _uiv_tablePanel.backgroundColor = [UIColor vcPanelBackgroundColor];
    
    //Update table view's content data
    [self loadHotspotTableView:(int)[sender tag]];
    //Add hotspots accroding to index
    [self createHotspots:(int)[sender tag]];
    //Add table view under buttons' container
    [buttonContianer insertSubview:_uiv_tablePanel aboveSubview:firstBtn];
    
    //Update Amenities panel's height
    CGRect oldFrame = uiv_neibAmePanel.frame;
    oldFrame.size.height = kExpendedHeight;
    uiv_neibAmePanel.frame = oldFrame;
    CGRect containerOldFrame = buttonContianer.frame;
    containerOldFrame.size.height = kExpendedHeight-kPanelTitleHeight;
    
    CGFloat duration = 0.5f;
    CGFloat damping = 0.7f;
    CGFloat velocity = 1.0f;
    // int to hold UIViewAnimationOption
    NSInteger option;
    option = UIViewAnimationCurveEaseInOut;
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:option animations:^{
        buttonContianer.frame = containerOldFrame;
        [self rearrangeBtns:(int)[sender tag]];
        [self rearrangeIndicator:(int)[sender tag]];
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

- (void)rearrangeIndicator:(int)index
{
    for (UIView *tmp in [[uiv_neibAmePanel viewWithTag:102] subviews]) {
        if (tmp.tag >=500) {
            if (tmp.tag-500 > index) {
                tmp.transform = CGAffineTransformMakeTranslation(0.0, kTableHeight);
            }
        }
    }
}

- (void)resetButtonsAndIndicators
{
    for (UIButton *tmp in arr_panelBtnArray) {
        uiv_neibAmePanel.frame = CGRectMake(panle_x, 0.0, panle_w, 160.0);
        tmp.transform = CGAffineTransformIdentity;
    }
    for (UIView *tmp in [[uiv_neibAmePanel viewWithTag:102] subviews]) {
        if (tmp.tag >=500) {
            tmp.transform = CGAffineTransformIdentity;
        }
    }
}
#pragma mark Load Hotspot data and hotspot view
- (void) prepareHotspotData
{
    [arr_HotSpotsRaw removeAllObjects];
    arr_HotSpotsRaw = nil;
    [arr_HotSpotCategories removeAllObjects];
    arr_HotSpotCategories = nil;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"hotspots"
													 ofType:@"plist"];
    // Build the array from the plist
	arr_HotSpotsRaw = [[NSMutableArray alloc] init];
	arr_HotSpotsRaw = [[NSMutableArray alloc] initWithContentsOfFile:path];

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
        hotspotView.tag=i + 100*index;
        [arr_HotSpotViewArray addObject: hotspotView];
        [_uiiv_mapImg addSubview: hotspotView];
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
    if (_uiv_tappedHotspot) {
        _uiv_tappedHotspot.backgroundColor = [UIColor whiteColor];
        _uiv_tappedHotspot.layer.borderWidth = 3.0;
        for (UILabel *tmp in [_uiv_tappedHotspot subviews]) {
            tmp.textColor = [arr_indicatorColors objectAtIndex:index/100];
        }
    }
    
    _uiv_tappedHotspot = [arr_HotSpotViewArray objectAtIndex:index%100];
    _uiv_tappedHotspot.backgroundColor = [arr_indicatorColors objectAtIndex:index/100];
    _uiv_tappedHotspot.layer.borderWidth = 0.0;
    for (UILabel *tmp in [_uiv_tappedHotspot subviews]) {
        tmp.textColor = [UIColor whiteColor];
    }
}
#pragma mark Delegate method of embMapHotspotListViewController
// Delegate method of class embMapHotspotListViewController
- (void)childViewController:(embMapHotspotListViewController*)viewController
               didChooseRow:(NSInteger)rowIndex
{
    //Get current amenities' section index
    int index = (int)_vc_hotspotList.view.tag;
    [self hiliteHotSpot:(int)rowIndex+index*100];
}

#pragma mark Add panel for neighborhood access
- (void)addNeibAccessPanel
{
    float panel_h = 236.0;
    uiv_neibAccPanel = [self createPanelWithTitle:@"ACCESS" andHeight:panel_h];
    NSArray *arr_buttonTitles = [[NSArray alloc] initWithObjects:@"FROM DALLAS N. TOLLWAY", @"FROM WOODALL RODGERS", @"FROM KATY TRAIL", @"FROM I-35", @"FROM I-30", nil];
    [self createBtnsForPanel:uiv_neibAccPanel withTitleArray:arr_buttonTitles andTargetSel:@"drawPathsFromBezierClass:" andEdgeInset:45.0 withIdicator:YES];
    [self.view insertSubview:uiv_neibAccPanel belowSubview:_uiv_siteSubMenu];
    [self animateThePanel:uiv_neibAccPanel];
}

#pragma mark - Site Submenu
#pragma mark Site Submenu
- (void)handleSiteSubMenu:(id)sender
{
    [self hiliteSubMenuTappedButton:sender inView:_uiv_siteSubMenu];
    [_uiiv_mapOverlay removeFromSuperview];
    _uiiv_mapOverlay = nil;
    [self removePaths];
    [self removeAllPanels];
    // Get -digit to detect which button is tapped
    // *1 --> load Site's Overview's overlay
    // *2 --> load Site's Amenities panel
    // *3 --> load Site's Access panel
    int selectedIndex = (int)[sender tag]%10;
    if (selectedIndex == 1) { // Tapped Overview
        _uiiv_mapOverlay = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grfx_site_overview.jpg"]];
        _uiiv_mapOverlay.frame = CGRectMake(77.0, 241.0, _uiiv_mapOverlay.frame.size.width, _uiiv_mapOverlay.frame.size.height);
        _uiiv_mapOverlay.transform = CGAffineTransformMakeTranslation(0.0, -100);
        _uiiv_mapOverlay.alpha = 0.0;
        [self.view insertSubview:_uiiv_mapOverlay belowSubview:_uib_city];
        // Animation for the overview image
        CGFloat duration = 0.5f;
        CGFloat damping = 0.5f;
        CGFloat velocity = 0.15f;
        // int to hold UIViewAnimationOption
        NSInteger option;
        option = UIViewAnimationCurveEaseInOut;
        
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:option animations:^{
            _uiiv_mapOverlay.alpha = 1.0;
            _uiiv_mapOverlay.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished){      }];
    }
    if (selectedIndex == 2) { // Tapped Amenities
        [self addSiteAmenitiesPanel];
    }
    if (selectedIndex == 3) { // Tapped Access
        [self addSiteAccessPanel];
    }
}

#pragma mark Add panel for site amenities
- (void)addSiteAmenitiesPanel
{
    float panel_h = 198.0;
    uiv_siteAmePanel = [self createPanelWithTitle:@"AMENITIES" andHeight:panel_h];
    NSArray *arr_buttonTitles = [[NSArray alloc] initWithObjects:@"RESTAURANT", @"RETAIL", @"RESIDENTIAL", @"RECREATION", nil];
    [self createBtnsForPanel:uiv_siteAmePanel withTitleArray:arr_buttonTitles andTargetSel:@"tapSiteAmenities:" andEdgeInset:45.0 withIdicator:YES];
    [self.view insertSubview:uiv_siteAmePanel belowSubview:_uiv_siteSubMenu];
    [self animateThePanel:uiv_siteAmePanel];
    //Set up overlay's array
    [arr_overlayArray removeAllObjects];
    arr_overlayArray = nil;
    arr_overlayArray = [[NSMutableArray alloc] initWithObjects:@"grfx_restaurant_overlay.png", @"grfx_retail_overlay.png", @"grfx_residential_overlay.png", @"grfx_recreationg_overlay.png", nil];
    
    //Set up indicator's color array
    [arr_indicatorColors removeAllObjects];
    arr_indicatorColors = nil;
    arr_indicatorColors = [[NSMutableArray alloc] initWithObjects:[UIColor vcSiteRestaurant], [UIColor vcSiteRetail], [UIColor vcSiteResidentail], [UIColor vcSiteRecreation], nil];
}
#pragma mark Actions for site amenities' buttons
- (void)tapSiteAmenities:(id)sender
{
    [self highLightPanelBtn:sender andIndicatorColor:[arr_indicatorColors objectAtIndex:[sender tag]] withIndicator:YES];
    [self updateOverlayImage:[arr_overlayArray objectAtIndex:[sender tag]]];
}

#pragma mark Add panel for site access
- (void)addSiteAccessPanel
{
    float panel_h = 236.0;
    uiv_siteAccPanel = [self createPanelWithTitle:@"ACCESS" andHeight:panel_h];
    NSArray *arr_buttonTitles = [[NSArray alloc] initWithObjects:@"FROM DALLAS N. TOLLWAY", @"FROM WOODALL RODGERS", @"FROM KATY TRAIL", @"FROM I-35", @"FROM I-30", nil];
    [self createBtnsForPanel:uiv_siteAccPanel withTitleArray:arr_buttonTitles andTargetSel:@"drawPathsFromBezierClass:" andEdgeInset:45.0 withIdicator:YES];
    [self.view insertSubview:uiv_siteAccPanel belowSubview:_uiv_siteSubMenu];
    [self animateThePanel:uiv_siteAccPanel];
}

#pragma mark - Highlight current tapped button of sub menu
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
        _uiiv_mapOverlay = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]];
        _uiiv_mapOverlay.frame = screenRect;
        _uiiv_mapOverlay.alpha = 0.0;
        [_uiv_mapContainer addSubview: _uiiv_mapOverlay];
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

- (UIView *)createPanelWithTitle:(NSString *)title andHeight:(float)panel_h
{
    UIView* uiv_panel = [[UIView alloc] initWithFrame:CGRectMake(panle_x, 0.0, panle_w, panel_h)];
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
    }
    UIButton *tappedBtn = sender;
    tappedBtn.backgroundColor = [UIColor vclightbluemenu];
    tappedBtn.layer.borderWidth = 1.0;
    tappedBtn.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    
    [uiv_panelIndicator removeFromSuperview];
    uiv_panelIndicator = nil;
    if (indicator) {
        CGRect frame = CGRectMake(19, tappedBtn.frame.origin.y + (tappedBtn.frame.size.height - 14)/2, 14, 14);
        uiv_panelIndicator = [[UIView alloc] initWithFrame:frame];
        uiv_panelIndicator.backgroundColor = color;
        uiv_panelIndicator.layer.borderColor = [UIColor whiteColor].CGColor;
        uiv_panelIndicator.layer.borderWidth = 2.0;
        CGPoint savedCenter = uiv_panelIndicator.center;
        uiv_panelIndicator.layer.cornerRadius = 14.0 / 2.0;
        uiv_panelIndicator.center = savedCenter;
        
        [tappedBtn.superview addSubview: uiv_panelIndicator];
    }
}

- (void)deHighLightPanelBtn:(id)sender
{
    UIButton *tappedBtn = sender;
    tappedBtn.backgroundColor = [UIColor whiteColor];
    tappedBtn.layer.borderWidth = 1.0;
    tappedBtn.layer.borderColor = [UIColor vcButtonBorder].CGColor;
    
    [uiv_panelIndicator removeFromSuperview];
    uiv_panelIndicator = nil;
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
        uib_accOption.frame = CGRectMake(0.0, i*38.0, panle_w, 38.0);
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
        if (indicator) {
            CGRect frame = CGRectMake(19, uib_accOption.frame.origin.y + (uib_accOption.frame.size.height - 14)/2, 14, 14);
            UIView *uiv_Indicator = [[UIView alloc] initWithFrame:frame];
            uiv_Indicator.backgroundColor = [UIColor lightGrayColor];
            uiv_Indicator.layer.borderColor = [UIColor whiteColor].CGColor;
            uiv_Indicator.layer.borderWidth = 2.0;
            CGPoint savedCenter = uiv_Indicator.center;
            uiv_Indicator.layer.cornerRadius = 14.0 / 2.0;
            uiv_Indicator.center = savedCenter;
            uiv_Indicator.tag = 500+i;
            [uiv_optionContainer addSubview: uiv_Indicator];
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

#pragma mark - Draw Path
-(void)drawPathsFromBezierClass:(id)sender
{
    UIButton *tappedBtn = sender;
    if (tappedBtn.selected) {
        [self removePaths];
        [self deHighLightPanelBtn:sender];
        for (UIButton *tmp in arr_panelBtnArray) {
            tmp.selected = NO;
        }
        return;
    }
    for (UIButton *tmp in arr_panelBtnArray) {
        tmp.selected = NO;
    }
    tappedBtn.selected = YES;
    
    
    [self highLightPanelBtn:sender andIndicatorColor:[UIColor redColor] withIndicator:YES];
    
	_arr_pathItems = [[NSMutableArray alloc] init];
	embBezierPaths *paths;
	embDirections *dirpaths;
    paths = [[embBezierPaths alloc] init];
    _arr_pathItems = paths.bezierPaths;
    dirpaths = [[embDirections alloc] init];
    _arr_pathItems = dirpaths.bezierPaths;
    
    // clean up
	[self removePaths];
	
	// actual drawpath function
	_embDirectionPath = [[embDrawPath alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
	_embDirectionPath.delegate=self;
	//[_uiv_mapContainer insertSubview:_embDirectionPath atIndex:2];
	
	if (_uiiv_mapOverlay) {
		[_uiv_mapContainer insertSubview:_embDirectionPath aboveSubview:_uiiv_mapOverlay];
	} else {
		[_uiv_mapContainer insertSubview:_embDirectionPath aboveSubview:_uiv_mapContainer];
	}
    
	//NSLog(@"%li",(long)currentHeaderIndex);
    
	// loop # paths in a group
	int pathGrouping	= -1;
	int indexStart		= -1;
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
				pathGrouping	= 3;
				indexStart		= 3;
				break;
				
			case 4:
				pathGrouping	= 1;
				indexStart		= 0;
				break;
			default:
				break;
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
        theBtn.backgroundColor = [UIColor vcLightBlueAlpha];
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
								   message: @"You are leaving Victory Center to Google Earth."
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
    NSLog(@"foobage! %i", (int)buttonIndex);
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

#pragma mark - Remove items and release memory

- (void)removeAllPanels
{
    [uiv_cityAccPanel removeFromSuperview];
    uiv_cityAccPanel = nil;
    
    [uiv_neibAccPanel removeFromSuperview];
    uiv_cityAccPanel = nil;
    
    [uiv_neibAmePanel removeFromSuperview];
    uiv_neibAmePanel = nil;
    
    [uiv_siteAccPanel removeFromSuperview];
    uiv_siteAccPanel = nil;
    
    [uiv_siteAmePanel removeFromSuperview];
    uiv_siteAmePanel = nil;
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
    
    [_uib_city removeFromSuperview];
    _uib_city = nil;
    
    [_uib_neighbor removeFromSuperview];
    _uib_neighbor = nil;
    
    [_uib_site removeFromSuperview];
    _uib_site = nil;
    
    [_uiiv_mapOverlay removeFromSuperview];
    _uiiv_mapOverlay = nil;
    
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
