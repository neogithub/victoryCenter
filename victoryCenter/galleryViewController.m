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
}

#pragma mark - Set top buttons
- (void)setTopButtons
{
    arr_topBtnArray = [[NSMutableArray alloc] init];
    
    [self initTopBtn:_uib_all withTitle:@"ALL" andTag:4 andSelected:NO];
    [self initTopBtn:_uib_render withTitle:@"RENDERING" andTag:1 andSelected:YES];
    [self initTopBtn:_uib_photo withTitle:@"VIEWS" andTag:2 andSelected:NO];
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
    [flowLayout setMinimumLineSpacing:22.0];
    [flowLayout setMinimumInteritemSpacing:22.0];
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
    NSString *extension = [NSString new];
    if (index == 1) {
        extension = @"mov";
    }
    else {
        extension = @"mp4";
    }
    
    NSString *name = [oldfileName substringWithRange:NSMakeRange(0, oldfileName.length-4)];
    NSString *url = [[NSBundle mainBundle]
                     pathForResource:name
                     ofType:extension];
    
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:url, @"movieName", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playGalleryMovie" object:nil userInfo:dictionary];
}

#pragma mark Prepare Pano image

- (void)loadPanoImage:(int)index
{
    if (_uiv_panoramicView) {
        [_uiv_panoramicView removeFromSuperview];
        _uiv_panoramicView = nil;
    }
    NSString *imageName = [arr_AllPhotos objectAtIndex: index];
    if (imageName) {
        _uiv_panoramicView = [[xhPanoramicView alloc] initWithFrame:self.view.bounds andImageName:imageName andDirection:NO];
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

#pragma mark Load FGallery
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
    
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:arr_AllImgs, @"images", localCaptions, @"caption", [NSNumber numberWithInt:index], @"startIndex", galleryTitle, @"title", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadFGallery" object:nil userInfo:dictionary];
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
                     @"Tap to load main menu",
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
