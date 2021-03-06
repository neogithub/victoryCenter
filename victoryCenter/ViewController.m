//
//  ViewController.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/23/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "ViewController.h"
#import "XHCustomSegue.h"
#import "UIColor+Extensions.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton			*uib_menu;
@property (strong, nonatomic) IBOutlet UIView			*uiv_toolsPanel;
@property (strong, nonatomic) UIView					*uiv_menuPanel;
@property (strong, nonatomic) UIView					*uiv_leftFillerPanel;
@property (strong, nonatomic) NSMutableArray			*arr_menuButtons;

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = screenRect;
    //_uiv_menuPanel.transform = CGAffineTransformMakeTranslation(-388, 0.0);
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //_uib_menu.hidden = YES;
	[self createMenuButtons];
	// Do any additional setup after loading the view, typically from a nib.
}

//=====================Tap home button to remove the subview===================

-(void)loadVC:(id)sender
{
	NSString *vcIdentifier;
	NSString *segueIdentifier;

	switch ([sender tag]) {
		case 1:
			vcIdentifier = @"buildingViewController";
			segueIdentifier =  @"buildingSegue";
			break;
			
		case 2:
			vcIdentifier = @"mapViewController";
			segueIdentifier =  @"mapSegue";
			break;
			
		case 3:
			vcIdentifier = @"galleryViewController";
			segueIdentifier =  @"gallerySegue";
			break;
			
		case 4:
			vcIdentifier = @"teamViewController";
			segueIdentifier =  @"teamSegue";
			break;
			
		default:
			break;
	}
	
	__block UIView *tmp = [self.view viewWithTag:1000];
    [UIView animateWithDuration:0.33 animations:^{
        tmp.alpha = 0.0;
    } completion:^(BOOL finished){
        [tmp removeFromSuperview];
        tmp = nil;
    }];
	
	UIViewController *destination = [self.storyboard instantiateViewControllerWithIdentifier:vcIdentifier];
	XHCustomSegue *segue = [[XHCustomSegue alloc] initWithIdentifier:segueIdentifier source:self destination:destination];
	[self prepareForSegue:segue sender:self];
	[segue perform];
	
	[self rewindMenuOffScreen];
}

- (void)returnToRoot:(id)sender {
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
	[self.view addSubview:_uiv_leftFillerPanel];
	
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
						 //
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
