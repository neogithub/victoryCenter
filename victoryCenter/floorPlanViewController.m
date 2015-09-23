//
//  floorPlanViewController.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 10/16/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "floorPlanViewController.h"
#import "embModelController.h"
#import "embDataViewController.h"
#import "UIColor+Extensions.h"
#import "xhPanoramicView.h"
#import "xhPopTipsView.h"
#import "GAIDictionaryBuilder.h"

static float    panle_w                     = 156;
static CGFloat  kPanelTitleHeight           = 46;
@interface floorPlanViewController ()<UIPageViewControllerDelegate>
{
    BOOL            pageIsSet;
}

// Page View
@property (nonatomic, readwrite)        NSInteger               currentPage;
@property (readonly, strong, nonatomic) embModelController		*modelController;
@property (readonly, strong, nonatomic) NSArray					*arr_pageData;
@property (strong, nonatomic)           UIPageViewController	*pageViewController;
// Side Panel
@property (nonatomic, strong)   UIView                          *uiv_panel;
@property (nonatomic, strong)   UIButton                        *uib_PanelTitle;
@property (nonatomic, strong)   NSArray                         *arr_titleText;
@property (nonatomic, strong)   NSArray                         *arr_squareFeet;
@property (nonatomic, strong)   UIImageView                     *uiiv_smallStack;
@property (nonatomic, strong)   UIView                          *uiv_btnContainer;
@property (nonatomic, strong)   UIView                          *uiv_floorIndicator;
@property (nonatomic, strong)   NSMutableArray                  *arr_indicatorFrames;
@property (nonatomic, strong)   UIButton                        *uib_upArrow;
@property (nonatomic, strong)   UIButton                        *uib_downArrow;
// Floor num & RSF. labels
@property (nonatomic, strong)   UIView                          *uiv_floorTitleContainer;
@property (nonatomic, strong)   UILabel                         *uil_floorTitle;
@property (nonatomic, strong)   UILabel                         *uil_floorRsf;
// Control Button
@property (nonatomic, strong)   UIButton                        *uib_backBtn;
// Pano image
@property (nonatomic, strong)   xhPanoramicView                 *uiv_panoramicView;
// Help tip view
@property (nonatomic, strong) xhPopTipsView                     *uiv_helpView;
@property (nonatomic, strong) NSMutableArray                    *arr_helpText;
@property (nonatomic, strong) NSMutableArray                    *arr_helpTargetViews;
@end

@implementation floorPlanViewController

@synthesize modelController = _modelController;
@synthesize pageIndex;

