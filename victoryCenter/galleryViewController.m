//
//  galleryViewController.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/24/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "galleryViewController.h"
#import "galleryCVCell.h"
#import "UIColor+Extensions.h"
#import <MediaPlayer/MediaPlayer.h>
#import "xhPanoramicView.h"
#import "xhPopTipsView.h"

@interface galleryViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    UIScreen                    *external_disp;
    UIWindow                    *external_wind;
    // movie stuff
	UIView                      *mpControlsView;
	UIView                      *mpBackingView;
	UIButton                    *closeMovieButton;
	NSTimeInterval              totalVideoTime;
    NSTimeInterval				totalElapsedTime;
	UISlider                    *progressIndicator;
    
    // Button's Array
    NSMutableArray          *arr_topBtnArray;
    // gallery
	NSString                *secTitle;
	NSDictionary            *albumDict;
    int                     sectionIndex;
    //Collection View's data
    NSMutableArray          *arr_AlbumData;
    NSMutableArray          *arr_AlbumItems;
    NSMutableArray          *arr_AlbumFrame;
    NSMutableArray          *arr_AlbumCaption;
    //Data for tapping on cells
    NSMutableArray          *arr_AllImgs;
    NSMutableArray          *arr_AllPhotos;
    NSMutableArray          *arr_AllFlms;
}
@property (weak, nonatomic) IBOutlet UIButton               *uib_all;
@property (weak, nonatomic) IBOutlet UIButton               *uib_render;
@property (weak, nonatomic) IBOutlet UIButton               *uib_photo;
@property (weak, nonatomic) IBOutlet UIButton               *uib_video;
@property (weak, nonatomic) IBOutlet UICollectionView       *uic_gallery;

@property (nonatomic, strong) MPMoviePlayerViewController   *playerViewController;
// Pano image
@property (nonatomic, strong)   xhPanoramicView             *uiv_panoramicView;
// Help tip view
@property (nonatomic, strong) xhPopTipsView                 *uiv_helpView;
@property (nonatomic, strong) NSMutableArray                *arr_helpText;
@property (nonatomic, strong) NSMutableArray                *arr_helpTargetViews;
@end

@implementation galleryViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = screenRect;
    [self prepareHlepData];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults objectForKey:@"firstGallery"])
    {
        [self performSelector:@selector(loadHelpViews) withObject:nil afterDelay:0.5];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"NO" forKey:@"firstGallery"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadGalleryData];
    [self setTopButtons];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doneButtonClick:) name:MPMoviePlayerPlaybackDidFinishNotification object:_playerViewController];
}

#pragma mark - Set top buttons
- (void)setTopButtons
{
    arr_topBtnArray = [[NSMutableArray alloc] init];
    
    [self initTopBtn:_uib_all withTitle:@"ALL" andTag:4 andSelected:NO];
    [self initTopBtn:_uib_render withTitle:@"RENDERING" andTag:1 andSelected:YES];
    [self initTopBtn:_uib_photo withTitle:@"PHOTOGRAPHY" andTag:2 andSelected:NO];
    [self initTopBtn:_uib_video withTitle:@"VIDEO" andTag:3 andSelected:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideAndUnhideHelp:) name:@"hideAndUnhideHelp" object:nil];
}

