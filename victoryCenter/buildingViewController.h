//
//  buildingViewController.h
//  victoryCenter
//
//  Created by Xiaohe Hu on 9/23/14.
//  Copyright (c) 2014 Neoscape. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollapseClick.h"

@interface buildingViewController : UIViewController<CollapseClickDelegate>
{
    CollapseClick   *theCollapseClick;
}
@end
