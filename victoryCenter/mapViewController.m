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

@property (weak, nonatomic) IBOutlet UIButton           *uib_city;
@property (weak, nonatomic) IBOutlet UIButton           *uib_neighbor;
@property (weak, nonatomic) IBOutlet UIButton           *uib_site;

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

#pragma mark - Init zooming scroll view for ma
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
