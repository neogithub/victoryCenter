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
#import "contactViewController.h"

@interface RootViewController ()
{
    UIScreen				*external_disp;
    UIWindow				*external_wind;
    // movie stuff
	UIView                      *mpControlsView;
	UIView                      *mpBackingView;
	UIButton                    *closeMovieButton;
	NSTimeInterval              totalVideoTime;
    NSTimeInterval				totalElapsedTime;
	UISlider                    *progressIndicator;
}
@property (weak, nonatomic) IBOutlet UIButton *uib_helpBtn;
@property (weak, nonatomic) IBOutlet UIButton *uib_movieBtn;
@property (weak, nonatomic) IBOutlet UIButton *uib_mailBtn;

@property (weak, nonatomic) IBOutlet UIButton                   *uib_menu;
@property (strong, nonatomic) IBOutlet UIView                   *uiv_toolsPanel;
@property (weak, nonatomic) IBOutlet UILabel                    *uil_titleLabel;
@property (strong, nonatomic) UIView                            *uiv_menuPanel;
@property (strong, nonatomic) UIView                            *uiv_leftFillerPanel;
@property (strong, nonatomic) UIView                            *uiv_mainMenuContainer;
@property (strong, nonatomic) UIButton                          *uib_resetBtn;
@property (strong, nonatomic) NSMutableArray                    *arr_menuButtons;
@property (nonatomic, strong) MPMoviePlayerViewController       *playerViewController;
@property (nonatomic, strong) contactViewController             *contactVC;

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeContact:) name:@"removeContact" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doneButtonClick:) name:MPMoviePlayerPlaybackDidFinishNotification object:_playerViewController];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(swithToBuilding) name:@"switchToBuilding" object:nil];
}

#pragma mark - Deal with notificaiton
- (void)hideHomeBtn:(NSNotification *)notification
{
    if (_contactVC.view)
    {
        return;
    }
    _uib_menu.hidden = YES;
    _uiv_toolsPanel.hidden = YES;
    _uil_titleLabel.hidden = YES;
}

- (void)unHideHomeBtn:(NSNotification *)notificaiton
{
    if (_contactVC.view)
    {
        return;
    }
    else
    {
        _uib_menu.hidden = NO;
        _uiv_toolsPanel.hidden = NO;
        _uil_titleLabel.hidden = NO;
    }
}

- (void)swithToBuilding
{
    UIButton *tmp = [UIButton new];
    tmp.tag = 1;
    [self loadVC:tmp];
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
    
    UITapGestureRecognizer *tapOnTitle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTitle:)];
    [_uil_titleLabel addGestureRecognizer: tapOnTitle];
    _uil_titleLabel.userInteractionEnabled = YES;
}

