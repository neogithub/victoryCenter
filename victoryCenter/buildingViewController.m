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
    [self initTopBtn:_uib_floorPlan withTitle:@"FLOOR PLAN" andTag:1 andSelected:YES];
    [self initTopBtn:_uib_bldgStats withTitle:@"BUILDING STATS" andTag:2 andSelected:NO];
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
