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

enum
{
	MPTransitionModeFold,
	MPTransitionModeFlip
} typedef MPTransitionMode;

@interface mapViewController : UIViewController

@property (assign, nonatomic) MPTransitionMode          mode;
@property (assign, nonatomic) NSUInteger                style;
@property (assign, nonatomic) MPFoldStyle               foldStyle;
@property (assign, nonatomic) MPFlipStyle               flipStyle;
@property (readonly, nonatomic) BOOL                    isFold;

@end