- (void)tapTitle:(UIGestureRecognizer *)gesture
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tapOnTitle" object:nil];
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

    _uiv_mainMenuContainer = [[UIView alloc] initWithFrame:screenRect];
    if ([self.view viewWithTag:1000]) {
        [_uiv_mainMenuContainer setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.6]];;
    }
    else {
        [_uiv_mainMenuContainer setBackgroundColor:[UIColor clearColor]];
    }
    _uiv_mainMenuContainer.alpha = 0.0;
    [self.view insertSubview:_uiv_mainMenuContainer belowSubview:_uiv_toolsPanel];
    
	_uiv_menuPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 320)];
	[_uiv_menuPanel setBackgroundColor:[UIColor clearColor]];
    [_uiv_mainMenuContainer addSubview: _uiv_menuPanel];
	
	_uiv_leftFillerPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 80)];
	[_uiv_leftFillerPanel setBackgroundColor:[UIColor vcmediummenu]];
    [_uiv_mainMenuContainer addSubview:_uiv_leftFillerPanel];
    
    _uib_resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _uib_resetBtn.frame = CGRectMake(0.0, 0.0, 45.0, 45.0);
    [_uib_resetBtn setImage:[UIImage imageNamed:@"grfx_homeBtn.png"] forState:UIControlStateNormal];
    [_uib_resetBtn addTarget:self action:@selector(resetApp) forControlEvents:UIControlEventTouchUpInside];
    [_uiv_mainMenuContainer addSubview: _uib_resetBtn];
    
	
	for (int i=0; i<[arr_MenuNames count]; i++) {
		UIButton *button = [UIButton buttonWithType: UIButtonTypeRoundedRect];
		CGRect frame = CGRectMake ( 6*i, 0, 800/10, 80 );
		[button setFrame: frame];
		button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
		[button.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:22.0]];
		[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[button setBackgroundColor:arr_MenuColors[i]];
		[button setTitle:[arr_MenuNames[i] uppercaseString]  forState:UIControlStateNormal];
		button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
		[button addTarget: NULL action:@selector(loadVC:) forControlEvents:UIControlEventTouchUpInside];
		[button setTag:i+1];
        button.layer.borderColor = button.backgroundColor.CGColor;
        button.layer.borderWidth = 1.5;
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
    
    UITapGestureRecognizer *tapOnWhite = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rewindMenuOffScreen)];
    tapOnWhite.numberOfTapsRequired = 1;
    _uiv_mainMenuContainer.userInteractionEnabled = YES;
    [_uiv_mainMenuContainer addGestureRecognizer:tapOnWhite];
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
		 _uib_menu.transform = CGAffineTransformMakeTranslation(370, -50);
         [_uib_menu setImage:[UIImage imageNamed:@"grfx_openMenuIcon.png"] forState:UIControlStateNormal];
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
													  btn.frame = CGRectMake(btn.frame.origin.x-800, btn.frame.origin.y-(i*78), 800, btn.frame.size.height);
												  } else {
													  btn.frame = CGRectMake(btn.frame.origin.x-800, btn.frame.origin.y-(i*78), 800, btn.frame.size.height);
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
											  
											  
											  _uib_menu.transform = CGAffineTransformMakeTranslation(370, -50);
											  
											  
											  
											  
										  }
										  completion:^(BOOL  completed){
											  
                                              [_uib_menu setImage:[UIImage imageNamed:@"grfx_menuIcon.png"] forState:UIControlStateNormal];
                                              
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
    
    [UIView animateWithDuration:0.2 animations:^{
        _uiv_mainMenuContainer.alpha = 0.0;
    } completion:^(BOOL finished){
        [_uiv_mainMenuContainer removeFromSuperview];
        _uiv_mainMenuContainer = nil;
        [_uiv_leftFillerPanel removeFromSuperview];
        _uiv_leftFillerPanel=nil;
        [_uiv_menuPanel removeFromSuperview];
        _uiv_menuPanel=nil;
        [_uib_resetBtn removeFromSuperview];
        _uib_resetBtn = nil;
    }];
}

-(void)animateMenuOnScreen
{
    [UIView animateWithDuration:0.33 animations:^{
        _uiv_mainMenuContainer.alpha = 1.0;
    }];
    
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
													  _uib_menu.transform = CGAffineTransformMakeTranslation(370, 0);
												  } completion:nil];
												  
												  
												  
											  }];
							 
							 ii += 1;
						 }
						 
					 }
					 completion:^(BOOL  completed){   }];
}

- (void)resetApp
{
    __block UIView *tmp = [self.view viewWithTag:1000];
    [UIView animateWithDuration:0.33 animations:^{
        tmp.alpha = 0.0;
        _uiv_mainMenuContainer.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished){
        for (UIView __strong *tmpV in [tmp subviews]) {
            [tmpV removeFromSuperview];
            tmpV = nil;
        }
        _uil_titleLabel.hidden = YES;
        [tmp removeFromSuperview];
        tmp = nil;
    }];
}

#pragma mark - Bottomleft buttons' actions
#pragma mark Mail Button Action
- (IBAction)mailBtnTapped:(id)sender {   
    _contactVC = [self.storyboard instantiateViewControllerWithIdentifier:@"contactViewController"];
    CGRect frame = screenRect;
    frame.origin.y = 768.0;
    
//    if (_uiv_menuPanel) {
//        _uiv_menuPanel.hidden = YES;
//        _uiv_leftFillerPanel.hidden = YES;
//    }   
    [self.view insertSubview: _contactVC.view belowSubview:_uiv_toolsPanel];
    _uib_menu.hidden = YES;
    _uib_mailBtn.enabled = NO;
    _contactVC.view.frame = frame;
    [UIView animateWithDuration:0.33 animations:^{
        _contactVC.view.frame = screenRect;
    }];
}

