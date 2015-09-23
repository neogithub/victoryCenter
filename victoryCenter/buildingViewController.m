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
#import "xhPopTipsView.h"
#import "buildingAmenities.h"
#import "ameniteisGallery.h"
#import "GAIDictionaryBuilder.h"

static float kOriginalStatHeight    = 45+36*3;

@interface buildingViewController ()
{
    NSMutableArray      *arr_panelBtnArray;
    NSArray             *arr_statContent;
    UIView              *uiv_panelIndicator;
    UIImageView         *uiiv_statContent;
    int                 loadStats;
    NSArray             *arr_bldStatsImages;
    BOOL                loadedPanoView;
}

@property (nonatomic, strong) NSMutableArray                *arr_topBtnsArray;

@property (weak, nonatomic) IBOutlet UIImageView            *uiiv_bgImg;
@property (weak, nonatomic) IBOutlet UIView                 *uiv_bldImgContainer;
@property (weak, nonatomic) IBOutlet UIView                 *uiv_statImgContainer;
@property (weak, nonatomic) IBOutlet UIButton               *uib_statsClose;
@property (weak, nonatomic) IBOutlet UIImageView            *uiiv_viewDiagram;

@property (weak, nonatomic) IBOutlet UIButton               *uib_bldgStats;
@property (weak, nonatomic) IBOutlet UIButton               *uib_floorPlan;
@property (weak, nonatomic) IBOutlet UIButton               *uib_amenities;
@property (weak, nonatomic) IBOutlet UIButton               *uib_elevators;
@property (weak, nonatomic) IBOutlet UILabel                *uil_parkingLabel;
@property (weak, nonatomic) IBOutlet UILabel                *uil_lobbyLabel;
@property (nonatomic, strong) UIView                        *uiv_bldStatsPanel;
//Floor plan
@property (nonatomic, strong) floorPlanViewController       *floorPlan;
@property (weak, nonatomic) IBOutlet UIButton               *uib_18_23;
@property (weak, nonatomic) IBOutlet UIButton               *uib_17;
@property (weak, nonatomic) IBOutlet UIButton               *uib_16;
@property (weak, nonatomic) IBOutlet UIButton               *uib_15;
@property (weak, nonatomic) IBOutlet UIButton               *uib_10_14;
@property (weak, nonatomic) IBOutlet UIButton               *uib_9;
@property (weak, nonatomic) IBOutlet UIButton               *uib_8;
@property (weak, nonatomic) IBOutlet UIButton               *uib_1;
@property (nonatomic, strong) NSArray                       *arr_floorBtns;

//Amenities
@property (nonatomic, strong) buildingAmenities             *amenities;
@property (nonatomic, strong) ameniteisGallery              *amenitiesGallery;

//Elevator
@property (nonatomic, strong) UIView                        *uiv_elevatorContainer;
@property (nonatomic, strong) UIView                        *uiv_eleLayerConainer;
@property (nonatomic, strong) NSMutableArray                *arr_eleBtnArray;
@property (nonatomic, strong) NSArray                       *arr_elevatroImgs;
@property (nonatomic, strong) NSMutableArray                *arr_eleIndArray;
// Help tip view
@property (nonatomic, strong) xhPopTipsView                 *uiv_helpView;
@property (nonatomic, strong) NSMutableArray                *arr_helpText;
@property (nonatomic, strong) NSMutableArray                *arr_helpTargetViews;

@end

@implementation buildingViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = screenRect;
    [self prepareHlepData];
    [self setUpBuildingStats];
    loadStats = 0;
    loadedPanoView = NO;
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Victory Center Building View"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideAndUnhideHelp:) name:@"hideAndUnhideHelp" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadedPano:) name:@"loadPanoView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removePano:) name:@"removePanoView" object:nil];
    
    _uil_parkingLabel.font = [UIFont fontWithName:@"Raleway-Bold" size:14.0];
    _uil_parkingLabel.textColor = [UIColor whiteColor];
    
    _uil_lobbyLabel.font = [UIFont fontWithName:@"Raleway-Bold" size:14.0];
    _uil_lobbyLabel.textColor = [UIColor vcDarkBlue];
    
    self.screenName = @"Victory Center Building View";
}

