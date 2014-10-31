//
//  buildingViewController.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/23/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "buildingViewController.h"
#import "UIColor+Extensions.h"
#import "floorPlanViewController.h"
@interface buildingViewController ()
{

}

@property (nonatomic, strong) NSMutableArray                *arr_topBtnsArray;

@property (weak, nonatomic) IBOutlet UIImageView            *uiiv_bgImg;
@property (weak, nonatomic) IBOutlet UIView                 *uiv_bldImgContainer;
@property (weak, nonatomic) IBOutlet UIView                 *uiv_statImgContainer;
@property (weak, nonatomic) IBOutlet UIButton               *uib_statsClose;

@property (weak, nonatomic) IBOutlet UIButton               *uib_bldgStats;
@property (weak, nonatomic) IBOutlet UIButton               *uib_floorPlan;
@property (weak, nonatomic) IBOutlet UIButton               *uib_amenities;
@property (weak, nonatomic) IBOutlet UIButton               *uib_elevators;
//Floor plan
@property (nonatomic, strong) floorPlanViewController       *floorPlan;

@property (weak, nonatomic) IBOutlet UIButton               *uib_24;
@property (weak, nonatomic) IBOutlet UIButton               *uib_18_23;
@property (weak, nonatomic) IBOutlet UIButton               *uib_17;
@property (weak, nonatomic) IBOutlet UIButton               *uib_16;
@property (weak, nonatomic) IBOutlet UIButton               *uib_15;
@property (weak, nonatomic) IBOutlet UIButton               *uib_10_14;
@property (weak, nonatomic) IBOutlet UIButton               *uib_9;
@property (weak, nonatomic) IBOutlet UIButton               *uib_8;
@property (nonatomic, strong) NSArray                       *arr_floorBtns;
//Elevator
@property (nonatomic, strong) UIView                        *uiv_elevatorContainer;
@property (nonatomic, strong) UIView                        *uiv_eleLayerConainer;
@property (nonatomic, strong) NSMutableArray                *arr_eleBtnArray;
@property (nonatomic, strong) NSArray                       *arr_elevatroImgs;
@property (nonatomic, strong) NSMutableArray                *arr_eleIndArray;
@end

@implementation buildingViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = screenRect;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTopButtons];
    [self setGestureToBldStats];
    [self groupBtns];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetBuilding) name:@"resetBuilding" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideBuildingMenu) name:@"hideBuildingTopMenu" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unhideBuildingMenu) name:@"unhideBuildingTopMenu" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetBuilding) name:@"tapOnTitle" object:nil];
}

#pragma mark - Hide & unhide top menu 

- (void)hideBuildingMenu
{
    for (UIButton *tmp in _arr_topBtnsArray) {
        tmp.hidden = YES;
    }
}

- (void)unhideBuildingMenu
{
    for (UIButton *tmp in _arr_topBtnsArray) {
        tmp.hidden = NO;
    }

}

#pragma mark - Add Button to building image