- (void)setPageIndex:(int)index
{
    pageIndex = index;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = screenRect;
    _arr_titleText = [[NSArray alloc] initWithObjects:
                      @"FLOOR 23",
                      @"FLOOR 22",
                      @"FLOOR 21",
                      @"FLOOR 20",
                      @"FLOOR 19",
                      @"FLOOR 18",
                      @"FLOOR 17",
                      @"FLOOR 16",
                      @"FLOOR 15",
                      @"FLOOR 14",
                      @"FLOOR 12",
                      @"FLOOR 11",
                      @"FLOOR 10",
                      @"FLOOR 9",
                      @"FLOOR 8",
                      @"FLOOR 1", nil];
    _arr_squareFeet = [[NSArray alloc] initWithObjects:
                       @"27,802",
                       @"27,957",
                       @"28,112",
                       @"28,276",
                       @"28,433",
                       @"28,591",
                       @"28,337",
                       @"28,439",
                       @"28,694",
                       @"28,853",
                       @"29,002",
                       @"29,161",
                       @"29,161",
                       @"29,750",
                       @"45,571",
                       @"8,900", nil];
    
    CGRect frame_23 = CGRectMake(42.0, 17.0, 93.0, 6.0);
    CGRect frame_22 = CGRectMake(42.0, 22.0, 93.0, 6.0);
    CGRect frame_21 = CGRectMake(42.0, 28.0, 93.0, 6.0);
    CGRect frame_20 = CGRectMake(42.0, 33.0, 93.0, 6.0);
    CGRect frame_19 = CGRectMake(42.0, 38.0, 93.0, 6.0);
    CGRect frame_18 = CGRectMake(42.0, 43.0, 93.0, 6.0);
    CGRect frame_17 = CGRectMake(42.0, 49.0, 93.0, 6.0);
    CGRect frame_16 = CGRectMake(42.0, 54.0, 93.0, 6.0);
    CGRect frame_15 = CGRectMake(42.0, 60.0, 93.0, 6.0);
    CGRect frame_14 = CGRectMake(42.0, 64.0, 93.0, 6.0);
    CGRect frame_12 = CGRectMake(42.0, 70.0, 93.0, 6.0);
    CGRect frame_11 = CGRectMake(42.0, 76.0, 93.0, 6.0);
    CGRect frame_10 = CGRectMake(42.0, 80.0, 93.0, 6.0);
    CGRect frame_9 = CGRectMake(42.0, 86.0, 93.0, 6.0);
    CGRect frame_8 = CGRectMake(16.0, 91.0, 118.0, 6.0);
    CGRect frame_1 = CGRectMake(16.0, 128.0, 118.0, 5.0);
    _arr_indicatorFrames = [[NSMutableArray alloc] initWithObjects:[NSValue valueWithCGRect:frame_23], [NSValue valueWithCGRect:frame_22], [NSValue valueWithCGRect:frame_21], [NSValue valueWithCGRect:frame_20], [NSValue valueWithCGRect:frame_19], [NSValue valueWithCGRect:frame_18], [NSValue valueWithCGRect:frame_17], [NSValue valueWithCGRect:frame_16], [NSValue valueWithCGRect:frame_15], [NSValue valueWithCGRect:frame_14], [NSValue valueWithCGRect:frame_12], [NSValue valueWithCGRect:frame_11], [NSValue valueWithCGRect:frame_10], [NSValue valueWithCGRect:frame_9], [NSValue valueWithCGRect:frame_8], [NSValue valueWithCGRect:frame_1], nil];
    
    _modelController = [[embModelController alloc] init];

    [self initPageView:pageIndex];
    _currentPage = pageIndex;

    [self createPanel];
    [self setCtrlBtns];
    [self createFloorPlanAndRsfLabels];
    [self prepareHlepData];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Victory Center FloorPlan View"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadPano:) name:@"loadPanoImage" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideAndUnhideHelp:) name:@"hideAndUnhideHelp" object:nil];
    self.screenName = @"Victory Center Building View";
}

#pragma mark - Prepare pano image
- (void)loadPano:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    NSString *imageName = [dict objectForKey:@"imageName"];
    NSString *panoTitle = [dict objectForKey:@"title"];
    float offset = [[dict objectForKey:@"offset"] floatValue];
    if (_uiv_panoramicView) {
        [_uiv_panoramicView removeFromSuperview];
        _uiv_panoramicView = nil;
    }
    
    if (imageName) {
        _uiv_panoramicView = [[xhPanoramicView alloc] initWithFrame:self.view.bounds andImageName:imageName andDirection:YES];
        [self setPanoCloseAndTitle:panoTitle];
        _uiv_panoramicView.offSetValue = offset;
        [self.view addSubview:_uiv_panoramicView];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideHomeButton" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideBuildingTopMenu" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadPanoView" object:nil];
    }
}

