//
//  buildingAmenities.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 12/8/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "buildingAmenities.h"

@implementation buildingAmenities

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = screenRect;
        [self createCatogoryViews];
    }
    return self;
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
    NSLog(@"The tapped view is %i", index);
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
