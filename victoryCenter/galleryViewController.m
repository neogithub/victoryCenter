//
//  galleryViewController.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/24/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "galleryViewController.h"
#import "galleryCVCell.h"

@interface galleryViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    // gallery
	NSString                *secTitle;
	NSDictionary            *albumDict;
    int                     sectionIndex;
    NSMutableArray          *arr_AlbumData;
}

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
}

#pragma mark - Collection Delegate Methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return arr_AlbumData.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDictionary *raw_Dict = [[NSDictionary alloc] initWithDictionary:[arr_AlbumData objectAtIndex:section]];
    NSMutableArray *arr_secInfo = [[NSMutableArray alloc] initWithArray:[raw_Dict objectForKey:@"sectioninfo"]];
    int sumOfItems = 0;
    NSString *typeOfFile = [[NSString alloc] init];
    
    for (int i = 0; i < [arr_secInfo count]; i++) {
        NSDictionary *itemDic = [[NSDictionary alloc] initWithDictionary:arr_secInfo[i]];
        typeOfFile = [itemDic objectForKey:@"albumtype"];
        if ([typeOfFile isEqualToString:@"image"]) {
            NSMutableArray *imgArray = [[NSMutableArray alloc] initWithArray:[itemDic objectForKey:@"images"]];
            sumOfItems = sumOfItems + [imgArray count];
        }
        else
        {
            sumOfItems++;
        }
        
    }
    return sumOfItems;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    galleryCVCell *galleryImageCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"cvCell"
                                    forIndexPath:indexPath];
    NSDictionary *tempDic = [[NSDictionary alloc] initWithDictionary:[arr_AlbumData objectAtIndex:indexPath.section]];
    NSMutableArray *secInfo = [[NSMutableArray alloc] initWithArray:[tempDic objectForKey:@"sectioninfo"]];
    
    NSMutableArray *totalImg = [[NSMutableArray alloc] init];
    NSMutableArray *totalCap = [[NSMutableArray alloc] init];
    NSMutableArray *totalFrm = [[NSMutableArray alloc] init];
    
    NSString *typeOfCell = [[NSString alloc] init];
    
    for (int i = 0; i < [secInfo count]; i++) {
        NSDictionary *itemDic = [[NSDictionary alloc] initWithDictionary:[secInfo objectAtIndex:i]];
        typeOfCell = [itemDic objectForKey:@"albumtype"];
        
        if ([typeOfCell isEqualToString:@"image"]) {
            NSMutableArray *imgArray = [[NSMutableArray alloc] initWithArray:[itemDic objectForKey:@"images"]];
            NSMutableArray *capArray = [[NSMutableArray alloc] initWithArray:[itemDic objectForKey:@"captions"]];
            NSMutableArray *frmArray = [[NSMutableArray alloc] initWithArray:[itemDic objectForKey:@"frame"]];
            [totalImg addObjectsFromArray:imgArray];
            [totalCap addObjectsFromArray:capArray];
            [totalFrm addObjectsFromArray:frmArray];
        }
        else
        {
            [totalImg addObject:[itemDic objectForKey:@"albumthumb"]];
            [totalCap addObject:[itemDic objectForKey:@"albumcaption"]];
            [totalFrm addObject:[itemDic objectForKey:@"albumframe"]];
        }
        
    }

    
    
    galleryImageCell.titleLabel.text = [totalCap objectAtIndex:indexPath.item];
    galleryImageCell.titleLabel.font = [UIFont fontWithName:@"Raleway-Medium" size:15];
    galleryImageCell.cellThumb.image = [UIImage imageNamed:[totalImg objectAtIndex:indexPath.item]];
    galleryImageCell.cellFrame.image = [UIImage imageNamed:[totalFrm objectAtIndex:indexPath.item]];
    return galleryImageCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"The tapped cell is no.%i", indexPath.item);
    
    UIButton *tmp = [[UIButton alloc] init];
	int currentIndex = (int)indexPath.section;
	tmp.tag = indexPath.row;
    [self click2Open:tmp inSection:currentIndex];
}

