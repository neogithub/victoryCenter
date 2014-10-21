//
//  contactViewController.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 10/21/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "contactViewController.h"
#import "UIColor+Extensions.h"

static float kContactWidth = 213;
static float kContactHeight = 85;
static float kContactGap = 4;

@interface contactViewController ()
@property (weak, nonatomic) IBOutlet UIView         *uiv_titleContainer;
@property (weak, nonatomic) IBOutlet UITextView     *uitv_titleText;

@property (nonatomic, strong) NSMutableArray        *arr_contactCards;
@end

@implementation contactViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = screenRect;
    self.view.clipsToBounds = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitleLabel];
    [self setTitleView];
    [self setContactCardsGroup];
    [self performSelector:@selector(animateContactCards) withObject:nil afterDelay:0.5];
}

#pragma  mark - Set top left title label
- (void)setTitleLabel
{
    UILabel *uil_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(44.0, 0.0, 180.0, 44.0)];
    uil_titleLabel.backgroundColor = [UIColor whiteColor];
    uil_titleLabel.layer.borderWidth = 1.0;
    uil_titleLabel.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    uil_titleLabel.text = @"CONTACT";
    uil_titleLabel.textAlignment = NSTextAlignmentCenter;
    uil_titleLabel.font = [UIFont fontWithName:@"Raleway-Medium" size:20];
    uil_titleLabel.textColor = [UIColor vcDarkBlue];
    [self.view addSubview: uil_titleLabel];
}

#pragma mark - Set top right title view

- (void)setTitleView
{
    _uiv_titleContainer.transform = CGAffineTransformMakeTranslation(0.0, -_uiv_titleContainer.frame.size.height);
    [_uitv_titleText setFont:[UIFont fontWithName:@"Raleway-Bold" size:12.0]];
    _uitv_titleText.textColor = [UIColor whiteColor];
}

#pragma mark - Set contact cards

- (void)setContactCardsGroup
{
    _arr_contactCards = [[NSMutableArray alloc] init];
    NSArray *arr_names = [[NSArray alloc] initWithObjects:@"FIRST LAST", @"FIRST LAST", @"FIRST LAST", nil];
    NSArray *arr_phone = [[NSArray alloc] initWithObjects:@"000.000.0000", @"000.000.0000", @"000.000.0000", nil];
    NSArray *arr_email = [[NSArray alloc] initWithObjects:@"xxx@xxxxxxxx", @"xxx@xxxxxxxx", @"xxx@xxxxxxxx", nil];
    
    for (int i = 0; i < arr_email.count; i++) {
        [self createContactCardwithName:arr_names[i] andPhone:arr_phone[i] andEmail:arr_email[i] andTag:i];
    }
}

#pragma mark Init contact card view

- (void)createContactCardwithName:(NSString *)name andPhone:(NSString *)phone andEmail:(NSString *)email andTag:(int)index
{
    UIView *uiv_contactCard = [[UIView alloc] initWithFrame:CGRectMake(752.0, 97.0 + (kContactGap + kContactHeight)*index, kContactWidth, kContactHeight)];
    uiv_contactCard.backgroundColor = [UIColor whiteColor];
    uiv_contactCard.tag = index;
    
    UILabel *uil_name = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 10.0, kContactWidth - 15, 25.0)];
    uil_name.text = name;
    uil_name.font = [UIFont fontWithName:@"Raleway-Bold" size:14.0];
    uil_name.textColor = [UIColor vcDarkBlue];
    uil_name.backgroundColor = [UIColor clearColor];
    uil_name.tag = 1;
    [uiv_contactCard addSubview: uil_name];
    
    UILabel *uil_phone = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 35.0, kContactWidth - 15, 18.0)];
    uil_phone.backgroundColor = [UIColor clearColor];
    uil_phone.text = phone;
    uil_phone.font = [UIFont fontWithName:@"Raleway-Bold" size:12.0];
    uil_phone.textColor = [UIColor vcDarkBlue];
    uil_phone.tag = 2;
    [uiv_contactCard addSubview: uil_phone];
    
    UILabel *uil_email = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 53.0, kContactWidth - 15, 18.0)];
    uil_email.backgroundColor = [UIColor clearColor];
    uil_email.text = email;
    uil_email.textColor = [UIColor vcDarkBlue];
    uil_email.font = [UIFont fontWithName:@"Raleway-Bold" size:12.0];
    uil_email.tag = 3;
    [uiv_contactCard addSubview: uil_email];
    [_arr_contactCards addObject:uiv_contactCard];
    uiv_contactCard.transform = CGAffineTransformMakeTranslation(0.0, -uiv_contactCard.frame.size.height - uiv_contactCard.frame.origin.y);
    [self.view insertSubview:uiv_contactCard belowSubview:_uiv_titleContainer];
}

#pragma mark Animate the contact card
- (void)animateContactCards
{
    CGFloat duration = 0.5f;
    CGFloat damping = 0.6f;
    CGFloat velocity = 0.68f;
    // int to hold UIViewAnimationOption
    NSInteger option;
    option = UIViewAnimationCurveEaseInOut;
    
    [UIView animateWithDuration:duration*1.5 delay:0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:option animations:^{
        _uiv_titleContainer.transform = CGAffineTransformIdentity;
        
        for (UIView *tmp in _arr_contactCards) {
            tmp.transform = CGAffineTransformIdentity;
        }
        
    } completion:^(BOOL finished){      }];
}

- (IBAction)closeBtnTapped:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeContact" object:nil];
}

#pragma mark - Cleaning Memory

- (void)viewWillDisappear:(BOOL)animated
{
    [_uiv_titleContainer removeFromSuperview];
    _uiv_titleContainer = nil;
    
    for (UIView __strong *tmp in _arr_contactCards) {
        [tmp removeFromSuperview];
        tmp = nil;
    }
    
    [_arr_contactCards removeAllObjects];
    _arr_contactCards = nil;
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