- (void)removeContact:(NSNotification *)notification
{
    _uiv_menuPanel.hidden = NO;
    _uiv_leftFillerPanel.hidden = NO;
    _uib_menu.hidden = NO;
    _uib_mailBtn.enabled = YES;
    [UIView animateWithDuration:0.33 animations:^{
        _contactVC.view.transform = CGAffineTransformMakeTranslation(0.0, 768);
    } completion:^(BOOL finished){
        [_contactVC.view removeFromSuperview];
        _contactVC.view = nil;
        [_contactVC removeFromParentViewController];
        _contactVC = nil;
    }];
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
//    [self.view insertSubview:_playerViewController.view aboveSubview:_uib_menu];
//    [_playerViewController.moviePlayer play];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideHomeButton" object:nil];
//    [self performSelector:@selector(setMovieControlAvailable) withObject:nil afterDelay:1.0];
    
    if (!external_wind) {
        [self setupExternalScreen];
    }
    
    if (external_wind) {
        
        _playerViewController.view.frame = [external_disp bounds];
        [external_wind addSubview:_playerViewController.view];
        
        CGRect extbounds = external_wind.bounds;
        
        UILabel *helpLabel = [[UILabel alloc] initWithFrame:CGRectMake(extbounds.size.width-320, extbounds.size.height-40, 300, 30)];
        
        [external_wind addSubview:helpLabel];
        
        helpLabel.text = @"Movie Controls on iPad";
        helpLabel.textColor = [UIColor whiteColor];
        helpLabel.textAlignment = NSTextAlignmentRight;
        helpLabel.backgroundColor = [UIColor clearColor];
        helpLabel.font = [UIFont fontWithName:@"Helvetica" size:10.0];
        helpLabel.highlighted = YES;
        helpLabel.highlightedTextColor = [UIColor whiteColor];
        
        // fade
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.fromValue = [NSNumber numberWithFloat:0.7];
        animation.toValue = [NSNumber numberWithFloat:0.35];
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        animation.duration = 1.33;
        [helpLabel.layer addAnimation:animation forKey:@"opacity"];
        
        [self useCustomMovieControls];
        
    } else {
        [self.view insertSubview:_playerViewController.view aboveSubview:_uib_menu];
        [_playerViewController.moviePlayer play];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideHomeButton" object:nil];
        [self performSelector:@selector(setMovieControlAvailable) withObject:nil afterDelay:1.0];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:_playerViewController
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:_playerViewController.moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_playerViewController.moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullscreenControlsNotification)
                                                 name:MPMoviePlayerLoadStateDidChangeNotification
                                               object:_playerViewController.moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDurationAvailableNotification)
                                                 name:MPMovieDurationAvailableNotification
                                               object:_playerViewController.moviePlayer];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

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

- (void)handleDurationAvailableNotification
{
	totalVideoTime = _playerViewController.moviePlayer.duration;
	_playerViewController.moviePlayer.currentPlaybackTime = 0;
	[_playerViewController.moviePlayer play];
}

- (void)fullscreenControlsNotification {
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:MPMoviePlayerNowPlayingMovieDidChangeNotification
												  object:_playerViewController];
	_playerViewController.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
}

#pragma mark Movie Notifications
- (void)movieFinishedCallback:(NSNotification*)aNotification {
	
	// Obtain the reason why the movie playback finished
    NSNumber *finishReason = [[aNotification userInfo] objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    
	// Dismiss the view controller ONLY when the reason is not "playback ended"
    if ([finishReason intValue] != MPMovieFinishReasonPlaybackEnded)
    {
        MPMoviePlayerController *moviePlayer = [aNotification object];
        // Remove this class from the observers
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:MPMoviePlayerPlaybackDidFinishNotification
                                                      object:moviePlayer];
        // Dismiss the view controller
		[_playerViewController.view removeFromSuperview];
		_playerViewController = nil;
		
		[[NSNotificationCenter defaultCenter]
		 postNotificationName:@"unhideMenu"
		 object:self];
        
    } else {
		[_playerViewController.view removeFromSuperview];
		_playerViewController = nil;
	}
	
	if (external_wind) {
		// Hide and then delete the window.
		external_wind.hidden = YES;
		external_wind = nil;
		[mpControlsView removeFromSuperview];
		[[NSNotificationCenter defaultCenter] removeObserver:self
														name:MPMovieDurationAvailableNotification
													  object:_playerViewController.moviePlayer];
	} else {
		[_playerViewController.view removeFromSuperview];
		_playerViewController = nil;
	}
}

