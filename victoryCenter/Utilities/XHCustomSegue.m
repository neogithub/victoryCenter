//
//  XHCustomSegue.m
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/23/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import "XHCustomSegue.h"

@implementation XHCustomSegue
- (void)perform
{
    UIView *uiv_sour = ((UIViewController *)self.sourceViewController).view;
    UIView *uiv_dest = ((UIViewController *)self.destinationViewController).view;
    
/* Pop up destination view from bottom
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    uiv_dest.center = CGPointMake(uiv_sour.center.x + uiv_sour.frame.size.width,
                            uiv_dest.center.y);
    [window insertSubview:uiv_dest aboveSubview: uiv_sour];
    [UIView animateWithDuration:0.4
                     animations:^{
                         uiv_dest.center = CGPointMake(uiv_sour.center.x,
                                                 uiv_dest.center.y);
                         uiv_sour.center = CGPointMake(0 - uiv_sour.center.x,
                                                 uiv_dest.center.y);
                     }
                     completion:^(BOOL finished){
                         [[self sourceViewController] presentViewController:
                          [self destinationViewController] animated:NO completion:nil];
                     }];
========================================== */
    
//Fade in destination view
    //Add destination vc to source vc. Otherwise uicollectionview will crash!!
    UIViewController *source = self.sourceViewController;
    UIViewController *destination = self.destinationViewController;
    
    [source addChildViewController:destination];
    
    uiv_dest.alpha = 0.0;
    [uiv_sour insertSubview:uiv_dest belowSubview:[uiv_sour viewWithTag:10]];
    [UIView animateWithDuration:0.33 animations:^{
        uiv_dest.alpha = 1.0;
    } completion:^(BOOL finished){
        [uiv_sour viewWithTag:11].hidden = NO;
        uiv_dest.tag = 1000;
    }];
    
}

@end
