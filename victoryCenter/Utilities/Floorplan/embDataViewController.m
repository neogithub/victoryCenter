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
	int iTotalButtons;
	UIView *uiv_testFitButtonHOlder;
    UIView *uiv_testFitSubMenuContainer;
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
@property (nonatomic, strong) IBOutlet UICollectionView		*cView;
@property (nonatomic, strong) UIButton						*uib_ShellBtn;
@property (nonatomic, strong) NSMutableArray                *arr_testFitSubMenu;
@property (nonatomic, strong) NSMutableArray                *arr_testFitTenant;

@end

@implementation embDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	_arr_hotspots = [[NSMutableArray alloc] init];
    _arr_testFitBtns = [[NSMutableArray alloc] init];
	// floor plans
	_arr_floorplans = [[NSMutableArray alloc] init];
	_dict = self.dataObject;
	_floorplan = [_dict valueForKeyPath:@"floorplaninfo.floorplan"];
	[_arr_floorplans addObject:[_floorplan objectAtIndex:0]];
	
    UIImageView *uiiv_bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grfx_floorPlan_bg.jpg"]];
    [self.view insertSubview:uiiv_bgImage atIndex:0];
    
//	[self shellButton];
    [self loadDataAndView];
}

#pragma mark - LAYOUT FLOOR PLAN DATA
-(void)loadDataAndView
{
	_uii_Plan = [UIImage imageNamed:_floorplan[0]];
	if (!_zoomingScroll) {
		// NSLog(@"running");
		_zoomingScroll = [[ebZoomingScrollView alloc] initWithFrame:CGRectMake(2, 115, 688, 530) image:_uii_Plan shouldZoom:YES];
		[self.view insertSubview:_zoomingScroll atIndex:1];
		_zoomingScroll.delegate=self;
	}
	
	// plan info data
	NSString *planName = _dict[@"floorplaninfo"][0][@"floorinfo"][0];

	if (!_uiv_PlanDataContainer) {
		if ([planName length] !=0) {
			_uii_PlanData = [UIImage imageNamed:planName];
			
			// plan info container
			CGRect containerFrame = CGRectMake(31, 192, 630, 330);
			
			_uiv_PlanDataContainer = [[UIView alloc] initWithFrame:containerFrame];
			[self.view addSubview:_uiv_PlanDataContainer];
			
			UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, containerFrame.size.width, containerFrame.size.height)];
			scroll.contentSize = CGSizeMake(_uii_PlanData.size.width, _uii_PlanData.size.height);
			scroll.showsHorizontalScrollIndicator = YES;
			scroll.scrollEnabled = YES;
			[_uiv_PlanDataContainer addSubview:scroll];
			
			// plan info uiimageview
			CGRect imageViewFrame = CGRectMake(0, 0, containerFrame.size.width, containerFrame.size.height);
			_uiiv_PlanData = [[UIImageView alloc] initWithFrame:imageViewFrame];
			_uiiv_PlanData.image = _uii_PlanData;
			[scroll addSubview:_uiiv_PlanData];
		}
	}

	// testfit buttons
	NSDictionary *tmp = [[NSDictionary alloc] init];
	tmp = [_dict valueForKeyPath:@"floorplaninfo.testfits"][0];
	
	_arr_testFitBtnsName = [[NSMutableArray alloc] init];
	_arr_testFitBtnsName = [tmp objectForKey:@"testfitcaptions"];

    _arr_testFitImgs = [[NSMutableArray alloc] init];
    _arr_testFitImgs = [tmp objectForKey:@"testfitimages"];
    NSArray *shell = _arr_testFitImgs[0];
    [self loadInImge:shell[0]];
	[self createTestFitButtons:(int)[_arr_testFitBtnsName count]];
}