#pragma mark - Hide & unhide help view form building
- (void)loadedPano:(NSNotification *)notification
{
    loadedPanoView = YES;
}

- (void)removePano:(NSNotification *)notification
{
    loadedPanoView = NO;
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
    _uib_18_23.tag = 5;
    _uib_17.tag = 6;
    _uib_16.tag = 7;
    _uib_15.tag = 8;
    _uib_10_14.tag = 12;
    _uib_9.tag = 13;
    _uib_8.tag = 14;
    _uib_1.tag = 15;
    _arr_floorBtns = [[NSArray alloc] initWithObjects:_uib_18_23, _uib_17, _uib_16, _uib_15, _uib_10_14, _uib_9, _uib_8, _uib_1, nil];

    for (UIButton *tmp in _arr_floorBtns) {
        [tmp addTarget:self action:@selector(floorBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)floorBtnTapped:(id)sender
{
    UIButton *tappedBtn = sender;
    int index = (int)tappedBtn.tag ;
    
    [self loadFloorPlan:index];
    
    [self resetTopMenu];
    _uib_floorPlan.backgroundColor = [UIColor vcDarkBlue];
    _uib_floorPlan.selected = YES;
    [self updateHelpData:2];
}

#pragma mark - Methods dealing with notifications
- (void)resetBuilding
{
    _uiiv_viewDiagram.hidden = NO;
    _uiiv_bgImg.hidden = YES;
    _uiv_bldImgContainer.transform = CGAffineTransformIdentity;
    _uiv_bldImgContainer.hidden = NO;
    _uiv_statImgContainer.hidden = YES;
    _uiv_statImgContainer.alpha = 0.0;
    _uiv_statImgContainer.transform = CGAffineTransformIdentity;
    
    [self removeFloorPlan];
    [self resetTopMenu];
    [_uiv_elevatorContainer removeFromSuperview];
    _uiv_elevatorContainer = nil;
    
    [_uiv_eleLayerConainer removeFromSuperview];
    _uiv_eleLayerConainer = nil;
    
    [self prepareHlepData];
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
    _uiiv_viewDiagram.hidden = YES;
    UIButton *tappedBtn = sender;
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Vicotry Center Building"];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Interaction"
                                                          action:@"touch"
                                                           label:[tappedBtn.titleLabel text]
                                                           value:nil] build]];
    
    if (tappedBtn.selected && tappedBtn.tag == 1) {
        [self resetBuildingImg:nil];
        return;
    }
    
    [self resetTopMenu];
    tappedBtn.selected = YES;
    tappedBtn.backgroundColor = [UIColor vcDarkBlue];
    
    [self updateContent:(int)tappedBtn.tag];
}

