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

static float    panle_w                     = 156;
static CGFloat  kPanelTitleHeight           = 46;
@interface floorPlanViewController ()<UIPageViewControllerDelegate>

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
// Floor num & RSF. labels
@property (nonatomic, strong)   UILabel                         *uil_floorRsf;
// Key panel
@property (nonatomic, strong)   UIImageView                     *uiiv_keyPanel;
// Control Button
@property (nonatomic, strong)   UIButton                        *uib_backBtn;
// Pano image
@property (nonatomic, strong)   xhPanoramicView                 *uiv_panoramicView;
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
    _arr_titleText = [[NSArray alloc] initWithObjects: @"FLOOR 18 - 23", @"FLOOR 17", @"FLOOR 16", @"FLOOR 15", @"FLOOR 10 - 14", @"FLOOR 9", @"FLOOR 8",nil];
    _arr_squareFeet = [[NSArray alloc] initWithObjects:@"100.0", @"101.0", @"102.0", @"103.0", @"104.0", @"105.0", @"106.0", @"107.0", nil];
    
    CGRect frame_18_23 = CGRectMake(42.0, 18.0, 93.0, 30.0);
    CGRect frame_17 = CGRectMake(42.0, 50.0, 93.0, 4.0);
    CGRect frame_16 = CGRectMake(42.0, 55.0, 93.0, 4.0);
    CGRect frame_15 = CGRectMake(42.0, 60.0, 93.0, 4.0);
    CGRect frame_14_10 = CGRectMake(42.0, 65.0, 93.0, 24.0);
    CGRect frame_9 = CGRectMake(42.0, 88.0, 93.0, 4.0);
    CGRect frame_8 = CGRectMake(16.0, 93.0, 118.0, 4.0);
    _arr_indicatorFrames = [[NSMutableArray alloc] initWithObjects:[NSValue valueWithCGRect:frame_18_23], [NSValue valueWithCGRect:frame_17], [NSValue valueWithCGRect:frame_16], [NSValue valueWithCGRect:frame_15], [NSValue valueWithCGRect:frame_14_10], [NSValue valueWithCGRect:frame_9], [NSValue valueWithCGRect:frame_8], nil];
    
    _modelController = [[embModelController alloc] init];
    [self initPageView:pageIndex];
    _currentPage = pageIndex;
    [self createPanel];
    [self setCtrlBtns];
    [self createKeyPanel];
    [self createFloorPlanAndRsfLabels];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadPano:) name:@"loadPanoImage" object:nil];
}

#pragma mark - Prepare pano image
- (void)loadPano:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    NSString *imageName = [dict objectForKey:@"imageName"];
    NSString *panoTitle = [dict objectForKey:@"title"];
    if (_uiv_panoramicView) {
        [_uiv_panoramicView removeFromSuperview];
        _uiv_panoramicView = nil;
    }
    
    if (imageName) {
        _uiv_panoramicView = [[xhPanoramicView alloc] initWithFrame:self.view.bounds andImageName:imageName];
        [self setPanoCloseAndTitle:panoTitle];
        [self.view addSubview:_uiv_panoramicView];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideHomeButton" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideBuildingTopMenu" object:nil];
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
        }];
    }
}

#pragma mark - Set up Keys panel

- (void)createKeyPanel
{
    _uiiv_keyPanel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grfx_floorplan_keys.png"]];
    _uiiv_keyPanel.frame = CGRectMake(_uiv_btnContainer.frame.origin.x, _uiv_btnContainer.frame.origin.y + _uiv_btnContainer.frame.size.height + 30, _uiiv_keyPanel.frame.size.width, _uiiv_keyPanel.frame.size.height);
    _uiiv_keyPanel.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    _uiiv_keyPanel.layer.borderWidth = 1.0;
    [self.view addSubview: _uiiv_keyPanel];
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
    [_uib_PanelTitle setTitle:_arr_titleText[pageIndex] forState:UIControlStateNormal];
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
    _uiv_floorIndicator.frame = [[_arr_indicatorFrames objectAtIndex:pageIndex] CGRectValue];
    
    [_uiv_panel addSubview: uiiv_panelBld];
    [_uiv_panel addSubview: _uiiv_smallStack];
    [_uiiv_smallStack addSubview: _uiv_floorIndicator];
}

#pragma mark - Set up floor RSF labels

- (void)createFloorPlanAndRsfLabels
{
    NSString *floorRsf = _arr_squareFeet[pageIndex];
    NSString *labelText = [NSString stringWithFormat:@"RSF: %@",  floorRsf];
    _uil_floorRsf = [[UILabel alloc] initWithFrame:CGRectMake(_uiiv_keyPanel.frame.origin.x, _uiiv_keyPanel.frame.origin.y + _uiiv_keyPanel.frame.size.height + 10, panle_w, 30.0)];
    _uil_floorRsf.backgroundColor = [UIColor whiteColor];
    _uil_floorRsf.layer.borderWidth = 1.0;
    _uil_floorRsf.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    _uil_floorRsf.text = labelText;
    _uil_floorRsf.textColor = [UIColor vcLightBlue];
    _uil_floorRsf.textAlignment = NSTextAlignmentCenter;
    _uil_floorRsf.font = [UIFont fontWithName:@"Raleway-Bold" size:13.0];
    [self.view addSubview: _uil_floorRsf];
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
    
    UIButton *uib_upArrow = [UIButton buttonWithType:UIButtonTypeCustom];
    uib_upArrow.frame = CGRectMake(0.0, 38, 74, 45);
    [uib_upArrow setBackgroundImage:[UIImage imageNamed:@"grfx_floorUp.png"] forState:UIControlStateNormal];
    uib_upArrow.tag = 7;
    [uib_upArrow addTarget:self action:@selector(tapArrowBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_uiv_btnContainer addSubview: uib_upArrow];
    
    UIButton *uib_downArrow = [UIButton buttonWithType:UIButtonTypeCustom];
    uib_downArrow.frame = CGRectMake(80.0, 38, 74, 45);
    [uib_downArrow setBackgroundImage:[UIImage imageNamed:@"grfx_floorDwon.png"] forState:UIControlStateNormal];
    [uib_downArrow addTarget:self action:@selector(tapArrowBtn:) forControlEvents:UIControlEventTouchUpInside];
    uib_downArrow.tag = 8;
    [_uiv_btnContainer addSubview: uib_downArrow];
    
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
    _uil_floorRsf.text = labelText;
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
