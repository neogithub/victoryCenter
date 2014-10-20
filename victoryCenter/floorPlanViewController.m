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

static float    panle_w                     = 156;
static CGFloat  kPanelTitleHeight           = 46;
@interface floorPlanViewController ()<UIPageViewControllerDelegate>

// Page View
@property (readonly, strong, nonatomic) embModelController		*modelController;
@property (readonly, strong, nonatomic) NSArray					*arr_pageData;
@property (strong, nonatomic)           UIPageViewController	*pageViewController;
// Side Panel
@property (nonatomic, strong)   UIView                          *uiv_panel;
@property (nonatomic, strong)   UIButton                        *uib_PanelTitle;
// Control Button
@property (nonatomic, strong)   UIButton                        *uib_backBtn;
@property (nonatomic, strong)   UIButton                        *uib_panoBtn;
@end

@implementation floorPlanViewController

@synthesize modelController = _modelController;

- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = screenRect;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _modelController = [[embModelController alloc] init];
    [self initPageView:0];
    [self createPanel];
    [self setCtrlBtns];
}

#pragma mark - Set up side panel
- (void)createPanel
{
    _uiv_panel = [[UIView alloc] initWithFrame:CGRectMake(817, 0.0, panle_w, 265)];
    _uiv_panel.backgroundColor = [UIColor clearColor];
    _uiv_panel.layer.borderWidth = 1.0;
    _uiv_panel.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    _uiv_panel.backgroundColor = [UIColor whiteColor];
    
    _uib_PanelTitle = [UIButton buttonWithType:UIButtonTypeCustom];
    _uib_PanelTitle.frame = CGRectMake(0.0, 0.0, panle_w, kPanelTitleHeight);
    [_uib_PanelTitle setBackgroundImage:[UIImage imageNamed:@"grfx_access_nav.png"] forState:UIControlStateNormal];
    [_uib_PanelTitle setTitle:@"FLOOR 18 - 23" forState:UIControlStateNormal];
    [_uib_PanelTitle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_PanelTitle.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:16.0]];
    _uib_PanelTitle.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    _uib_PanelTitle.tag = 101;
    _uib_PanelTitle.layer.borderWidth = 1.0;
    _uib_PanelTitle.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    [_uiv_panel addSubview: _uib_PanelTitle];
    
    [self createPanelContent];
    
    [self.view addSubview: _uiv_panel];
}

- (void)createPanelContent
{
    UIImageView *uiiv_panelBld = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, kPanelTitleHeight, panle_w, 150)];
    uiiv_panelBld.backgroundColor = [UIColor vcPanelBackgroundColor];
    [_uiv_panel addSubview: uiiv_panelBld];
}

#pragma mark - Set up control Buttons
- (void)setCtrlBtns
{
    UIView *uiv_btnContainer = [[UIView alloc] initWithFrame:CGRectMake(_uiv_panel.frame.origin.x, _uiv_panel.frame.size.height+3, panle_w, 83)];
    
    _uib_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _uib_backBtn.frame = CGRectMake(0.0, 0.0, panle_w, 33.0);
    _uib_backBtn.backgroundColor = [UIColor vcLightBlue];
    [_uib_backBtn setTitle:@"BACK TO STACK" forState:UIControlStateNormal];
    [_uib_backBtn.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14]];
    [_uib_backBtn addTarget:self action:@selector(backBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [uiv_btnContainer addSubview: _uib_backBtn];
    
    _uib_panoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _uib_panoBtn.frame = CGRectMake(0.0, _uib_backBtn.frame.size.height + 3, panle_w, 33);
    _uib_panoBtn.backgroundColor = [UIColor vcLightBlue];
    [_uib_panoBtn setTitle:@"VIEW PANO" forState:UIControlStateNormal];
    [_uib_panoBtn.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14]];
    [uiv_btnContainer addSubview: _uib_panoBtn];
    [_uib_panoBtn addTarget:self action:@selector(panoBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: uiv_btnContainer];
}

- (void)backBtnTapped:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"resetBuilding" object:nil];
}

- (void)panoBtnTapped:(id)sender
{
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle: @""
                               message: @"LOAD PANO IMAGE"
                              delegate: self
                     cancelButtonTitle: @"OK"
                     otherButtonTitles: nil];
    alert.tag = 1;
    [alert show];
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
//    [self setPageIndex];
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

    [_uib_panoBtn removeFromSuperview];
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
