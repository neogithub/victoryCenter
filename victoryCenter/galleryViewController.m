//
//  galleryViewController.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/23/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "galleryViewController.h"
#import "CVCell.h"
#import <QuartzCore/QuartzCore.h>

@interface galleryViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSString                    *secTitle;
	NSDictionary                *albumDict;
	NSArray                     *albumSections;
    UICollectionViewFlowLayout  *flowLayout;
    int                         sumOfSections;
    int                         sectionIndex;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, copy) NSMutableArray          *arr_AlbumData;
@end

@implementation galleryViewController
@synthesize collectionView = _collectionView;
- (BOOL)prefersStatusBarHidden {
    return YES;
}

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
    [self loadCollectionData];
    [self setUpCollectionView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}

- (void)loadCollectionData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:
					  @"galleryData" ofType:@"plist"];
	// Build the array from the plist
	NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    sumOfSections = [array count];
	NSMutableArray *array_1 = [[NSMutableArray alloc] init];
    [array_1 addObject:[array objectAtIndex:sectionIndex]];
	self.arr_AlbumData = array_1;
	albumSections = self.arr_AlbumData;
}

- (void)setUpCollectionView
{
    [self.collectionView registerClass:[CVCell class] forCellWithReuseIdentifier:@"cvCell"];
    self.collectionView.backgroundColor = [UIColor redColor];
    flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(285, 285)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.collectionView setCollectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView reloadData];
    [self.collectionView setContentOffset:CGPointZero animated:NO];
}

#pragma mark - UICollectionView Delegate Method
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
//	NSUInteger numGallSections = [albumSections count];
//    NSLog(@"The num of section is %i", (int)[albumSections count]);
//	return numGallSections;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return 3;
    
    NSDictionary *tempDic = [[NSDictionary alloc] initWithDictionary:[self.arr_AlbumData objectAtIndex:section]];
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
    NSLog(@"The num of cell is %i", sumOfImg);
    return sumOfImg;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)mycollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{   
    static NSString *cellIdentifier = @"cvCell";
    CVCell *cell = (CVCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
//    cell.titleLabel.text = [NSString stringWithFormat:@"Title No.%i", (int)indexPath.row];
//    cell.cellThumb.image = [UIImage new];
    NSDictionary *tempDic = [[NSDictionary alloc] initWithDictionary:[_arr_AlbumData objectAtIndex:indexPath.section]];
    NSMutableArray *secInfo = [[NSMutableArray alloc] initWithArray:[tempDic objectForKey:@"sectioninfo"]];
    
    NSMutableArray *totalImg = [[NSMutableArray alloc] init];
    NSMutableArray *totalCap = [[NSMutableArray alloc] init];
    NSString *typeOfCell = [[NSString alloc] init];
    
    for (int i = 0; i < [secInfo count]; i++) {
        NSDictionary *itemDic = [[NSDictionary alloc] initWithDictionary:[secInfo objectAtIndex:i]];
        typeOfCell = [itemDic objectForKey:@"albumtype"];
        
        if ([typeOfCell isEqualToString:@"image"]) {
            NSMutableArray *imgArray = [[NSMutableArray alloc] initWithArray:[itemDic objectForKey:@"images"]];
            NSMutableArray *capArray = [[NSMutableArray alloc] initWithArray:[itemDic objectForKey:@"captions"]];
            [totalImg addObjectsFromArray:imgArray];
            [totalCap addObjectsFromArray:capArray];
        }
        else
        {
            [totalImg addObject:[itemDic objectForKey:@"albumthumb"]];
            [totalCap addObject:[itemDic objectForKey:@"albumcaption"]];
        }
        
    }
    
    [cell.titleLabel setText:[totalCap objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tap on cell %i",(int)indexPath.row);
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
