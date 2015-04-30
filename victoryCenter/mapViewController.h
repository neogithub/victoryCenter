//
//  mapViewController.h
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/23/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPFoldEnumerations.h"
#import "MPFlipEnumerations.h"
#import "GAITrackedViewController.h"

enum
{
	MPTransitionModeFold,
	MPTransitionModeFlip
} typedef MPTransitionMode;

@interface mapViewController : GAITrackedViewController

@property (assign, nonatomic) MPTransitionMode          mode;
@property (assign, nonatomic) NSUInteger                style;
@property (assign, nonatomic) MPFoldStyle               foldStyle;
@property (readonly, nonatomic) BOOL                    isFold;

@end
