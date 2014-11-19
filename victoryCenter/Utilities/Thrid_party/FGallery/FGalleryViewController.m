//
//  FGalleryViewController.m
//  FGallery
//
//  Created by Grant Davis on 5/19/10.
//  Copyright 2011 Grant Davis Interactive, LLC. All rights reserved.
//

#import "FGalleryViewController.h"
#import "UIColor+Extensions.h"
#import "xhPopTipsView.h"
#define kThumbnailSize 75
#define kThumbnailSpacing 4
#define kCaptionPadding 3
#define kToolbarHeight 60


@interface FGalleryViewController ()

// Help tip view
@property (nonatomic, strong) xhPopTipsView                 *uiv_helpView;
@property (nonatomic, strong) NSMutableArray                *arr_helpText;
@property (nonatomic, strong) NSMutableArray                *arr_helpTargetViews;

// general
- (void)buildViews;
- (void)destroyViews;
- (void)layoutViews;
- (void)moveScrollerToCurrentIndexWithAnimation:(BOOL)animation;
- (void)updateTitle;
- (void)updateButtons;
- (void)layoutButtons;
- (void)updateScrollSize;
- (void)updateCaption;
- (void)resizeImageViewsWithRect:(CGRect)rect;
- (void)resetImageViewZoomLevels;

- (void)enterFullscreen;
- (void)exitFullscreen;
- (void)enableApp;
- (void)disableApp;

- (void)positionInnerContainer;
- (void)positionScroller;
- (void)positionToolbar;
- (void)resizeThumbView;
//- (void)PositionCaption;
// thumbnails
- (void)toggleThumbnailViewWithAnimation:(BOOL)animation;
- (void)showThumbnailViewWithAnimation:(BOOL)animation;
- (void)hideThumbnailViewWithAnimation:(BOOL)animation;
- (void)buildThumbsViewPhotos;

- (void)arrangeThumbs;
- (void)loadAllThumbViewPhotos;

- (void)preloadThumbnailImages;
- (void)unloadFullsizeImageWithIndex:(NSUInteger)index;

- (void)scrollingHasEnded;

- (void)handleSeeAllTouch:(id)sender;
- (void)handleThumbClick:(id)sender;

- (FGalleryPhoto*)createGalleryPhotoForIndex:(NSUInteger)index;

- (void)loadThumbnailImageWithIndex:(NSUInteger)index;
- (void)loadFullsizeImageWithIndex:(NSUInteger)index;

@end



@implementation FGalleryViewController
@synthesize galleryID;
@synthesize photoSource = _photoSource;
@synthesize currentIndex = _currentIndex;
@synthesize thumbsView = _thumbsView;
@synthesize toolBar = _toolbar;
@synthesize useThumbnailView = _useThumbnailView;
@synthesize startingIndex = _startingIndex;
@synthesize beginsInThumbnailView = _beginsInThumbnailView;
@synthesize hideTitle = _hideTitle;
@synthesize galleryTitle = _galleryTitle;

