//
//  ViewController.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/23/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "RootViewController.h"
#import "XHCustomSegue.h"
#import "UIColor+Extensions.h"
#import <MediaPlayer/MediaPlayer.h>

@interface RootViewController ()

@property (weak, nonatomic) IBOutlet UIButton                   *uib_menu;
@property (strong, nonatomic) IBOutlet UIView                   *uiv_toolsPanel;
@property (weak, nonatomic) IBOutlet UILabel                    *uil_titleLabel;
@property (strong, nonatomic) UIView                            *uiv_menuPanel;
@property (strong, nonatomic) UIView                            *uiv_leftFillerPanel;
@property (strong, nonatomic) NSMutableArray                    *arr_menuButtons;
@property (nonatomic, strong) MPMoviePlayerViewController       *playerViewController;
@end

@implementation RootViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = screenRect;
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self createMenuButtons];
    [self setTitleLabel];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideHomeBtn:) name:@"hideHomeButton" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unHideHomeBtn:) name:@"unhideHomeButton" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doneButtonClick:) name:MPMoviePlayerPlaybackDidFinishNotification object:_playerViewController];
}

#pragma mark - Deal with notificaiton
- (void)hideHomeBtn:(NSNotification *)notification
{
    _uib_menu.hidden = YES;
    _uiv_toolsPanel.hidden = YES;
}

- (void)unHideHomeBtn:(NSNotification *)notificaiton
{
    _uib_menu.hidden = NO;
    _uiv_toolsPanel.hidden = NO;
}

#pragma mark - Style the title label

- (void)setTitleLabel
{
    _uil_titleLabel.textColor = [UIColor vcDarkBlue];
    [_uil_titleLabel setTextAlignment:NSTextAlignmentCenter];
    _uil_titleLabel.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    _uil_titleLabel.layer.borderWidth = 1.0;
    _uil_titleLabel.backgroundColor = [UIColor whiteColor];
    [_uil_titleLabel setFont:[UIFont fontWithName:@"Raleway-Medium" size:20]];
    _uil_titleLabel.hidden = YES;
}

#pragma mark - Load VC
-(void)loadVC:(id)sender
{
	NSString *vcIdentifier;
    NSArray *arr_identifier = [[NSArray alloc] initWithObjects:@"buildingViewController", @"mapViewController", @"galleryViewController", @"teamViewController", nil];
    NSArray *arr_vcTitle = [[NSArray alloc] initWithObjects:@"BUILDING", @"LOCATION", @"GALLERY", @"TEAM", nil];

    vcIdentifier = [arr_identifier objectAtIndex:[sender tag] - 1];
	__block UIView *tmp = [self.view viewWithTag:1000];
    [UIView animateWithDuration:0.33 animations:^{
        tmp.alpha = 0.0;
    } completion:^(BOOL finished){
        for (UIView __strong *tmpV in [tmp subviews]) {
            [tmpV removeFromSuperview];
            tmpV = nil;
        }
        [tmp removeFromSuperview];
        tmp = nil;
    }];

	UIViewController *destination = [self.storyboard instantiateViewControllerWithIdentifier:vcIdentifier];
	XHCustomSegue *segue = [[XHCustomSegue alloc] initWithIdentifier:nil source:self destination:destination];
	[self prepareForSegue:segue sender:self];
	[segue perform];
	
    [_uil_titleLabel setText:[arr_vcTitle objectAtIndex:[sender tag]-1]];
    
	[self rewindMenuOffScreen];
    
    _uil_titleLabel.hidden = NO;
}