- (void)groupBtns
{
    _uib_24.tag = 1;
    _uib_18_23.tag = 2;
    _uib_17.tag = 3;
    _uib_16.tag = 4;
    _uib_15.tag = 5;
    _uib_10_14.tag = 6;
    _uib_9.tag = 7;
    _uib_8.tag = 8;
    _arr_floorBtns = [[NSArray alloc] initWithObjects:_uib_24, _uib_18_23, _uib_17, _uib_16, _uib_15, _uib_10_14, _uib_9, _uib_8, nil];

    for (UIButton *tmp in _arr_floorBtns) {
        [tmp addTarget:self action:@selector(floorBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)floorBtnTapped:(id)sender
{
    UIButton *tappedBtn = sender;
    int index = (int)tappedBtn.tag - 1;
    
    [self loadFloorPlan:index];
    
    [self resetTopMenu];
    _uib_floorPlan.backgroundColor = [UIColor vcDarkBlue];
    _uib_floorPlan.selected = YES;
}

#pragma mark - Methods dealing with notifications
- (void)resetBuilding
{
    _uiiv_bgImg.hidden = YES;
    _uiv_bldImgContainer.transform = CGAffineTransformIdentity;
    _uiv_bldImgContainer.hidden = NO;
    _uiv_statImgContainer.hidden = YES;
    _uiv_statImgContainer.alpha = 0.0;
    _uiv_statImgContainer.transform = CGAffineTransformIdentity;
    
    [self removeFloorPlan];
}

#pragma mark - Set up Top menu buttons

- (void)setTopButtons
{
    _arr_topBtnsArray = [[NSMutableArray alloc] init];
    [self initTopBtn:_uib_bldgStats withTitle:@"BUILDING STATS" andTag:1 andSelected:NO];
    [self initTopBtn:_uib_floorPlan withTitle:@"FLOOR PLAN" andTag:2 andSelected:NO];
    [self initTopBtn:_uib_amenities withTitle:@"AMENITIES" andTag:3 andSelected:NO];
    [self initTopBtn:_uib_elevators withTitle:@"ELEVATORS" andTag:4 andSelected:NO];
}

- (void)initTopBtn:(UIButton *)theBtn withTitle:(NSString *)title andTag:(int)index andSelected:(BOOL)selected
{
    [theBtn setTitle:title forState:UIControlStateNormal];
    [theBtn setTitle:title forState:UIControlStateSelected];
    [theBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [theBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [theBtn.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14]];
    theBtn.tag = index;
    if (selected) {
        theBtn.backgroundColor = [UIColor vcDarkBlue];
        theBtn.selected = selected;
    }
    else{
        theBtn.backgroundColor = [UIColor vcLightBlue];
        theBtn.selected = selected;
    }
    [_arr_topBtnsArray addObject: theBtn];
    [theBtn addTarget:self action:@selector(tapOnTopBtns:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark Reset top Menu
- (void)resetTopMenu
{
    for (UIButton *tmp in _arr_topBtnsArray) {
        tmp.selected = NO;
        tmp.backgroundColor = [UIColor vcLightBlue];
    }
}
#pragma mark Actions of top menu
- (void)tapOnTopBtns:(id)sender
{
    UIButton *tappedBtn = sender;
    [self resetTopMenu];
    
    tappedBtn.selected = YES;
    tappedBtn.backgroundColor = [UIColor vcDarkBlue];
    
    [self updateContent:(int)tappedBtn.tag];
}

- (void)updateContent:(int)index
{
    [_uiv_elevatorContainer removeFromSuperview];
    _uiv_elevatorContainer = nil;
    _uiiv_bgImg.hidden = YES;
    _uiv_bldImgContainer.hidden = YES;
    _uiv_bldImgContainer.transform = CGAffineTransformIdentity;
    _uiv_statImgContainer.hidden = YES;
    _uiv_statImgContainer.alpha = 0.0;
    _uiv_statImgContainer.transform = CGAffineTransformIdentity;
    [self removeFloorPlan];
    
    switch (index) {
        case 1: {
            [self moveInBldStats];
            break;
        }
        case 2: {
            [self loadFloorPlan:0];
            break;
        }
        case 3: {
            _uiiv_bgImg.hidden = NO;
            NSString *url = [[NSBundle mainBundle] pathForResource:@"grfx_bldAmenities_bg" ofType:@"jpg"];
            _uiiv_bgImg.image = [UIImage imageWithContentsOfFile:url];
            break;
        }
        case 4: {
            [self loadElevator];
            break;
        }
        default:
            break;
    }
}

#pragma mark - Building Stats
- (IBAction)closeBldStats:(id)sender {
    [self resetBuildingImg:nil];
}

- (void)setGestureToBldStats
{
    UISwipeGestureRecognizer *swipeStatImg = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(resetBuildingImg:)];
    swipeStatImg.direction = UISwipeGestureRecognizerDirectionLeft;
    [_uiv_statImgContainer addGestureRecognizer: swipeStatImg];
}

- (void)resetBuildingImg:(UIGestureRecognizer *)gesture
{
    [UIView animateWithDuration:0.33 animations:^{
        _uiv_bldImgContainer.transform = CGAffineTransformIdentity;
        _uiv_statImgContainer.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        _uiv_statImgContainer.hidden = YES;
        [self resetTopMenu];
    }];
}

- (void)moveInBldStats
{
    _uiv_bldImgContainer.hidden = NO;
    _uiv_statImgContainer.hidden = NO;
    
    // Animation for the building and stat image
    CGFloat duration = 0.9f;
    CGFloat damping = 0.6f;
    CGFloat velocity = 0.7f;
    // int to hold UIViewAnimationOption
    NSInteger option;
    option = UIViewAnimationCurveEaseInOut;
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:option animations:^{
        _uiv_bldImgContainer.transform = CGAffineTransformMakeTranslation(140.0, 0.0);
        
    } completion:^(BOOL finished){      }];
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping*1.0 initialSpringVelocity:velocity*0.8 options:option animations:^{
        _uiv_statImgContainer.alpha = 1.0;
        _uiv_statImgContainer.transform = CGAffineTransformMakeTranslation(356, 0.0);
        
    } completion:^(BOOL finished){      }];
}

#pragma mark - Set up Floor plan view
- (void)loadFloorPlan:(int)pageIndex
{
    [self removeFloorPlan];
    
    _floorPlan = [self.storyboard instantiateViewControllerWithIdentifier:@"floorPlanViewController"];;
    _floorPlan.view.frame = screenRect;
    _floorPlan.pageIndex = pageIndex;
    [self addChildViewController:_floorPlan];
    [self.view insertSubview:_floorPlan.view belowSubview:_uib_bldgStats];
}

- (void)removeFloorPlan {
    if (_floorPlan) {
        [_floorPlan.view removeFromSuperview];
        _floorPlan.view = nil;
        [_floorPlan removeFromParentViewController];
        _floorPlan = nil;
    }
}

#pragma mark - Set up elevator view

- (void)loadElevator
{
    if (_uiv_elevatorContainer) {
        [_uiv_elevatorContainer removeFromSuperview];
        _uiv_elevatorContainer = nil;
    }
    _uiv_elevatorContainer = [[UIView alloc] initWithFrame:screenRect];
    _uiv_elevatorContainer.backgroundColor = [UIColor clearColor];
    [self loadElevatorBldImg];
    [self loadElevatorCtrlPanel];
    [self.view insertSubview:_uiv_elevatorContainer belowSubview:_uib_bldgStats];
    
}

#pragma mark Set up building image
- (void)loadElevatorBldImg
{
    UIImageView *uiiv_eleBldImg = [[UIImageView alloc] initWithFrame:CGRectMake(185, 36, 780, 733)];
    uiiv_eleBldImg.image = [UIImage imageNamed:@"grfx_elavators_stack_blank.png"];
    
    if (_uiv_eleLayerConainer) {
        [_uiv_eleLayerConainer removeFromSuperview];
        _uiv_eleLayerConainer = nil;
    }
    _uiv_eleLayerConainer = [[UIView alloc] initWithFrame:screenRect];
    _uiv_eleLayerConainer.backgroundColor = [UIColor clearColor];
    UIImageView *uiiv_lowRiseEle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grfx_elavators_low_rise.png"]];
    uiiv_lowRiseEle.frame = CGRectMake(686, 328, uiiv_lowRiseEle.frame.size.width, uiiv_lowRiseEle.frame.size.height);
    uiiv_lowRiseEle.transform = CGAffineTransformMakeTranslation(0.0, uiiv_lowRiseEle.frame.size.height);
    
    UIImageView *uiiv_highRiseEle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grf_elavators_high_rise.png"]];
    uiiv_highRiseEle.frame = CGRectMake(584, 121, uiiv_highRiseEle.frame.size.width, uiiv_highRiseEle.frame.size.height);
    uiiv_highRiseEle.transform = CGAffineTransformMakeTranslation(0.0, uiiv_highRiseEle.frame.size.height);
    
    UIImageView *uiiv_parking = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grfx_elavators_parking.png"]];
    uiiv_parking.frame = CGRectMake(247, 534, uiiv_parking.frame.size.width, uiiv_parking.frame.size.height);
    uiiv_parking.transform = CGAffineTransformMakeTranslation(0.0, uiiv_parking.frame.size.height);
    
    UIImageView *uiiv_lobby = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grfx_elavators_lobby.png"]];
    uiiv_lobby.frame = CGRectMake(395, 650, uiiv_lobby.frame.size.width, uiiv_lobby.frame.size.height);
    uiiv_lobby.transform = CGAffineTransformMakeTranslation(0.0, uiiv_lobby.frame.size.height);
    
    _arr_elevatroImgs = [[NSArray alloc] initWithObjects:uiiv_lowRiseEle, uiiv_highRiseEle, uiiv_parking, uiiv_lobby,nil];
    
    [_uiv_eleLayerConainer insertSubview:uiiv_parking atIndex:1];
    [_uiv_eleLayerConainer insertSubview:uiiv_lobby atIndex:2];
    [_uiv_eleLayerConainer insertSubview:uiiv_lowRiseEle atIndex:3];
    [_uiv_eleLayerConainer insertSubview:uiiv_highRiseEle atIndex:4];
    
    [_uiv_elevatorContainer insertSubview:_uiv_eleLayerConainer atIndex:1];
    [_uiv_elevatorContainer insertSubview:uiiv_eleBldImg atIndex:2];
    
    //Label of "Parking" & "Lobby"
    UILabel *uil_parking = [[UILabel alloc]initWithFrame:CGRectMake(770.0, 590.0, 100.0, 30.0)];
    uil_parking.backgroundColor = [UIColor clearColor];
    uil_parking.text = @"PARKING";
    uil_parking.font = [UIFont fontWithName:@"Raleway-Bold" size:14.0];
    uil_parking.textColor = [UIColor vcDarkBlue];
    [_uiv_elevatorContainer addSubview: uil_parking];
    
    UILabel *uil_lobby = [[UILabel alloc]initWithFrame:CGRectMake(770.0, 700.0, 100.0, 30.0)];
    uil_lobby.backgroundColor = [UIColor clearColor];
    uil_lobby.text = @"LOBBY";
    uil_lobby.font = [UIFont fontWithName:@"Raleway-Bold" size:14.0];
    uil_lobby.textColor = [UIColor vcDarkBlue];
    [_uiv_elevatorContainer addSubview: uil_lobby];
    //Floor number image
    UIImageView *uiiv_floorNum = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grfx_elevator_floorNum.png"]];
    uiiv_floorNum.frame = CGRectMake(400, 98, uiiv_floorNum.frame.size.width, uiiv_floorNum.frame.size.height);
    [_uiv_elevatorContainer addSubview: uiiv_floorNum];
}


#pragma mark Set up elevator control panel
- (void)loadElevatorCtrlPanel
{
    UIView *uiv_ctrlPanel = [[UIView alloc] initWithFrame:CGRectMake(65.0, 95.0, 200.0, 246.0)];
    uiv_ctrlPanel.backgroundColor = [UIColor clearColor];
    uiv_ctrlPanel.clipsToBounds = YES;
    
    UIButton *uib_PanelTitle = [UIButton buttonWithType:UIButtonTypeCustom];
    uib_PanelTitle.frame = CGRectMake(0.0, 0.0, 200.0, 46);
    [uib_PanelTitle setBackgroundImage:[UIImage imageNamed:@"grfx_access_nav.png"] forState:UIControlStateNormal];
    [uib_PanelTitle setTitle:@"ELEVATORS" forState:UIControlStateNormal];
    [uib_PanelTitle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [uib_PanelTitle.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:16.0]];
    uib_PanelTitle.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 100);
    uib_PanelTitle.tag = 101;
    uib_PanelTitle.userInteractionEnabled = NO;
    [uiv_ctrlPanel addSubview: uib_PanelTitle];
    
    NSArray *arr_buttonTitles = [[NSArray alloc] initWithObjects:@"LOW-RISE ELEVATORS", @"HIGH-RISE ELEVATORS", @"PARKING", @"LOBBY", nil];
    [uiv_ctrlPanel addSubview: [self loadPanelBtnsWithTitle:arr_buttonTitles]];
    
    //Add Reset button to the panel
    UIButton *uib_resetEle = [UIButton buttonWithType:UIButtonTypeCustom];
    uib_resetEle.frame = CGRectMake(100.0, 206.0, 100.0, 40.0);
    uib_resetEle.backgroundColor = [UIColor clearColor];
    [uib_resetEle setTitle:@"RESET" forState:UIControlStateNormal];
    [uib_resetEle setTitleColor:[UIColor vcLightBlue] forState:UIControlStateNormal];
    [uib_resetEle.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14.0]];
    [uib_resetEle setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 50, 10.0, 0.0)];
    [uib_resetEle addTarget:self action:@selector(resetAllEleImgs) forControlEvents:UIControlEventTouchUpInside];
    [uiv_ctrlPanel addSubview: uib_resetEle];
    
    UIButton *uib_showAll = [UIButton buttonWithType:UIButtonTypeCustom];
    uib_showAll.frame = CGRectMake(0.0, 206.0, 100.0, 40.0);
    uib_showAll.backgroundColor = [UIColor clearColor];
    [uib_showAll setTitle:@"ALL" forState:UIControlStateNormal];
    [uib_showAll setTitleColor:[UIColor vcLightBlue                                                                                                                                                         ] forState:UIControlStateNormal];
    [uib_showAll.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14.0]];
    [uib_showAll setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 10.0, 60.0)];
    [uib_showAll addTarget:self action:@selector(showAllEleImg) forControlEvents:UIControlEventTouchUpInside];
    [uiv_ctrlPanel addSubview: uib_showAll];
    
    [_uiv_elevatorContainer addSubview: uiv_ctrlPanel];
    [self animateCtrlPanel:uiv_ctrlPanel];
}
#pragma mark Create panel's buttons
- (UIView *)loadPanelBtnsWithTitle:(NSArray *)arr_title
{
    [_arr_eleBtnArray removeAllObjects];
    _arr_eleBtnArray = nil;
    _arr_eleBtnArray = [[NSMutableArray alloc] init];
    
    [_arr_eleIndArray removeAllObjects];
    _arr_eleIndArray = nil;
    _arr_eleIndArray = [[NSMutableArray alloc] init];
    
    UIView *uiv_btnContainer = [[UIView alloc] initWithFrame:CGRectMake(0.0, 46.0, 200.0, 160.0)];
    uiv_btnContainer.backgroundColor = [UIColor whiteColor];
    uiv_btnContainer.layer.borderWidth = 1.0;
    uiv_btnContainer.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    
    for (int i = 0; i < arr_title.count; i++) {
        UIButton *uib_option = [UIButton buttonWithType:UIButtonTypeCustom];
        uib_option.frame = CGRectMake(0.0, i*40, 200.0, 40);
        uib_option.backgroundColor = [UIColor whiteColor];
        uib_option.layer.borderColor = [UIColor vcButtonBorder].CGColor;
        uib_option.layer.borderWidth = 1.0;
        [uib_option setTitle:arr_title[i] forState:UIControlStateNormal];
        [uib_option setTitleColor:[UIColor vcDarkBlue] forState:UIControlStateNormal];
        [uib_option.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:12.0]];
        uib_option.tag = i;
        uib_option.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        uib_option.titleEdgeInsets = UIEdgeInsetsMake(3.0, 45, 0.0, 0.0);
        uib_option.selected = NO;
        [uib_option addTarget:self action:@selector(tapOptions:) forControlEvents:UIControlEventTouchUpInside];
        [uiv_btnContainer addSubview: uib_option];
        
        CGRect frame = CGRectMake(19, uib_option.frame.origin.y + (uib_option.frame.size.height - 14)/2, 14, 14);
        UIView *uiv_Indicator = [[UIView alloc] initWithFrame:frame];
        uiv_Indicator.backgroundColor = [UIColor clearColor];
        uiv_Indicator.layer.borderColor = [UIColor vcDarkBlue].CGColor;
        uiv_Indicator.layer.borderWidth = 2.0;
        CGPoint savedCenter = uiv_Indicator.center;
        uiv_Indicator.layer.cornerRadius = 14.0 / 2.0;
        uiv_Indicator.center = savedCenter;
        uiv_Indicator.tag = 500+i;
        [uiv_btnContainer addSubview: uiv_Indicator];
        [_arr_eleIndArray addObject: uiv_Indicator];
        [_arr_eleBtnArray addObject: uib_option];
    }
    return uiv_btnContainer;
}