#pragma mark - Public Methods

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if((self = [super initWithNibName:nil bundle:nil])) {
        
		// init gallery id with our memory address
		self.galleryID						= [NSString stringWithFormat:@"%p", self];
        
        // configure view controller
		self.hidesBottomBarWhenPushed		= YES;
        
        // set defaults
        _useThumbnailView                   = YES;
		_prevStatusStyle					= [[UIApplication sharedApplication] statusBarStyle];
        _hideTitle                          = NO;
		
		// create storage objects
		_currentIndex						= 0;
        _startingIndex                      = 0;
		_photoLoaders						= [[NSMutableDictionary alloc] init];
		_photoViews							= [[NSMutableArray alloc] init];
		_photoThumbnailViews				= [[NSMutableArray alloc] init];
		_barItems							= [[NSMutableArray alloc] init];
        
        /*
         // debugging:
         _container.layer.borderColor = [[UIColor yellowColor] CGColor];
         _container.layer.borderWidth = 1.0;
         
         _innerContainer.layer.borderColor = [[UIColor greenColor] CGColor];
         _innerContainer.layer.borderWidth = 1.0;
         
         _scroller.layer.borderColor = [[UIColor redColor] CGColor];
         _scroller.layer.borderWidth = 2.0;
         */
        
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        [[UINavigationBar appearance] setBackgroundColor:[UIColor clearColor]];
//        [self.navigationController.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
        
        [self prepareHlepData];
	}
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideAndUnhideHelp:) name:@"hideAndUnhideHelp" object:nil];
	return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	
	if (self != nil) {
		self.galleryID						= [NSString stringWithFormat:@"%p", self];
		
        // configure view controller
		self.hidesBottomBarWhenPushed		= YES;
        
        // set defaults
        _useThumbnailView                   = YES;
		_prevStatusStyle					= [[UIApplication sharedApplication] statusBarStyle];
        _hideTitle                          = NO;
		
		// create storage objects
		_currentIndex						= 0;
        _startingIndex                      = 0;
		_photoLoaders						= [[NSMutableDictionary alloc] init];
		_photoViews							= [[NSMutableArray alloc] init];
		_photoThumbnailViews				= [[NSMutableArray alloc] init];
		_barItems							= [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (id)initWithPhotoSource:(NSObject<FGalleryViewControllerDelegate>*)photoSrc
{
	if((self = [self initWithNibName:nil bundle:nil])) {
		
		_photoSource = photoSrc;
	}
	return self;
}


- (id)initWithPhotoSource:(NSObject<FGalleryViewControllerDelegate>*)photoSrc barItems:(NSArray*)items
{
	if((self = [self initWithPhotoSource:photoSrc])) {
		
		[_barItems addObjectsFromArray:items];
	}
	return self;
}


- (void)loadView
{
    // create public objects first so they're available for custom configuration right away. positioning comes later.
    _container							= [[UIView alloc] initWithFrame:CGRectZero];
    _innerContainer						= [[UIView alloc] initWithFrame:CGRectZero];
    _scroller							= [[UIScrollView alloc] initWithFrame:CGRectZero];
    _thumbsView							= [[UIScrollView alloc] initWithFrame:CGRectZero];
    _toolbar							= [[UIToolbar alloc] initWithFrame:CGRectZero];
    _captionContainer					= [[UIView alloc] initWithFrame:CGRectZero];
    _caption							= [[UILabel alloc] initWithFrame:CGRectZero];
    _captionBgImg                       = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    _toolbar.barStyle					= UIBarStyleDefault;
    _toolbar.translucent                = YES;
    _toolbar.backgroundColor            = [UIColor clearColor];
    _container.backgroundColor			= [UIColor blackColor];
    
    // listen for container frame changes so we can properly update the layout during auto-rotation or going in and out of fullscreen
    [_container addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    
    // setup scroller
    _scroller.delegate							= self;
    _scroller.pagingEnabled						= YES;
    _scroller.showsVerticalScrollIndicator		= NO;
    _scroller.showsHorizontalScrollIndicator	= NO;
    
    // setup caption
    _captionContainer.backgroundColor			= [UIColor clearColor];
    _captionContainer.hidden					= YES;
    _captionContainer.userInteractionEnabled	= NO;
    _captionContainer.exclusiveTouch			= YES;
    _caption.font								= [UIFont fontWithName:@"Raleway-Medium" size:14.0];
    _caption.textColor							= [UIColor whiteColor];
    _caption.backgroundColor					= [UIColor clearColor];
    _caption.textAlignment						= NSTextAlignmentRight;
    _caption.shadowColor						= [UIColor clearColor];
    _caption.shadowOffset						= CGSizeMake( 1, 1 );
    _captionBgImg.image                         = [UIImage imageNamed:@"grfx_galleryCap.png"];
    
    // make things flexible
    _container.autoresizesSubviews				= NO;
    _innerContainer.autoresizesSubviews			= NO;
    _scroller.autoresizesSubviews				= NO;
    _container.autoresizingMask					= UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // setup thumbs view
    _thumbsView.backgroundColor					= [UIColor whiteColor];
    _thumbsView.hidden							= YES;
    _thumbsView.contentInset					= UIEdgeInsetsMake( kThumbnailSpacing, kThumbnailSpacing, kThumbnailSpacing, kThumbnailSpacing);
    
	// set view
	self.view                                   = _container;
	
	// add items to their containers
    UIImageView *uiiv_galleryBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Lightbox_overlay_BG.png"]];
    uiiv_galleryBg.frame = screenRect;
    [_container addSubview: uiiv_galleryBg];
	[_container addSubview:_innerContainer];
	[_container addSubview:_thumbsView];
	
	[_innerContainer addSubview:_scroller];
//	[_innerContainer addSubview:_toolbar];
	[_innerContainer addSubview:_captionContainer];
    //	[_toolbar addSubview:_captionContainer];
    [_captionContainer addSubview:_captionBgImg];
	[_captionContainer addSubview:_caption];
	
	// create buttons for toolbar
    //	UIImage *leftIcon = [UIImage imageNamed:@"photo-gallery-left.png"];
    //	UIImage *rightIcon = [UIImage imageNamed:@"photo-gallery-right.png"];
    //	_nextButton = [[UIBarButtonItem alloc] initWithImage:rightIcon style:UIBarButtonItemStylePlain target:self action:@selector(next)];
    //	_prevButton = [[UIBarButtonItem alloc] initWithImage:leftIcon style:UIBarButtonItemStylePlain target:self action:@selector(previous)];
    //
    //	// add prev next to front of the array
    //	[_barItems insertObject:_nextButton atIndex:0];
    //	[_barItems insertObject:_prevButton atIndex:0];
    //
    //	_prevNextButtonSize = leftIcon.size.width;
    //
    //	// set buttons on the toolbar.
    //	[_toolbar setItems:_barItems animated:NO];
    
    // build stuff
    [self reloadGallery];
    
    //Init Customized Buttons (Back and See all)
    //    _uib_backButton         = [UIButton buttonWithType:UIButtonTypeSystem];
    //    _uib_backButton.frame = CGRectMake(20.0, 50.0, 100.0, 50.0);
    //    [_uib_backButton setTitle:@"Back" forState:UIControlStateNormal];
    //    [_container addSubview:_uib_backButton];
    //    [_uib_backButton addTarget:self action:@selector(getBack) forControlEvents:UIControlEventTouchDown];
    //
    //    _uib_seeAllButton       = [UIButton buttonWithType:UIButtonTypeSystem];
    //    _uib_seeAllButton.frame = CGRectMake(140.0, 50.0, 100.0, 50.0);
    //    [_uib_seeAllButton setTitle:@"See All" forState:UIControlStateNormal];
    //    [_container addSubview:_uib_seeAllButton];
    //    [_uib_seeAllButton addTarget:self action:@selector(seeThumbs) forControlEvents:UIControlEventTouchDown];
    
    [self enterFullscreen];
    [self setUpTitleLabel];
    
}

- (void)setUpTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(44.0, 0.0, 180.0, 44.0)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.layer.borderWidth = 1.0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor vcDarkBlue];
    titleLabel.font = [UIFont fontWithName:@"Raleway-Medium" size:20];
    titleLabel.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    titleLabel.text = _galleryTitle;
    
    [self.navigationController.navigationBar addSubview: titleLabel];
}

-(void)getBack
{
    //    [self.navigationController popViewControllerAnimated:YES];
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"backToGallery" object:self];

    [self.parentViewController.view removeFromSuperview];
//    [self removeFromParentViewController];
//    [self.view removeFromSuperview];
//    self.view  = nil;
//    self = nil;
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:nil] forBarPosition:UIBarPositionAny
                                              barMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
        [[UINavigationBar appearance] setBackgroundColor:[UIColor clearColor]];
    }
    else
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:nil]  forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"unhideHomeButton" object:nil];
    //[self removeFromParentViewController];
}

-(void)seeThumbs
{
    // show thumb view
    [self toggleThumbnailViewWithAnimation:YES];
    
    // tell thumbs that havent loaded to load
    [self loadAllThumbViewPhotos];
    
    //    [_uib_seeAllButton setTitle:@"Close" forState:UIControlStateNormal];
    //    [_uib_seeAllButton removeTarget:self action:@selector(seeThumbs) forControlEvents:UIControlEventTouchDown];
}

-(void)closeThumbs
{
    
}

