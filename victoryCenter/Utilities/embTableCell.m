//
//  embTableCell.m
//  victoryparkmenudemo
//
//  Created by Xiaohe Hu on 12/30/13.
//  Copyright (c) 2013 neoscape. All rights reserved.
//

#import "embTableCell.h"
#import "UIColor+Extensions.h"

@implementation embTableCell

@synthesize uil_tableLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (selected) {
        self.backgroundColor = [UIColor vcLightBlueAlpha];
        NSLog(@"The Height is %@", [self description]);
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
    
}

@end
