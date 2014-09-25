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
    NSLog(@"The tapped cell is no.%i", indexPath.item);
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