- (void)initTopBtn:(UIButton *)theBtn withTitle:(NSString *)title andTag:(int)index andSelected:(BOOL)selected
{
    [theBtn setTitle:title forState:UIControlStateNormal];
    [theBtn setTitle:title forState:UIControlStateSelected];
    [theBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [theBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [theBtn.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14]];
    theBtn.tag = index;
    theBtn.selected = selected;
    if (selected) {
        theBtn.backgroundColor = [UIColor vcDarkBlue];
    }
    else{
        theBtn.backgroundColor = [UIColor vcLightBlue];
    }
    [arr_topBtnArray addObject: theBtn];
    [theBtn addTarget:self action:@selector(tapOnTopBtns:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tapOnTopBtns:(id)sender
{
    UIButton *tappedBtn = sender;
    for (UIButton *tmp in arr_topBtnArray) {
        tmp.selected = NO;
        [tmp setBackgroundColor:[UIColor vcLightBlue]];
    }
    
    tappedBtn.selected = YES;
    tappedBtn.backgroundColor = [UIColor vcDarkBlue];
    
    int index = (int)tappedBtn.tag;
    [self updateGalleryData:index];
    
	[_uic_gallery performBatchUpdates:^{
		[_uic_gallery reloadSections:[NSIndexSet indexSetWithIndex:0]];
	} completion:nil];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(285, 285)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
	[_uic_gallery setCollectionViewLayout:flowLayout animated:YES];
    [_uic_gallery scrollRectToVisible:CGRectMake(0.0, 0.0, _uic_gallery.frame.size.width, _uic_gallery.frame.size.height) animated:YES];
    [_uic_gallery reloadData];
}

#pragma mark - Prepare collecion view data from plist
- (void)loadGalleryData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:
					  @"galleryData" ofType:@"plist"];
	// Build the array from the plist
	NSMutableArray *rawArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    arr_AlbumData = [[NSMutableArray alloc] init];
    [arr_AlbumData addObject:[rawArray objectAtIndex:0]];
    [self updateGalleryData:1];//Init with Rendering images
    [_uic_gallery reloadData];
}

- (void)updateGalleryData:(int)index
{
    [self clearAllDataCollection];
    NSDictionary *raw_Dict = [[NSDictionary alloc] initWithDictionary:[arr_AlbumData objectAtIndex:0]];
    NSMutableArray *arr_secInfo = [[NSMutableArray alloc] initWithArray:[raw_Dict objectForKey:@"sectioninfo"]];
    if (index == 4) {
        for (int i = 0; i < [arr_secInfo count]; i++) {
            NSDictionary *itemDic = [[NSDictionary alloc] initWithDictionary:arr_secInfo[i]];
            [self addItemsAndFramesAndCapions:itemDic];
        }
    }
    else {
        NSDictionary *itemDic = [[NSDictionary alloc] initWithDictionary:arr_secInfo[index-1]];
        [self addItemsAndFramesAndCapions:itemDic];
    }
}

- (void)addItemsAndFramesAndCapions:(NSDictionary *)itemDic
{
    NSMutableArray *itmArray = [[NSMutableArray alloc] initWithArray:[itemDic objectForKey:@"items"]];
    [arr_AlbumItems addObjectsFromArray:itmArray];
    NSMutableArray *frmArray = [[NSMutableArray alloc] initWithArray:[itemDic objectForKey:@"frame"]];
    [arr_AlbumFrame addObjectsFromArray:frmArray];
    NSMutableArray *capArray = [[NSMutableArray alloc] initWithArray:[itemDic objectForKey:@"captions"]];
    [arr_AlbumCaption addObjectsFromArray:capArray];
    
    [self prepareDetailData:itemDic];
}

- (void)prepareDetailData:(NSDictionary *)itemDic
{
    if ([[itemDic objectForKey:@"albumtype"] isEqualToString:@"image"]) {
        [arr_AllImgs addObjectsFromArray:[itemDic objectForKey:@"items"]];
    }
    if ([[itemDic objectForKey:@"albumtype"] isEqualToString:@"photo"]) {
        [arr_AllPhotos addObjectsFromArray:[itemDic objectForKey:@"items"]];
    }
    if ([[itemDic objectForKey:@"albumtype"] isEqualToString:@"film"]) {
        [arr_AllFlms addObjectsFromArray:[itemDic objectForKey:@"items"]];
    }
}

- (void)clearAllDataCollection
{
    [arr_AlbumItems removeAllObjects];
    arr_AlbumItems = nil;
    arr_AlbumItems = [[NSMutableArray alloc] init];
    [arr_AlbumFrame removeAllObjects];
    arr_AlbumFrame = nil;
    arr_AlbumFrame = [[NSMutableArray alloc] init];
    [arr_AlbumCaption removeAllObjects];
    arr_AlbumCaption = nil;
    arr_AlbumCaption = [[NSMutableArray alloc] init];
    [arr_AllImgs removeAllObjects];
    arr_AllImgs = nil;
    arr_AllImgs = [[NSMutableArray alloc] init];
    [arr_AllFlms removeAllObjects];
    arr_AllFlms = nil;
    arr_AllFlms = [[NSMutableArray alloc] init];
    [arr_AllPhotos removeAllObjects];
    arr_AllPhotos = nil;
    arr_AllPhotos = [[NSMutableArray alloc] init];
}

#pragma mark - Collection Delegate Methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return arr_AlbumData.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arr_AlbumItems.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    galleryCVCell *galleryImageCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"cvCell"
                                    forIndexPath:indexPath];

    galleryImageCell.titleLabel.text = [arr_AlbumCaption objectAtIndex:indexPath.item];
    galleryImageCell.titleLabel.font = [UIFont fontWithName:@"Raleway-Medium" size:15];
    galleryImageCell.cellThumb.image = [UIImage imageNamed:[NSString stringWithFormat:@"thumb_%@",[arr_AlbumItems objectAtIndex:indexPath.item]]];
    galleryImageCell.cellFrame.image = [UIImage imageNamed:[arr_AlbumFrame objectAtIndex:indexPath.item]];
    return galleryImageCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIButton *tmp = [[UIButton alloc] init];
	int currentIndex = (int)indexPath.section;
	tmp.tag = indexPath.row;
    [self click2Open:tmp inSection:currentIndex];
}

