//
//  teamViewController.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/23/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "teamViewController.h"

static float kDropSpeed		= 0.33;
static float kAnimaDelay	= 0.2;
static float kCardWidth     = 183.0;
static float kCardsGap      = 12.0;
@interface teamViewController ()

@property (nonatomic, strong) NSMutableArray                *arr_cards;

@end

@implementation teamViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = screenRect;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _arr_cards = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        // input parameters:
        // 1. name of logo image
        // 2. name of text image
        // 3. x value of the card
        [self createItemBox:@"team_logo.png" andText:@"team_Text.png" andX:(30 + i * (kCardsGap + kCardWidth))];
    }
    
    // Do any additional setup after loading the view.
}

/*  Create team member's card
    
    Need input:
    1. logo image's name
    2. Text image's name
    3. card's x value      
 */
- (void)createItemBox:(NSString *)logoName andText:(NSString *)textName andX:(float)x_value
{
    UIView *uiv_cardContainer = [[UIView alloc] initWithFrame:CGRectMake(x_value, 180.0, kCardWidth, 428.0)];
    
	// 1. add logo
    UIView *uiv_logo = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, kCardWidth, 142.0)];
    uiv_logo.tag = 1;
    UIImageView *uiiv_logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed: logoName]];
    uiiv_logo.frame = CGRectMake(0.0, 0.0, kCardWidth, 142.0);
    [uiv_logo addSubview:uiiv_logo];
    [uiv_cardContainer insertSubview:uiv_logo atIndex:2];
    
	// 2. add text
    UIView *uiv_text = [[UIView alloc] initWithFrame:CGRectMake(0.0, 142.0, kCardWidth, 286.0)];
    uiv_text.tag = 2;
    UIImageView *uiiv_text = [[UIImageView alloc] initWithImage:[UIImage imageNamed: textName]];
    uiiv_text.frame = CGRectMake(0.0, 0.0, kCardWidth, 286.0);
    uiiv_text.tag = 1;
    [uiiv_text setTintColor:[UIColor lightGrayColor]];
    [uiv_text addSubview:uiiv_text];
    [uiv_cardContainer insertSubview:uiv_text belowSubview:uiv_logo];
    CGAffineTransform t1 = CGAffineTransformMakeScale(1.0, 0.5);
    uiv_text.transform = CGAffineTransformTranslate(t1, 0.0, -427.0);
    
    
    UIView *uiv_bar = [[UIView alloc] initWithFrame:CGRectMake(0.0, 124.0, kCardWidth, 18.0)];
    uiv_bar.tag = 3;
    UIImageView *uiiv_bar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"team_logoBtmBar.png"]];
    uiiv_bar.frame = CGRectMake(0.0, 0.0, kCardWidth, 18.0);
    [uiv_bar addSubview: uiiv_bar];
    uiv_bar.hidden = YES;
    [uiv_cardContainer addSubview: uiv_bar];
    uiv_bar.transform = CGAffineTransformMakeTranslation(0.0, 18);
    
    uiv_cardContainer.alpha = 0.0;
    [self.view addSubview: uiv_cardContainer];
    uiv_cardContainer.transform = CGAffineTransformMakeTranslation(0.0, -40);
    [_arr_cards addObject:uiv_cardContainer];
    
	// Do animiation by index order
    [self performSelector:@selector(animateArray:) withObject:_arr_cards afterDelay:0.0];
    [self performSelector:@selector(showNeoLogo) withObject:nil afterDelay:kDropSpeed *5 - kAnimaDelay];
}

#pragma mark - Animate all cards by the order of the index
//Read all cards in the array by index
// Need input arrary of cards(uiview)

-(void)animateArray:(NSMutableArray *)viewArray
{
    for (int i = 0; i < viewArray.count; i++) {
        UIView *tmpView = [viewArray objectAtIndex:i];
        [self performSelector:@selector(animateCard:) withObject:tmpView afterDelay:(kAnimaDelay*i)];
    }
}


/*  Animate one card
 
    input: UIView (team member's card)
    
    animtion order:
    1. make the logo part alpha = 1.0
 
    2. Make the card's container moving down to the correct Y value
 
    3. Reveal text image view from back of the logo image
 
    4. Call the function to animate the bar between logo and text
*/
- (void)animateCard:(UIView *)container
{
    UIView *text = [container viewWithTag:2];
    UIView *textImg = [text viewWithTag:1];
    [UIView animateWithDuration:kDropSpeed animations:^{
        container.alpha = 1.0;
        container.transform = CGAffineTransformIdentity;
        text.transform = CGAffineTransformIdentity;
        textImg.tintColor = [UIColor clearColor];
    } completion:^(BOOL finished){
        [self performSelector:@selector(animateBar:) withObject:container afterDelay:kDropSpeed-kAnimaDelay];
    }];
}

/*  Animate the bar between logo and text image
 
    input: UIView (team member's card)
 
    animtion order:
    1. change the order of views inside of the card's container:
        a. logo -> bottom
        b. bar -> middle
        c. text -> top
    
    2. Move the bar to the correct position from back of text
 
*/
- (void)animateBar:(UIView *)container
{
    UIView *logo = [container viewWithTag:1];
    UIView *text = [container viewWithTag:2];
    UIView *bar = [container viewWithTag:3];
    logo.layer.zPosition = 0;
    bar.layer.zPosition = 1;
    text.layer.zPosition = 2;
    bar.hidden = NO;
    [UIView animateWithDuration:kDropSpeed delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        bar.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        
    }];
}


#pragma mark - Add neoscape label
//add Neoscape's logo after all cards droping down

- (void)showNeoLogo
{
    UIView *uiv_neoContainer = [[UIView alloc] initWithFrame:CGRectMake(774.0, 730.0, 211.0, 38.0)];
    uiv_neoContainer.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    
    UILabel *uil_neoLogo = [[UILabel alloc] initWithFrame:uiv_neoContainer.bounds];
    uil_neoLogo.backgroundColor = [UIColor clearColor];
    [uil_neoLogo setText:@"DESIGNED BY NEOSCAPE®"];
    [uil_neoLogo setTextAlignment:NSTextAlignmentCenter];
    uil_neoLogo.font = [UIFont fontWithName:@"Raleway-Medium" size:12.0];
    [uil_neoLogo setTextColor:[UIColor grayColor]];
	// uil_neoLogo.alpha = 0.7;
    [uiv_neoContainer addSubview: uil_neoLogo];

    uiv_neoContainer.transform = CGAffineTransformMakeTranslation(0.0, uiv_neoContainer.frame.size.width);
    [self.view addSubview: uiv_neoContainer];
    
    [UIView animateWithDuration:0.2 animations:^{
        uiv_neoContainer.transform = CGAffineTransformIdentity;
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    for (UIView *tmp in [self.view subviews]) {
        [tmp removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
