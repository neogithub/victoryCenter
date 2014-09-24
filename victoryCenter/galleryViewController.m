//
//  galleryViewController.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/24/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "galleryViewController.h"
#import "CVCell.h"

@interface galleryViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    // gallery
	NSString                *secTitle;
	NSDictionary            *albumDict;
	NSArray                 *albumSections;
    int                     sectionIndex;
    int                     sumOfSections;
    NSMutableArray          *arr_AlbumData;
}

@end

@implementation galleryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = CGRectMake(0.0, 0.0, 1024.0, 768.0);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadGalleryData];
    // Do any additional setup after loading the view.
}

//====================Prepare Collection View's data from plist===============================

- (void)loadGalleryData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:
					  @"galleryData" ofType:@"plist"];
	// Build the array from the plist
	NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    sumOfSections = [array count];
	NSMutableArray *array_1 = [[NSMutableArray alloc] init];
    [array_1 addObject:[array objectAtIndex:sectionIndex]];
	arr_AlbumData = array_1;
	albumSections = arr_AlbumData;
}
//=================================================================

#pragma mark - Collection Delegate Methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDictionary *tempDic = [[NSDictionary alloc] initWithDictionary:[arr_AlbumData objectAtIndex:section]];
    NSMutableArray *secInfo = [[NSMutableArray alloc] initWithArray:[tempDic objectForKey:@"sectioninfo"]];
    int sumOfImg = 0;
    NSString *typeOfFile = [[NSString alloc] init];
    
    for (int i = 0; i < [secInfo count]; i++) {
        NSDictionary *itemDic = [[NSDictionary alloc] initWithDictionary:secInfo[i]];
        typeOfFile = [itemDic objectForKey:@"albumtype"];
        if ([typeOfFile isEqualToString:@"image"]) {
            NSMutableArray *imgArray = [[NSMutableArray alloc] initWithArray:[itemDic objectForKey:@"images"]];
            sumOfImg = sumOfImg + [imgArray count];
        }
        else
        {
            sumOfImg++;
        }
        
    }
    return sumOfImg;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CVCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"cvCell"
                                    forIndexPath:indexPath];
    myCell.titleLabel.text = @"title";
    return myCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"The tapped cell is no.%i", indexPath.item);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