- (void)updateContent:(int)index
{
    // Update help view's data
    [self updateHelpData:index];
    
    [_uiv_elevatorContainer removeFromSuperview];
    _uiv_elevatorContainer = nil;
    [_amenities removeFromSuperview];
    _amenities = nil;
    [_amenitiesGallery removeFromSuperview];
    _amenitiesGallery = nil;
    _uiiv_bgImg.hidden = YES;
    _uiv_bldImgContainer.hidden = YES;
    _uiv_bldImgContainer.transform = CGAffineTransformIdentity;
    _uiv_statImgContainer.hidden = YES;
    _uiv_statImgContainer.alpha = 0.0;
    [self resetButtonsAndIndicators:_uiv_bldStatsPanel];
    [_uiv_bldStatsPanel viewWithTag:102].frame = CGRectMake(0.0, 45.0, 371, 3*36);
    for (UIButton *tmp in arr_panelBtnArray) {
        [self deHighLightPanelBtn:tmp];
    }
    [uiiv_statContent removeFromSuperview];
    uiiv_statContent = nil;
    _uiv_statImgContainer.transform = CGAffineTransformIdentity;
    [self removeFloorPlan];
    
    switch (index) {
        case 1: {
            [self moveInBldStats];
            break;
        }
        case 2: {
            [self loadFloorPlan:15];//load floor 1
            break;
        }
        case 3: {
            _amenitiesGallery = [[ameniteisGallery alloc] initWithFrame:screenRect];
            [self.view insertSubview:_amenitiesGallery belowSubview:_uib_bldgStats];
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

- (void)setUpBuildingStats
{
    arr_statContent = [[NSArray alloc] initWithObjects:@"building_stats_office.png", @"building_stats_area.png", @"building_stats_amenities.png", nil];
    _uiv_bldStatsPanel = [[UIView alloc] init];
    _uiv_bldStatsPanel.clipsToBounds = NO;
    _uiv_bldStatsPanel = [self createPanelWithTitle:@"BUILDING STATS" andHeight:kOriginalStatHeight];
    [_uiv_statImgContainer addSubview: _uiv_bldStatsPanel];
    NSArray *titles = [[NSArray alloc] initWithObjects:@"OFFICE TOWER", @"AREA SUMMARY", @"AMENITIES",  nil];
    [self createBtnsForPanel:_uiv_bldStatsPanel withTitleArray:titles andTargetSel:@"loadStatsContent:" andEdgeInset:45 withIdicator:YES];
    
    NSArray *arr_fitnessImages = [[NSArray alloc] initWithObjects:@"fitness_image.jpg", @"fitness2.jpg", @"fitness&conference.jpg", nil];
    NSArray *arr_deliImage = [[NSArray alloc] initWithObjects:@"deli_image.jpg", nil];
    NSArray *arr_conference = [[NSArray alloc] initWithObjects:@"conference_image.jpg",@"conference2_image.jpg", @"restaurant&conference.jpg", nil];
    NSArray *arr_resturant = [[NSArray alloc] initWithObjects:@"restaurant_image.jpg", @"restaurant&conference.jpg", nil];
    NSArray *arr_courtyardImage = [[NSArray alloc] initWithObjects:@"View 04.jpg", nil];
    
    arr_bldStatsImages = [[NSArray alloc] initWithObjects:arr_fitnessImages, arr_deliImage, arr_conference, arr_resturant, arr_courtyardImage, nil];
    
}

- (UIView *)createPanelWithTitle:(NSString *)title andHeight:(float)panelH
{
    UIView* uiv_panel = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 371, panelH)];
    uiv_panel.backgroundColor = [UIColor clearColor];
    
    UIButton *uib_PanelTitle = [UIButton buttonWithType:UIButtonTypeCustom];
    uib_PanelTitle.frame = CGRectMake(0.0, 0.0, 371, 45.0);
    [uib_PanelTitle setBackgroundImage:[UIImage imageNamed:@"grfx_access_nav.png"] forState:UIControlStateNormal];
    [uib_PanelTitle setTitle:title forState:UIControlStateNormal];
    [uib_PanelTitle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [uib_PanelTitle.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:18.0]];
    uib_PanelTitle.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 150);
    uib_PanelTitle.tag = 101;
    uib_PanelTitle.layer.borderWidth = 1.0;
    uib_PanelTitle.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    uib_PanelTitle.userInteractionEnabled = NO;
    [uiv_panel addSubview: uib_PanelTitle];
    
    UIButton *uib_closeStats = [UIButton buttonWithType:UIButtonTypeCustom];
    uib_closeStats.frame = CGRectMake(337.0, -6.0, 40.0, 50.0);
    [uib_closeStats setImage:[UIImage imageNamed:@"grfx_bldstat_close.png"] forState:UIControlStateNormal];
    [uiv_panel addSubview: uib_closeStats];
    [uib_closeStats addTarget:self action:@selector(closeBldStats:) forControlEvents:UIControlEventTouchUpInside];
    return uiv_panel;
}

