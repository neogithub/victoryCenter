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
@synthesize flipStyle = _flipStyle;

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
    // Do any additional setup after loading the view.
}

#pragma mark - Set up map's flod animation
- (void)setUpMapAnimation
{
    _mode = MPTransitionModeFold;
	_flipStyle = MPFlipStyleDefault;
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
	else
	{
		[MPFlipTransition transitionFromView:previousView
									  toView:nextView
									duration:[MPTransition defaultDuration]
									   style:forwards? [self flipStyle]	: MPFlipStyleFlipDirectionBit([self flipStyle])
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
    [_uib_city setTitle:@"CITY" forState:UIControlStateNormal];
    [_uib_city setTitle:@"CITY" forState:UIControlStateSelected];
    [_uib_city setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_city setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_uib_city.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14]];
    _uib_city.backgroundColor = [UIColor vcDarkBlue];
    _uib_city.selected = YES;
    
    [_uib_neighbor setTitle:@"NEIGHBORHOOD" forState:UIControlStateNormal];
    [_uib_neighbor setTitle:@"NEIGHBORHOOD" forState:UIControlStateSelected];
    [_uib_neighbor setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_neighbor setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_uib_neighbor.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14]];
    _uib_neighbor.backgroundColor = [UIColor vcLightBlue];
    _uib_neighbor.selected = NO;
    
    [_uib_site setTitle:@"SITE" forState:UIControlStateNormal];
    [_uib_site setTitle:@"SITE" forState:UIControlStateSelected];
    [_uib_site setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_site setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_uib_site.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14]];
    _uib_site.backgroundColor = [UIColor vcLightBlue];
    _uib_site.selected = NO;
    
}

/*
    1. Reset all top buttons
    2. Make the tapped one (sender) selected
 */
- (void)updateTopBtns:(id)sender
{
    UIButton *tappedBtn = sender;
    _uib_city.selected = NO;
    _uib_city.backgroundColor = [UIColor vcLightBlue];
    _uib_neighbor.selected = NO;
    _uib_neighbor.backgroundColor = [UIColor vcLightBlue];
    _uib_site.selected = NO;
    _uib_site.backgroundColor = [UIColor vcLightBlue];
    tappedBtn.selected = YES;
    tappedBtn.backgroundColor = [UIColor vcDarkBlue];
}

- (IBAction)tapCityBtn:(id)sender {
    if (_uib_city.selected) {
        return;
    }
    else {
        [self updateTopBtns:_uib_city];
        [self animationOfMaps:0];
    }

}
- (IBAction)tapNeighborhoodBtn:(id)sender {
    if (_uib_neighbor.selected) {
        return;
    }
    else {
        [self updateTopBtns:_uib_neighbor];
        [self animationOfMaps:1];
    }
}
- (IBAction)tapSiteBtn:(id)sender {
    if (_uib_site.selected) {
        return;
    }
    else {
        [self updateTopBtns:_uib_site];
        [self animationOfMaps:2];
    }
}

- (void)setSubMenus
{
    [self setCitySubMenu];
    [self setNeighborhoodSubMenu];
    [self setSiteSubMenu];
}

- (void)setCitySubMenu
{
    [_uib_cityDistricts setTitle:@"DISTRICTS" forState:UIControlStateNormal];
    [_uib_cityDistricts setTitle:@"DISTRICTS" forState:UIControlStateSelected];
    [_uib_cityDistricts setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_cityDistricts setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_uib_cityDistricts.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14.0]];
    _uib_cityDistricts.backgroundColor = [UIColor vcLightBlue];
    _uib_cityDistricts.tag = 11;
    _uib_cityDistricts.selected = NO;

    [_uib_cityAccess setTitle:@"ACCESS" forState:UIControlStateNormal];
    [_uib_cityAccess setTitle:@"ACCESS" forState:UIControlStateSelected];
    [_uib_cityAccess setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_cityAccess setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_uib_cityAccess.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14.0]];
    _uib_cityAccess.backgroundColor = [UIColor vcLightBlue];
    _uib_cityAccess.tag = 12;
    _uib_cityAccess.selected = NO;
}

- (void)setNeighborhoodSubMenu
{
    [_uib_neighboorhoodAmenities setTitle:@"AMENITIES" forState:UIControlStateNormal];
    [_uib_neighboorhoodAmenities setTitle:@"AMENITIES" forState:UIControlStateSelected];
    [_uib_neighboorhoodAmenities setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_neighboorhoodAmenities setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_uib_neighboorhoodAmenities.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14.0]];
    _uib_neighboorhoodAmenities.backgroundColor = [UIColor vcLightBlue];
    _uib_neighboorhoodAmenities.tag = 21;
    _uib_neighboorhoodAmenities.selected = NO;
    
    [_uib_neighborhoodAccess setTitle:@"ACCESS" forState:UIControlStateNormal];
    [_uib_neighborhoodAccess setTitle:@"ACCESS" forState:UIControlStateSelected];
    [_uib_neighborhoodAccess setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_neighborhoodAccess setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_uib_neighborhoodAccess.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14.0]];
    _uib_neighborhoodAccess.backgroundColor = [UIColor vcLightBlue];
    _uib_neighborhoodAccess.tag = 22;
    _uib_neighborhoodAccess.selected = NO;
}

- (void)setSiteSubMenu
{
    [_uib_siteOverview setTitle:@"OVERVIEW" forState:UIControlStateNormal];
    [_uib_siteOverview setTitle:@"OVERVIEW" forState:UIControlStateSelected];
    [_uib_siteOverview setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_siteOverview setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_uib_siteOverview.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14.0]];
    _uib_siteOverview.backgroundColor = [UIColor vcLightBlue];
    _uib_siteOverview.tag = 31;
    _uib_siteOverview.selected = NO;
    
    [_uib_siteAmenities setTitle:@"AMENITIES" forState:UIControlStateNormal];
    [_uib_siteAmenities setTitle:@"AMENITIES" forState:UIControlStateSelected];
    [_uib_siteAmenities setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_siteAmenities setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_uib_siteAmenities.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14.0]];
    _uib_siteAmenities.backgroundColor = [UIColor vcLightBlue];
    _uib_siteAmenities.tag = 32;
    _uib_siteAmenities.selected = NO;
    
    [_uib_siteAccess setTitle:@"ACCESS" forState:UIControlStateNormal];
    [_uib_siteAccess setTitle:@"ACCESS" forState:UIControlStateSelected];
    [_uib_siteAccess setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_siteAccess setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_uib_siteAccess.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14.0]];
    _uib_siteAccess.backgroundColor = [UIColor vcLightBlue];
    _uib_siteAccess.tag = 33;
    _uib_siteAccess.selected = NO;
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