- (void)viewDidUnload {
    
    [self destroyViews];
    
    [_barItems release], _barItems = nil;
    [_nextButton release], _nextButton = nil;
    [_prevButton release], _prevButton = nil;
    [_container release], _container = nil;
    [_innerContainer release], _innerContainer = nil;
    [_scroller release], _scroller = nil;
    [_thumbsView release], _thumbsView = nil;
    //    [_toolbar release], _toolbar = nil;
    [_captionContainer release], _captionContainer = nil;
    [_caption release], _caption = nil;
    [_captionBgImg release], _captionBgImg = nil;
    
    [_uib_seeAllButton release], _uib_seeAllButton = nil;
    [_uib_backButton release], _uib_backButton = nil;
    
//    [self.view removeFromSuperview];
//    self.view = nil;
//    
//    [self removeFromParentViewController];
//    self = nil;
    [self dealloc];
    [super viewDidUnload];
}


- (void)destroyViews {
    // remove previous photo views
    for (UIView *view in _photoViews) {
        [view removeFromSuperview];
    }
    [_photoViews removeAllObjects];
    
    // remove previous thumbnails
    for (UIView *view in _photoThumbnailViews) {
        [view removeFromSuperview];
    }
    [_photoThumbnailViews removeAllObjects];
    
    // remove photo loaders
    NSArray *photoKeys = [_photoLoaders allKeys];
    for (int i=0; i<[photoKeys count]; i++) {
        FGalleryPhoto *photoLoader = [_photoLoaders objectForKey:[photoKeys objectAtIndex:i]];
        photoLoader.delegate = nil;
        [photoLoader unloadFullsize];
        [photoLoader unloadThumbnail];
    }
    [_photoLoaders removeAllObjects];
}


- (void)reloadGallery
{
    _currentIndex = _startingIndex;
    _isThumbViewShowing = NO;
    
    // remove the old
    [self destroyViews];
    
    // build the new
    if ([_photoSource numberOfPhotosForPhotoGallery:self] > 0) {
        // create the image views for each photo
        [self buildViews];
        
        // create the thumbnail views
        [self buildThumbsViewPhotos];
        
        // start loading thumbs
        [self preloadThumbnailImages];
        
        // start on first image
        [self gotoImageByIndex:_currentIndex animated:NO];
        
        // layout
        [self layoutViews];
    }
}

- (FGalleryPhoto*)currentPhoto
{
    return [_photoLoaders objectForKey:[NSString stringWithFormat:@"%i", (int)_currentIndex]];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
	self.view.frame = CGRectMake(0.0, 0.0, 1024, 768);
    _isActive = YES;
    
    self.useThumbnailView = _useThumbnailView;
	
    // toggle into the thumb view if we should start there
    if (_beginsInThumbnailView && _useThumbnailView) {
        [self showThumbnailViewWithAnimation:NO];
        [self loadAllThumbViewPhotos];
    }
    
	[self layoutViews];
	
	// update status bar to be see-through
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:animated];
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
	// init with next on first run.
	if( _currentIndex == -1 ) [self next];
	else [self gotoImageByIndex:_currentIndex animated:NO];
	
	// eb addition
	[self exitFullscreen];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults objectForKey:@"firstFGallery"])
    {
        [self performSelector:@selector(loadHelpViews) withObject:nil afterDelay:0.5];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"NO" forKey:@"firstFGallery"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // remove KVO listener
    [_container removeObserver:self forKeyPath:@"frame"];
    
    // Cancel all photo loaders in progress
    NSArray *keys = [_photoLoaders allKeys];
    NSUInteger i, count = [keys count];
    for (i = 0; i < count; i++) {
        FGalleryPhoto *photo = [_photoLoaders objectForKey:[keys objectAtIndex:i]];
        photo.delegate = nil;
        [photo unloadThumbnail];
        [photo unloadFullsize];
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    self.galleryID = nil;
    
    _photoSource = nil;
    
    [_caption release];
    _caption = nil;
    
    [_captionContainer release];
    _captionContainer = nil;
    
    [_container release];
    _container = nil;
    
    [_innerContainer release];
    _innerContainer = nil;
    
    [_toolbar release];
    _toolbar = nil;
    
    [_thumbsView release];
    _thumbsView = nil;
    
    [_scroller release];
    _scroller = nil;
    
    [_photoLoaders removeAllObjects];
    [_photoLoaders release];
    _photoLoaders = nil;
    
    [_barItems removeAllObjects];
    [_barItems release];
    _barItems = nil;
    
    [_photoThumbnailViews removeAllObjects];
    [_photoThumbnailViews release];
    _photoThumbnailViews = nil;
    
    [_photoViews removeAllObjects];
    [_photoViews release];
    _photoViews = nil;
    
    [_nextButton release];
    _nextButton = nil;
    
    [_prevButton release];
    _prevButton = nil;
    
}


- (void)resizeImageViewsWithRect:(CGRect)rect
{
	// resize all the image views
	NSUInteger i, count = [_photoViews count];
	float dx = 0;
	for (i = 0; i < count; i++) {
		FGalleryPhotoView * photoView = [_photoViews objectAtIndex:i];
		photoView.frame = CGRectMake(dx, 0, rect.size.width, rect.size.height );
		dx += rect.size.width;
	}
}


- (void)resetImageViewZoomLevels
{
	// resize all the image views
	NSUInteger i, count = [_photoViews count];
	for (i = 0; i < count; i++) {
		FGalleryPhotoView * photoView = [_photoViews objectAtIndex:i];
		[photoView resetZoom];
	}
}


- (void)removeImageAtIndex:(NSUInteger)index
{
	// remove the image and thumbnail at the specified index.
	FGalleryPhotoView *imgView = [_photoViews objectAtIndex:index];
 	FGalleryPhotoView *thumbView = [_photoThumbnailViews objectAtIndex:index];
	FGalleryPhoto *photo = [_photoLoaders objectForKey:[NSString stringWithFormat:@"%i",(int)index]];
	
	[photo unloadFullsize];
	[photo unloadThumbnail];
	
	[imgView removeFromSuperview];
	[thumbView removeFromSuperview];
	
	[_photoViews removeObjectAtIndex:index];
	[_photoThumbnailViews removeObjectAtIndex:index];
	[_photoLoaders removeObjectForKey:[NSString stringWithFormat:@"%i",(int)index]];
	
	[self layoutViews];
	[self updateButtons];
    [self updateTitle];
}


- (void)next
{
	NSUInteger numberOfPhotos = [_photoSource numberOfPhotosForPhotoGallery:self];
	NSUInteger nextIndex = _currentIndex+1;
	
	// don't continue if we're out of images.
	if( nextIndex <= numberOfPhotos )
	{
		[self gotoImageByIndex:nextIndex animated:NO];
	}
}



- (void)previous
{
	NSUInteger prevIndex = _currentIndex-1;
	[self gotoImageByIndex:prevIndex animated:NO];
}



- (void)gotoImageByIndex:(NSUInteger)index animated:(BOOL)animated
{
	
	NSUInteger numPhotos = [_photoSource numberOfPhotosForPhotoGallery:self];
	
	// constrain index within our limits
    if( index >= numPhotos ) index = numPhotos - 1;
	
	
	if( numPhotos == 0 ) {
		
		// no photos!
		_currentIndex = -1;
	}
	else {
		
		// clear the fullsize image in the old photo
		[self unloadFullsizeImageWithIndex:_currentIndex];
		
		_currentIndex = index;
		[self moveScrollerToCurrentIndexWithAnimation:animated];
		[self updateTitle];
		
		if( !animated )	{
			[self preloadThumbnailImages];
			[self loadFullsizeImageWithIndex:index];
		}
	}
	[self updateButtons];
	[self updateCaption];
}


- (void)layoutViews
{
	[self positionInnerContainer];
	[self positionScroller];
	[self resizeThumbView];
	[self positionToolbar];
	[self updateScrollSize];
	[self updateCaption];
	[self resizeImageViewsWithRect:_scroller.frame];
	[self layoutButtons];
	[self arrangeThumbs];
	[self moveScrollerToCurrentIndexWithAnimation:NO];
    
    [self positionCaption];
}


- (void)setUseThumbnailView:(BOOL)useThumbnailView
{
    
    UIButton *uib_back = [UIButton buttonWithType:UIButtonTypeCustom];
    [uib_back setFrame:CGRectMake(0.0, 0.0, 44.0, 44.0)];
    uib_back.backgroundColor = [UIColor whiteColor];
    [uib_back setImage:[UIImage imageNamed:@"grfx_contactClose.jpg"] forState:UIControlStateNormal];
    [uib_back addTarget:self action:@selector(getBack) forControlEvents:UIControlEventTouchDown];
    [self.navigationController.navigationBar addSubview:uib_back];
    
    
    _useThumbnailView = useThumbnailView;
    if( self.navigationController ) {
        if (_useThumbnailView) {
            _uib_seeAllRightItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"SEE ALL", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(handleSeeAllTouch:)] autorelease];
            [_uib_seeAllRightItem setTitleTextAttributes:@{ NSFontAttributeName: [UIFont fontWithName:@"Raleway-Medium" size:17.0], NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
            UIBarButtonItem *rightSpacer = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                            target:nil action:nil];
            rightSpacer.width = 100;
            //            [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:rightSpacer, _uib_seeAllRightItem, nil] animated:NO];
            //            [self.navigationItem setRightBarButtonItem:btn animated:YES];
            
            _uib_seeAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_uib_seeAllButton setFrame:CGRectMake(780, 17, 150, 20)];
            [_uib_seeAllButton setTitle:@"SEE ALL" forState:UIControlStateNormal];
            _uib_seeAllButton.titleLabel.font = [UIFont fontWithName:@"Raleway-Medium" size:17.0];
            [_uib_seeAllButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_uib_seeAllButton addTarget:self action:@selector(handleSeeAllTouch:) forControlEvents:UIControlEventTouchDown];
//            [self.navigationController.navigationBar addSubview:_uib_seeAllButton];
            
        }
        else {
            [self.navigationItem setRightBarButtonItem:nil animated:NO];
        }
    }
}