- (void)createBtnsForPanel:(UIView *)panle withTitleArray:(NSArray *)arr_buttonTitles andTargetSel:(NSString *)methodName andEdgeInset:(float)leftEdge withIdicator:(BOOL)indicator
{
    [arr_panelBtnArray removeAllObjects];
    arr_panelBtnArray = nil;
    arr_panelBtnArray = [[NSMutableArray alloc] init];
    UIView *uiv_optionContainer = [[UIView alloc] init];
    uiv_optionContainer.backgroundColor = [UIColor whiteColor];
    uiv_optionContainer.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    uiv_optionContainer.layer.borderWidth = 1.0;
    uiv_optionContainer.frame = CGRectMake(0.0, 45, 371, panle.frame.size.height-45);
    uiv_optionContainer.tag = 102;
    uiv_optionContainer.clipsToBounds = YES;
    
    SEL method = NSSelectorFromString(methodName);
    
    for (int i = 0; i < arr_buttonTitles.count; i++) {
        UIButton *uib_accOption = [UIButton buttonWithType:UIButtonTypeCustom];
        uib_accOption.frame = CGRectMake(0.0, i*36, 371, 36);
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
        UIView *uiv_Indicator;
        if (indicator) {
            CGRect frame = CGRectMake(19, uib_accOption.frame.origin.y + (uib_accOption.frame.size.height - 14)/2, 14, 14);
            uiv_Indicator = [[UIView alloc] initWithFrame:frame];
            uiv_Indicator.backgroundColor = [UIColor whiteColor];
            uiv_Indicator.layer.borderColor = [UIColor vcDarkBlue].CGColor;
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

- (void)highLightPanelBtn:(id)sender andIndicatorColor:(UIColor *)color
{
    for (UIButton *tmp in arr_panelBtnArray) {
        tmp.backgroundColor = [UIColor whiteColor];
        tmp.layer.borderWidth = 1.0;
        tmp.layer.borderColor = [UIColor vcButtonBorder].CGColor;
        tmp.selected = NO;
    }
    
    UIButton *tappedBtn = sender;
    tappedBtn.selected = YES;
    tappedBtn.backgroundColor = [UIColor vclightbluemenu];
    tappedBtn.layer.borderWidth = 1.0;
    tappedBtn.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    
    [uiv_panelIndicator removeFromSuperview];
    uiv_panelIndicator = nil;
    
    CGRect frame = CGRectMake(19, tappedBtn.frame.origin.y + (tappedBtn.frame.size.height - 14)/2, 14, 14);
    uiv_panelIndicator = [[UIView alloc] initWithFrame:frame];
    uiv_panelIndicator.backgroundColor = color;
    uiv_panelIndicator.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    uiv_panelIndicator.layer.borderWidth = 2.0;
    CGPoint savedCenter = uiv_panelIndicator.center;
    uiv_panelIndicator.layer.cornerRadius = 14.0 / 2.0;
    uiv_panelIndicator.center = savedCenter;
    [tappedBtn.superview addSubview: uiv_panelIndicator];
}

- (void)deHighLightPanelBtn:(id)sender
{
    UIButton *tappedBtn = sender;
    tappedBtn.backgroundColor = [UIColor whiteColor];
    tappedBtn.layer.borderWidth = 1.0;
    tappedBtn.layer.borderColor = [UIColor vcButtonBorder].CGColor;
    
    [self unselectAllPanelBtns];
    [uiv_panelIndicator removeFromSuperview];
    uiv_panelIndicator = nil;
}

- (void)unselectAllPanelBtns
{
    for (UIButton *tmp in arr_panelBtnArray) {
        tmp.selected = NO;
    }
}

- (void)loadStatsContent:(id)sender
{
    UIButton *tappedBtn = sender;
    UIView *buttonContianer = tappedBtn.superview; //[uiv_neibAmePanel viewWithTag:102];
    UIView *thePanel = buttonContianer.superview;
    if (tappedBtn.selected) {
        CGRect frame = buttonContianer.frame;
        frame.size.height = 3*36;//4*kPanelBtnHeight;
        [UIView animateWithDuration:0.33 animations:^{
            [self resetButtonsAndIndicators:thePanel];
            buttonContianer.frame = frame;
        } completion:^(BOOL finished){
            [self deHighLightPanelBtn:sender];
            [uiiv_statContent removeFromSuperview];
            uiiv_statContent = nil;
            return;
        }];
    }
    else {
        
        //Check if panel is opened:
        //Do the animation of shrink , change highlighted button and expension
        if (buttonContianer.frame.size.height > 3*36) {
            CGRect frame = buttonContianer.frame;
            frame.size.height = 3*36;//4*kPanelBtnHeight;
            [UIView animateWithDuration:0.33 animations:^{
                [self resetButtonsAndIndicators:thePanel];
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
    UIButton *tappedBtn = sender;
    //Get button's contianer
    UIView *buttonContianer = tappedBtn.superview;//[uiv_neibAmePanel viewWithTag:102];
    //Get the current panel
    UIView *thePanel = buttonContianer.superview;
    
    //Update position of table view's position
    [uiiv_statContent removeFromSuperview];
    uiiv_statContent = nil;
    uiiv_statContent = [[UIImageView alloc] initWithImage:[UIImage imageNamed:arr_statContent[tappedBtn.tag]]];
    UIButton *firstBtn = [arr_panelBtnArray objectAtIndex:0];
    uiiv_statContent.frame = CGRectMake(0.0, 36*([sender tag] + 1), uiiv_statContent.frame.size.width, uiiv_statContent.frame.size.height);
    if ((int)[sender tag] == 2) {
        uiiv_statContent.userInteractionEnabled = YES;
        [self addOptionBtns:uiiv_statContent];
    }
    
    //Add table view under buttons' container
    [buttonContianer insertSubview:uiiv_statContent aboveSubview:firstBtn];
    
    //Update Amenities panel's height
    CGRect oldFrame = thePanel.frame;
    oldFrame.size.height = kOriginalStatHeight + uiiv_statContent.frame.size.height;  //kExpendedHeight;
    thePanel.frame = oldFrame;
    CGRect containerOldFrame = buttonContianer.frame;
    containerOldFrame.size.height = oldFrame.size.height-45;
    
    CGFloat duration = 0.5f;
    CGFloat damping = 0.7f;
    CGFloat velocity = 1.0f;
    // int to hold UIViewAnimationOption
    NSInteger option;
    option = UIViewAnimationCurveEaseInOut;
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:option animations:^{
        buttonContianer.frame = containerOldFrame;
        [self rearrangeBtns:(int)[sender tag]];
        [self rearrangeIndicator:(int)[sender tag] andInContainer:buttonContianer];
        [self highLightPanelBtn:sender andIndicatorColor:[UIColor vcDarkBlue]];
    } completion:^(BOOL finished){      }];
}

- (void)resetButtonsAndIndicators:(UIView *)panel
{
    panel.frame = CGRectMake(0.0, 0.0, 371, kOriginalStatHeight);
    for (UIButton *tmp in arr_panelBtnArray) {
        tmp.transform = CGAffineTransformIdentity;
    }
    for (UIView *tmp in [[panel viewWithTag:102] subviews]) {
        if (tmp.tag >=500) {
            tmp.transform = CGAffineTransformIdentity;
        }
    }
}

// Move all buttons have bigger index to bottom panel
- (void)rearrangeBtns:(int)index
{
    for (UIButton *tmp in arr_panelBtnArray) {
        if (tmp.tag > index) {
            tmp.transform = CGAffineTransformMakeTranslation(0.0, uiiv_statContent.frame.size.height);
        }
    }
}
// Move indicators to correct position
- (void)rearrangeIndicator:(int)index andInContainer:(UIView *)container
{
    for (UIView *tmp in [[container viewWithTag:102] subviews]) {
        if (tmp.tag >=500) {
            if (tmp.tag-500 > index) {
                tmp.transform = CGAffineTransformMakeTranslation(0.0, uiiv_statContent.frame.size.height);
            }
        }
    }
}


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
        [self resetButtonsAndIndicators:_uiv_bldStatsPanel];
        [_uiv_bldStatsPanel viewWithTag:102].frame = CGRectMake(0.0, 45.0, 371, 3*36);
        for (UIButton *tmp in arr_panelBtnArray) {
            [self deHighLightPanelBtn:tmp];
        }
        [uiiv_statContent removeFromSuperview];
        uiiv_statContent = nil;
        [self resetTopMenu];
        _uiiv_viewDiagram.hidden = NO;
        [self prepareHlepData];
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
        _uiv_statImgContainer.transform = CGAffineTransformMakeTranslation(371, 0.0);
        
    } completion:^(BOOL finished){
        UIButton *tmp = arr_panelBtnArray[0];
        if (loadStats == 0) {
            [self loadStatsContent:tmp];
        }
        loadStats++;
    }];
}

- (void)addOptionBtns:(UIView *)container
{
    for (int i = 0; i < 5; i++) {
        CGRect btnFrame = CGRectZero;
        if (i < 3) {
            btnFrame = CGRectMake(0.0, 20.0*i, 371.0, 20.0);
        }else {
            btnFrame = CGRectMake(0.0, 20.0*(i + 1), 371.0, 20.0);
        }
        
        UIButton *uib_tmp =[UIButton buttonWithType:UIButtonTypeCustom];
        uib_tmp.frame = btnFrame;
        uib_tmp.backgroundColor = [UIColor clearColor];
        uib_tmp.tag = i;
        [uib_tmp addTarget:self action:@selector(tapOnAmenitiesBtn:) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview: uib_tmp];
    }
}

- (void)tapOnAmenitiesBtn:(id)sender
{
    int index = (int)[sender tag];
    NSString *caption = [NSString new];
    switch (index) {
        case 0:
            caption = @"Fitness";
            break;
        case 1:
            caption = @"Deli";
            break;
        case 2:
            caption = @"Conference Center";
            break;
        case 3:
            caption = @"Restaurant";
            break;
        case 4:
            caption = @"Courtyard";
            break;
        default:
            break;
    }
    NSArray *arr_image = [[NSArray alloc] initWithArray:arr_bldStatsImages[index]];
    NSMutableArray *arr_caption = [[NSMutableArray alloc] init];
    for (int i = 0; i< arr_image.count; i++) {
        [arr_caption addObject: caption];
    }
    
    
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:arr_image, @"images", [NSNumber numberWithInt:0], @"startIndex",[caption uppercaseString], @"title", arr_caption, @"caption", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadFGallery" object:nil userInfo:dictionary];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideHomeButton" object:nil];
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
    uiiv_parking.frame = CGRectMake(247, 564, uiiv_parking.frame.size.width, uiiv_parking.frame.size.height);
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
    uiiv_floorNum.frame = CGRectMake(410, 98, uiiv_floorNum.frame.size.width, uiiv_floorNum.frame.size.height);
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
    uib_resetEle.frame = CGRectMake(120.0, 216.0, 80.0, 20.0);
    uib_resetEle.backgroundColor = [UIColor vcLightBlue];
    [uib_resetEle setTitle:@"RESET" forState:UIControlStateNormal];
    [uib_resetEle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [uib_resetEle.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14.0]];
//    [uib_resetEle setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 30, 10.0, 0.0)];
    [uib_resetEle addTarget:self action:@selector(resetAllEleImgs) forControlEvents:UIControlEventTouchUpInside];
    [uiv_ctrlPanel addSubview: uib_resetEle];
    
    UIButton *uib_showAll = [UIButton buttonWithType:UIButtonTypeCustom];
    uib_showAll.frame = CGRectMake(0.0, 216.0, 80.0, 20.0);
    uib_showAll.backgroundColor = [UIColor vcLightBlue];
    [uib_showAll setTitle:@"ALL" forState:UIControlStateNormal];
    [uib_showAll setTitleColor:[UIColor whiteColor                                                                                                                                                         ] forState:UIControlStateNormal];
    [uib_showAll.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14.0]];
//    [uib_showAll setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 10.0, 40.0)];
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
                     @"Tap to load main menu",
                     @"Tap buttons to change sections",
                     @"Tap a floor grouping to load the lowest floor within that group",
                     nil];
    
    [_arr_helpTargetViews removeAllObjects];
    _arr_helpTargetViews = nil;
    // Home Button
    UIButton *homeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 45.0, 45.0)];
    // Top menu Button
    UIView *tmp1 = [[UIView alloc] initWithFrame:CGRectMake(423.0, 0.0, 130.0, 34.0)];
    // Top menu Button
    UIView *tmp2 = [[UIView alloc] initWithFrame:CGRectMake(455.0, 180.0, 130.0, 34.0)];
    _arr_helpTargetViews = [[NSMutableArray alloc] initWithObjects:homeBtn, tmp1, tmp2, nil];
}