- (void)animateCtrlPanel:(UIView *)panel
{
    panel.transform = CGAffineTransformMakeTranslation(0.0, -200.0);
    [panel viewWithTag:102].transform = CGAffineTransformMakeTranslation(0.0, -46.0);
    
    CGFloat duration = 0.5f;
    CGFloat damping = 0.6f;
    CGFloat velocity = 0.6f;
    // int to hold UIViewAnimationOption
    NSInteger option;
    option = UIViewAnimationCurveEaseInOut;
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:option animations:^{
        panel.transform = CGAffineTransformIdentity;
        [panel viewWithTag:102].transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){      }];
}
#pragma mark - interaction of ctrl panel
- (void)tapOptions:(id)sender
{
    float delay = 0.0;
    [self performSelector:@selector(animateElevator:) withObject:sender afterDelay:delay];
}

- (void)animateElevator:(id)sender
{
    UIButton *tappedBtn = sender;
    int index = (int)tappedBtn.tag;
    
    UIView *buttonContainer = [tappedBtn superview];
    UIView *indicator = [buttonContainer viewWithTag:(500+index)];
    NSArray *arr_color = [[NSArray alloc] initWithObjects:[UIColor vcSiteResidentail], [UIColor vcSiteRecreation], [UIColor vcBldParking], [UIColor vcSiteRetail], nil];
    
    UIImageView *uiiv_selectetd = _arr_elevatroImgs[index];
    if (tappedBtn.selected) {
        tappedBtn.backgroundColor = [UIColor whiteColor];
        tappedBtn.layer.borderWidth = 1.0;
        tappedBtn.layer.borderColor = [UIColor vcButtonBorder].CGColor;
        indicator.backgroundColor = [UIColor clearColor];
        // Set the parameters to be passed into the animation
        CGFloat duration = 0.5f;
        CGFloat damping = 0.8;
        CGFloat velocity = 0.6;
        // int to hold UIViewAnimationOption
        NSInteger option;
        option = UIViewAnimationCurveEaseInOut;
        
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:option animations:^{
            uiiv_selectetd.transform = CGAffineTransformMakeTranslation(0.0, uiiv_selectetd.frame.size.height);
        } completion:^(BOOL finished){      }];

    }
    else {
        tappedBtn.backgroundColor = [UIColor vclightbluemenu];
        tappedBtn.layer.borderWidth = 1.0;
        uiiv_selectetd.alpha = 1.0;
        tappedBtn.layer.borderColor = [UIColor vcDarkBlue].CGColor;
        indicator.backgroundColor = arr_color[index];
        // Set the parameters to be passed into the animation
        CGFloat duration = 0.5f;
        CGFloat damping = 0.8;
        CGFloat velocity = 0.6;
        // int to hold UIViewAnimationOption
        NSInteger option;
        option = UIViewAnimationCurveEaseInOut;
        
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:option animations:^{
            uiiv_selectetd.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished){      }];
    }
    tappedBtn.selected = !tappedBtn.selected;
}