#pragma mark - Test Fit Buttons
-(void)createTestFitButtons:(int)index
{
	iTotalButtons=index;
	[_arr_testFitBtns removeAllObjects];
    
	uiv_testFitButtonHOlder = [[UIView alloc] initWithFrame:CGRectMake(34.0, 615, 626, 35.0)];
	[uiv_testFitButtonHOlder setBackgroundColor:[UIColor blueColor]];
	[self.view addSubview:uiv_testFitButtonHOlder];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"BrandonGrotesque-Medium" size:17]};
    CGSize pre_size = CGSizeZero;
    CGFloat pre_X = 50.0;
    CGFloat pre_Y = 0.0;
    CGFloat space = 30;
    
	for (int j=0;j<iTotalButtons;j++){ //cols
        NSString *str_btnTitile = [_arr_testFitBtnsName objectAtIndex:j];
        CGSize str_size =[str_btnTitile sizeWithAttributes:attributes];
        
		UIButton *uib_testFitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        uib_testFitBtn.frame = CGRectMake((pre_size.width + space + 11.0 + pre_X), 0.0, str_size.width + space, 60.0);
        uib_testFitBtn.frame = CGRectMake(pre_size.width + pre_X + space, 0.0, str_size.width + 5, 35.0);
        [uib_testFitBtn setTitle:str_btnTitile forState:UIControlStateNormal];
        [uib_testFitBtn setTitle:str_btnTitile forState:UIControlStateSelected];
        [uib_testFitBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [uib_testFitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [uib_testFitBtn.titleLabel setFont:[UIFont fontWithName:@"BrandonGrotesque-Medium" size:17]];
        uib_testFitBtn.tag = j;
        [uib_testFitBtn addTarget:self action:@selector(testFitBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        
//        if (uib_testFitBtn.selected)
//            [uib_testFitBtn.titleLabel setFont:[UIFont fontWithName:@"BrandonGrotesque-BLACK" size:22]];
//        
//        else
//            [uib_testFitBtn.titleLabel setFont:[UIFont fontWithName:@"BrandonGrotesque-Medium" size:20]];
        
        if (j == 0) {
            uib_testFitBtn.selected = YES;
            uib_testFitBtn.userInteractionEnabled = NO;
        }
        uib_testFitBtn.backgroundColor = [UIColor clearColor];
        [uiv_testFitButtonHOlder addSubview: uib_testFitBtn];
        pre_size = uib_testFitBtn.frame.size;
        pre_X = uib_testFitBtn.frame.origin.x;
        pre_Y = uib_testFitBtn.frame.origin.y;
        [_arr_testFitBtns addObject: uib_testFitBtn];
	}
}


#pragma mark Test Fit Toggle
-(void)testFitBtnTapped:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideNaviMenu" object:self];
    for (UIButton *tmp in _arr_testFitBtns) {
        tmp.selected = NO;
        tmp.userInteractionEnabled = YES;
    }
    
    UIButton *tmpBtn = sender;
    tmpBtn.selected = !tmpBtn.selected;
    tmpBtn.userInteractionEnabled = !tmpBtn.userInteractionEnabled;
    NSArray *arr_imgName = [_arr_testFitImgs objectAtIndex:tmpBtn.tag];
    
    [_arr_testFitTenant removeAllObjects];
    _arr_testFitTenant = nil;
    
    _arr_testFitTenant = [[NSMutableArray alloc] initWithArray:arr_imgName];
    
    [self createFloorImage];
//Uncommand to send Notification to change the "Facts & Figures"
//    if (tmpBtn.tag == 0) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"floorFacts" object:self];
//    }
//    else {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"testfitFacts" object:self];
//    }
    
}

-(void)createFloorImage
{
    NSString *str_imgName;
    if (_arr_testFitTenant.count == 1) {
        if (uiv_testFitSubMenuContainer) {
            [UIView animateWithDuration:0.3 animations:^{
                uiv_testFitSubMenuContainer.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished){
                [uiv_testFitSubMenuContainer removeFromSuperview];
                uiv_testFitSubMenuContainer = nil;
            }];
        }

        str_imgName = _arr_testFitTenant[0];
        [self loadInImge:str_imgName];
    }
    if (_arr_testFitTenant.count > 1) {
        [self createTestFitSubMneu];
    }
}

-(void)createTestFitSubMneu
{
    [_arr_testFitSubMenu removeAllObjects];
    _arr_testFitSubMenu = nil;
    _arr_testFitSubMenu = [[NSMutableArray alloc] init];
    
    if (uiv_testFitSubMenuContainer) {
        [UIView animateWithDuration:0.3 animations:^{
            uiv_testFitSubMenuContainer.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished){
            [uiv_testFitSubMenuContainer removeFromSuperview];
            uiv_testFitSubMenuContainer = nil;
            uiv_testFitSubMenuContainer = [[UIView alloc] initWithFrame:uiv_testFitButtonHOlder.frame];
            UIView *topBar = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, uiv_testFitSubMenuContainer.frame.size.width, 1.0)];
            topBar.backgroundColor = [UIColor blueColor];
            UIView *btmBar = [[UIView alloc] initWithFrame:CGRectMake(0.0, uiv_testFitSubMenuContainer.frame.size.height-1, uiv_testFitSubMenuContainer.frame.size.width, 1.0)];
            btmBar.backgroundColor = [UIColor blueColor];
            [uiv_testFitSubMenuContainer addSubview: topBar];
            [uiv_testFitSubMenuContainer addSubview: btmBar];
            [self createSubMneuBtn];
            [self.view insertSubview:uiv_testFitSubMenuContainer belowSubview:uiv_testFitButtonHOlder];
            [UIView animateWithDuration:0.3 animations:^{
                uiv_testFitSubMenuContainer.transform = CGAffineTransformMakeTranslation(0.0, 35.0);
            } completion:^(BOOL finished){      }];
        }];
    }
    else {
        uiv_testFitSubMenuContainer = [[UIView alloc] initWithFrame:uiv_testFitButtonHOlder.frame];
        [self createSubMneuBtn];
        [self.view insertSubview:uiv_testFitSubMenuContainer belowSubview:uiv_testFitButtonHOlder];
        [UIView animateWithDuration:0.3 animations:^{
            uiv_testFitSubMenuContainer.transform = CGAffineTransformMakeTranslation(0.0, 35.0);
            UIView *topBar = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, uiv_testFitSubMenuContainer.frame.size.width, 1.0)];
            topBar.backgroundColor = [UIColor blueColor];
            UIView *btmBar = [[UIView alloc] initWithFrame:CGRectMake(0.0, uiv_testFitSubMenuContainer.frame.size.height-1, uiv_testFitSubMenuContainer.frame.size.width, 1.0)];
            btmBar.backgroundColor = [UIColor blueColor];
            [uiv_testFitSubMenuContainer addSubview: topBar];
            [uiv_testFitSubMenuContainer addSubview: btmBar];
        } completion:^(BOOL finished){      }];
    }
}