- (void)moviePlaybackComplete:(NSNotification *)notification
{
	MPMoviePlayerController *moviePlayerController = [notification object];
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:MPMoviePlayerPlaybackDidFinishNotification
												  object:moviePlayerController];
}

- (void)monitorPlaybackTime
{
	[[NSNotificationCenter defaultCenter] removeObserver:_playerViewController
													name:MPMovieDurationAvailableNotification
												  object:_playerViewController.moviePlayer];
    
//	[progressIndicator addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:NULL];
    
	
	progressIndicator.value = _playerViewController.moviePlayer.currentPlaybackTime / totalVideoTime;
	totalElapsedTime = progressIndicator.value;
	
	CGFloat t = _playerViewController.moviePlayer.currentPlaybackTime;
	
	NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
	[userInfo setObject:[NSNumber numberWithInt:t] forKey:@"slidevalue"];
	
	NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
	[nc postNotificationName:@"eRXReceived" object:self userInfo:userInfo];
	
	//constantly keep checking if at the end of video:
	if (totalVideoTime != 0 && _playerViewController.moviePlayer.currentPlaybackTime >= totalVideoTime - 0.1)
	{
		//-------- rewind code:
		_playerViewController.moviePlayer.currentPlaybackTime = 0;
		[_playerViewController.moviePlayer pause];
	}
	else
	{
		[self performSelector:@selector(monitorPlaybackTime) withObject:nil afterDelay:0.5];
	}
}