- (void)resetAllEleImgs
{
    for (UIImageView *tmp in _arr_elevatroImgs) {
        // Set the parameters to be passed into the animation
        CGFloat duration = 0.5f;
        CGFloat damping = 0.8;
        CGFloat velocity = 0.6;
        // int to hold UIViewAnimationOption
        NSInteger option;
        option = UIViewAnimationCurveEaseInOut;
        
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:option animations:^{
            tmp.transform = CGAffineTransformMakeTranslation(0.0, tmp.frame.size.height);
        } completion:^(BOOL finished){      }];
    }
    for (UIButton *tmp in _arr_eleBtnArray) {
        tmp.backgroundColor = [UIColor whiteColor];
        tmp.layer.borderWidth = 1.0;
        tmp.layer.borderColor = [UIColor vcButtonBorder].CGColor;
        tmp.selected = NO;
    }
    for (UIView *tmp in _arr_eleIndArray) {
        tmp.backgroundColor = [UIColor clearColor];
    }
}

- (void)showAllEleImg
{
    for (UIImageView *tmp in _arr_elevatroImgs) {
        // Set the parameters to be passed into the animation
        CGFloat duration = 0.5f;
        CGFloat damping = 0.8;
        CGFloat velocity = 0.6;
        // int to hold UIViewAnimationOption
        NSInteger option;
        option = UIViewAnimationCurveEaseInOut;
        
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:option animations:^{
            tmp.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished){      }];
    }
    for (UIButton *tmp in _arr_eleBtnArray) {
        tmp.backgroundColor = [UIColor vclightbluemenu];
        tmp.layer.borderWidth = 1.0;
        tmp.alpha = 1.0;
        tmp.layer.borderColor = [UIColor vcDarkBlue].CGColor;
        tmp.selected = YES;
    }
    NSArray *arr_color = [[NSArray alloc] initWithObjects:[UIColor vcSiteResidentail], [UIColor vcSiteRecreation], [UIColor vcBldParking], [UIColor vcSiteRetail], nil];
    for (UIView *tmp in _arr_eleIndArray) {
        tmp.backgroundColor = arr_color[[_arr_eleIndArray indexOfObject:tmp]];
    }
}