#pragma mark - Private Methods

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if([keyPath isEqualToString:@"frame"])
	{
		[self layoutViews];
	}
}


- (void)positionInnerContainer
{
	CGRect screenFrame = [[UIScreen mainScreen] bounds];
	CGRect innerContainerRect;
	
	if( self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown )
	{//portrait
		innerContainerRect = CGRectMake( 0, _container.frame.size.height - screenFrame.size.height, _container.frame.size.width, screenFrame.size.height );
	}
	else
	{// landscape
		innerContainerRect = CGRectMake( 0, _container.frame.size.height - screenFrame.size.width, _container.frame.size.width, screenFrame.size.width );
	}
	
	_innerContainer.frame = innerContainerRect;
}


- (void)positionScroller
{
//	CGRect screenFrame = [[UIScreen mainScreen] bounds];
//	CGRect scrollerRect;
	
//	if( self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown )
//	{//portrait
//		scrollerRect = CGRectMake( 0, 0, screenFrame.size.width, screenFrame.size.height );
//	}
//	else
//	{//landscape
//		scrollerRect = screenRect;
//	}
	
	_scroller.frame = screenRect;
}


- (void)positionToolbar
{
	_toolbar.frame = CGRectMake( 0, _scroller.frame.size.height-kToolbarHeight, _scroller.frame.size.width, kToolbarHeight );
}

- (void)positionCaption
{
    _captionContainer.frame = CGRectMake( 0, _scroller.frame.size.height-kToolbarHeight, _scroller.frame.size.width, kToolbarHeight );
    _captionBgImg.frame = _captionContainer.bounds;
}

- (void)resizeThumbView
{
    int barHeight = 0;
    if (self.navigationController.navigationBar.barStyle == UIBarStyleBlackTranslucent) {
        barHeight = self.navigationController.navigationBar.frame.size.height;
    }
	_thumbsView.frame = CGRectMake( 0, barHeight, _container.frame.size.width, _container.frame.size.height-barHeight );
}


