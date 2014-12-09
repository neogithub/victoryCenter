//
//  buildingAmenities.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 12/8/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "buildingAmenities.h"
#import "UIColor+Extensions.h"

@implementation buildingAmenities

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = screenRect;
        [self prepareData];
        [self createCatogoryViews];
    }
    return self;
}

- (void)prepareData
{
    NSString *url = [[NSBundle mainBundle] pathForResource:@"amenities_gallery" ofType:@"plist"];
    arr_rawData = [[NSArray alloc] initWithContentsOfFile:url];
}

- (void)createCatogoryViews
{
    uiv_imgsContainer = [[UIView alloc] initWithFrame:CGRectMake(206.0, 111.0, 612.0, 526.0)];
    uiv_imgsContainer.backgroundColor = [UIColor clearColor];
    [self addSubview: uiv_imgsContainer];
    
    NSArray *arr_imgNames = [[NSArray alloc] initWithObjects:@"grfx_amen_conference.jpg", @"grfx_amen_fitness.jpg", @"grfx_amen_dining.jpg", nil];
    arr_catogoryImgs = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < arr_imgNames.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:arr_imgNames[i]]];
        imageView.tag = i+1;
        imageView.frame = CGRectMake(0.0, (166 + 14)*i, imageView.frame.size.width, imageView.frame.size.height);
        [uiv_imgsContainer addSubview:imageView];
        [arr_catogoryImgs addObject: imageView];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapOnImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnImage:)];
        tapOnImage.numberOfTapsRequired = 1;
        [imageView addGestureRecognizer:tapOnImage];
    }
}

- (void)tapOnImage:(UIGestureRecognizer *)gesture
{
    UIView *tappedView = gesture.view;
    int index = (int)tappedView.tag;
    dict_collectionData = [arr_rawData objectAtIndex: index - 1];
    NSString *title = [NSString new];
    switch (index) {
        case 1:
            title = @"CONFERENCE CENTER";
            break;
        case 2:
            title = @"FITNESS";
            break;
        case 3:
            title = @"DINING";
            break;
            
        default:
            break;
    }
    
    [arr_thumbs removeAllObjects];
    arr_thumbs = nil;
    [arr_images removeAllObjects];
    arr_images = nil;
    
    arr_images = [[NSMutableArray alloc] initWithArray: [dict_collectionData objectForKey:@"content"]];
    arr_thumbs = [[NSMutableArray alloc] initWithArray: [dict_collectionData objectForKey:@"thumb"]];
    
    [self createTitleView:title];
    [self createCollectionView];
    [self createBackView];
    
    [UIView animateWithDuration:0.33 animations:^{
        uiv_imgsContainer.alpha = 0.0;
    }];
}

- (void)createTitleView:(NSString *)title
{
    [uiv_titleContainer removeFromSuperview];
    uiv_titleContainer = nil;
    uiv_titleContainer = [[UIView alloc] initWithFrame:CGRectMake(31.0, 77.0, 191.0, 58.0)];
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
}

- (void)createBackView
{
    uiv_backBtnContainer = [[UIView alloc] initWithFrame:CGRectMake(434.0, 711.0, 156.0, 40.0)];
    uiv_backBtnContainer.backgroundColor = [UIColor vcdarkmenu];
    [self addSubview: uiv_backBtnContainer];
    
    UILabel *uil_back = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 0.0, 130.0, 40.0)];
    [uil_back setLineBreakMode: NSLineBreakByWordWrapping];
    uil_back.numberOfLines = 0;
    [uil_back setTextAlignment: NSTextAlignmentCenter];
    uil_back.text = @"BACK TO AMENITIES GALLERY";
    [uil_back setTextColor: [UIColor whiteColor]];
    [uil_back setFont: [UIFont fontWithName:@"Raleway-Bold" size:13.0]];
    [uiv_backBtnContainer addSubview: uil_back];
    
    UIButton *uib_back = [UIButton buttonWithType: UIButtonTypeCustom];
    uib_back.frame = uiv_backBtnContainer.bounds;
    uib_back.backgroundColor = [UIColor clearColor];
    [uiv_backBtnContainer addSubview: uib_back];
    [uib_back addTarget:self action:@selector(removeCollectionView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)removeCollectionView
{
    [UIView animateWithDuration:0.33 animations:^{
        uiv_backBtnContainer.alpha = 0.0;
        uic_gallery.alpha = 0.0;
        uiv_titleContainer.alpha = 0.0;
    } completion:^(BOOL finished){
        [uiv_titleContainer removeFromSuperview];
        uiv_titleContainer = nil;
        
        [uic_gallery removeFromSuperview];
        uic_gallery = nil;
        
        [uiv_backBtnContainer removeFromSuperview];
        uiv_backBtnContainer = nil;
        
        [UIView animateWithDuration:0.33 animations:^{
            uiv_imgsContainer.alpha = 1.0;
        }];
    }];
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(165, 165)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setMinimumLineSpacing:10.0];
    [flowLayout setMinimumInteritemSpacing:10.0];
    uic_gallery = [[UICollectionView alloc] initWithFrame:CGRectMake(79.0, 157.0, 884.0, 540.0) collectionViewLayout:flowLayout];
    uic_gallery.backgroundColor = [UIColor redColor];
    [uic_gallery registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"amenitiesCell"];
    uic_gallery.delegate = self;
    uic_gallery.dataSource = self;
    uic_gallery.alpha = 0.0;
    [self addSubview: uic_gallery];
    [UIView animateWithDuration:0.33
                     animations:^{
                         uic_gallery.alpha = 1.0;
                     }];
}

#pragma mark - Collection Delegate Methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arr_images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [uic_gallery dequeueReusableCellWithReuseIdentifier:@"amenitiesCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:arr_images, @"images", [NSNumber numberWithInt:indexPath.row], @"startIndex", nil];
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
