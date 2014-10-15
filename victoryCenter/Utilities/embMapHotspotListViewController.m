//
//  ebBuildingListViewController.m
//  quadrangle
//
//  Created by Evan Buxton on 6/22/13.
//  Copyright (c) 2013 neoscape. All rights reserved.
//

#import "embMapHotspotListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+Extensions.h"
#import "embTableCell.h"
@interface embMapHotspotListViewController ()
@property (nonatomic, strong)		NSArray				*tableData;
@property (nonatomic, strong)       NSArray             *tableUnits;
@property (nonatomic, strong)		NSMutableArray		*categoryHeaders;
@property (nonatomic, strong)		UIColor				*rowHilite;
@property (nonatomic, strong)		UIImage             *numImg;
@property (nonatomic, readwrite)	NSInteger			page;
@property (nonatomic, readwrite)    BOOL                isLive;

@end

static CGFloat	kFontSize = 13.0f;
static NSString *kFontName = @"Raleway-Medium";

extern NSArray *arrHotSpots;

@implementation embMapHotspotListViewController
@synthesize numColor;

-(void)viewWillAppear:(BOOL)animated
{	
	NSArray *arrCategoryPicked = [[NSArray alloc] init];
	arrCategoryPicked = _incomingData;
	
	NSString *tmpStringCategory = _category;
	
	NSMutableArray *arrHotSpots = [[NSMutableArray alloc] init];
	_categoryHeaders = [[NSMutableArray alloc] init];

	for (NSDictionary *_hotspotsDict in arrCategoryPicked) { // iterate through the array
		if ([[_hotspotsDict valueForKey:@"category"] isEqualToString:tmpStringCategory]) {
			[arrHotSpots addObject:[_hotspotsDict valueForKeyPath:@"hotspots"]];	// all hotspots arrays for category
			for (NSDictionary *dict in arrHotSpots) {
				_tableData=[dict valueForKey:@"name"];								// all hotspot names
			}
			[_categoryHeaders addObject:[_hotspotsDict valueForKey:@"category"]];	// all category names for table
		}
	}
	[self vcInit];
}

-(void)vcInit
{
	// table
	tableView.backgroundColor = [UIColor clearColor];
	tableView.opaque = NO;
	tableView.backgroundView = nil;
	[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

//	_numColor = [UIColor vcSiteRetail];
	_rowHilite = [UIColor vcDarkBlue];
}

#pragma mark - Hilight cell of tapped hot spot from parent
-(void)rowToSelect:(NSIndexPath*)indexPath
{
	[[self tableView] selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
//	NSLog(@"row %li",(long)indexPath.row);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    embTableCell *customCell = (embTableCell*)[self.tableView cellForRowAtIndexPath:indexPath];
//    CGFloat px = customCell.frame.origin.x;
//    CGFloat width = customCell.frame.size.width;
//    if ((px + width) > self.tableView.frame.size.width) {
//        return 33;
//    }
    
//    NSString *str = [_tableData objectAtIndex:indexPath.row];
//    CGSize size = [str sizeWithFont:[UIFont fontWithName:kFontName size:kFontSize] constrainedToSize:CGSizeMake(self.tableView.frame.size.width-50, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
//    NSLog(@"The height is %f", size.height);
//    return size.height;
    
    NSString *str = [_tableData objectAtIndex:indexPath.row];
    CGSize size = [str sizeWithFont:[UIFont fontWithName:kFontName size:kFontSize]];
    if (size.width > self.tableView.frame.size.width - 50) {
        return 35;
    }
    else
        return 26;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 0.0;
}

- (UIView *) tableView:(UITableView *)ttableView viewForHeaderInSection:(NSInteger)section
{
        return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)ttableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    embTableCell *cell = (embTableCell *)[ttableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"embTableCell" owner:self options:nil];
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[embTableCell class]])
            {
                cell = (embTableCell *)currentObject;
                break;
            }
        }

    }
    NSString *str = [_tableData objectAtIndex:indexPath.row];