- (void)enterFullscreen
{
    if (!_isThumbViewShowing)
    {
        _isFullscreen = YES;
        
        [self disableApp];
        
        UIApplication* application = [UIApplication sharedApplication];
        if ([application respondsToSelector: @selector(setStatusBarHidden:withAnimation:)]) {
            [[UIApplication sharedApplication] setStatusBarHidden: YES withAnimation: UIStatusBarAnimationFade]; // 3.2+
        } else {
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
            [[UIApplication sharedApplication] setStatusBarHidden: YES animated:YES]; // 2.0 - 3.2
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
        }
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
        [UIView beginAnimations:@"galleryOut" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(enableApp)];
        _toolbar.alpha = 0.0;
        _captionContainer.alpha = 0.0;
        [UIView commitAnimations];
    }
}



- (void)exitFullscreen
{
	_isFullscreen = NO;
    
	[self disableApp];
    
	UIApplication* application = [UIApplication sharedApplication];
	if ([application respondsToSelector: @selector(setStatusBarHidden:withAnimation:)]) {
		[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade]; // 3.2+
	} else {
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
		[[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO]; // 2.0 - 3.2
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
	}
    
	[self.navigationController setNavigationBarHidden:NO animated:YES];
    
	[UIView beginAnimations:@"galleryIn" context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(enableApp)];
	_toolbar.alpha = 1.0;
	_captionContainer.alpha = 1.0;
	[UIView commitAnimations];
}



- (void)enableApp
{
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
}


- (void)disableApp
{
	[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}


- (void)didTapPhotoView:(FGalleryPhotoView*)photoView
{
	// don't change when scrolling
	if( _isScrolling || !_isActive ) return;
	
	// toggle fullscreen.
	if( _isFullscreen == NO ) {
		
		[self enterFullscreen];
	}
	else {
		
		[self exitFullscreen];
	}
    
}


- (void)updateCaption
{
	if([_photoSource numberOfPhotosForPhotoGallery:self] > 0 )
	{
		if([_photoSource respondsToSelector:@selector(photoGallery:captionForPhotoAtIndex:)])
		{
			NSString *caption = [_photoSource photoGallery:self captionForPhotoAtIndex:_currentIndex];
			
			if([caption length] > 0 )
			{
				float captionWidth = _container.frame.size.width-kCaptionPadding*2;
                CGSize textSize = [caption sizeWithAttributes:
                               @{NSFontAttributeName:
                                     _caption.font}];
				NSUInteger numLines = ceilf( textSize.width / captionWidth );
				NSInteger height = ( textSize.height + kCaptionPadding ) * numLines;
				
				_caption.numberOfLines = numLines;
				_caption.text = caption;
				
                //				NSInteger containerHeight = height+kCaptionPadding*2;
                //				_captionContainer.frame = CGRectMake(0, -containerHeight, _container.frame.size.width, containerHeight );
                _captionContainer.frame = CGRectMake( 0, _scroller.frame.size.height-kToolbarHeight, _scroller.frame.size.width, kToolbarHeight );
				_caption.frame = CGRectMake(-125, (kToolbarHeight-height)/2, captionWidth, height );
                
				// show caption bar
				_captionContainer.hidden = NO;
			}
			else {
				
				// hide it if we don't have a caption.
				_captionContainer.hidden = YES;
			}
		}
	}
}


- (void)updateScrollSize
{
	float contentWidth = _scroller.frame.size.width * [_photoSource numberOfPhotosForPhotoGallery:self];
	[_scroller setContentSize:CGSizeMake(contentWidth, 768)];//_scroller.frame.size.height)];
}


- (void)updateTitle
{
    if (!_hideTitle){
        NSString *theTitle = [NSString stringWithFormat:@"%i %@ %i", (int)_currentIndex+1, NSLocalizedString(@"of", @"") , [_photoSource numberOfPhotosForPhotoGallery:self]];
//        [self setTitle:[NSString stringWithFormat:@"%i %@ %i", (int)_currentIndex+1, NSLocalizedString(@"of", @"") , [_photoSource numberOfPhotosForPhotoGallery:self]]];
        
        UILabel* titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(472, 13, 80, 30)];
        titleLabel.text = theTitle;
//        titleLabel.text=self.navigationItem.title;
        titleLabel.textColor=[UIColor whiteColor];
        titleLabel.backgroundColor =[UIColor vcDarkBlue];
        titleLabel.adjustsFontSizeToFitWidth=YES;
        titleLabel.textAlignment= NSTextAlignmentCenter;
//        [titleLabel sizeToFit];
        titleLabel.font = [UIFont fontWithName:@"Raleway-Bold" size:16.0];
        [self.navigationController.navigationBar addSubview: titleLabel];
//        [self.view addSubview: titleLabel];
//        self.navigationItem.titleView=titleLabel;
//        CGFloat verticalOffset = 3;
//        [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:verticalOffset forBarMetrics:UIBarMetricsDefault];
        
    }else{
        [self setTitle:@""];
    }
}


- (void)updateButtons
{
	_prevButton.enabled = ( _currentIndex <= 0 ) ? NO : YES;
	_nextButton.enabled = ( _currentIndex >= [_photoSource numberOfPhotosForPhotoGallery:self]-1 ) ? NO : YES;
}


- (void)layoutButtons
{
	NSUInteger buttonWidth = roundf( _toolbar.frame.size.width / [_barItems count] - _prevNextButtonSize * .5);
	
	// loop through all the button items and give them the same width
	NSUInteger i, count = [_barItems count];
	for (i = 0; i < count; i++) {
		UIBarButtonItem *btn = [_barItems objectAtIndex:i];
		btn.width = buttonWidth;
	}
	[_toolbar setNeedsLayout];
}


- (void)moveScrollerToCurrentIndexWithAnimation:(BOOL)animation
{
	int xp = _scroller.frame.size.width * _currentIndex;
	[_scroller scrollRectToVisible:CGRectMake(xp, 0, _scroller.frame.size.width, _scroller.frame.size.height) animated:animation];
	_isScrolling = animation;
}


// creates all the image views for this gallery
- (void)buildViews
{
	NSUInteger i, count = [_photoSource numberOfPhotosForPhotoGallery:self];
	for (i = 0; i < count; i++) {
		FGalleryPhotoView *photoView = [[FGalleryPhotoView alloc] initWithFrame:CGRectZero];
		photoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		photoView.autoresizesSubviews = YES;
		photoView.photoDelegate = self;
		[_scroller addSubview:photoView];
		[_photoViews addObject:photoView];
		[photoView release];
	}
}


- (void)buildThumbsViewPhotos
{
	NSUInteger i, count = [_photoSource numberOfPhotosForPhotoGallery:self];
	for (i = 0; i < count; i++) {
		
		FGalleryPhotoView *thumbView = [[FGalleryPhotoView alloc] initWithFrame:CGRectZero target:self action:@selector(handleThumbClick:)];
		[thumbView setContentMode:UIViewContentModeScaleAspectFill];
		[thumbView setClipsToBounds:YES];
		[thumbView setTag:i];
		[_thumbsView addSubview:thumbView];
		[_photoThumbnailViews addObject:thumbView];
		[thumbView release];
	}
}



- (void)arrangeThumbs
{
	float dx = 0.0;
	float dy = 49.0;
	// loop through all thumbs to size and place them
	NSUInteger i, count = [_photoThumbnailViews count];
	for (i = 0; i < count; i++) {
		FGalleryPhotoView *thumbView = [_photoThumbnailViews objectAtIndex:i];
		[thumbView setBackgroundColor:[UIColor grayColor]];
		
		// create new frame
		thumbView.frame = CGRectMake( dx, dy, kThumbnailSize, kThumbnailSize);
		
		// increment position
		dx += kThumbnailSize + kThumbnailSpacing;
		
		// check if we need to move to a different row
		if( dx + kThumbnailSize + kThumbnailSpacing > _thumbsView.frame.size.width - kThumbnailSpacing )
		{
			dx = 0.0;
			dy += kThumbnailSize + kThumbnailSpacing;
		}
	}
	
	// set the content size of the thumb scroller
	[_thumbsView setContentSize:CGSizeMake( _thumbsView.frame.size.width - ( kThumbnailSpacing*2 ), dy + kThumbnailSize + kThumbnailSpacing )];
}


- (void)toggleThumbnailViewWithAnimation:(BOOL)animation
{
    if (_isThumbViewShowing) {
        [self hideThumbnailViewWithAnimation:animation];
    }
    else {
        [self showThumbnailViewWithAnimation:animation];
    }
}


- (void)showThumbnailViewWithAnimation:(BOOL)animation
{
    _isThumbViewShowing = YES;
    
    [self arrangeThumbs];
    
    //    [self.navigationItem.rightBarButtonItem setTitle:NSLocalizedString(@"CLOSE", @"")];
    //    [_uib_seeAllRightItem setTitle:NSLocalizedString(@"CLOSE", @"")];
    [_uib_seeAllButton setTitle:@"CLOSE" forState:UIControlStateNormal];
    if (animation) {
        // do curl animation
        [UIView beginAnimations:@"uncurl" context:nil];
        [UIView setAnimationDuration:.666];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_thumbsView cache:YES];
        [_thumbsView setHidden:NO];
        [UIView commitAnimations];
    }
    else {
        [_thumbsView setHidden:NO];
    }
}


