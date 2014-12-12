//
//  ameniteisGallery.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 12/11/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "ameniteisGallery.h"
#import "UIColor+Extensions.h"
#import "amenitiesHeader.h"
#import "CVCell.h"

@implementation ameniteisGallery

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self prepareData];
        [self createCollectionView];
    }
    return self;
}

- (void)prepareData
{
    NSString *url = [[NSBundle mainBundle] pathForResource:@"amenities_gallery" ofType:@"plist"];
    arr_rawData = [[NSArray alloc] initWithContentsOfFile:url];
}

- (UIView *)createTitleView:(NSString *)title
{

    UIView *uiv_titleContainer = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 191.0, 58.0)];
    uiv_titleContainer.backgroundColor = [UIColor whiteColor];
    [self addSubview: uiv_titleContainer];
    
    UIView *uiv_leftBar = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 13.0, 58.0)];
    uiv_leftBar.backgroundColor = [UIColor vcdarkmenu];
    [uiv_titleContainer addSubview: uiv_leftBar];
    
    UILabel *uil_title = [[UILabel alloc] initWithFrame:CGRectMake(30.0, 0.0, 130.0, 58.0)];
    uil_title.backgroundColor = [UIColor clearColor];
    [uil_title setLineBreakMode: NSLineBreakByWordWrapping];
    uil_title.numberOfLines = 0;
    [uil_title setText: title];
    [uil_title setTextColor: [UIColor vcDarkBlue]];
    [uil_title setFont:[UIFont fontWithName:@"Raleway-Bold" size:18.0]];
    [uil_title setTextAlignment: NSTextAlignmentLeft];
    [uiv_titleContainer addSubview: uil_title];
    
    return  uiv_titleContainer;
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(165, 165)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setMinimumLineSpacing:10.0];
    [flowLayout setMinimumInteritemSpacing:10.0];
    uic_gallery = [[UICollectionView alloc] initWithFrame:CGRectMake(79.0, 100.0, 884.0, 580.0) collectionViewLayout:flowLayout];
    uic_gallery.backgroundColor = [UIColor clearColor];
    [uic_gallery registerClass:[CVCell class] forCellWithReuseIdentifier:@"cvCell"];
    [uic_gallery registerClass:[amenitiesHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SupplementaryView"];
    uic_gallery.delegate = self;
    uic_gallery.dataSource = self;
    uic_gallery.alpha = 0.0;
    uic_gallery.showsVerticalScrollIndicator = NO;
    [self addSubview: uic_gallery];
    [UIView animateWithDuration:0.33
                     animations:^{
                         uic_gallery.alpha = 1.0;
                     }];
}

#pragma mark - Collection Delegate Methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDictionary *dict_tmp = arr_rawData[section];
    NSArray *images = [dict_tmp objectForKey:@"content"];
    return  images.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(0, 100);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    amenitiesHeader *supplementaryView = [[amenitiesHeader alloc] init];
    if (kind == UICollectionElementKindSectionHeader ) {
        NSString *title = [NSString new];
        switch (indexPath.section) {
            case 0:
                title = @"CONFERENCE CENTER";
                break;
            case 1:
                title = @"FITNESS";
                break;
            case 2:
                title = @"DINING";
                break;
            default:
                break;
        }
        supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SupplementaryView" forIndexPath:indexPath];
        supplementaryView.uil_title.text = title;
    }

    return  supplementaryView;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict_tmp = arr_rawData[indexPath.section];
    NSArray *arr_caption = [dict_tmp objectForKey:@"caption"];
    NSArray *arr_image = [dict_tmp objectForKey:@"content"];
    
    CVCell *cell = [uic_gallery dequeueReusableCellWithReuseIdentifier:@"cvCell" forIndexPath:indexPath];
    cell.titleLabel.text = arr_caption[indexPath.row];
    cell.titleLabel.font = [UIFont fontWithName:@"Raleway-Medium" size:13];
    cell.cellThumb.image = [UIImage imageNamed:[NSString stringWithFormat:@"thumb_%@",arr_image[indexPath.row]]];
    cell.imgFrame.image = [UIImage imageNamed:@"normal_frame.png"];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict_tmp = arr_rawData[indexPath.section];
    NSArray *arr_image = [dict_tmp objectForKey:@"content"];
    
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:arr_image, @"images", [NSNumber numberWithInt:(int)indexPath.row], @"startIndex", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadFGallery" object:nil userInfo:dictionary];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideHomeButton" object:nil];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