#pragma mark - Thumbnail Action
// Used in Photos Layout.
// In Photos layout, tap on one thumbnail, photo gallery start at that index
-(void)click2Open:(id)sender inSection:(int)section {
	
	NSMutableArray *imageArr = [[NSMutableArray alloc] init];
	NSMutableArray *capArr = [[NSMutableArray alloc] init];
    NSMutableArray *typeArr = [[NSMutableArray alloc] init];
    NSMutableArray *fileArr = [[NSMutableArray alloc] init];
    
	NSDictionary *ggallDict = [arr_AlbumData objectAtIndex:section];
	NSArray *ggalleryArray = [ggallDict objectForKey:@"sectioninfo"];
    for (int i = 0; i < [ggalleryArray count]; i++) {
        NSDictionary *itemDic = [[NSDictionary alloc] initWithDictionary:ggalleryArray[i]];
        
        //Add all items' names into this array
        if ([[itemDic objectForKey:@"albumtype"] isEqualToString:@"image"]) {
            [fileArr addObjectsFromArray: [itemDic objectForKey:@"images"]];
            [imageArr addObjectsFromArray: [itemDic objectForKey:@"images"]];
            [capArr addObjectsFromArray: [itemDic objectForKey:@"captions"]];
            
            NSArray *tmpImgArr = [[NSArray alloc] initWithArray:[itemDic objectForKey:@"images"]];
            for (int j = 0; j < [tmpImgArr count]; j++) {
                [typeArr addObject:[itemDic objectForKey:@"albumtype"]];
            }
        }
        if ([[itemDic objectForKey:@"albumtype"] isEqualToString:@"film"]) {
            
            [fileArr addObject:[itemDic objectForKey:@"film"]];
            // Add item's type into this array
            [[NSNotificationCenter defaultCenter] postNotificationName:@"hideStar" object:self];
            
            [typeArr addObject:[itemDic objectForKey:@"albumtype"]];
        }
        if ([[itemDic objectForKey:@"albumtype"] isEqualToString:@"pdf"]) {
            [fileArr addObject:[itemDic objectForKey:@"pdf"]];
            // Add item's type into this array
            [typeArr addObject:[itemDic objectForKey:@"albumtype"]];
        }
        if ([[itemDic objectForKey:@"albumtype"] isEqualToString:@"url"]) {
            [fileArr addObject:[itemDic objectForKey:@"url"]];
            // Add item's type into this array
            [typeArr addObject:[itemDic objectForKey:@"albumtype"]];
        }
    }
    //    NSLog(@"names: %@ =", fileArr);
    //    NSLog(@"types: %@ =", typeArr);
    NSMutableDictionary *typesAndNamesDict = [[NSMutableDictionary alloc] init];
    [typesAndNamesDict setObject:typeArr forKey:@"types"];
    [typesAndNamesDict setObject:fileArr forKey:@"fileName"];
    
	if ([[[typesAndNamesDict objectForKey:@"types"] objectAtIndex:[sender tag]]isEqualToString:@"film"]) {
//		NSArray *tmpFile = [[NSArray alloc] initWithArray:[typesAndNamesDict objectForKey:@"fileName"]];
//        
//		NSString *fileString = [[[tmpFile objectAtIndex:[sender tag]] lastPathComponent] stringByDeletingPathExtension];
//		NSString *extensionString = [[tmpFile objectAtIndex:[sender tag]] pathExtension];
//		NSLog(@"%@.%@",fileString,extensionString);
//        
//		[self playMovie:fileString ofType:extensionString];
		
	} else if ([[[typesAndNamesDict objectForKey:@"types"] objectAtIndex:[sender tag]] isEqualToString:@"image"]) {
//		NSLog(@"image %@ and %@", imageArr, capArr);
		localImages =  imageArr;
		localCaptions = [NSArray arrayWithArray:capArr];
		//[self imageViewer:sender];
        UINavigationController *fGalleryNavigationController = [[UINavigationController alloc] init];
        fGalleryNavigationController.view.frame = self.view.frame;
        //[fGalleryNavigationController setToolbarHidden:NO];
        //        [fGalleryNavigationController.view setBackgroundColor:[UIColor clearColor]];
		localGallery = [[FGalleryViewController alloc] initWithPhotoSource:self];
        localGallery.startingIndex = [sender tag];
        [fGalleryNavigationController addChildViewController:localGallery];
        [fGalleryNavigationController.view addSubview:localGallery.view];
        //		[self.navigationController pushViewController:localGallery animated:YES];
        [self addChildViewController:fGalleryNavigationController];
        [self.view addSubview:fGalleryNavigationController.view];
        
        
	} else if ([[[typesAndNamesDict objectForKey:@"types"] objectAtIndex:[sender tag]] isEqualToString:@"pdf"]) {
//        NSArray *tmpFile = [[NSArray alloc] initWithArray:[typesAndNamesDict objectForKey:@"fileName"]];
//        [self viewPDF:[tmpFile objectAtIndex:[sender tag]]];
		
	}else if([[[typesAndNamesDict objectForKey:@"types"] objectAtIndex:[sender tag]]  isEqualToString:@"url"]){
//        NSArray *tmpFile = [[NSArray alloc] initWithArray:[typesAndNamesDict objectForKey:@"fileName"]];
//        NSString *theURL =[tmpFile objectAtIndex:[sender tag]];
//        NSLog(@"the  url is %@", theURL);
//        [self openWebPage:theURL];
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