- (void)hideThumbnailViewWithAnimation:(BOOL)animation
{
    _isThumbViewShowing = NO;
    //    [self.navigationItem.rightBarButtonItem setTitle:NSLocalizedString(@"SEE ALL", @"")];
    //    [_uib_seeAllRightItem setTitle:NSLocalizedString(@"SEE ALL", @"")];
    [_uib_seeAllButton setTitle:@"SEE ALL" forState:UIControlStateNormal];
    if (animation) {
        // do curl animation
        [UIView beginAnimations:@"curl" context:nil];
        [UIView setAnimationDuration:.666];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:_thumbsView cache:YES];
        [_thumbsView setHidden:YES];
        [UIView commitAnimations];
    }
    else {
        [_thumbsView setHidden:NO];
    }
}


- (void)handleSeeAllTouch:(id)sender
{
	// show thumb view
	[self toggleThumbnailViewWithAnimation:YES];
	
	// tell thumbs that havent loaded to load
	[self loadAllThumbViewPhotos];
}


- (void)handleThumbClick:(id)sender
{
	FGalleryPhotoView *photoView = (FGalleryPhotoView*)[(UIButton*)sender superview];
	[self hideThumbnailViewWithAnimation:YES];
	[self gotoImageByIndex:photoView.tag animated:NO];
}


#pragma mark - Image Loading


- (void)preloadThumbnailImages
{
	NSUInteger index = _currentIndex;
	NSUInteger count = [_photoViews count];
    
	// make sure the images surrounding the current index have thumbs loading
	NSUInteger nextIndex = index + 1;
	NSUInteger prevIndex = index - 1;
	
	// the preload count indicates how many images surrounding the current photo will get preloaded.
	// a value of 2 at maximum would preload 4 images, 2 in front of and two behind the current image.
	NSUInteger preloadCount = 1;
	
	FGalleryPhoto *photo;
	
	// check to see if the current image thumb has been loaded
	photo = [_photoLoaders objectForKey:[NSString stringWithFormat:@"%i", (int)index]];
	
	if( !photo )
	{
		[self loadThumbnailImageWithIndex:index];
		photo = [_photoLoaders objectForKey:[NSString stringWithFormat:@"%i", (int)index]];
	}
	
	if( !photo.hasThumbLoaded && !photo.isThumbLoading )
	{
		[photo loadThumbnail];
	}
	
	NSUInteger curIndex = prevIndex;
	while( curIndex > -1 && curIndex > prevIndex - preloadCount )
	{
		photo = [_photoLoaders objectForKey:[NSString stringWithFormat:@"%i", (int)curIndex]];
		
		if( !photo ) {
			[self loadThumbnailImageWithIndex:curIndex];
			photo = [_photoLoaders objectForKey:[NSString stringWithFormat:@"%i", (int)curIndex]];
		}
		
		if( !photo.hasThumbLoaded && !photo.isThumbLoading )
		{
			[photo loadThumbnail];
		}
		
		curIndex--;
	}
	
	curIndex = nextIndex;
	while( curIndex < count && curIndex < nextIndex + preloadCount )
	{
		photo = [_photoLoaders objectForKey:[NSString stringWithFormat:@"%i", (int)curIndex]];
		
		if( !photo ) {
			[self loadThumbnailImageWithIndex:curIndex];
			photo = [_photoLoaders objectForKey:[NSString stringWithFormat:@"%i", (int)curIndex]];
		}
		
		if( !photo.hasThumbLoaded && !photo.isThumbLoading )
		{
			[photo loadThumbnail];
		}
		
		curIndex++;
	}
}