#pragma mark - Memory cleaning & warning

- (void)viewWillDisappear:(BOOL)animated
{
    [_uiiv_bgImg removeFromSuperview];
    _uiiv_bgImg = nil;
    
    [_uib_bldgStats removeFromSuperview];
    _uib_bldgStats = nil;
    
    [_uib_floorPlan removeFromSuperview];
    _uib_floorPlan = nil;
    
    [_uib_amenities removeFromSuperview];
    _uib_amenities = nil;
    
    [_uib_elevators removeFromSuperview];
    _uib_elevators = nil;
    
    [_uiv_bldImgContainer removeFromSuperview];
    _uiv_bldImgContainer = nil;
    
    [_uiv_statImgContainer removeFromSuperview];
    _uiv_statImgContainer = nil;
    
    [_uiv_elevatorContainer removeFromSuperview];
    _uiv_elevatorContainer = nil;
    
    [_uiv_eleLayerConainer removeFromSuperview];
    _uiv_eleLayerConainer = nil;
    
    for (UIButton __strong *tmp in _arr_eleBtnArray) {
        [tmp removeFromSuperview];
        tmp = nil;
    }
    
    for (UIView __strong *tmp in _arr_eleIndArray) {
        [tmp removeFromSuperview];
        tmp = nil;
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