#pragma mark - Thumbnail Action

- (void)openFilm:(int)index
{
    NSString *oldfileName = [arr_AllFlms objectAtIndex: index];
    NSString *name = [oldfileName substringWithRange:NSMakeRange(0, oldfileName.length-4)];
    NSString *url = [[NSBundle mainBundle]
                     pathForResource:name
                     ofType:@"mov"];
    
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
//    [self.view insertSubview:_playerViewController.view aboveSubview:_uic_gallery];
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
        [self.view insertSubview:_playerViewController.view aboveSubview:_uic_gallery];
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
		[_playerViewController.view removeFromSuperview];
        _playerViewController.view = nil;
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

#pragma mark - Prepare Pano image

- (void)loadPanoImage:(int)index
{
    if (_uiv_panoramicView) {
        [_uiv_panoramicView removeFromSuperview];
        _uiv_panoramicView = nil;
    }
    NSString *imageName = [arr_AllPhotos objectAtIndex: index];
    if (imageName) {
        _uiv_panoramicView = [[xhPanoramicView alloc] initWithFrame:self.view.bounds andImageName:imageName];
        [self setPanoCloseAndTitle:nil];
        [self.view addSubview:_uiv_panoramicView];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideHomeButton" object:nil];
    }
}

- (void)setPanoCloseAndTitle:(NSString *)title
{
    UIButton *uib_panoClose = [UIButton buttonWithType:UIButtonTypeCustom];
    uib_panoClose.frame = CGRectMake(0.0, 0.0, 44.0, 44.0);
    [uib_panoClose setBackgroundImage:[UIImage imageNamed:@"grfx_contactClose.jpg"] forState:UIControlStateNormal];
    [uib_panoClose addTarget:self action:@selector(removePano:) forControlEvents:UIControlEventTouchUpInside];
    [_uiv_panoramicView addSubview: uib_panoClose];
    
//    UILabel *uil_title = [[UILabel alloc] initWithFrame:CGRectMake(42.0, 0.0, 180.0, 44.0)];
//    uil_title.text = title;
//    uil_title.textColor = [UIColor vcDarkBlue];
//    [uil_title setTextAlignment:NSTextAlignmentCenter];
//    uil_title.layer.borderColor = [UIColor vcDarkBlue].CGColor;
//    uil_title.layer.borderWidth = 1.0;
//    uil_title.backgroundColor = [UIColor whiteColor];
//    [uil_title setFont:[UIFont fontWithName:@"Raleway-Bold" size:20]];
//    [_uiv_panoramicView addSubview: uil_title];
}

- (void)removePano:(id)sender
{
    if (_uiv_panoramicView) {
        [UIView animateWithDuration:0.2 animations:^{
            _uiv_panoramicView.alpha = 0.0;
        } completion:^(BOOL finished){
            [_uiv_panoramicView removeFromSuperview];
            _uiv_panoramicView = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"unhideHomeButton" object:nil];
        }];
    }
}

