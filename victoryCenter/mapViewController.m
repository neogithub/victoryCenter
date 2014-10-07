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

static BOOL kMapCanZoom                 = YES;
static CGFloat kMinZoom                 = 1.0;
static CGFloat kMaxZoom                 = 2.0;

@interface mapViewController () <UIScrollViewDelegate, UIGestureRecognizerDelegate>
{
    NSMutableArray          *arr_topBtnsArray;
    NSMutableArray          *arr_subMenuArray;
    
    UIView                  *uiv_cityAccPanel;
    UIView                  *uiv_neibAmePanel;
    UIView                  *uiv_neibAccPanel;
    UIView                  *uiv_siteAmePanel;
    UIView                  *uiv_siteAccPanel;
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
            [_uiiv_mapImg setImage:[UIImage imageNamed:@"Access_overlay.png"]];
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

- (IBAction)tapCityBtn:(id)sender {
    if (_uib_city.selected) {
        return;
    }
    else {
        //remove all panels
        [self removeAllPanels];
        
        [self updateTopBtns:_uib_city];
        [self animationOfMaps:0];
        [self updateSubMenu:0];
    }

}
- (IBAction)tapNeighborhoodBtn:(id)sender {
    if (_uib_neighbor.selected) {
        return;
    }
    else {
        //remove all panels
        [self removeAllPanels];
        
        [self updateTopBtns:_uib_neighbor];
        [self animationOfMaps:1];
        [self updateSubMenu:1];
    }
}
- (IBAction)tapSiteBtn:(id)sender {
    if (_uib_site.selected) {
        return;
    }
    else {
        //remove all panels
        [self removeAllPanels];
        
        [self updateTopBtns:_uib_site];
        [self animationOfMaps:2];
        [self updateSubMenu:2];
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
    theBtn.backgroundColor = [UIColor vcLightBlue];
    theBtn.tag = index;
    theBtn.selected = selected;
    [theBtn addTarget:self action:@selector(tapSubMenu:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)resetSubMenus
{
    for (UIView *tmpView in arr_subMenuArray) {
        for (UIButton *tmp in [tmpView subviews]) {
            tmp.selected = NO;
            tmp.backgroundColor = [UIColor vcLightBlue];
            [tmp.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14.0]];
        }
    }
}

- (void)tapSubMenu:(id)sender
{
    UIButton *tappedBtn = sender;
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
    [self hiliteTappedButton:sender inView:_uiv_citySubMenu];
    [_uiiv_mapOverlay removeFromSuperview];
    _uiiv_mapOverlay = nil;
    [self removeAllPanels];
    
    int selectedIndex = (int)[sender tag]%10;
    if (selectedIndex == 1) { // Tapped Districts
        _uiiv_mapOverlay = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Districts_overlay.png"]];
        _uiiv_mapOverlay.frame = CGRectMake(0.0, 0.0, 1024.0, 768.0);
        [_uiv_mapContainer addSubview: _uiiv_mapOverlay];
    }
    if (selectedIndex == 2) { // Tapped Access
        [self addCityAccessPanel];
    }
}

- (void)addCityAccessPanel
{
    float panle_x = 733.0;
    float panle_w = 227.0;
    float panle_h = 236.0;
    uiv_cityAccPanel = [[UIView alloc] initWithFrame:CGRectMake(panle_x, 0.0, panle_w, panle_h)];
    uiv_cityAccPanel.backgroundColor = [UIColor whiteColor];
    uiv_cityAccPanel.layer.borderWidth = 1.0;
    uiv_cityAccPanel.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    
    UIButton *uib_PanelTitle = [UIButton buttonWithType:UIButtonTypeCustom];
    uib_PanelTitle.frame = CGRectMake(0.0, 0.0, panle_w, 46);
    [uib_PanelTitle setBackgroundImage:[UIImage imageNamed:@"grfx_access_nav.png"] forState:UIControlStateNormal];
    [uib_PanelTitle setTitle:@"ACCESS" forState:UIControlStateNormal];
    [uib_PanelTitle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [uib_PanelTitle.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:16.0]];
    uib_PanelTitle.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 100);
    [uiv_cityAccPanel addSubview: uib_PanelTitle];
    
    NSArray *arr_buttonTitles = [[NSArray alloc] initWithObjects:@"FROM DALLAS NORTH TOLLWAY", @"FROM WOODALL RODGERS", @"FROM KATY TRAIL", @"FROM I-35", @"FROM I-30", nil];
    for (int i = 0; i < arr_buttonTitles.count; i++) {
        UIButton *uib_accOption = [UIButton buttonWithType:UIButtonTypeCustom];
        uib_accOption.frame = CGRectMake(0.0, 46+i*38.0, panle_w, 38.0);
        uib_accOption.layer.borderWidth = 1.0;
        uib_accOption.layer.borderColor = [UIColor vcButtonBorder].CGColor;
        [uib_accOption setTitle:arr_buttonTitles[i] forState:UIControlStateNormal];
        [uib_accOption setTitleColor:[UIColor vcDarkBlue] forState:UIControlStateNormal];
        [uib_accOption.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:12.0]];
        uib_accOption.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        uib_accOption.titleEdgeInsets = UIEdgeInsetsMake(0.0, 15.0, 0.0, 0.0);
        uib_accOption.tag = i;
        [uiv_cityAccPanel addSubview: uib_accOption];
    }
    
    [self.view insertSubview:uiv_cityAccPanel belowSubview:_uiv_siteSubMenu];
}

#pragma  mark - Neighborhood Submenu
- (void)handleNeibSubMenu:(id)sender
{
    [self hiliteTappedButton:sender inView:_uiv_neighborhoodSubMenu];
    
    int selectedIndex = (int)[sender tag]%10;
    if (selectedIndex == 1) { // Tapped Amenities
        
    }
    if (selectedIndex == 2) { // Tapped Access
        
    }
}


#pragma mark - Site Submenu
- (void)handleSiteSubMenu:(id)sender
{
    [self hiliteTappedButton:sender inView:_uiv_siteSubMenu];
    [_uiiv_mapOverlay removeFromSuperview];
    _uiiv_mapOverlay = nil;
    
    int selectedIndex = (int)[sender tag]%10;
    if (selectedIndex == 1) { // Tapped Overview
        _uiiv_mapOverlay = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grfx_site_overview.jpg"]];
        _uiiv_mapOverlay.frame = CGRectMake(77.0, 241.0, _uiiv_mapOverlay.frame.size.width, _uiiv_mapOverlay.frame.size.height);
        [self.view insertSubview:_uiiv_mapOverlay belowSubview:_uib_city];
        
    }
    if (selectedIndex == 2) { // Tapped Amenities
        
    }
    if (selectedIndex == 3) { // Tapped Access
        
    }
}

- (void)hiliteTappedButton:(id)sender inView:(UIView *)container
{
    UIButton *tappedBtn = sender;
    for (UIButton *tmp in [container subviews]) {
        tmp.selected = NO;
        tmp.backgroundColor = [UIColor vcLightBlue];
        [tmp.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14.0]];
    }
    tappedBtn.selected = YES;
    [tappedBtn.titleLabel setFont:[UIFont fontWithName:@"Raleway-ExtraBold" size:15.0]];
    tappedBtn.backgroundColor = [UIColor vcDarkBlue];
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
