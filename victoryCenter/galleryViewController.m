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

@interface galleryViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
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
    NSMutableArray          *arr_AllFlms;
}
@property (weak, nonatomic) IBOutlet UIButton               *uib_all;
@property (weak, nonatomic) IBOutlet UIButton               *uib_render;
@property (weak, nonatomic) IBOutlet UIButton               *uib_photo;
@property (weak, nonatomic) IBOutlet UIButton               *uib_video;
@property (weak, nonatomic) IBOutlet UICollectionView       *uic_gallery;

@end

@implementation galleryViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = screenRect;
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
    [_uib_all setTitle:@"ALL" forState:UIControlStateNormal];
    [_uib_all setTitle:@"ALL" forState:UIControlStateSelected];
    [_uib_all setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_all setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_uib_all.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14]];
    _uib_all.backgroundColor = [UIColor vcDarkBlue];
    _uib_all.selected = YES;
    _uib_all.tag = 1;
    [_uib_all addTarget:self action:@selector(tapOnTopBtns:) forControlEvents:UIControlEventTouchUpInside];
    
    [_uib_render setTitle:@"RENDERING" forState:UIControlStateNormal];
    [_uib_render setTitle:@"RENDERING" forState:UIControlStateSelected];
    [_uib_render setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_render setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_uib_render.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14]];
    _uib_render.backgroundColor = [UIColor vcLightBlue];
    _uib_render.selected = NO;
    _uib_render.tag = 2;
    [_uib_render addTarget:self action:@selector(tapOnTopBtns:) forControlEvents:UIControlEventTouchUpInside];
    
    [_uib_photo setTitle:@"PHOTOGRAPHY" forState:UIControlStateNormal];
    [_uib_photo setTitle:@"PHOTOGRAPHY" forState:UIControlStateSelected];
    [_uib_photo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_photo setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_uib_photo.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14]];
    _uib_photo.backgroundColor = [UIColor vcLightBlue];
    _uib_photo.selected = NO;
    _uib_photo.tag = 3;
    [_uib_photo addTarget:self action:@selector(tapOnTopBtns:) forControlEvents:UIControlEventTouchUpInside];
    
    [_uib_video setTitle:@"VIDEO" forState:UIControlStateNormal];
    [_uib_video setTitle:@"VIDEO" forState:UIControlStateSelected];
    [_uib_video setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uib_video setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_uib_video.titleLabel setFont:[UIFont fontWithName:@"Raleway-Bold" size:14]];
    _uib_video.backgroundColor = [UIColor vcLightBlue];
    _uib_video.selected = NO;
    _uib_video.tag = 4;
    [_uib_video addTarget:self action:@selector(tapOnTopBtns:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tapOnTopBtns:(id)sender
{
    UIButton *tappedBtn = sender;
    _uib_all.selected = NO;
    _uib_render.selected = NO;
    _uib_photo.selected = NO;
    _uib_video.selected = NO;
    [_uib_all setBackgroundColor:[UIColor vcLightBlue]];
    [_uib_render setBackgroundColor:[UIColor vcLightBlue]];
    [_uib_photo setBackgroundColor:[UIColor vcLightBlue]];
    [_uib_video setBackgroundColor:[UIColor vcLightBlue]];
    
    tappedBtn.selected = YES;
    tappedBtn.backgroundColor = [UIColor vcDarkBlue];
    
    int index = (int)tappedBtn.tag;
    [self updateGalleryData:index];
    
    [_uic_gallery reloadData];
	[_uic_gallery performBatchUpdates:^{
		[_uic_gallery reloadSections:[NSIndexSet indexSetWithIndex:0]];
	} completion:nil];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(285, 285)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
	[_uic_gallery setCollectionViewLayout:flowLayout animated:YES];
    [_uic_gallery scrollRectToVisible:CGRectMake(0.0, 0.0, _uic_gallery.frame.size.width, _uic_gallery.frame.size.height) animated:YES];
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
    [self updateGalleryData:1];//Init with all items of gallery
    [_uic_gallery reloadData];
}

- (void)updateGalleryData:(int)index
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
    [arr_AllFlms removeAllObjects];
    arr_AllFlms = nil;
    arr_AllImgs = [[NSMutableArray alloc] init];
    arr_AllFlms = [[NSMutableArray alloc] init];
    
    NSDictionary *raw_Dict = [[NSDictionary alloc] initWithDictionary:[arr_AlbumData objectAtIndex:0]];
    NSMutableArray *arr_secInfo = [[NSMutableArray alloc] initWithArray:[raw_Dict objectForKey:@"sectioninfo"]];
    switch (index) {
        case 1: { // All Items
            for (int i = 0; i < [arr_secInfo count]; i++) {
                NSDictionary *itemDic = [[NSDictionary alloc] initWithDictionary:arr_secInfo[i]];
                [self addItemsAndFramesAndCapions:itemDic];
            }
            break;
        }
        case 2: { // Renderings
            for (int i = 0; i < [arr_secInfo count]; i++) {
                NSDictionary *itemDic = [[NSDictionary alloc] initWithDictionary:arr_secInfo[i]];
                // Check the category is "rendering" or not
                if ([[itemDic objectForKey:@"category"] isEqualToString:@"rendering"]) {
                    [self addItemsAndFramesAndCapions:itemDic];
                }
            }
            break;
        }
        case 3: { // Photography
            for (int i = 0; i < [arr_secInfo count]; i++) {
                NSDictionary *itemDic = [[NSDictionary alloc] initWithDictionary:arr_secInfo[i]];
                // Check the category is "phototgraphy" or not
                if ([[itemDic objectForKey:@"category"] isEqualToString:@"photography"]) {
                    [self addItemsAndFramesAndCapions:itemDic];
                }
            }
            break;
        }
        case 4: { // Video
            for (int i = 0; i < [arr_secInfo count]; i++) {
                NSDictionary *itemDic = [[NSDictionary alloc] initWithDictionary:arr_secInfo[i]];
                // Check the category is "video" or not
                if ([[itemDic objectForKey:@"category"] isEqualToString:@"video"]) {
                    [self addItemsAndFramesAndCapions:itemDic];
                }
            }
            break;
        }
        default:
            break;
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
    if ([[itemDic objectForKey:@"albumtype"] isEqualToString:@"film"]) {
        [arr_AllFlms addObjectsFromArray:[itemDic objectForKey:@"items"]];
    }
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
    galleryImageCell.cellThumb.image = [UIImage imageNamed:[arr_AlbumItems objectAtIndex:indexPath.item]];
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
    NSString *name = [oldfileName substringWithRange:NSMakeRange(0, oldfileName.length-3)];
    NSString *newFileName = [NSString stringWithFormat:@"%@mov",name];
    NSLog(@"The film file's name is %@", newFileName);
}

- (void)openFGallery:(int)index
{
    localImages =  arr_AllImgs;
    localCaptions = [NSArray arrayWithArray:[arr_AlbumCaption subarrayWithRange:NSMakeRange(0, arr_AllImgs.count-1)]];
    //[self imageViewer:sender];
    UINavigationController *fGalleryNavigationController = [[UINavigationController alloc] init];
    fGalleryNavigationController.view.frame = self.view.frame;
    localGallery = [[FGalleryViewController alloc] initWithPhotoSource:self];
    localGallery.startingIndex = index;
    [fGalleryNavigationController addChildViewController:localGallery];
    [fGalleryNavigationController.view addSubview:localGallery.view];
    [self addChildViewController:fGalleryNavigationController];
    [self.view addSubview:fGalleryNavigationController.view];
}

// Used in Photos Layout.
// In Photos layout, tap on one thumbnail, photo gallery start at that index
-(void)click2Open:(id)sender inSection:(int)section {
    
    int rowIndex = (int)[sender tag];
    if (arr_AllImgs.count == 0) {
        [self openFilm:rowIndex];
    }
    else {
        if (rowIndex < arr_AllImgs.count) {
            [self openFGallery:rowIndex];
        }
        else {
            [self openFilm:(rowIndex - arr_AllImgs.count)];
        }
    }
	return;
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
	num = [localImages count];
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
