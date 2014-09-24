//
//  teamViewController.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/23/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "teamViewController.h"

static float kDropSpeed = 0.33;
static float kAnimaGap  = 0.2;

@interface teamViewController ()

@property (nonatomic, strong) NSMutableArray                *arr_cards;

@end

@implementation teamViewController

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
    _arr_cards = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        [self createItemBox:@"team_logo.png" andText:@"team_Text.png" andX:(18.0 + i * (18.0 + 183.0))];
    }
    
    // Do any additional setup after loading the view.
}

- (void)createItemBox:(NSString *)logoName andText:(NSString *)textName andX:(float)x_value
{
    UIView *uiv_cardContainer = [[UIView alloc] initWithFrame:CGRectMake(x_value, 180.0, 183.0, 428.0)];
    
    UIView *uiv_logo = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 183.0, 142.0)];
    uiv_logo.tag = 1;
    UIImageView *uiiv_logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed: logoName]];
    uiiv_logo.frame = CGRectMake(0.0, 0.0, 183.0, 142.0);
    [uiv_logo addSubview:uiiv_logo];
    [uiv_cardContainer insertSubview:uiv_logo atIndex:2];
    
    UIView *uiv_text = [[UIView alloc] initWithFrame:CGRectMake(0.0, 142.0, 183.0, 286.0)];
    uiv_text.tag = 2;
    UIImageView *uiiv_text = [[UIImageView alloc] initWithImage:[UIImage imageNamed: textName]];
    uiiv_text.frame = CGRectMake(0.0, 0.0, 183.0, 286.0);
    uiiv_text.tag = 1;
    [uiiv_text setTintColor:[UIColor lightGrayColor]];
    [uiv_text addSubview:uiiv_text];
    [uiv_cardContainer insertSubview:uiv_text belowSubview:uiv_logo];
    CGAffineTransform t1 = CGAffineTransformMakeScale(1.0, 0.5);
    uiv_text.transform = CGAffineTransformTranslate(t1, 0.0, -427.0);
    
    
    UIView *uiv_bar = [[UIView alloc] initWithFrame:CGRectMake(0.0, 124.0, 183.0, 18.0)];
    uiv_bar.tag = 3;
    UIImageView *uiiv_bar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"team_logoBtmBar.png"]];
    uiiv_bar.frame = CGRectMake(0.0, 0.0, 183.0, 18.0);
    [uiv_bar addSubview: uiiv_bar];
    uiv_bar.hidden = YES;
    [uiv_cardContainer addSubview: uiv_bar];
    uiv_bar.transform = CGAffineTransformMakeTranslation(0.0, 18);
    
    uiv_cardContainer.alpha = 0.0;
    [self.view addSubview: uiv_cardContainer];
    uiv_cardContainer.transform = CGAffineTransformMakeTranslation(0.0, -40);
    [_arr_cards addObject:uiv_cardContainer];
    
    [self performSelector:@selector(animateArray:) withObject:_arr_cards afterDelay:0.0];
    [self performSelector:@selector(showNeoLogo) withObject:nil afterDelay:kDropSpeed *5 - kAnimaGap];
}

-(void)animateArray:(NSMutableArray *)viewArray
{
    for (int i = 0; i < viewArray.count; i++) {
        UIView *tmpView = [viewArray objectAtIndex:i];
        [self performSelector:@selector(animateCard:) withObject:tmpView afterDelay:(kAnimaGap*i)];
    }
}

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
        [self performSelector:@selector(animateBar:) withObject:container afterDelay:kDropSpeed-kAnimaGap];
    }];
//    [self performSelector:@selector(animateBarArray:) withObject:_arr_cards afterDelay:0.3];
}

//- (void)animateBarArray:(NSMutableArray *)viewArray
//{
//    for (int i = 0; i < viewArray.count; i++) {
//        UIView *tmpView = [viewArray objectAtIndex:i];
//        [self performSelector:@selector(animateBar:) withObject:tmpView afterDelay:(0.2*(i + 1))];
//    }
//}

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

- (void)showNeoLogo
{
    UIView *uiv_neoContainer = [[UIView alloc] initWithFrame:CGRectMake(774.0, 730.0, 211.0, 38.0)];
    uiv_neoContainer.backgroundColor = [UIColor whiteColor];
    uiv_neoContainer.alpha = 0.2;
    
    UILabel *uil_neoLogo = [[UILabel alloc] initWithFrame:uiv_neoContainer.bounds];
    uil_neoLogo.backgroundColor = [UIColor clearColor];
    [uil_neoLogo setText:@"DESIGNED BY NEOSCAPE®"];
    [uil_neoLogo setTextAlignment:NSTextAlignmentCenter];
    uil_neoLogo.font = [UIFont systemFontOfSize:15.0];
    uil_neoLogo.alpha = 0.7;
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