#pragma mark - Load FGallery
- (void)openFGallery:(int)index
{
    NSString *galleryTitle = [NSString new];
    for (UIButton *tmp in arr_topBtnArray) {
        if (tmp.selected) {
            galleryTitle = tmp.titleLabel.text;
        }
    }
    
    localImages =  arr_AllImgs;
    localCaptions = [NSArray arrayWithArray:[arr_AlbumCaption subarrayWithRange:NSMakeRange(0, arr_AllImgs.count)]];
    //[self imageViewer:sender];
    UINavigationController *fGalleryNavigationController = [[UINavigationController alloc] init];
    fGalleryNavigationController.view.frame = self.view.frame;
    localGallery = [[FGalleryViewController alloc] initWithPhotoSource:self];
    localGallery.startingIndex = index;
    localGallery.galleryTitle = galleryTitle;
    [fGalleryNavigationController addChildViewController:localGallery];
    [fGalleryNavigationController.view addSubview:localGallery.view];
    [self addChildViewController:fGalleryNavigationController];
    [self.view addSubview:fGalleryNavigationController.view];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideHomeButton" object:nil];
}

// Used in Photos Layout.
// In Photos layout, tap on one thumbnail, photo gallery start at that index
-(void)click2Open:(id)sender inSection:(int)section {
    int rowIndex = (int)[sender tag];
    if (_uib_all.selected) {
        if (rowIndex < arr_AllImgs.count) {
            [self openFGallery:rowIndex];
            return;
        }
        if (rowIndex >= arr_AllImgs.count && rowIndex < (arr_AllPhotos.count + arr_AllImgs.count)) {
            [self loadPanoImage:rowIndex - (int)arr_AllImgs.count];
            return;
        }
        else {
            [self openFilm:rowIndex - (int)arr_AllImgs.count - (int)arr_AllPhotos.count];
            return;
        }
    }
    
    if (_uib_render.selected) {
        [self openFGallery:rowIndex];
    }
    
    if (_uib_photo.selected) {
//        NSLog(@"\n\n PHOTOGRAPHY");
        [self loadPanoImage:rowIndex];
    }
    
    if (_uib_video.selected) {
        [self openFilm:rowIndex];
    }
}

#pragma mark - FGalleryViewControllerDelegate Methods
- (int)numberOfPhotosForPhotoGallery:(FGalleryViewController *)gallery
{
    int num;
    //    if( gallery == localGallery ) {
    //		num = [localImages count];
    //	}
    //	else if( gallery == networkGallery ) {
    //		num = [networkImages count];
    //	}
	num = (int)[localImages count];
	return num;
}

- (FGalleryPhotoSourceType)photoGallery:(FGalleryViewController *)gallery sourceTypeForPhotoAtIndex:(NSUInteger)index
{
	if( gallery == localGallery ) {
		return FGalleryPhotoSourceTypeLocal;
	}
	else return FGalleryPhotoSourceTypeNetwork;
}

- (NSString*)photoGallery:(FGalleryViewController *)gallery captionForPhotoAtIndex:(NSUInteger)index
{
    NSString *caption;
    if( gallery == localGallery ) {
        caption = [localCaptions objectAtIndex:index];
    }
	//    else if( gallery == networkGallery ) {
	//        caption = [networkCaptions objectAtIndex:index];
	//    }
	return caption;
}