#pragma mark - Create main menu's buttons
-(IBAction)createMenuButtons
{
	if (_uiv_menuPanel) {
		[self rewindMenuOffScreen];
		return;
	}
	
	_arr_menuButtons = [[NSMutableArray alloc] init];
	
	NSArray *arr_MenuNames = @[@"Building",@"Location",@"Gallery",@"Team"];
	NSArray *arr_MenuColors = @[[UIColor vcmediummenu],[UIColor vcdarkmenu],[UIColor vccyanmenu],[UIColor vclightbluemenu]];

	_uiv_menuPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 320)];
	[_uiv_menuPanel setBackgroundColor:[UIColor clearColor]];
	[self.view insertSubview:_uiv_menuPanel belowSubview:_uiv_toolsPanel];
	
	_uiv_leftFillerPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 80)];
	[_uiv_leftFillerPanel setBackgroundColor:[UIColor vcmediummenu]];
	[self.view insertSubview:_uiv_leftFillerPanel aboveSubview:_uil_titleLabel];
	
	for (int i=0; i<[arr_MenuNames count]; i++) {
		UIButton *button = [UIButton buttonWithType: UIButtonTypeRoundedRect];
		CGRect frame = CGRectMake ( 6*i, 0, 800/10, 80 );
		[button setFrame: frame];
		button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
		[button.titleLabel setFont:[UIFont fontWithName:@"Futura" size:22.0]];
		[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[button setBackgroundColor:arr_MenuColors[i]];
		[button setTitle:[arr_MenuNames[i] uppercaseString]  forState:UIControlStateNormal];
		button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
		[button addTarget: NULL action:@selector(loadVC:) forControlEvents:UIControlEventTouchUpInside];
		[button setTag:i+1];
		[_arr_menuButtons addObject:button];
		[_uiv_menuPanel insertSubview:button atIndex:0];
		button.alpha = 0.0;
	}
	
	//rotate and move the container
	float degrees = 86; //the value in degrees
	CGAffineTransform s =  CGAffineTransformMakeRotation(degrees * -M_PI/180);
	CGAffineTransform t = CGAffineTransformMakeTranslation(-200, 250);
	_uiv_menuPanel.transform = CGAffineTransformConcat(s, t);
	
	s =  CGAffineTransformMakeRotation(degrees * -M_PI/180);
	t = CGAffineTransformMakeTranslation(-494, 540);
	_uiv_leftFillerPanel.transform = CGAffineTransformConcat(s, t);
	
	[self prepareMenuForAnimation];
}

-(void)prepareMenuForAnimation
{
	[UIView animateWithDuration:0.3/1.5 animations:^{
		
		float fAngle = atan2f(_uiv_leftFillerPanel.transform.b, _uiv_leftFillerPanel.transform.a);
		CGAffineTransform s =  CGAffineTransformMakeRotation(fAngle);
		CGAffineTransform t = CGAffineTransformMakeTranslation(-394, 340);
		_uiv_leftFillerPanel.transform = CGAffineTransformConcat(s, t);
		[self animateMenuOnScreen];
		_uib_menu.transform = CGAffineTransformMakeTranslation(0, -50);
		
	} completion:^(BOOL completed)
	 {
		 // animate the menu buttons
		 _uib_menu.transform = CGAffineTransformMakeTranslation(375, -50);
	 }];
}

-(void)rewindMenuOffScreen
{
	NSLog(@"rewind");
	[UIView animateWithDuration:0.33
					 animations:^{
						 NSInteger ii = 0;
						 for (int i=0; i<[_arr_menuButtons count]; i++) {
							 
							 UIViewAnimationOptions options = UIViewAnimationOptionAllowUserInteraction;
							 [UIView animateWithDuration:.2 delay:((0.05 * ii) + 0.2) options:options
											  animations:^{
												  
												  NSArray* reversed = [[_arr_menuButtons reverseObjectEnumerator] allObjects];
												  UIView *btn = reversed[i];
												  
												  if (i==0) {
													  btn.frame = CGRectMake(btn.frame.origin.x-800, btn.frame.origin.y-(i*80), 800, btn.frame.size.height);
												  } else {
													  btn.frame = CGRectMake(btn.frame.origin.x-800, btn.frame.origin.y-(i*80), 800, btn.frame.size.height);
												  }
												  btn.alpha = 0.0;
											  }
											  completion:^(BOOL finished){
												  
											  }];
							 
							 ii += 1;
						 }
						 
					 }
	 
					 completion:^(BOOL  completed) {
						 NSLog(@"asds");
						 
						 [UIView animateWithDuration:0.33
										  animations:^{
											  
											  
											  _uib_menu.transform = CGAffineTransformMakeTranslation(375, -50);
											  
											  
											  
											  
										  }
										  completion:^(BOOL  completed){
											  
                                              
                                              
										  }];
						 
						 
						 
						 
						 
					 }];
	
	[self performSelector:@selector(removeMenuFromMemory) withObject:nil afterDelay:0.5];
}