- (void)setPanoCloseAndTitle:(NSString *)title
{
    UIButton *uib_panoClose = [UIButton buttonWithType:UIButtonTypeCustom];
    uib_panoClose.frame = CGRectMake(0.0, 0.0, 44.0, 44.0);
    [uib_panoClose setBackgroundImage:[UIImage imageNamed:@"grfx_contactClose.jpg"] forState:UIControlStateNormal];
    [uib_panoClose addTarget:self action:@selector(removePano:) forControlEvents:UIControlEventTouchUpInside];
    [_uiv_panoramicView addSubview: uib_panoClose];
    
    UILabel *uil_title = [[UILabel alloc] initWithFrame:CGRectMake(42.0, 0.0, 180.0, 44.0)];
    uil_title.text = title;
    uil_title.textColor = [UIColor vcDarkBlue];
    [uil_title setTextAlignment:NSTextAlignmentCenter];
    uil_title.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    uil_title.layer.borderWidth = 1.0;
    uil_title.backgroundColor = [UIColor whiteColor];
    [uil_title setFont:[UIFont fontWithName:@"Raleway-Bold" size:20]];
    [_uiv_panoramicView addSubview: uil_title];
}

- (void)removePano:(id)sender
{
    if (_uiv_panoramicView) {
        [UIView animateWithDuration:0.2 animations:^{
            _uiv_panoramicView.alpha = 0.0;
        } completion:^(BOOL finished){
            [_uiv_panoramicView removeFromSuperview];
            _uiv_panoramicView = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"unhideHomeButton" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"unhideBuildingTopMenu" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"removePanoView" object:nil];
        }];
    }
}

#pragma mark - Set up side panel
- (void)createPanel
{
    _uiv_panel = [[UIView alloc] initWithFrame:CGRectMake(850, 0.0, panle_w, 185)];
    _uiv_panel.backgroundColor = [UIColor clearColor];
    _uiv_panel.layer.borderWidth = 1.0;
    _uiv_panel.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    _uiv_panel.backgroundColor = [UIColor whiteColor];
    
    _uib_PanelTitle = [UIButton buttonWithType:UIButtonTypeCustom];
    _uib_PanelTitle.frame = CGRectMake(0.0, 0.0, panle_w, kPanelTitleHeight);
    [_uib_PanelTitle setBackgroundImage:[UIImage imageNamed:@"grfx_access_nav.png"] forState:UIControlStateNormal];
    [_uib_PanelTitle setTitle:_arr_titleText[_currentPage] forState:UIControlStateNormal];
    [_uib_PanelTitle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_PanelTitle.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:16.0]];
    _uib_PanelTitle.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    _uib_PanelTitle.tag = 101;
    _uib_PanelTitle.layer.borderWidth = 1.0;
    _uib_PanelTitle.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    _uib_PanelTitle.userInteractionEnabled = NO;
    [_uiv_panel addSubview: _uib_PanelTitle];
    
    [self createPanelContent];
    
    [self.view addSubview: _uiv_panel];
}

- (void)createPanelContent
{
    UIImageView *uiiv_panelBld = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, kPanelTitleHeight, panle_w, 185-kPanelTitleHeight)];
    uiiv_panelBld.backgroundColor = [UIColor vcPanelBackgroundColor];
    
    _uiiv_smallStack = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, kPanelTitleHeight, panle_w, 185 - kPanelTitleHeight)];
    _uiiv_smallStack.image = [UIImage imageNamed:@"grfx_smallStack.png"];
    _uiiv_smallStack.contentMode = UIViewContentModeScaleAspectFit;
    
    _uiv_floorIndicator = [[UIView alloc] initWithFrame:CGRectZero];
    _uiv_floorIndicator.backgroundColor = [UIColor vcDarkBlue];
    _uiv_floorIndicator.frame = [[_arr_indicatorFrames objectAtIndex:_currentPage] CGRectValue];
    
    [_uiv_panel addSubview: uiiv_panelBld];
    [_uiv_panel addSubview: _uiiv_smallStack];
    [_uiiv_smallStack addSubview: _uiv_floorIndicator];
}

#pragma mark - Set up floor RSF labels