- (void)updateHelpData:(int)index
{
    [_arr_helpText removeAllObjects];
    _arr_helpText = nil;
    
    [_arr_helpTargetViews removeAllObjects];
    _arr_helpTargetViews = nil;
    
    switch (index) {
        case 1:
        {
            _arr_helpText = [[NSMutableArray alloc] initWithObjects:
                             @"Tap menu button to load main menu",
                             @"Tap buttons to change sections",
                             @"Tap Section title to expand. Tap Amenity rows for gallery images",
                             nil];
            // Home Button
            UIButton *homeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 45.0, 45.0)];
            // Top menu Button
            UIView *tmp1 = [[UIView alloc] initWithFrame:CGRectMake(423.0, 0.0, 130.0, 34.0)];
            // Table Cell
            UIView *tmp2 = [[UIView alloc] initWithFrame:CGRectMake(200, 300, 1, 1)];
            _arr_helpTargetViews = [[NSMutableArray alloc] initWithObjects:homeBtn, tmp1, tmp2, nil];
            break;
        }
        case 2:
        {
            _arr_helpText = [[NSMutableArray alloc] initWithObjects:
                             @"Tap to load main menu",
                             @"Tap buttons to change sections",
                             @"Swipe up and down to change floor, pinch to zoom in and out",
                             @"Tap arrow button to change floor",
                             @"Tap Back to Stack to reload the stack",
                             nil];
            // Home Button
            UIButton *homeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 45.0, 45.0)];
            // Top menu Button
            UIView *tmp1 = [[UIView alloc] initWithFrame:CGRectMake(423.0, 0.0, 130.0, 34.0)];
            // Floor plan image
            UIView *tmp2 = [[UIView alloc] initWithFrame:CGRectMake(450, 300, 1, 1)];
            // Arrow buttons
            UIView *tmp3 = [[UIView alloc] initWithFrame:CGRectMake(880, 260, 233, 1)];
            // Arrow buttons
            UIView *tmp4 = [[UIView alloc] initWithFrame:CGRectMake(930, 190, 1, 1)];
            _arr_helpTargetViews = [[NSMutableArray alloc] initWithObjects:homeBtn, tmp1, tmp2, tmp3, tmp4, nil];
            break;
        }
        case 3:
        {
            _arr_helpText = [[NSMutableArray alloc] initWithObjects:
                             @"Tap to load main menu",
                             @"Tap buttons to change sections",
                             @"Tap image to load gallery",
                             nil];
            // Home Button
            UIButton *homeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 45.0, 45.0)];
            // Top menu Button
            UIView *tmp1 = [[UIView alloc] initWithFrame:CGRectMake(423.0, 0.0, 130.0, 34.0)];
            // Gallery Cell
            UIView *tmp2 = [[UIView alloc] initWithFrame:CGRectMake(520, 360, 1, 1)];
            _arr_helpTargetViews = [[NSMutableArray alloc] initWithObjects:homeBtn, tmp1, tmp2, nil];
            break;
        }
        case 4:
        {
            _arr_helpText = [[NSMutableArray alloc] initWithObjects:
                             @"Tap to load main menu",
                             @"Tap buttons to change sections",
                             @"Tap titles to view elevators",
                             nil];
            // Home Button
            UIButton *homeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 45.0, 45.0)];
            // Top menu Button
            UIView *tmp1 = [[UIView alloc] initWithFrame:CGRectMake(423.0, 0.0, 130.0, 34.0)];
            // Gallery Cell
            UIView *tmp2 = [[UIView alloc] initWithFrame:CGRectMake(165, 320, 1, 1)];
            _arr_helpTargetViews = [[NSMutableArray alloc] initWithObjects:homeBtn, tmp1, tmp2, nil];
            break;
        }
        default:
            break;
    }
}

- (void)loadHelpViews
{
    if (loadedPanoView) {
        return;
    }
    
    if (_uiv_helpView) {
        [_uiv_helpView removeFromSuperview];
        _uiv_helpView = nil;
    }
    _uiv_helpView = [[xhPopTipsView alloc] initWithFrame:screenRect andText:_arr_helpText andViews:_arr_helpTargetViews];
    [self.view addSubview: _uiv_helpView];
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
    
    [_amenitiesGallery removeFromSuperview];
    _amenitiesGallery = nil;
    
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
