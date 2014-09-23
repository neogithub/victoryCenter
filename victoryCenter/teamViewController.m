//
//  teamViewController.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/23/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "teamViewController.h"

@interface teamViewController ()

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
    [self createItemBox:@"team_logo.png" andText:@"team_Text.png"];
    // Do any additional setup after loading the view.
}

- (void)createItemBox:(NSString *)logoName andText:(NSString *)textName
{
    UIView *uiv_cardContainer = [[UIView alloc] initWithFrame:CGRectMake(100.0, 180.0, 183.0, 428.0)];
    
    UIView *uiv_logo = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 183.0, 142.0)];
    uiv_logo.tag = 1;
    UIImageView *uiiv_logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed: logoName]];
    uiiv_logo.frame = CGRectMake(0.0, 0.0, 183.0, 142.0);
    [uiv_logo addSubview:uiiv_logo];
    [uiv_cardContainer insertSubview:uiv_logo atIndex:2];
    
    UIView *uiv_text = [[UIView alloc] initWithFrame:CGRectMake(0.0, 142.0, 183.0, 268.0)];
    uiv_text.tag = 2;
    UIImageView *uiiv_text = [[UIImageView alloc] initWithImage:[UIImage imageNamed: textName]];
    uiiv_text.frame = CGRectMake(0.0, 0.0, 183.0, 268.0);
    [uiv_text addSubview:uiiv_text];
    [uiv_cardContainer insertSubview:uiv_text belowSubview:uiv_logo];
    uiv_text.transform = CGAffineTransformMakeTranslation(0.0, -142);
    
    UIView *uiv_bar = [[UIView alloc] initWithFrame:CGRectMake(0.0, 124.0, 183.0, 18.0)];
    uiv_bar.tag = 3;
    UIImageView *uiiv_bar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"team_logoBtmBar.png"]];
    uiiv_bar.frame = CGRectMake(0.0, 0.0, 183.0, 18.0);
    [uiv_bar addSubview: uiiv_bar];
    [uiv_cardContainer addSubview: uiv_bar];
    uiv_bar.transform = CGAffineTransformMakeTranslation(0.0, 18);
    uiv_bar.hidden = YES;
    
    [self.view addSubview: uiv_cardContainer];
    uiv_cardContainer.transform = CGAffineTransformMakeTranslation(0.0, -40);
    
    [self performSelector:@selector(animateCard:) withObject:uiv_cardContainer afterDelay:1.0];
    
}

- (void)animateCard:(UIView *)container
{
    UIView *logo = [container viewWithTag:1];
    UIView *text = [container viewWithTag:2];
    UIView *bar = [container viewWithTag:3];
    
    [UIView animateWithDuration:0.5 animations:^{
        container.transform = CGAffineTransformIdentity;
        text.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        logo.layer.zPosition = 0;
        bar.layer.zPosition = 1;
        text.layer.zPosition = 2;
        bar.hidden = NO;
        [UIView animateWithDuration:0.33
                         animations:^{
                             bar.transform = CGAffineTransformIdentity;
                        }];
    }];
    
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