- (void)loadAllThumbViewPhotos
{
	NSUInteger i, count = [_photoSource numberOfPhotosForPhotoGallery:self];
	for (i=0; i < count; i++) {
		
		[self loadThumbnailImageWithIndex:i];
	}
}


- (void)loadThumbnailImageWithIndex:(NSUInteger)index
{
	FGalleryPhoto *photo = [_photoLoaders objectForKey:[NSString stringWithFormat:@"%i", (int)index]];
	
	if( photo == nil )
		photo = [self createGalleryPhotoForIndex:index];
	
	[photo loadThumbnail];
}


- (void)loadFullsizeImageWithIndex:(NSUInteger)index
{
	FGalleryPhoto *photo = [_photoLoaders objectForKey:[NSString stringWithFormat:@"%i", (int)index]];
	
	if( photo == nil )
		photo = [self createGalleryPhotoForIndex:index];
	
	[photo loadFullsize];
}


- (void)unloadFullsizeImageWithIndex:(NSUInteger)index
{
	if (index < [_photoViews count]) {
		FGalleryPhoto *loader = [_photoLoaders objectForKey:[NSString stringWithFormat:@"%i", (int)index]];
		[loader unloadFullsize];
		
		FGalleryPhotoView *photoView = [_photoViews objectAtIndex:index];
		photoView.imageView.image = loader.thumbnail;
	}
}


- (FGalleryPhoto*)createGalleryPhotoForIndex:(NSUInteger)index
{
	FGalleryPhotoSourceType sourceType = [_photoSource photoGallery:self sourceTypeForPhotoAtIndex:index];
	FGalleryPhoto *photo;
	NSString *thumbPath;
	NSString *fullsizePath;
	
	if( sourceType == FGalleryPhotoSourceTypeLocal )
	{
		thumbPath = [_photoSource photoGallery:self filePathForPhotoSize:FGalleryPhotoSizeThumbnail atIndex:index];
		fullsizePath = [_photoSource photoGallery:self filePathForPhotoSize:FGalleryPhotoSizeFullsize atIndex:index];
		photo = [[[FGalleryPhoto alloc] initWithThumbnailPath:thumbPath fullsizePath:fullsizePath delegate:self] autorelease];
	}
	else if( sourceType == FGalleryPhotoSourceTypeNetwork )
	{
		thumbPath = [_photoSource photoGallery:self urlForPhotoSize:FGalleryPhotoSizeThumbnail atIndex:index];
		fullsizePath = [_photoSource photoGallery:self urlForPhotoSize:FGalleryPhotoSizeFullsize atIndex:index];
		photo = [[[FGalleryPhoto alloc] initWithThumbnailUrl:thumbPath fullsizeUrl:fullsizePath delegate:self] autorelease];
	}
	else
	{
		// invalid source type, throw an error.
		[NSException raise:@"Invalid photo source type" format:@"The specified source type of %d is invalid", sourceType];
	}
    
	// assign the photo index
	photo.tag = index;
	
	// store it
	[_photoLoaders setObject:photo forKey: [NSString stringWithFormat:@"%i", (int)index]];
	
	return photo;
}


- (void)scrollingHasEnded {
	
	_isScrolling = NO;
	
	NSUInteger newIndex = floor( _scroller.contentOffset.x / _scroller.frame.size.width );
	
	// don't proceed if the user has been scrolling, but didn't really go anywhere.
	if( newIndex == _currentIndex )
		return;
	
	// clear previous
	[self unloadFullsizeImageWithIndex:_currentIndex];
	
	_currentIndex = newIndex;
	[self updateCaption];
	[self updateTitle];
	[self updateButtons];
	[self loadFullsizeImageWithIndex:_currentIndex];
	[self preloadThumbnailImages];
}


#pragma mark - FGalleryPhoto Delegate Methods


- (void)galleryPhoto:(FGalleryPhoto*)photo willLoadThumbnailFromPath:(NSString*)path
{
	// show activity indicator for large photo view
	FGalleryPhotoView *photoView = [_photoViews objectAtIndex:photo.tag];
	[photoView.activity startAnimating];
	
	// show activity indicator for thumbail
	if( _isThumbViewShowing ) {
		FGalleryPhotoView *thumb = [_photoThumbnailViews objectAtIndex:photo.tag];
		[thumb.activity startAnimating];
	}
}


- (void)galleryPhoto:(FGalleryPhoto*)photo willLoadThumbnailFromUrl:(NSString*)url
{
	// show activity indicator for large photo view
	FGalleryPhotoView *photoView = [_photoViews objectAtIndex:photo.tag];
	[photoView.activity startAnimating];
	
	// show activity indicator for thumbail
	if( _isThumbViewShowing ) {
		FGalleryPhotoView *thumb = [_photoThumbnailViews objectAtIndex:photo.tag];
		[thumb.activity startAnimating];
	}
}


- (void)galleryPhoto:(FGalleryPhoto*)photo didLoadThumbnail:(UIImage*)image
{
	// grab the associated image view
	FGalleryPhotoView *photoView = [_photoViews objectAtIndex:photo.tag];
	
	// if the gallery photo hasn't loaded the fullsize yet, set the thumbnail as its image.
	if( !photo.hasFullsizeLoaded )
		photoView.imageView.image = photo.thumbnail;
    
	[photoView.activity stopAnimating];
	
	// grab the thumbail view and set its image
	FGalleryPhotoView *thumbView = [_photoThumbnailViews objectAtIndex:photo.tag];
	thumbView.imageView.image = image;
	[thumbView.activity stopAnimating];
}



- (void)galleryPhoto:(FGalleryPhoto*)photo didLoadFullsize:(UIImage*)image
{
	// only set the fullsize image if we're currently on that image
	if( _currentIndex == photo.tag )
	{
		FGalleryPhotoView *photoView = [_photoViews objectAtIndex:photo.tag];
		photoView.imageView.image = photo.fullsize;
	}
	// otherwise, we don't need to keep this image around
	else [photo unloadFullsize];
}


#pragma mark - UIScrollView Methods


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	_isScrolling = YES;
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	if( !decelerate )
	{
		[self scrollingHasEnded];
		//if (!_isFullscreen) {
        [self enterFullscreen];
		//}
	}
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	[self scrollingHasEnded];
}

