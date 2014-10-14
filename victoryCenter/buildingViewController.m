//
//  buildingViewController.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/23/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "buildingViewController.h"
#import "UIColor+Extensions.h"

@interface buildingViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *uiiv_bgImg;
@property (weak, nonatomic) IBOutlet UIView *uiv_bldImgContainer;
@property (weak, nonatomic) IBOutlet UIView *uiv_statImgContainer;

@property (weak, nonatomic) IBOutlet UIButton *uib_floorPlan;
@property (weak, nonatomic) IBOutlet UIButton *uib_bldgStats;
@property (weak, nonatomic) IBOutlet UIButton *uib_amenities;
@property (weak, nonatomic) IBOutlet UIButton *uib_elevators;

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
}

- (void)setTopButtons
{
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
    [theBtn addTarget:self action:@selector(tapOnTopBtns:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tapOnTopBtns:(id)sender
{
    UIButton *tappedBtn = sender;
    _uib_floorPlan.selected = NO;
    _uib_floorPlan.backgroundColor = [UIColor vcLightBlue];
    _uib_bldgStats.selected = NO;
    _uib_bldgStats.backgroundColor = [UIColor vcLightBlue];
    _uib_amenities.selected = NO;
    _uib_amenities.backgroundColor = [UIColor vcLightBlue];
    _uib_elevators.selected = NO;
    _uib_elevators.backgroundColor = [UIColor vcLightBlue];
    
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
    switch (index) {
        case 1: {
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
            
            [UIView animateWithDuration:duration*1.5 delay:0 usingSpringWithDamping:damping*0.8 initialSpringVelocity:velocity*0.8 options:option animations:^{
                _uiv_statImgContainer.alpha = 1.0;
                _uiv_statImgContainer.transform = CGAffineTransformMakeTranslation(356, 0.0);
                
            } completion:^(BOOL finished){      }];
            
            break;
        }
        case 2: {
            _uiiv_bgImg.hidden = NO;
            NSString *url = [[NSBundle mainBundle] pathForResource:@"grfx_bldFloorPlan_bg" ofType:@"jpg"];
            _uiiv_bgImg.image = [UIImage imageWithContentsOfFile:url];
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
