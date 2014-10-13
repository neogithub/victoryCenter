//
//  mapViewController.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/23/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "mapViewController.h"
#import "MPFoldTransition.h"
#import "MPFlipTransition.h"
#import "UIColor+Extensions.h"

static BOOL     kMapCanZoom                 = YES;
static CGFloat  kMinZoom                    = 1.0;
static CGFloat  kMaxZoom                    = 2.0;
static float    panle_x                     = 733.0;
static float    panle_w                     = 227.0;
@interface mapViewController () <UIScrollViewDelegate, UIGestureRecognizerDelegate>
{
    NSMutableArray          *arr_topBtnsArray;
    NSMutableArray          *arr_subMenuArray;
    NSMutableArray          *arr_panelBtnArray;
    NSMutableArray          *arr_overlayArray;
    NSMutableArray          *arr_indicatorColors;
    
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

@property (nonatomic, strong) UIScrollView              *uis_zooming;
@property (nonatomic, strong) UIView                    *uiv_mapContainer;
@property (nonatomic, strong) UIImageView               *uiiv_mapImg;
@property (nonatomic, strong) UIImageView               *uiiv_mapOverlay;
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
            break;
        }
        case 1: { //Show Neighborhood's sub menu
            _uiv_citySubMenu.hidden = YES;
            _uiv_neighborhoodSubMenu.hidden = NO;
            _uiv_siteSubMenu.hidden = YES;
            break;
        }
        case 2: { //Show Site's sub menu
            _uiv_citySubMenu.hidden = YES;
            _uiv_neighborhoodSubMenu.hidden = YES;
            _uiv_siteSubMenu.hidden = NO;
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
#pragma mark - City Submenu
- (void)handleCitySubMenu:(id)sender
{
    [self hiliteTappedButton:sender inView:_uiv_citySubMenu];
    [_uiiv_mapOverlay removeFromSuperview];
    _uiiv_mapOverlay = nil;
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
    NSArray *arr_buttonTitles = [[NSArray alloc] initWithObjects:@"FROM DALLAS NORTH TOLLWAY", @"FROM WOODALL RODGERS", @"FROM KATY TRAIL", @"FROM I-35", @"FROM I-30", nil];
    [self createBtnsForPanel:uiv_cityAccPanel withTitleArray:arr_buttonTitles andTargetSel:@"tappedBtn:" andEdgeInset:15.0];
    
    [self.view insertSubview:uiv_cityAccPanel belowSubview:_uiv_siteSubMenu];
}

#pragma  mark - Neighborhood Submenu
#pragma  mark - Neighborhood Submenu
- (void)handleNeibSubMenu:(id)sender
{
    [self hiliteTappedButton:sender inView:_uiv_neighborhoodSubMenu];
    [_uiiv_mapOverlay removeFromSuperview];
    _uiiv_mapOverlay = nil;
    [self removeAllPanels];
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

#pragma mark - Add panel for neighborhood amenities
- (void)addNeibAmenitiesPanel
{
    float panel_h = 160.0;
    uiv_neibAmePanel = [self createPanelWithTitle:@"AMENITIES" andHeight:panel_h];
    NSArray *arr_buttonTitles = [[NSArray alloc] initWithObjects:@"RECREATION", @"ACCOMMODATION", @"RESIDENTIAL", nil];
    [self createBtnsForPanel:uiv_neibAmePanel withTitleArray:arr_buttonTitles andTargetSel:@"tappedBtn:" andEdgeInset:45.0];
    
    [self.view insertSubview:uiv_neibAmePanel belowSubview:_uiv_siteSubMenu];
}

#pragma mark - Add panel for neighborhood access
- (void)addNeibAccessPanel
{
    float panel_h = 236.0;
    uiv_neibAccPanel = [self createPanelWithTitle:@"ACCESS" andHeight:panel_h];
    
    [self.view insertSubview:uiv_neibAccPanel belowSubview:_uiv_siteSubMenu];
}

#pragma mark - Site Submenu
#pragma mark - Site Submenu
- (void)handleSiteSubMenu:(id)sender
{
    [self hiliteTappedButton:sender inView:_uiv_siteSubMenu];
    [_uiiv_mapOverlay removeFromSuperview];
    _uiiv_mapOverlay = nil;
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
        CGFloat duration = 0.33f;
        CGFloat damping = 0.5f;
        CGFloat velocity = 0.05f;
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

#pragma mark - Add panel for site amenities
- (void)addSiteAmenitiesPanel
{
    float panel_h = 198.0;
    uiv_siteAmePanel = [self createPanelWithTitle:@"AMENITIES" andHeight:panel_h];
    NSArray *arr_buttonTitles = [[NSArray alloc] initWithObjects:@"RESTAURANT", @"RETAIL", @"RESIDENTIAL", @"RECREATION", nil];
    [self createBtnsForPanel:uiv_siteAmePanel withTitleArray:arr_buttonTitles andTargetSel:@"tapSiteAmenities:" andEdgeInset:45.0];
    
    [self.view insertSubview:uiv_siteAmePanel belowSubview:_uiv_siteSubMenu];
    
    //Set up overlay's array
    [arr_overlayArray removeAllObjects];
    arr_overlayArray = nil;
    arr_overlayArray = [[NSMutableArray alloc] initWithObjects:@"grfx_restaurant_overlay.png", @"grfx_retail_overlay.png", @"grfx_residential_overlay.png", @"grfx_recreationg_overlay.png", nil];
    
    //Set up indicator's color array
    [arr_indicatorColors removeAllObjects];
    arr_indicatorColors = nil;
    arr_indicatorColors = [[NSMutableArray alloc] initWithObjects:[UIColor vcSiteRestaurant], [UIColor vcSiteRetail], [UIColor vcSiteResidentail], [UIColor vcSiteRecreation], nil];
}

- (void)tapSiteAmenities:(id)sender
{
    [self hightLightPanelBtn:sender andIndicatorColor:[arr_indicatorColors objectAtIndex:[sender tag]]];
    [self updateOverlayImage:[arr_overlayArray objectAtIndex:[sender tag]]];
}

#pragma mark - Add panel for site access
- (void)addSiteAccessPanel
{
    float panel_h = 236.0;
    uiv_siteAccPanel = [self createPanelWithTitle:@"ACCESS" andHeight:panel_h];
    
    [self.view insertSubview:uiv_siteAccPanel belowSubview:_uiv_siteSubMenu];
}

#pragma mark - Highlight current tapped button of top sub menu
- (void)hiliteTappedButton:(id)sender inView:(UIView *)container
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

#pragma mark - create Panel
/*
 Required arguements:
 1. NSString panel's title
 2. float panel's height
 */

- (UIView *)createPanelWithTitle:(NSString *)title andHeight:(float)panel_h
{
    UIView* uiv_panel = [[UIView alloc] initWithFrame:CGRectMake(panle_x, 0.0, panle_w, panel_h)];
    uiv_panel.backgroundColor = [UIColor whiteColor];
    uiv_panel.layer.borderWidth = 1.0;
    uiv_panel.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    
    UIButton *uib_PanelTitle = [UIButton buttonWithType:UIButtonTypeCustom];
    uib_PanelTitle.frame = CGRectMake(0.0, 0.0, panle_w, 46);
    [uib_PanelTitle setBackgroundImage:[UIImage imageNamed:@"grfx_access_nav.png"] forState:UIControlStateNormal];
    [uib_PanelTitle setTitle:title forState:UIControlStateNormal];
    [uib_PanelTitle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [uib_PanelTitle.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:16.0]];
    uib_PanelTitle.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 100);
    
    [uiv_panel addSubview: uib_PanelTitle];
    return uiv_panel;
}

- (void)hightLightPanelBtn:(id)sender andIndicatorColor:(UIColor *)color
{
    for (UIButton *tmp in arr_panelBtnArray) {
        tmp.backgroundColor = [UIColor clearColor];
        tmp.layer.borderWidth = 1.0;
        tmp.layer.borderColor = [UIColor vcButtonBorder].CGColor;
    }
    UIButton *tappedBtn = sender;
    tappedBtn.backgroundColor = [UIColor vclightbluemenu];
    tappedBtn.layer.borderWidth = 1.0;
    tappedBtn.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    
    [uiv_panelIndicator removeFromSuperview];
    uiv_panelIndicator = nil;
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

#pragma mark - Create panel's content (Buttons)
/*
 Required arguements:
 1. UIView      the panel
 2. NSArray     array of content buttons' titles
 3. NSString    name of button's target selector
 4. float       left edge inset for button's title
 */

- (void)createBtnsForPanel:(UIView *)panle withTitleArray:(NSArray *)arr_buttonTitles andTargetSel:(NSString *)methodName andEdgeInset:(float)leftEdge
{
    [arr_panelBtnArray removeAllObjects];
    arr_panelBtnArray = nil;
    arr_panelBtnArray = [[NSMutableArray alloc] init];
    UIView *uiv_optionContainer = [[UIView alloc] init];
    uiv_optionContainer.frame = CGRectMake(0.0, 46.0, panle_w, panle.frame.size.height-46.0);
    uiv_optionContainer.tag = 20;
    
    SEL method = NSSelectorFromString(methodName);
    
    for (int i = 0; i < arr_buttonTitles.count; i++) {
        UIButton *uib_accOption = [UIButton buttonWithType:UIButtonTypeCustom];
        uib_accOption.frame = CGRectMake(0.0, 46+i*38.0, panle_w, 38.0);
        uib_accOption.layer.borderWidth = 1.0;
        uib_accOption.layer.borderColor = [UIColor vcButtonBorder].CGColor;
        [uib_accOption setTitle:arr_buttonTitles[i] forState:UIControlStateNormal];
        [uib_accOption setTitleColor:[UIColor vcDarkBlue] forState:UIControlStateNormal];
        [uib_accOption.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:12.0]];
        uib_accOption.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        uib_accOption.titleEdgeInsets = UIEdgeInsetsMake(0.0, leftEdge, 0.0, 0.0);
        uib_accOption.tag = i;
        [uib_accOption addTarget:self action:method forControlEvents:UIControlEventTouchUpInside];
        [uiv_optionContainer addSubview: uib_accOption];
        [arr_panelBtnArray addObject: uib_accOption];
    }
}

-(void)tappedBtn:(id)sender
{
    NSLog(@"the tapped button is %i",(int)[sender tag]);
}

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

- (void)viewWillDisappear:(BOOL)animated
{
    [self removeAllPanels];
    
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
