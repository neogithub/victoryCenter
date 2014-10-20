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

@property (nonatomic, strong) NSMutableArray                *arr_topBtnsArray;

@property (weak, nonatomic) IBOutlet UIImageView            *uiiv_bgImg;
@property (weak, nonatomic) IBOutlet UIView                 *uiv_bldImgContainer;
@property (weak, nonatomic) IBOutlet UIView                 *uiv_statImgContainer;

@property (weak, nonatomic) IBOutlet UIButton               *uib_floorPlan;
@property (weak, nonatomic) IBOutlet UIButton               *uib_bldgStats;
@property (weak, nonatomic) IBOutlet UIButton               *uib_amenities;
@property (weak, nonatomic) IBOutlet UIButton               *uib_elevators;

@property (nonatomic, strong) floorPlanViewController       *floorPlan;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetBuilding) name:@"resetBuilding" object:nil];
}

- (void)resetBuilding
{
    _uiiv_bgImg.hidden = YES;
    _uiv_bldImgContainer.transform = CGAffineTransformIdentity;
    _uiv_bldImgContainer.hidden = NO;
    _uiv_statImgContainer.hidden = YES;
    _uiv_statImgContainer.alpha = 0.0;
    _uiv_statImgContainer.transform = CGAffineTransformIdentity;
    
    [self removeFloorPlan];
    [self resetTopMenu];
}

- (void)setTopButtons
{
    _arr_topBtnsArray = [[NSMutableArray alloc] init];
    
    [self initTopBtn:_uib_floorPlan withTitle:@"BUILDING STATS" andTag:1 andSelected:NO];
    [self initTopBtn:_uib_bldgStats withTitle:@"FLOOR PLAN" andTag:2 andSelected:NO];
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

- (void)resetTopMenu
{
    for (UIButton *tmp in _arr_topBtnsArray) {
        tmp.selected = NO;
        tmp.backgroundColor = [UIColor vcLightBlue];
    }
}

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
            [self loadFloorPlan];
            break;
        }
        case 3: {
            _uiiv_bgImg.hidden = NO;
            NSString *url = [[NSBundle mainBundle] pathForResource:@"grfx_bldAmenities_bg" ofType:@"jpg"];
            _uiiv_bgImg.image = [UIImage imageWithContentsOfFile:url];
            break;
        }
        case 4: {
            _uiiv_bgImg.hidden = NO;
            NSString *url = [[NSBundle mainBundle] pathForResource:@"grfx_bldElevator_bg" ofType:@"jpg"];
            _uiiv_bgImg.image = [UIImage imageWithContentsOfFile:url];
            break;
        }
        default:
            break;
    }
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
        _uiv_bldImgContainer.transform = CGAffineTransformMakeTranslation(197.0, 0.0);
        
    } completion:^(BOOL finished){      }];
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping*1.0 initialSpringVelocity:velocity*0.8 options:option animations:^{
        _uiv_statImgContainer.alpha = 1.0;
        _uiv_statImgContainer.transform = CGAffineTransformMakeTranslation(356, 0.0);
        
    } completion:^(BOOL finished){      }];
}

#pragma mark - Set up Floor plan view
- (void)loadFloorPlan
{
    [self removeFloorPlan];
    
    _floorPlan = [self.storyboard instantiateViewControllerWithIdentifier:@"floorPlanViewController"];;
    _floorPlan.view.frame = screenRect;
    [self addChildViewController:_floorPlan];
    [self.view insertSubview:_floorPlan.view belowSubview:_uib_floorPlan];
}

- (void)removeFloorPlan {
    if (_floorPlan) {
        [_floorPlan.view removeFromSuperview];
        _floorPlan.view = nil;
        [_floorPlan removeFromParentViewController];
        _floorPlan = nil;
    }
}

#pragma mark - Memory cleaning & warning

- (void)viewWillDisappear:(BOOL)animated
{
    [_uiiv_bgImg removeFromSuperview];
    _uiiv_bgImg = nil;
    
    [_uib_floorPlan removeFromSuperview];
    _uib_floorPlan = nil;
    
    [_uib_bldgStats removeFromSuperview];
    _uib_bldgStats = nil;
    
    [_uib_amenities removeFromSuperview];
    _uib_amenities = nil;
    
    [_uib_elevators removeFromSuperview];
    _uib_elevators = nil;
    
    [_uiv_bldImgContainer removeFromSuperview];
    _uiv_bldImgContainer = nil;
    
    [_uiv_statImgContainer removeFromSuperview];
    _uiv_statImgContainer = nil;
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