-(void)removeMenuFromMemory
{
	float fAngle = atan2f(_uiv_leftFillerPanel.transform.b, _uiv_leftFillerPanel.transform.a);
	CGAffineTransform s =  CGAffineTransformMakeRotation(fAngle);
	CGAffineTransform t = CGAffineTransformMakeTranslation(-794, 340);
	_uiv_leftFillerPanel.transform = CGAffineTransformConcat(s, t);
	
	_uib_menu.transform = CGAffineTransformIdentity;
	
	[_uiv_leftFillerPanel removeFromSuperview];
	_uiv_leftFillerPanel=nil;
	[_uiv_menuPanel removeFromSuperview];
	_uiv_menuPanel=nil;
}

-(void)animateMenuOnScreen
{
	[UIView animateWithDuration:0.33
					 animations:^{
						 
						 
						 NSInteger ii = 0;
						 for (int i=0; i<[_arr_menuButtons count]; i++) {
							 
							 UIViewAnimationOptions options = UIViewAnimationOptionAllowUserInteraction;
							 [UIView animateWithDuration:.2 delay:((0.05 * ii) + 0.2) options:options
											  animations:^{
												  UIView *btn = _arr_menuButtons[i];
												  
												  if (i==0) {
													  btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y+(i*80), 800, btn.frame.size.height);
												  } else {
													  btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y+(i*80), 800, btn.frame.size.height);
												  }
												  btn.alpha = 1.0;
											  }
											  completion:^(BOOL finished){
												  
												  [UIView animateWithDuration:0.3/1.5 animations:^{
													  _uib_menu.transform = CGAffineTransformMakeTranslation(375, 0);
												  } completion:nil];
												  
												  
												  
											  }];
							 
							 ii += 1;
						 }
						 
					 }
					 completion:^(BOOL  completed){   }];
}

#pragma mark - Bottomleft buttons' actions
#pragma mark Mail Button Action
- (IBAction)mailBtnTapped:(id)sender {
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle: @""
                               message: @"Mail Coming Soon"
                              delegate: self
                     cancelButtonTitle: @"OK"
                     otherButtonTitles: nil];
    alert.tag = 1;
    [alert show];
}

#pragma mark Movie Button Action
- (IBAction)movieBtnTapped:(id)sender {
    
    NSString *url = [[NSBundle mainBundle] pathForResource:@"neoscape_bug" ofType:@"mov"];
    
    if (_playerViewController) {
        [_playerViewController.view removeFromSuperview];
        _playerViewController = nil;
    }
    
    _playerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:url]];
    _playerViewController.view.frame = self.view.bounds;//CGRectMake(0, 0, 1024, 768);
    _playerViewController.view.alpha=1.0;
    _playerViewController.moviePlayer.controlStyle = MPMovieControlStyleNone;
    [_playerViewController.moviePlayer setAllowsAirPlay:YES];
    _playerViewController.moviePlayer.repeatMode = MPMovieRepeatModeOne;
    [self.view insertSubview:_playerViewController.view aboveSubview:_uib_menu];
    [_playerViewController.moviePlayer play];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideHomeButton" object:nil];
    [self performSelector:@selector(setMovieControlAvailable) withObject:nil afterDelay:1.0];
}

- (void)setMovieControlAvailable
{
    _playerViewController.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
}

-(void)doneButtonClick:(NSNotification*)aNotification{
    [_playerViewController.view removeFromSuperview];
    _playerViewController = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"unhideHomeButton" object:nil];
}

#pragma mark Help Button Action
- (IBAction)helpBtnTapped:(id)sender {
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle: @""
                               message: @"Help Coming Soon"
                              delegate: self
                     cancelButtonTitle: @"OK"
                     otherButtonTitles: nil];
    alert.tag = 1;
    [alert show];
}

#pragma mark - Memory Warning & Cleaning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
