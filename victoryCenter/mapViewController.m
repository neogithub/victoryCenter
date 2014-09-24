//
//  mapViewController.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/23/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "mapViewController.h"

@interface mapViewController ()

@property (weak, nonatomic) IBOutlet UIButton *uib_city;
@property (weak, nonatomic) IBOutlet UIButton *uib_neighbor;
@property (weak, nonatomic) IBOutlet UIButton *uib_site;

@end

@implementation mapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = CGRectMake(0.0, 0.0, 1024.0, 768.0);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Top 3 buttons (city, neighborhood and site) action

- (IBAction)tapCityBtn:(id)sender {
    UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:@"Tapped" message:@"City button is tapped!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
- (IBAction)tapNeighborhoodBtn:(id)sender {
    UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:@"Tapped" message:@"Neighborhood button is tapped!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
- (IBAction)tapSiteBtn:(id)sender {
    UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:@"Tapped" message:@"Site button is tapped!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
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
