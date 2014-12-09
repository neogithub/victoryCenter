//
//  siteOverview.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 10/29/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "siteOverview.h"
#import "UIColor+Extensions.h"

@implementation siteOverview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUpView];
    }
    return self;
}

- (void)setUpView
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor vcDarkBlue].CGColor;
    self.layer.borderWidth = 1.0;
    
    [self addVpLogo];
    [self addVpText];
    [self addCell];
}

- (void)addVpLogo
{
    UIImageView *uiiv_logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grfx_victoryPark_logo.png"]];
    uiiv_logo.frame = CGRectMake(62.0, 47.0, 41, 125);
    uiiv_logo.backgroundColor = [UIColor clearColor];
    uiiv_logo.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: uiiv_logo];
}

- (void)addVpText
{
    UITextView *uitv_vpText = [[UITextView alloc] initWithFrame:CGRectMake(174.0, 45.0, 630.0, 160.0)];
    uitv_vpText.backgroundColor = [UIColor clearColor];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineHeightMultiple = 30.0f;
    paragraphStyle.maximumLineHeight = 30.0f;
    paragraphStyle.minimumLineHeight = 30.0f;
    
    NSDictionary *ats = @{
                          NSFontAttributeName : [UIFont fontWithName:@"Raleway-Medium" size:15.0f],
                          NSParagraphStyleAttributeName : paragraphStyle,
                          };
    NSString *text = @"Victory Park is currently under redevelopment to become a vibrant, pedestrian friendly, sustainable and distinctive neighborhood connecting Uptown to the Design District and beyond. Victory Park has partnered with Trademark to reposition the retail segments of Victory Park with an estimated Phase 1 opening in late 2014.";
    uitv_vpText.attributedText = [[NSAttributedString alloc] initWithString:text attributes:ats];
    [uitv_vpText setTextColor:[UIColor vcDarkBlue]];
    uitv_vpText.editable = NO;
    uitv_vpText.selectable = NO;
    [self addSubview: uitv_vpText];
}

- (void)addCell
{
    [arr_cells removeAllObjects];
    arr_cells = nil;
    arr_cells = [[NSMutableArray alloc] init];
    NSArray *arr_cellImages = [[NSArray alloc] initWithObjects:
                               @"overview_cell1.jpg",
                               @"overview_cell2.jpg",
                               @"overview_cell3.jpg",
                               @"overview_cell4.jpg",
                               nil];
    for (int i = 0; i < 4; i++) {
        UIButton *uib_cell = [self createCellwithFrame:CGRectMake(41 + i*(25 + 184), 220, 184, 117) andImage:arr_cellImages[i] andTag:i];
        [arr_cells addObject: uib_cell];
        [self addSubview: uib_cell];
    }
}

- (UIButton *)createCellwithFrame:(CGRect)frame andImage:(NSString *)imageName andTag:(int)index
{
    UIButton *uib_cell = [UIButton buttonWithType: UIButtonTypeCustom];
    uib_cell.backgroundColor = [UIColor redColor];
    uib_cell.frame = frame;
    [uib_cell setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    uib_cell.tag = index;
    [uib_cell addTarget:self action:@selector(tapCell:) forControlEvents:UIControlEventTouchUpInside];
    return  uib_cell;
}

- (void)tapCell:(id)sender
{
    NSLog(@"Tapped cell is %i", (int)[sender tag]);
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