- (NSString*)photoGallery:(FGalleryViewController*)gallery filePathForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
    return [localImages objectAtIndex:index];
}

- (void)handleTrashButtonTouch:(id)sender {
    // here we could remove images from our local array storage and tell the gallery to remove that image
    // ex:
    //[localGallery removeImageAtIndex:[localGallery currentIndex]];
}

- (void)handleEditCaptionButtonTouch:(id)sender {
    // here we could implement some code to change the caption for a stored image
}

-(void)imageViewer:(id)sender {
	
    //	UIButton *tmpBtn = (UIButton*)sender;
    //
    //	galleryNameString = tmpBtn.titleLabel.text;
    //	tmpBtn.alpha = 0.6;
    //
    //	GalleryImagesViewController *vc = [[GalleryImagesViewController alloc] initWithGallery:[Gallery galleryNamed:galleryNameString]];
    //	[vc goToPageAtIndex:0 animated:NO];
    //
    //	CATransition* transition = [CATransition animation];
    //	transition.duration = 0.33;
    //	transition.type = kCATransitionFade;
    //	transition.subtype = kCATransitionFromTop;
    //
    //	[self.navigationController.view.layer
    //	 addAnimation:transition forKey:kCATransition];
    //	[self.navigationController pushViewController:vc animated:NO];
}

#pragma mark - Add Help view
- (void)hideAndUnhideHelp:(NSNotification *)pNotification
{
    if (localGallery.galleryID || _uiv_panoramicView) {
        return;
    }
    
    if (_uiv_helpView.onScreen) {
        [UIView animateWithDuration:0.33 animations:^{
            _uiv_helpView.alpha = 0.0;
        } completion:^(BOOL finsihed){
            [_uiv_helpView removeFromSuperview];
            _uiv_helpView = nil;
        }];
    }
    else {
        [self loadHelpViews];
    }
}

- (void)prepareHlepData
{
    [_arr_helpText removeAllObjects];
    _arr_helpText = nil;
    _arr_helpText = [[NSMutableArray alloc] initWithObjects:
                     @"Tap menu button to load main menu.",
                     @"Tap buttons to change sections",
                     @"Tap image to view",
                     nil];
    
    [_arr_helpTargetViews removeAllObjects];
    _arr_helpTargetViews = nil;
    UIButton *homeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 45.0, 45.0)];
    //Top menu Button
    UIView *tmp1 = [[UIView alloc] initWithFrame:CGRectMake(423.0, 0.0, 130.0, 34.0)];
    //Top collection view cell
    UIView *tmp2 = [[UIView alloc] initWithFrame:CGRectMake(204.0, 75.0, 204.0, 285.0)];
    _arr_helpTargetViews = [[NSMutableArray alloc] initWithObjects:homeBtn, tmp1, tmp2, nil];
}

- (void)loadHelpViews
{
    if (_uiv_helpView) {
        [_uiv_helpView removeFromSuperview];
        _uiv_helpView = nil;
    }
    _uiv_helpView = [[xhPopTipsView alloc] initWithFrame:screenRect andText:_arr_helpText andViews:_arr_helpTargetViews];
    [self.view addSubview: _uiv_helpView];
}

#pragma mark - Cleaning memory

- (void)viewWillDisappear:(BOOL)animated
{
    [self clearAllDataCollection];
    
    [_uic_gallery removeFromSuperview];
    _uic_gallery = nil;
    
    [_playerViewController removeFromParentViewController];
    [_playerViewController.view removeFromSuperview];
    _playerViewController = nil;
    
    [localGallery.view removeFromSuperview];
    localGallery.view = nil;
    
    [localGallery removeFromParentViewController];
    localGallery = nil;
    
    localImages = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideAndUnhideHelp" object:nil];
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