#pragma mark - Add Help view
- (void)hideAndUnhideHelp:(NSNotification *)pNotification
{
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
                     @"Tap close button to retun gallery",
                     @"Current page number. Swipe to load more",
                     @"Double tap or pinch to zoom the image",
                     nil];
    
    [_arr_helpTargetViews removeAllObjects];
    _arr_helpTargetViews = nil;
    UIButton *homeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 45.0, 45.0)];
    UIView *tmp1 = [[UIView alloc] initWithFrame:CGRectMake(512, 50, 1, 1)];
    UIView *tmp2 = [[UIView alloc] initWithFrame:CGRectMake(512, 384, 1, 1)];
    _arr_helpTargetViews = [[NSMutableArray alloc] initWithObjects:homeBtn, tmp1, tmp2,nil];
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
#pragma mark - Memory Management Methods

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
	
	NSLog(@"[FGalleryViewController] didReceiveMemoryWarning! clearing out cached images...");
	// unload fullsize and thumbnail images for all our images except at the current index.
	NSArray *keys = [_photoLoaders allKeys];
	NSUInteger i, count = [keys count];
    if (_isThumbViewShowing==YES) {
        for (i = 0; i < count; i++)
        {
            FGalleryPhoto *photo = [_photoLoaders objectForKey:[keys objectAtIndex:i]];
            [photo unloadFullsize];
            
            // unload main image thumb
            FGalleryPhotoView *photoView = [_photoViews objectAtIndex:i];
            photoView.imageView.image = nil;
        }
    } else {
        for (i = 0; i < count; i++)
        {
            if( i != _currentIndex )
            {
                FGalleryPhoto *photo = [_photoLoaders objectForKey:[keys objectAtIndex:i]];
                [photo unloadFullsize];
                [photo unloadThumbnail];
                
                // unload main image thumb
                FGalleryPhotoView *photoView = [_photoViews objectAtIndex:i];
                photoView.imageView.image = nil;
                
                // unload thumb tile
                photoView = [_photoThumbnailViews objectAtIndex:i];
                photoView.imageView.image = nil;
            }
        }
    }
}

- (void)dealloc {
	
//	// remove KVO listener
//	[_container removeObserver:self forKeyPath:@"frame"];
//	
//	// Cancel all photo loaders in progress
//	NSArray *keys = [_photoLoaders allKeys];
//	NSUInteger i, count = [keys count];
//	for (i = 0; i < count; i++) {
//		FGalleryPhoto *photo = [_photoLoaders objectForKey:[keys objectAtIndex:i]];
//		photo.delegate = nil;
//		[photo unloadThumbnail];
//		[photo unloadFullsize];
//	}
//	
//	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//	
////	self.galleryID = nil;
//	
//	_photoSource = nil;
//	
//    [_caption release];
//    _caption = nil;
//	
//    [_captionContainer release];
//    _captionContainer = nil;
//	
//    [_container release];
//    _container = nil;
//	
//    [_innerContainer release];
//    _innerContainer = nil;
//	
//    [_toolbar release];
//    _toolbar = nil;
//	
//    [_thumbsView release];
//    _thumbsView = nil;
//	
//    [_scroller release];
//    _scroller = nil;
//	
//	[_photoLoaders removeAllObjects];
//    [_photoLoaders release];
//    _photoLoaders = nil;
//	
//	[_barItems removeAllObjects];
//	[_barItems release];
//	_barItems = nil;
//	
//	[_photoThumbnailViews removeAllObjects];
//    [_photoThumbnailViews release];
//    _photoThumbnailViews = nil;
//	
//	[_photoViews removeAllObjects];
//    [_photoViews release];
//    _photoViews = nil;
//	
//    [_nextButton release];
//    _nextButton = nil;
//	
//    [_prevButton release];
//    _prevButton = nil;
//    
    [super dealloc];
}


@end


/**
 *	This section overrides the auto-rotate methods for UINaviationController and UITabBarController
 *	to allow the tab bar to rotate only when a FGalleryController is the visible controller. Sweet.
 */

@implementation UINavigationController (FGallery)

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if([self.visibleViewController isKindOfClass:[FGalleryViewController class]])
	{
        return YES;
	}
    
	// To preserve the UINavigationController's defined behavior,
	// walk its stack.  If all of the view controllers in the stack
	// agree they can rotate to the given orientation, then allow it.
	BOOL supported = YES;
	for(UIViewController *sub in self.viewControllers)
	{
		if(![sub shouldAutorotateToInterfaceOrientation:interfaceOrientation])
		{
			supported = NO;
			break;
		}
	}
	if(supported)
		return YES;
	
	// we need to support at least one type of auto-rotation we'll get warnings.
	// so, we'll just support the basic portrait.
	return ( interfaceOrientation == UIInterfaceOrientationPortrait ) ? YES : NO;
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	// see if the current controller in the stack is a gallery
	if([self.visibleViewController isKindOfClass:[FGalleryViewController class]])
	{
		FGalleryViewController *galleryController = (FGalleryViewController*)self.visibleViewController;
		[galleryController resetImageViewZoomLevels];
	}
}

@end




@implementation UITabBarController (FGallery)


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // only return yes if we're looking at the gallery
    if( [self.selectedViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *navController = (UINavigationController*)self.selectedViewController;
        
        // see if the current controller in the stack is a gallery
        if([navController.visibleViewController isKindOfClass:[FGalleryViewController class]])
        {
            return YES;
        }
    }
	
	// we need to support at least one type of auto-rotation we'll get warnings.
	// so, we'll just support the basic portrait.
	return ( interfaceOrientation == UIInterfaceOrientationPortrait ) ? YES : NO;
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	if([self.selectedViewController isKindOfClass:[UINavigationController class]])
	{
		UINavigationController *navController = (UINavigationController*)self.selectedViewController;
		
		// see if the current controller in the stack is a gallery
		if([navController.visibleViewController isKindOfClass:[FGalleryViewController class]])
		{
			FGalleryViewController *galleryController = (FGalleryViewController*)navController.visibleViewController;
			[galleryController resetImageViewZoomLevels];
		}
	}
}

@end