#pragma mark movie control on ipad
- (void)useCustomMovieControls
{
	[mpControlsView removeFromSuperview];
	[mpBackingView removeFromSuperview];
	
    //	if (external_wind) {
    //		uib_film.enabled = NO;
    //	}
	
	// Create a category view and add it to the window.
	if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
		mpControlsView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 435, 88)];
		mpBackingView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 1024, 768)];
	}
	
	//mpBackingView.center = self.view.center;
	
	[mpBackingView setBackgroundColor: [UIColor whiteColor]];
	mpBackingView.alpha = 0.0;
	[self.view addSubview:mpBackingView];
	[mpBackingView setUserInteractionEnabled:YES];
	
	CGPoint center = [self.view convertPoint:self.view.center fromView: self.view.superview];
	mpControlsView.center = center;
	
	[mpControlsView setBackgroundColor: [UIColor whiteColor]];
	mpControlsView.alpha = 0.0;
	[self.view addSubview:mpControlsView];
	
	[UIView animateWithDuration:0.33
					 animations:^{
						 //mpControlsView.transform = CGAffineTransformMakeTranslation(0, 100);
						 mpControlsView.alpha = 1.0;
						 mpBackingView.alpha = 0.5;
					 }
					 completion:^(BOOL  completed){
						 [UIView animateWithDuration:0.3
										  animations:^{ }
										  completion:^(BOOL  completed){  }];}];
	
	closeMovieButton = [UIButton buttonWithType: UIButtonTypeCustom];
	[closeMovieButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[closeMovieButton setBackgroundColor:[UIColor darkGrayColor]];
	[closeMovieButton setTitle:@"PAUSE" forState:UIControlStateNormal];
	CGRect frame = CGRectMake (20, 30, 92, 32);
	[closeMovieButton setFrame: frame];
	[closeMovieButton addTarget:self action:@selector(playbackToggle) forControlEvents:UIControlEventTouchUpInside];
	[mpControlsView addSubview:closeMovieButton];
	
	UIButton* closeMe = [UIButton buttonWithType: UIButtonTypeCustom];
	[closeMe setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[closeMe setBackgroundColor:[UIColor darkGrayColor]];
	
	[closeMe setTitle:@"CLOSE" forState:UIControlStateNormal];
	frame = CGRectMake (320, 30, 92, 32);
	[closeMe setFrame: frame];
	[closeMe addTarget:self action:@selector(removeExternalScreen) forControlEvents:UIControlEventTouchUpInside];
	[mpControlsView addSubview:closeMe];
	
	// info label for external screen
	UILabel *uil_movieOnExternal = [[UILabel alloc] initWithFrame:CGRectMake(mpControlsView.frame.size.width-312, mpControlsView.frame.size.height-28, 200, 30)];
	uil_movieOnExternal.text = @"Movie is on External Monitor";
	uil_movieOnExternal.textColor = [UIColor darkGrayColor];
	uil_movieOnExternal.textAlignment = NSTextAlignmentCenter;
	uil_movieOnExternal.alpha = 0.75;
	uil_movieOnExternal.font = [UIFont fontWithName:@"Helvetica" size:10.0];
	[mpControlsView addSubview:uil_movieOnExternal];
	
	frame = CGRectMake(128.0, 27.0, 170, 40.0);
    progressIndicator = [[UISlider alloc] initWithFrame:frame];
    [progressIndicator addTarget:self action:@selector(playbackScrubber:) forControlEvents:UIControlEventValueChanged];
    [progressIndicator setBackgroundColor:[UIColor clearColor]];
	progressIndicator.tintColor = [UIColor darkGrayColor];
    progressIndicator.continuous = YES;
	[mpControlsView addSubview:progressIndicator];
	
	[self monitorPlaybackTime];
}


-(void)playbackToggle {
	if (_playerViewController.moviePlayer.playbackState == MPMoviePlaybackStatePlaying) {
		[_playerViewController.moviePlayer pause];
	} else {
		[_playerViewController.moviePlayer play];
		[self monitorPlaybackTime];
	}
}

- (void)playbackScrubber: (UISlider*)sender
{
	_playerViewController.moviePlayer.currentPlaybackTime = totalVideoTime*progressIndicator.value;
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

#pragma mark - External Screen
- (void)setupExternalScreen
{
	if ([[UIScreen screens] count] > 1)
    {
		[self setUpScreenConnectionNotificationHandlers];
        // Get the screen object that represents the external display.
        external_disp = [[UIScreen screens] objectAtIndex:1];
        // Get the screen's bounds so that you can create a window of the correct size.
        CGRect screenBounds = external_disp.bounds;
		
        external_wind = [[UIWindow alloc] initWithFrame:screenBounds];
        external_wind.screen = external_disp;
        external_wind.hidden = NO;
    }
}

#pragma mark External Screen Clear
-(void)removeExternalScreen {
	if (external_wind) {
		// Hide and then delete the window.
		[_playerViewController.moviePlayer pause];
		external_wind.hidden = YES;
		external_wind = nil;
		[mpControlsView removeFromSuperview];
		[mpBackingView removeFromSuperview];
		[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(monitorPlaybackTime) object:nil];
		_playerViewController=nil;
	}
}

#pragma mark External Screen Connection
- (void)setUpScreenConnectionNotificationHandlers
{
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//	
//    [center addObserver:self selector:@selector(handleScreenDidConnectNotification:)
//				   name:UIScreenDidConnectNotification object:nil];
//    [center addObserver:self selector:@selector(handleScreenDidDisconnectNotification:)
//				   name:UIScreenDidDisconnectNotification object:nil];
}

- (void)handleScreenDidConnectNotification:(NSNotification*)aNotification
{
//    UIScreen *newScreen = [aNotification object];
//    CGRect screenBounds = newScreen.bounds;
//	
//    if (!external_wind)
//    {
//        external_wind = [[UIWindow alloc] initWithFrame:screenBounds];
//        external_wind.screen = newScreen;
//        // Set the initial UI for the window.
//    }
}

- (void)handleScreenDidDisconnectNotification:(NSNotification*)aNotification
{
//    if (external_wind)
//    {
//        // Hide and then delete the window.
//        external_wind.hidden = YES;
//        external_wind = nil;
//    }
}

#pragma mark - Memory Warning & Cleaning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