- (void)createFloorPlanAndRsfLabels
{
    _uiv_floorTitleContainer = [[UIView alloc] initWithFrame:CGRectMake(31, 97, 168, 58)];
    _uiv_floorTitleContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: _uiv_floorTitleContainer];
    
    UIView *uiv_leftBar = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 13.0, 58.0)];
    uiv_leftBar.backgroundColor = [UIColor vcdarkmenu];
    [_uiv_floorTitleContainer addSubview: uiv_leftBar];
    
    _uil_floorTitle = [[UILabel alloc] initWithFrame:CGRectMake(13.0, 0.0, 140.0, 32)];
    _uil_floorTitle.text = _arr_titleText[_currentPage];
    _uil_floorTitle.font = [UIFont fontWithName:@"Raleway-Bold" size:16.0];
    _uil_floorTitle.textColor = [UIColor vcDarkBlue];
    _uil_floorTitle.textAlignment = NSTextAlignmentCenter;
    [_uiv_floorTitleContainer addSubview: _uil_floorTitle];
    
    _uil_floorRsf = [[UILabel alloc] initWithFrame:CGRectMake(13.0, 32.0, 150.0, 26.0)];
    _uil_floorRsf.text = [NSString stringWithFormat:@"RSF: %@", _arr_squareFeet[_currentPage]];
//    _uil_floorRsf.font = [UIFont fontWithName:@"Raleway-Bold" size:13.0];
    _uil_floorRsf.font = [UIFont boldSystemFontOfSize:13.0];
    _uil_floorRsf.textColor = [UIColor vcDarkBlue];
    _uil_floorRsf.textAlignment = NSTextAlignmentCenter;
    [_uiv_floorTitleContainer addSubview: _uil_floorRsf];
}

#pragma mark - Set up control Buttons
- (void)setCtrlBtns
{
    _uiv_btnContainer = [[UIView alloc] initWithFrame:CGRectMake(_uiv_panel.frame.origin.x, _uiv_panel.frame.size.height, panle_w, 83)];
    _uiv_btnContainer.backgroundColor = [UIColor clearColor];
    _uib_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _uib_backBtn.frame = CGRectMake(0.0, 0.0, panle_w, 33.0);
    _uib_backBtn.backgroundColor = [UIColor vcLightBlue];
    [_uib_backBtn setTitle:@"BACK TO STACK" forState:UIControlStateNormal];
    [_uib_backBtn.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14]];
    [_uib_backBtn addTarget:self action:@selector(backBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [_uiv_btnContainer addSubview: _uib_backBtn];
    
    _uib_upArrow = [UIButton buttonWithType:UIButtonTypeCustom];
    _uib_upArrow.frame = CGRectMake(0.0, 38, 74, 45);
    [_uib_upArrow setBackgroundImage:[UIImage imageNamed:@"grfx_floorUp.png"] forState:UIControlStateNormal];
    _uib_upArrow.tag = 7;
    [_uib_upArrow addTarget:self action:@selector(tapArrowBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_uiv_btnContainer addSubview: _uib_upArrow];
    
    _uib_downArrow = [UIButton buttonWithType:UIButtonTypeCustom];
    _uib_downArrow.frame = CGRectMake(80.0, 38, 74, 45);
    [_uib_downArrow setBackgroundImage:[UIImage imageNamed:@"grfx_floorDwon.png"] forState:UIControlStateNormal];
    [_uib_downArrow addTarget:self action:@selector(tapArrowBtn:) forControlEvents:UIControlEventTouchUpInside];
    _uib_downArrow.tag = 8;
    [_uiv_btnContainer addSubview: _uib_downArrow];
    
    [self enableArrowBtns];
    [self.view addSubview: _uiv_btnContainer];
}

- (void)tapArrowBtn:(id)sender
{
    UIButton *tappedBtn = sender;
    int btnIndex = (int)tappedBtn.tag;
    
    if (btnIndex == 7) {
        if (_currentPage == 0) {
            return;
        }
        _currentPage--;
        embDataViewController *startingViewController = [self.modelController viewControllerAtIndex:_currentPage storyboard:self.storyboard];
        
        NSArray *viewControllers = @[startingViewController];
        
        [self.pageViewController setViewControllers:viewControllers
                                          direction:UIPageViewControllerNavigationDirectionReverse
                                           animated:YES
                                         completion:nil];
    }
    if (btnIndex == 8) {
        if (_currentPage == _arr_titleText.count-1) {
            return;
        }
        _currentPage++;
        embDataViewController *startingViewController = [self.modelController viewControllerAtIndex:_currentPage storyboard:self.storyboard];
        
        NSArray *viewControllers = @[startingViewController];
        
        [self.pageViewController setViewControllers:viewControllers
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:YES
                                         completion:nil];
    }
    
    [self setpageIndex];
}

- (void)backBtnTapped:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"resetBuilding" object:nil];
}

