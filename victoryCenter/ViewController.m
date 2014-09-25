//
//  ViewController.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/23/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton		*uib_menu;
@property (weak, nonatomic) IBOutlet UIView			*uiv_menuPanel;

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = CGRectMake(0.0, 0.0, 1024.0, 768.0);
    _uiv_menuPanel.transform = CGAffineTransformMakeTranslation(-388, 0.0);
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _uib_menu.hidden = YES;
	// Do any additional setup after loading the view, typically from a nib.
}

//=====================Tap home button to remove the subview===================

- (IBAction)returnToRoot:(id)sender {
    //Detail subview is set tag with 1000 in custom segue
    _uib_menu.hidden = YES;
	
    __block UIView *tmp = [self.view viewWithTag:1000];
    [UIView animateWithDuration:0.33 animations:^{
        tmp.alpha = 0.0;
    } completion:^(BOOL finished){
        [tmp removeFromSuperview];
        tmp = nil;
    }];
}
//=============================================================================

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