//    NSString *unitNum = [_tableUnits objectAtIndex:indexPath.row];
    CGSize size = [str sizeWithFont:[UIFont fontWithName:kFontName size:kFontSize] constrainedToSize:CGSizeMake((ttableView.frame.size.width - cell.uil_tableLabel.frame.origin.x), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
//    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, size.height);
//   cell.uil_tableLabel.frame = CGRectMake(cell.uil_tableLabel.frame.origin.x, cell.uil_tableLabel.frame.origin.y, size.width, size.height);
    if (size.height > 30) {
        cell.uil_tableLabel.frame = CGRectMake(cell.uil_tableLabel.frame.origin.x, cell.uil_tableLabel.frame.origin.y, size.width, size.height);
        cell.uil_tableLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        cell.uil_tableLabel.backgroundColor = [UIColor redColor];
        cell.uil_tableLabel.numberOfLines = 0;
        cell.uil_tableLabel.text = [_tableData objectAtIndex:indexPath.row];
        cell.uil_tableLabel.font = [UIFont fontWithName:kFontName size:kFontSize];
        cell.uil_tableLabel.textColor = [UIColor vcDarkBlue];
        [cell.uil_tableLabel sizeToFit];
    }
    else{
 //       cell.uil_tableIndex.frame = CGRectMake(cell.uil_tableIndex.frame.origin.x, cell.uil_tableIndex.frame.origin.y, cell.uil_tableLabel.frame.size.width, 8);
//        cell.uil_tableLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        cell.uil_tableLabel.numberOfLines = 0;
        if (indexPath.section == 0) {
            cell.uil_tableLabel.text = [_tableData objectAtIndex:indexPath.row];
            cell.uil_tableLabel.textColor = [UIColor vcDarkBlue];
        }
        else {
            cell.uil_tableLabel.text = [_tableData objectAtIndex:indexPath.row+17];
        }
        cell.uil_tableLabel.font = [UIFont fontWithName:kFontName size:kFontSize];
        if (_tableUnits[0]==[NSNull null]) {
            cell.uil_tableUnit.text = @"";
            cell.uil_tableUnit.font = [UIFont fontWithName:kFontName size:kFontSize];
        }
        else
        {
            if (indexPath.section == 0) {
                cell.uil_tableUnit.text = [_tableUnits objectAtIndex:indexPath.row];
            }
            else {
                cell.uil_tableUnit.text = [_tableUnits objectAtIndex:indexPath.row +17];
            }
            
            cell.uil_tableUnit.font = [UIFont fontWithName:kFontName size:kFontSize];
        }
        
     }
    
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, cell.uil_tableLabel.frame.size.height);

//    [cell.uil_tableIndex sizeToFit];
    int numOfRow = (int)indexPath.row + 1;
//    NSLog(@"%i",numOfRow);
    if (indexPath.section == 0) {
        cell.uil_tableIndex.text = [NSString stringWithFormat:@"%i.", numOfRow];
        [cell.uil_tableIndex setFont:[UIFont fontWithName:kFontName size:kFontSize]];
        [cell.uil_tableIndex setTextColor:numColor];
    }
    else {
        cell.uil_tableIndex.text = [NSString stringWithFormat:@"%i.", (numOfRow + 17)];
        
    }
    

    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [UIView new];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    NSLog(@"The frame of LABEL is %@ \n", [cell.uil_tableLabel description]);
//    NSLog(@"The frame of CELL is %@ \n \n", [cell description]);
    
    
	return cell;
}

#pragma mark - Make Img For Nums

- (UIImage*) buildLabelImages_duringDevelopmentOnly:(NSString *)suffix withFrame: (CGRect) frame
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
//    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2, frame.size.height/2-2, frame.size.width/2, frame.size.height/2)];
    UILabel *numLabel = [[UILabel alloc] initWithFrame:frame];
    numLabel.font = [UIFont fontWithName:kFontName size:kFontSize];
    numLabel.backgroundColor = [UIColor clearColor];
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    numLabel.textColor = [UIColor blackColor];
    numLabel.text = suffix;
    
    NSDictionary *attribs = @{NSForegroundColorAttributeName: numLabel.textColor,NSFontAttributeName: numLabel.font};
	NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:numLabel.text
																					   attributes:attribs];
	UIFont *font = [UIFont fontWithName:kFontName size:kFontSize];
	
    	[attributedText setAttributes:@{
       NSForegroundColorAttributeName:numColor,
    			  NSFontAttributeName:font}
    							range:NSMakeRange(0,numLabel.text.length)];
    numLabel.attributedText = attributedText;
    
    
    //[numLabel setContentMode:UIViewContentModeBottomLeft];
    
    UIView *vview = [[UIView alloc] initWithFrame:imageView.bounds];
    [vview addSubview:imageView];
    [vview addSubview:numLabel];
    //[vview setContentMode:UIViewContentModeBottomLeft];
    [vview setBackgroundColor:[UIColor clearColor]];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
//    NSString *libraryDirectory = [paths objectAtIndex:0];
//    [self createSubdirectory:[libraryDirectory stringByAppendingPathComponent:@"maphotspotbuttons"]];
//    NSLog(@"%@",libraryDirectory);
    
//    NSArray *strings = [withRange componentsSeparatedByString:@","];
    
//    for (int num=[[strings objectAtIndex:0] integerValue]; num<=[[strings objectAtIndex:1] integerValue]; num++) {
//        
//        NSString *imageFilePath = [libraryDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d%@.png", backImg, num, suffix]];
//        [[NSFileManager defaultManager] fileExistsAtPath:imageFilePath];
//        numLabel.text = [NSString stringWithFormat:@"%d", num];
//        
//        NSLog(@"%@",imageFilePath);
    
        UIGraphicsBeginImageContext(vview.bounds.size);
        [vview.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();    
//        NSData *imageData = UIImagePNGRepresentation(vviewImage);
//        [imageData writeToFile:imageFilePath atomically:NO];
//    }
    return viewImage;
}



#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// talks to child and hilights row
	if ([self.delegate respondsToSelector:@selector(childViewController:didChooseRow:)]) {
        if (indexPath.section == 1) {
            [self.delegate childViewController:self didChooseRow:indexPath.row + 17];
        }
        else {
            [self.delegate childViewController:self didChooseRow:indexPath.row];
        }
        
    }
}

@end
