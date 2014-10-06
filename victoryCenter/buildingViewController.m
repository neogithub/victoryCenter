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

@property (weak, nonatomic) IBOutlet UIButton *uib_floorPlan;
@property (weak, nonatomic) IBOutlet UIButton *uib_bldgStats;
@property (weak, nonatomic) IBOutlet UIButton *uib_amenities;
@property (weak, nonatomic) IBOutlet UIButton *uib_elevators;

@end

@implementation buildingViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = CGRectMake(0.0, 0.0, 1024.0, 768.0);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTopButtons];
}

- (void)setTopButtons
{
    [_uib_floorPlan setTitle:@"FLOOR PLAN" forState:UIControlStateNormal];
    [_uib_floorPlan setTitle:@"FLOOR PLAN" forState:UIControlStateSelected];
    [_uib_floorPlan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_floorPlan setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_uib_floorPlan.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14]];
    _uib_floorPlan.backgroundColor = [UIColor vcLightBlue];
    _uib_floorPlan.selected = NO;
    _uib_floorPlan.tag = 1;
    [_uib_floorPlan addTarget:self action:@selector(tapOnTopBtns:) forControlEvents:UIControlEventTouchUpInside];
    
    [_uib_bldgStats setTitle:@"BUILDING STATS" forState:UIControlStateNormal];
    [_uib_bldgStats setTitle:@"BUILDING STATS" forState:UIControlStateSelected];
    [_uib_bldgStats setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_bldgStats setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_uib_bldgStats.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14]];
    _uib_bldgStats.backgroundColor = [UIColor vcLightBlue];
    _uib_bldgStats.selected = NO;
    _uib_bldgStats.tag = 2;
    [_uib_bldgStats addTarget:self action:@selector(tapOnTopBtns:) forControlEvents:UIControlEventTouchUpInside];
    
    [_uib_amenities setTitle:@"AMENITIES" forState:UIControlStateNormal];
    [_uib_amenities setTitle:@"AMENITIES" forState:UIControlStateSelected];
    [_uib_amenities setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_amenities setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_uib_amenities.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14]];
    _uib_amenities.backgroundColor = [UIColor vcLightBlue];
    _uib_amenities.selected = NO;
    _uib_amenities.tag = 3;
    [_uib_amenities addTarget:self action:@selector(tapOnTopBtns:) forControlEvents:UIControlEventTouchUpInside];
    
    [_uib_elevators setTitle:@"ELEVATORS" forState:UIControlStateNormal];
    [_uib_elevators setTitle:@"ELEVATORS" forState:UIControlStateSelected];
    [_uib_elevators setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_elevators setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_uib_elevators.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14]];
    _uib_elevators.backgroundColor = [UIColor vcLightBlue];
    _uib_elevators.selected = NO;
    _uib_elevators.tag = 4;
    [_uib_elevators addTarget:self action:@selector(tapOnTopBtns:) forControlEvents:UIControlEventTouchUpInside];
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
