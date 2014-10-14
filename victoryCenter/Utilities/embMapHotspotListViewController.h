//
//  ebBuildingListViewController.h
//  quadrangle
//
//  Created by Evan Buxton on 6/22/13.
//  Copyright (c) 2013 neoscape. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol embMapHotspotListViewControllerDelegate;

@interface embMapHotspotListViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
	UITableView *tableView;
	UIView *headerView;
}
@property (nonatomic, weak) id<embMapHotspotListViewControllerDelegate> delegate;

@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSArray *incomingData;
-(void)rowToSelect:(NSIndexPath*)indexPath;
@end


@protocol embMapHotspotListViewControllerDelegate <NSObject>

- (void)childViewController:(embMapHotspotListViewController*)viewController
             didChooseRow:(NSInteger)rowIndex;

@end