//
//  amenitiesHeader.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 12/11/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "amenitiesHeader.h"
#import "UIColor+Extensions.h"
@implementation amenitiesHeader
@synthesize uil_title;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *uiv_titleContainer = [[UIView alloc] initWithFrame:CGRectMake(0.0, 20.0, 191.0, 58.0)];
        uiv_titleContainer.backgroundColor = [UIColor whiteColor];
        [self addSubview: uiv_titleContainer];
        
        UIView *uiv_leftBar = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 13.0, 58.0)];
        uiv_leftBar.backgroundColor = [UIColor vcdarkmenu];
        [uiv_titleContainer addSubview: uiv_leftBar];
        
        uil_title = [[UILabel alloc] initWithFrame:CGRectMake(30.0, 0.0, 130.0, 58.0)];
        uil_title.backgroundColor = [UIColor clearColor];
        [uil_title setLineBreakMode: NSLineBreakByWordWrapping];
        uil_title.numberOfLines = 0;
        [uil_title setTextColor: [UIColor vcDarkBlue]];
        [uil_title setFont:[UIFont fontWithName:@"Raleway-Bold" size:18.0]];
        [uil_title setTextAlignment: NSTextAlignmentLeft];
        [uiv_titleContainer addSubview: uil_title];
        self.frame = uiv_titleContainer.bounds;
    }
    return self;
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