-(void)createSubMneuBtn
{
    for (int i = 0; i < _arr_testFitTenant.count; i++) {
        UIButton *uib_subTestfit = [UIButton buttonWithType:UIButtonTypeCustom];
        uib_subTestfit.frame = CGRectMake(150 + 100*i+50, 0.0, 100.0, 35.0);
        NSString *buttonTitle = [NSString stringWithFormat:@"%i TENANT", i+1];
        [uib_subTestfit setTitle:buttonTitle forState:UIControlStateNormal];
        [uib_subTestfit setTitle:buttonTitle forState:UIControlStateSelected];
        [uib_subTestfit setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [uib_subTestfit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        uib_subTestfit.tag = i;
        [uib_subTestfit.titleLabel setFont:[UIFont fontWithName:@"BrandonGrotesque-Medium" size:17]];
        if (i == 0) {
            uib_subTestfit.selected = YES;
            uib_subTestfit.userInteractionEnabled = NO;
        }
        [_arr_testFitSubMenu addObject: uib_subTestfit];
        [uib_subTestfit addTarget:self action:@selector(tapTestFitSubMenu:) forControlEvents:UIControlEventTouchUpInside];
        [uiv_testFitSubMenuContainer addSubview: uib_subTestfit];
    }
    [self loadInImge:_arr_testFitTenant[0]];
}

-(void)tapTestFitSubMenu:(id)sender
{
    for (UIButton *tmp in _arr_testFitSubMenu) {
        tmp.selected = NO;
        tmp.userInteractionEnabled = YES;
    }
    UIButton *tappedBtn = sender;
    tappedBtn.selected = !tappedBtn.selected;
    tappedBtn.userInteractionEnabled = !tappedBtn.userInteractionEnabled;
    int index = (int)tappedBtn.tag;
    NSString *tenantName = _arr_testFitTenant[index];
    [self loadInImge:tenantName];
}

-(void)loadInImge:(NSString *)imageName
{
    [UIView animateWithDuration:0.33 animations:^{
        _zoomingScroll.blurView.alpha = 0.0;
    } completion:^(BOOL finished){
        _zoomingScroll.blurView.image = [UIImage imageNamed:imageName];
        [UIView animateWithDuration:0.33 animations:^{
            _zoomingScroll.blurView.alpha = 1.0;
        }];
    }];

}

#pragma mark - BOILERPLATE
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideNaviMenu" object:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	
	// otherwise plan stays zoomed in
	// when you scroll to new page
	[_zoomingScroll resetScroll];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
