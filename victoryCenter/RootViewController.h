//
//  ViewController.h
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/23/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGalleryViewController.h"
#import "GAITrackedViewController.h"

@interface RootViewController : GAITrackedViewController <FGalleryViewControllerDelegate>
{
    // fgallery
	FGalleryViewController	*localGallery;
	NSArray					*localCaptions;
    NSArray					*localImages;
}
@end
