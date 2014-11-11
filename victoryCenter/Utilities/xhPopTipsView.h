//
//  xhPopTipsView.h
//  victoryCenter
//
//  Created by Xiaohe Hu on 11/11/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMPopTipView.h"

@interface xhPopTipsView : UIView <CMPopTipViewDelegate>

@property (nonatomic, readwrite) BOOL       onScreen;

- (id)initWithFrame:(CGRect)frame andText:(NSArray *)helpText andViews:(NSArray *)viewArray;

@end