#pragma mark - Set up page view

-(void)initPageView:(NSInteger)index {
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationVertical options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self.modelController;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.autoresizesSubviews =YES;
    self.pageViewController.view.frame = self.view.bounds;
    [self.pageViewController didMoveToParentViewController:self];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview: self.pageViewController.view];
    [self.pageViewController.view setBackgroundColor:[UIColor vcBackGroundColor]];
    
    [self loadPage:(int)index];
}

-(void)loadPage:(int)page {

    embDataViewController *startingViewController = [self.modelController viewControllerAtIndex:page storyboard:self.storyboard];
	
	NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
}

#pragma mark - PageViewController
#pragma mark update page index
- (void)pageViewController:(UIPageViewController *)pvc didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    // If the page did not turn
    if (!completed)
    {
        // You do nothing because whatever page you thought you were on
        // before the gesture started is still the correct page
		NSLog(@"same page");
        return;
    }
    // This is where you would know the page number changed and handle it appropriately
    //    NSLog(@"new page");
    [self setpageIndex];
}

//Up date panel's title text
- (void) setpageIndex
{
    embDataViewController *theCurrentViewController = [self.pageViewController.viewControllers objectAtIndex:0];
    int index = (int)[self.modelController indexOfViewController:theCurrentViewController];
    _currentPage = index;
    [_uib_PanelTitle setTitle:_arr_titleText[index] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.33 animations:^{
        _uiv_floorIndicator.frame = [[_arr_indicatorFrames objectAtIndex:_currentPage] CGRectValue];
    }];
    
    NSString *floorRsf = _arr_squareFeet[index];
    NSString *labelText = [NSString stringWithFormat:@"RSF: %@", floorRsf];
    _uil_floorTitle.text = _arr_titleText[index];
    _uil_floorRsf.text = labelText;
    [self enableArrowBtns];
}

- (void)enableArrowBtns
{
    _uib_downArrow.enabled = YES;
    _uib_upArrow.enabled = YES;
    if (_currentPage == 0) {
        _uib_upArrow.enabled = NO;
    }
    if (_currentPage == _arr_titleText.count-1) {
        _uib_downArrow.enabled = NO;
    }
}

#pragma mark set page index

- (embModelController *)modelController
{
	// Return the model controller object, creating it if necessary.
	// In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [[embModelController alloc] init];
    }
    return _modelController;
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
                     @"Help for this section is coming soon",
                     nil];
    
    [_arr_helpTargetViews removeAllObjects];
    _arr_helpTargetViews = nil;
    UIButton *tmp = [[UIButton alloc] initWithFrame:CGRectMake(10.0, 700.0, 45.0, 45.0)];
    _arr_helpTargetViews = [[NSMutableArray alloc] initWithObjects:tmp, nil];
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


#pragma mark - Remove items from view and cleaning memory

- (void)viewWillDisappear:(BOOL)animated
{
    _modelController = nil;
    
    _arr_pageData = nil;
    
    [_pageViewController.view removeFromSuperview];
    _pageViewController.view = nil;
    [_pageViewController removeFromParentViewController];
    _pageViewController = nil;

    [_uiv_panel removeFromSuperview];
    _uiv_panel = nil;

    [_uib_PanelTitle removeFromSuperview];
    _uib_PanelTitle = nil;

    [_uib_backBtn removeFromSuperview];
    _uib_backBtn = nil;
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
